unit Recedit;
{ ==========================================================
  WinWCP - Record editing module (c) J. Dempster 1997
  V2.1a 12/4/99 A/D voltage range can now be amended by user
  15/7/99 V3.0 Updated to 32 bit (Delphi V3.0)
  4/9/99 ... Display grid added
  30/10/99 ... NewFile method added
  3/11/99 ... NewFile now closes form if no records available
  13/12/99 ... Backup file no longer closes data file
  21/5/01 ... Ctrl+1,2,3 shortcuts for TYP1, TYP2, TYP3 added
  29/8/01 ... Fixed zero level now saved when changed
              From record zero area indicated by vertical bars
  31/8/01 ... FileClose error in Windows NT fixed
              Error when manually selecting record # fixed
  3/12/01 ... NewFile now retains displayed record number position
  22.5.02 ... Now reports progress on main status bar
              Record range initialised correctly
              Accepted/Rejected and Record type now update file when changed
  24.6.03 ... No. of display grid lines can be changed
  12.2.04 ... Record A/D voltage range now updated correctly
              Cursor readout tidied up
  01.01.04 .. Out of memory error blocked when windows resized to tiny size
  12.12.08 .. Sampling Interval added to record information panel
  ========================================================== }
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, global, fileio, plotlib, shared,
  Grids,Zero, maths, ScopeDisplay, ValEdit, RangeEdit, ComCtrls,
  ValidatedEdit, CursorLabel, math, seslabio  ;

type
  TEditFrm = class(TForm)
    RecordGrp: TGroupBox;
    Label2: TLabel;
    Label1: TLabel;
    Group: TLabel;
    cbRecordType: TComboBox;
    ckBadRecord: TCheckBox;
    sbRecordNum: TScrollBar;
    Label3: TLabel;
    edADCVoltageRange: TValidatedEdit;
    edGroup: TValidatedEdit;
    edTime: TValidatedEdit;
    edRecordNum: TRangeEdit;
    EditGrp: TGroupBox;
    HorGrp: TGroupBox;
    bLeft: TButton;
    Button1: TButton;
    VertGrp: TGroupBox;
    bUp: TButton;
    bDown: TButton;
    YScaleGrp: TGroupBox;
    bScale: TButton;
    edYScale: TValidatedEdit;
    GroupBox8: TGroupBox;
    rbAllRecords: TRadioButton;
    rbThisRecord: TRadioButton;
    rbRange: TRadioButton;
    edRecRange: TRangeEdit;
    edXShift: TValidatedEdit;
    edYShift: TValidatedEdit;
    GroupBox1: TGroupBox;
    edSetValue: TValidatedEdit;
    bUndo: TButton;
    edRegion: TRangeEdit;
    Label6: TLabel;
    bSetRegion: TButton;
    Label5: TLabel;
    Label7: TLabel;
    edSamplingInterval: TValidatedEdit;
    Label4: TLabel;
    cbChannel: TComboBox;
    scDisplay: TScopeDisplay;
    ckFixedZeroLevels: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbRecordNumChange(Sender: TObject);
    procedure bLeftClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bScaleClick(Sender: TObject);
    procedure bUpClick(Sender: TObject);
    procedure bDownClick(Sender: TObject);
    procedure bUndoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbChannelChange(Sender: TObject);
    procedure scDisplayCursorChange(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure bSetRegionClick(Sender: TObject);
    procedure edRegionKeyPress(Sender: TObject; var Key: Char);
    procedure scDisplayMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure edRecordNumKeyPress(Sender: TObject; var Key: Char);
    procedure ckBadRecordClick(Sender: TObject);
    procedure cbRecordTypeChange(Sender: TObject);
    procedure edGroupKeyPress(Sender: TObject; var Key: Char);
    procedure edADCVoltageRangeKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure ZeroLevelGrpClick(Sender: TObject);
    procedure ckFixedZeroLevelsClick(Sender: TObject);

  private
    { Private declarations }
    procedure InitialiseDisplay ;
    procedure DisplayRecord ;
    procedure ShiftHorizontal( ShiftBy : Integer ) ;
    procedure ShiftVertical( ShiftBy : Integer ) ;
    procedure ScaleVertical( ScaleBy : single ) ;
    procedure HeapBuffers( Operation : THeapBufferOp ) ;
    procedure GetRecordRange( var RecStart : Integer ; var RecEnd : Integer ) ;
  public
    { Public declarations }
    procedure ChangeDisplayGrid ;
    procedure ZoomOut ;
    procedure NewFile ;
  end;

var
  EditFrm: TEditFrm;

implementation
uses          MDIForm ;
type
    TCursors = record
             Base : Integer ;
             Read : Integer ;
             C0 : Integer ;
             C1 : Integer ;
             end ;

var
   SaveRecord : Boolean ;
   Cursors : TCursors ;
   rH : TRecHeader ;      { Signal record header block }
   ADC : ^TSmallIntArray ;
   Buf : ^TSmallIntArray ;
   XShift : Integer ;
   YShift : Integer ;
   BackUpFH : TFileHeader ;
   BuffersAllocated : boolean ;{ Indicates if memory buffers have been allocated }
{$R *.DFM}


procedure TEditFrm.HeapBuffers( Operation : THeapBufferOp ) ;
{ -----------------------------------------------
  Allocate/deallocation dynamic buffers from heap
  -----------------------------------------------}
begin
     case Operation of
          Allocate : begin
             if not BuffersAllocated then begin
                New(ADC) ;
                New(Buf) ;
                BuffersAllocated := True ;
                end ;
             end ;
          Deallocate : begin
             if BuffersAllocated then begin
                Dispose(ADC) ;
                Dispose(Buf) ;
                BuffersAllocated := False ;
                end ;
             end ;
          end ;
     end ;


procedure TEditFrm.FormShow(Sender: TObject);
{ ---------------------------------------
  Initialisations done when form is shown
  ---------------------------------------}
begin
     { Create working buffers }
     HeapBuffers( Allocate ) ;

     cbRecordType.items := RecordTypes ;
     cbRecordType.items.delete(0) ; {Remove 'ALL' item}

     cbChannel.items := ChannelNames ;
     cbChannel.ItemIndex := 0 ;

     XShift := 1 ;
     YShift := 1 ;

     NewFile ;

     Resize ;

     end ;

procedure TEditFrm.NewFile ;
{ ---------------------------------------------------------
  Update controls/display to account for change of data file
  ---------------------------------------------------------}
var
   i : Integer ;
begin

     { Create a back-up file }
     if FH.Numrecords > 0 then begin
        BackUpFH := FH ;
        BackUpFH.FileName := Settings.ProgDirectory + 'editrec.bak' ;
        BackUpFH.FileHandle := FileCreate( BackUpFH.FileName ) ;
        SaveHeader( BackUpFH ) ;
        for i := 1 to FH.NumRecords do begin
            GetRecord( fH, RH, i, Buf^ ) ;
            PutRecord( BackUpfH, RH, i, Buf^ ) ;
            end ;
        FileClose( BackupFH.FileHandle ) ;
        SaveRecord := False ;

        UpdateScrollBar( sbRecordNum, FH.RecordNum, 1, fH.NumRecords ) ;

        edRegion.Scale := Settings.TScale ;
        edRegion.Units := Settings.TUnits ;

        edRecRange.LoLimit := 1 ;
        edRecRange.LoValue := 1 ;
        edRecRange.HiLimit := 1E30 ;
        edRecRange.HiLimit := fH.NumRecords ;
        edRecRange.HiValue := edRecRange.HiLimit ;

        InitialiseDisplay ;
        DisplayRecord ;
        end
     else Close ;

     end;


procedure TEditFrm.InitialiseDisplay ;
{ --------------------------------------------------
  Initialise scope display to show selected channels
  -------------------------------------------------- }
var
   ch : Integer ;
begin
     { Set up scope display }
     scDisplay.MaxADCValue := FH.MaxADCValue ;
     scDisplay.MinADCValue := FH.MinADCValue ;
     scDisplay.DisplayGrid := Settings.DisplayGrid ;
     scDisplay.DisableChannelVisibilityButton := True ;

     scDisplay.MaxPoints := FH.NumSamples ;
     scDisplay.NumPoints := FH.NumSamples ;
     scDisplay.NumChannels := FH.NumChannels ;
     { Set channel information }
     for ch := 0 to FH.NumChannels-1 do begin
         scDisplay.ChanOffsets[ch] := Channel[ch].ChannelOffset ;
         scDisplay.ChanUnits[ch] := Channel[Ch].ADCUnits ;
         scDisplay.ChanName[ch] := Channel[Ch].ADCName ;
         scDisplay.ChanScale[ch] := Channel[ch].ADCScale ;
         scDisplay.yMin[ch] := Channel[Ch].yMin ;
         scDisplay.yMax[ch] := Channel[Ch].yMax ;
         if (ch = cbChannel.ItemIndex) then scDisplay.ChanVisible[ch] := True
                                       else scDisplay.ChanVisible[ch] := False ;
         end ;

     scDisplay.xMin := 0 ;
     scDisplay.xMax := FH.NumSamples - 1 ;
     scDisplay.xOffset := 0 ;
     scDisplay.TScale := RawFH.dt*Settings.TScale ;
     scDisplay.TUnits := Settings.TUnits ;

     scDisplay.ClearHorizontalCursors ;
     { Channel baseline }
     Cursors.Base := scDisplay.AddHorizontalCursor(
                     cbChannel.ItemIndex,
                     Settings.Colors.Cursors,
                     True,
                     'z') ;
     scDisplay.HorizontalCursors[Cursors.Base] := Channel[cbChannel.ItemIndex].ADCZero ;

     scDisplay.ClearVerticalCursors ;
     { Readout cursor position }
     Cursors.Read := scDisplay.AddVerticalCursor(cbChannel.ItemIndex,Settings.Colors.Cursors,'?ri') ;
     scDisplay.VerticalCursors[Cursors.Read] := RawFH.NumSamples div 2 ;

     { Region selection cursors }
     Cursors.C0 := scDisplay.AddVerticalCursor(cbChannel.ItemIndex,clOlive,'') ;
     Cursors.C1 := scDisplay.AddVerticalCursor(cbChannel.ItemIndex,clOlive,'') ;
     scDisplay.LinkVerticalCursors(Cursors.C0,Cursors.C1);

     scDisplay.VerticalCursors[Cursors.C0] := 1 ;
     scDisplay.VerticalCursors[Cursors.C1] := RawFH.NumSamples - 2 ;

     edSetValue.Units := Channel[cbChannel.ItemIndex].ADCUnits ;
     

     end ;


procedure TEditFrm.DisplayRecord ;
{ ===============================
  Display digitised signal record
  ===============================}
begin

     if fH.NumRecords > 0 then begin

        if SaveRecord then begin
            RH.ADCVoltageRange[cbChannel.ItemIndex] := edADCVoltageRange.Value ;
            PutRecord( fH, RH, fH.RecordNum, Buf^ ) ;
            SaveRecord := False ;
            end ;

        fH.RecordNum := SbRecordNum.position ;
        fH.CurrentRecord := SbRecordNum.position ;

        { Read record data from file and extract channel to be edited }
        GetRecord( fH, RH, fH.RecordNum, ADC^ ) ;

        scDisplay.SetDataBuf( ADC ) ;

        // Set zero level cursor
        scDisplay.HorizontalCursors[Cursors.Base] := Channel[cbChannel.ItemIndex].ADCZero ;
        scDisplay.ChanZeroAt[cbChannel.ItemIndex] := Channel[cbChannel.ItemIndex].ADCZeroAt ;
        scDisplay.ChanZeroAvg := FH.NumZeroAvg ;

        edRecordNum.LoValue := sbRecordNum.position ;
        edRecordNum.HiValue := fH.NumRecords ;

        { Show whether record has been rejected by operator }
        if RH.Status = 'ACCEPTED' then ckBadRecord.checked := False
                                   else ckBadRecord.checked := True ;
        { Show type of record }
        if cbRecordType.items.indexOf(RH.RecType) >= 0 then
             cbRecordType.ItemIndex := cbRecordType.items.indexOf(RH.RecType);
        edTime.text := format( '%f s', [RH.Time] ) ;
        edGroup.Value := RH.Number ;
        edADCVoltageRange.Value := RH.ADCVoltageRange[cbChannel.ItemIndex] ;
        edSamplingInterval.Value := RH.dt ;

        { Set signal shift/scaling steps }
        edXShift.Scale := RH.dt*Settings.TScale ;
        edXShift.Units := Settings.TUnits ;
        edXShift.Value := XShift ;
        edYShift.Scale := Channel[cbChannel.ItemIndex].ADCScale ;
        edYShift.Units := Channel[cbChannel.ItemIndex].ADCUnits ;
        edYShift.Value := YShift ;

        end ;

     end ;


procedure TEditFrm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     HeapBuffers( Deallocate ) ;
     Action := caFree ;
     end;


procedure TEditFrm.sbRecordNumChange(Sender: TObject);
begin
     DisplayRecord ;
     end;


procedure TEditFrm.ShiftHorizontal( ShiftBy : Integer ) ;
{ ---------------------------------------------
  Shift digitised signal data by SHIFTBY samples
  ----------------------------------------------}
var
   ch,iTo,iFrom,jTo,jFrom,ChOffset,EndOfData : Integer ;
   RecStart,RecEnd,Rec : Integer ;
begin

     // Get range of record to b editted
     GetRecordRange( RecStart, RecEnd ) ;

     for Rec := RecStart to RecEnd do begin

         { Read record data from file }
         GetRecord( fH, RH, Rec, ADC^ ) ;

         { Shift all channels in signal record }
         EndOfData := FH.NumSamples - 1 ;
         for ch := 0 to FH.NumChannels-1 do begin
             ChOffset := Channel[ch].ChannelOffset ;
             for iFrom := 0 to FH.NumSamples-1 do begin
                 iTo := IntLimitTo( iFrom + ShiftBy, 0, EndOfData ) ;
                 jFrom := iFrom*FH.NumChannels + ChOffset ;
                 jTo := iTo*FH.NumChannels + ChOffset ;
                 Buf^[jTo] := ADC^[jFrom] ;
                 end ;
             end ;
         { Save record back to file }
         PutRecord( fH, RH, Rec, Buf^ ) ;

         // Report progress
         Main.StatusBar.SimpleText := format(
         ' Edit Records : %d/%d records processed',
         [Rec,RecEnd] );

         { Allow other activities }
         Application.ProcessMessages ;

         end ;

     end ;


procedure TEditFrm.ShiftVertical( ShiftBy : Integer ) ;
{ ---------------------------------------------
  Shift digitised signal data by SHIFTBY samples
  ----------------------------------------------}
var
   i,j,RecStart,RecEnd,Rec : Integer ;
begin

     // Get range of record to b editted
     GetRecordRange( RecStart, RecEnd ) ;

     for Rec := RecStart to RecEnd do begin
         { Read record data from file }
         GetRecord( fH, RH, Rec, ADC^ ) ;

         { Shift the channel selected for editing up/down }
         j := Channel[cbChannel.ItemIndex].ChannelOffset ;
         for i := 0 to FH.NumSamples-1 do begin
             ADC^[j] := ADC^[j] + ShiftBy ;
             j := j + FH.NumChannels ;
             end ;
         { Save record back to file }
         PutRecord( fH, RH, Rec, ADC^ ) ;

         // Report progress
         Main.StatusBar.SimpleText := format(
         ' Edit Records : %d/%d records processed',
         [Rec,RecEnd] );

         { Allow other activities }
         Application.ProcessMessages ;

         end ;

     end ;


procedure TEditFrm.ScaleVertical( ScaleBy : single ) ;
{ ---------------------------------------------
  Scale digitised signal data by ScaleBy factor
  ---------------------------------------------}
var
   i,j,RecStart,RecEnd,Rec : Integer ;
begin

     // Get range of record to b editted
     GetRecordRange( RecStart, RecEnd ) ;

     for Rec := RecStart to RecEnd do begin
         GetRecord( fH, RH, Rec, ADC^ ) ;

         { Shift the channel selected for editing up/down }
         j := Channel[cbChannel.ItemIndex].ChannelOffset ;
         for i := 0 to FH.NumSamples-1 do begin
             ADC^[j] := Round( (ADC^[j] - Channel[cbChannel.ItemIndex].ADCZero)*ScaleBy )
                        + Channel[cbChannel.ItemIndex].ADCZero  ;
             j := j + FH.NumChannels ;
             end ;

         { Save record back to file }
         PutRecord( fH, RH, Rec, ADC^ ) ;

         // Report progress
         Main.StatusBar.SimpleText := format(
         ' Edit Records : %d/%d records processed',
         [Rec,RecEnd] );

         { Allow other activities }
         Application.ProcessMessages ;

         end ;

     end ;


procedure TEditFrm.bSetRegionClick(Sender: TObject);
{ ---------------------------------------------
  Set selected region of record to fixed value
  ---------------------------------------------}
var
   i,j,RecStart,RecEnd,Rec,iValue : Integer ;
begin

     // Get range of record to b editted
     GetRecordRange( RecStart, RecEnd ) ;

     for Rec := RecStart to RecEnd do begin

         // Load record from file
         GetRecord( fH, RH, Rec, ADC^ ) ;

         // A/D value to be set
         iValue := Round(edSetValue.Value/Channel[cbChannel.ItemIndex].ADCScale)
                   + Channel[cbChannel.ItemIndex].ADCZero ;

         { Shift the channel selected for editing up/down }
         for i := scDisplay.VerticalCursors[Cursors.C0] to
                  scDisplay.VerticalCursors[Cursors.C1] do begin
             j := (i*FH.NumChannels) + Channel[cbChannel.ItemIndex].ChannelOffset ;
             ADC^[j] := iValue ;
             end ;

         // Save record back to file
         PutRecord( fH, RH, Rec, ADC^ ) ;

         // Report progress
         Main.StatusBar.SimpleText := format(
         ' Edit Records : %d/%d records processed',
         [Rec,RecEnd] );

         { Allow other activities }
         Application.ProcessMessages ;

         end ;

     scDisplay.Invalidate ;

     end ;


{ *** Horizontal shift functions *** }

procedure TEditFrm.bLeftClick(Sender: TObject);
{ ------------------------
  Shift record to the left
  ------------------------}
begin
     ShiftHorizontal( Round(-edXShift.Value) ) ;
     scDisplay.Invalidate ;
     end;


procedure TEditFrm.Button1Click(Sender: TObject);
{ -------------------------
  Shift record to the right
  -------------------------}
begin
     ShiftHorizontal( Round(edXShift.Value) ) ;
     scDisplay.Invalidate ;
     end;


{ *** Vertical shift function *** }



procedure TEditFrm.bUpClick(Sender: TObject);
{ ---------------------------
  Shift channel up vertically
  ---------------------------}
begin
     ShiftVertical( Round(edYShift.Value) ) ;
     scDisplay.Invalidate ;
     end;


procedure TEditFrm.bDownClick(Sender: TObject);
{ ------------------------
  Shift down up vertically
  ------------------------}
begin
     ShiftVertical( Round(-edYShift.Value) ) ;
     scDisplay.Invalidate ;
     end;

{ *** Vertical scaling function *** }

procedure TEditFrm.bScaleClick(Sender: TObject);
begin
     ScaleVertical( edYScale.Value ) ;
     scDisplay.Invalidate ;
     end;



procedure TEditFrm.bUndoClick(Sender: TObject);
// ----------------------
// Undo changes to record
// ----------------------
begin
     GetRecord(BackUpfH, RH, FH.RecordNum, Buf^ ) ;
     PutRecord( fH, RH, FH.RecordNum, Buf^ ) ;
     DisplayRecord ;
     end;


procedure TEditFrm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
{ -----------------------
  Function key processing
  -----------------------}
begin
     case key of
          VK_LEFT : scDisplay.MoveActiveVerticalCursor(-1) ;
          VK_RIGHT : scDisplay.MoveActiveVerticalCursor(1) ;
          VK_SUBTRACT : begin { - key }
                if sbRecordNum.Position > sbRecordNum.Min then begin
                   sbRecordNum.Position := sbRecordNum.Position - 1 ;
                   DisplayRecord ;
                   end ;
                end ;
          VK_ADD : begin { + key }
                if sbRecordNum.Position < sbRecordNum.Max then begin
                   sbRecordNum.Position := sbRecordNum.Position + 1 ;
                   DisplayRecord ;
                   end ;
                end ;
          VK_F1 : begin
             end ;

          $31, $32, $33, $54, $4c,$45,$4d,$46 : begin
               if (Shift = [ssCtrl]) then begin
                  { Update record type }
                  case Key of
                     $31 : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('TYP1') ;
                     $32 : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('TYP2') ;
                     $33 : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('TYP3') ;
                     $54 : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('TEST') ;
                     $4c : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('LEAK') ;
                     $45 : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('EVOK') ;
                     $4d : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('MINI') ;
                     $46 : cbRecordType.ItemIndex := cbRecordType.Items.IndexOf('FAIL') ;
                     end ;
                  RH.RecType := cbRecordType.text ;
                  PutRecordHeaderOnly( fH, RH, fH.RecordNum ) ;
                  end ;
               end ;
          $52 : begin
               if (Shift = [ssCtrl]) then begin
                  ckBadRecord.Checked := not ckBadRecord.Checked ;
                  If ckBadRecord.Checked then RH.Status := 'REJECTED'
                                         else RH.Status := 'ACCEPTED' ;
                  PutRecordHeaderOnly( fH, RH, fH.RecordNum ) ;
                  end;
               end ;
          end ;

     end;


procedure TEditFrm.cbChannelChange(Sender: TObject);
begin
     InitialiseDisplay ;
     DisplayRecord ;
     end;

procedure TEditFrm.scDisplayCursorChange(Sender: TObject);
var
   iSample,CursorPos,ch : Integer ;
begin

     edRegion.LoValue := scDisplay.VerticalCursors[Cursors.C0]*RH.dt ;
     edRegion.HiValue := scDisplay.VerticalCursors[Cursors.C1]*RH.dt ;

     { Update channel descriptors with any changes to display }
     for ch := 0 to scDisplay.NumChannels-1 do if Channel[ch].InUse then begin
         Channel[Ch].yMin := scDisplay.YMin[Ch] ;
         Channel[Ch].yMax := scDisplay.YMax[Ch] ;
         // Fix baseline if required
         if Settings.FixedZeroLevels or (Channel[ch].ADCZeroAt >= 0) then begin
            if scDisplay.HorizontalCursors[ch] <> Channel[ch].ADCZero then begin
               scDisplay.HorizontalCursors[ch] := Channel[ch].ADCZero ;
               end ;
            end
         else Channel[ch].ADCZero := scDisplay.HorizontalCursors[ch] ;
         
         end ;

     end;

procedure TEditFrm.FormResize(Sender: TObject);
{ ------------------------------------------------------
  Adjust size/position of controls when form is re-sized
  ------------------------------------------------------ }
var
     i : Integer ;
begin

     EditGrp.Top := ClientHeight - EditGrp.Height - 10 ;
     EditGrp.Width := ClientWidth - EditGrp.Left - 10 ;

     ckFixedZeroLevels.Left := scDisplay.left ;
     ckFixedZeroLevels.Top := EditGrp.Top - 5 - ckFixedZeroLevels.Height ;
     scDisplay.Height := Max( ckFixedZeroLevels.Top - scDisplay.Top -1,2) ;

     scDisplay.Width := Max( ClientWidth - scDisplay.Left - 5,2) ;

     end;


procedure TEditFrm.GetRecordRange(
          var RecStart : Integer ;
          var RecEnd : Integer ) ;
// ----------------------------------
// Get range of records to be edited
// ----------------------------------
begin

     if rbAllRecords.checked then begin
        RecStart := 1 ;
        RecEnd := FH.NumRecords ;
        end
     else if rbThisRecord.checked then begin
        RecStart := FH.RecordNum ;
        RecEnd := FH.RecordNum ;
        end
     else begin
        RecStart := Round(edRecRange.LoValue) ;
        RecEnd := Round(edRecRange.HiValue) ;
        end ;

     end ;


procedure TEditFrm.ChangeDisplayGrid ;
{ --------------------------------------------
  Update grid pattern on oscilloscope display
  -------------------------------------------- }
begin
     scDisplay.MaxADCValue := FH.MaxADCValue ;
     scDisplay.MinADCValue := FH.MinADCValue ;
     scDisplay.DisplayGrid := Settings.DisplayGrid ;
     scDisplay.Invalidate ;
     end ;


procedure  TEditFrm.ZoomOut ;
{ ---------------------------------
  Set minimum display magnification
  --------------------------------- }
begin
     scDisplay.MaxADCValue := FH.MaxADCValue ;
     scDisplay.MinADCValue := FH.MinADCValue ;
     scDisplay.ZoomOut ;
     end ;


procedure TEditFrm.edRegionKeyPress(Sender: TObject; var Key: Char);
begin
     if key = chr(13) then begin
        scDisplay.VerticalCursors[Cursors.C0] := Round(edRegion.LoValue/RH.dt) ;
        scDisplay.VerticalCursors[Cursors.C1] := Round(edRegion.HiValue/RH.dt) ;
        end ;
     end;


procedure TEditFrm.scDisplayMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
{ ---------------------------
  Display zero level mode box
  --------------------------- }
begin
     if (Button = mbRight) and (scDisplay.ActiveHorizontalCursor >=0) then begin
        ZeroFrm.EnableFromRecord := True ;     
        ZeroFrm.Chan := scDisplay.ActiveHorizontalCursor ;
        ZeroFrm.Level := Channel[ZeroFrm.Chan].ADCZero ;
        ZeroFrm.ChanName := Channel[ZeroFrm.Chan].ADCName ;
        ZeroFrm.NewZeroAt := Round(scDisplay.ScreenCoordToX( ZeroFrm.Chan, X )) ;
        ZeroFrm.OldZeroAt := Channel[ZeroFrm.Chan].ADCZeroAt ;
        ZeroFrm. NumSamplesPerRecord := scDisplay.NumPoints ;
        ZeroFrm.NumZeroAveraged := FH.NumZeroAvg ;
        ZeroFrm.MaxValue := FH.MaxADCValue ;
        ZeroFrm.Left := Self.Left + Main.Left + 10 + scDisplay.Left + X;
        ZeroFrm.Top := Self.Top + Main.Top + 10 + scDisplay.Top + Y ;
        ZeroFrm.ShowModal ;
        Channel[ZeroFrm.Chan].ADCZero := ZeroFrm.Level ;
        Channel[ZeroFrm.Chan].ADCZeroAt := ZeroFrm.NewZeroAt ;
        SaveHeader( FH ) ;
        if ZeroFrm.ModalResult = mrOK then DisplayRecord ;
        end
     else begin
        // Update zero baseline cursor
        if scDisplay.ActiveHorizontalCursor >= 0 then begin
           if Channel[cbChannel.ItemIndex].ADCZeroAt < 0 then begin
              // Fixed baseline level (update zero level to new position)
              Channel[cbChannel.ItemIndex].ADCZero :=
              scDisplay.HorizontalCursors[scDisplay.ActiveHorizontalCursor] ;
              end
           else begin
              // Baseline level computed from record (return to computed level)
              scDisplay.HorizontalCursors[scDisplay.ActiveHorizontalCursor] :=
              Channel[cbChannel.ItemIndex].ADCZero ;

              end ;
           SaveHeader( FH ) ;
           scDisplay.Invalidate ;
           end ;

        end ;
     edGroup.SetFocus ;
     end ;


procedure TEditFrm.edRecordNumKeyPress(Sender: TObject; var Key: Char);
{ ------------------------------------
  Go to record number entered by user
  -----------------------------------}
begin
     if key = #13 then begin
        sbRecordNum.Position := Round(edRecordNum.LoValue) ;
        edRecordNum.HiValue := FH.NumRecords ;
        DisplayRecord ;
        end ;
     end;

     
procedure TEditFrm.ckBadRecordClick(Sender: TObject);
{ ------------------------------------------------
  Save new record ACCEPTED/REJECTED status to file
  ------------------------------------------------}
begin
     if ckBadRecord.checked then RH.Status := 'REJECTED'
                            else RH.Status := 'ACCEPTED' ;
     PutRecordHeaderOnly( fH, RH, fH.RecordNum ) ;
     end;


procedure TEditFrm.cbRecordTypeChange(Sender: TObject);
{ -----------------------------
  Save new record type to file
  ----------------------------}
begin
     RH.RecType := cbRecordType.text ;
     PutRecordHeaderOnly( fH, RH, fH.RecordNum ) ;
     end;


procedure TEditFrm.edGroupKeyPress(Sender: TObject; var Key: Char);
{ ------------------------------------
  Save new record group number to file
  ------------------------------------}
begin
     if Key = #13 then begin
        RH.Number := Round( Edgroup.Value ) ;
        PutRecordHeaderOnly( fH, RH, fH.RecordNum ) ;
        end ;
     end;


procedure TEditFrm.edADCVoltageRangeKeyPress(Sender: TObject;
  var Key: Char);
// ----------------------------
//  Change A/D converter range
//  ---------------------------
begin
     if Key = #13 then begin
        RH.ADCVoltageRange[cbChannel.ItemIndex] := edADCVoltageRange.Value ;
        PutRecordHeaderOnly( fH, RH, fH.RecordNum ) ;
        end ;
     end ;

procedure TEditFrm.FormActivate(Sender: TObject);
begin
    ckFixedZeroLevels.Checked := Settings.FixedZeroLevels ;
    end;

procedure TEditFrm.ZeroLevelGrpClick(Sender: TObject);
// --------------------------------
// Enable/Disable fixed zero levels
// --------------------------------
begin
     Settings.FixedZeroLevels := ckFixedZeroLevels.Checked ;
     end;

procedure TEditFrm.ckFixedZeroLevelsClick(Sender: TObject);
// --------------------------------
// Enable/Disable fixed zero levels
// --------------------------------
begin
     Settings.FixedZeroLevels := ckFixedZeroLevels.Checked ;
     end;

end.
