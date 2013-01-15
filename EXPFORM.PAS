unit Expform;
{ -------------------------------------------
  General purpose data file export dialog box
  -------------------------------------------
  10/8/99 ... 32 bit version
  25/1/00 ... ConvertWCPToAxon now works correctly
  7/3/01  ... ConvertWCPToAxon modified to support 16 bit WCP files also
  25/2/02 ... ConvertWCPtoTabText now outputs sub-ranges of records correctly
              Exporting progress now appears on status bar on MDI form
  28/4/02 ... Sub-range of samples within record can now be output in
              tab-text and binary export formats
  15/5/02 ... Sub-ranges of records can now be exported to ABF files
  29.5.02 ... Spurious "V' no longer added to single letter units (WCPToAxon)
  4.3.04 .... Axon ABF file scaling factors now exported correctly when WCPchannels
              channels have different A/D voltage ranges (ConvertWCPToAxon)
              }


interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, RangeEdit, ComCtrls, maths ;

type
  TExportFormat = (FloatingPointFormat,IntegerFormat) ;
  TExportFrm = class(TForm)
    GroupBox1: TGroupBox;
    ckChannel0: TCheckBox;
    ckChannel1: TCheckBox;
    ckChannel2: TCheckBox;
    ckChannel3: TCheckBox;
    ckChannel4: TCheckBox;
    ckChannel5: TCheckBox;
    GrpRecords: TGroupBox;
    rbAllRecords: TRadioButton;
    rbRange: TRadioButton;
    GrpFormat: TGroupBox;
    rbTabText: TRadioButton;
    rbInteger: TRadioButton;
    rbFloat: TRadioButton;
    bOK: TButton;
    bCancel: TButton;
    rbpClamp: TRadioButton;
    rbCED: TRadioButton;
    ckTime: TCheckBox;
    edRecRange: TRangeEdit;
    bAbort: TButton;
    ckChannel6: TCheckBox;
    ckChannel7: TCheckBox;
    SamplesGrp: TGroupBox;
    erSamples: TRangeEdit;
    procedure bOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbTabTextClick(Sender: TObject);
    procedure rbpClampClick(Sender: TObject);
    procedure rbIntegerClick(Sender: TObject);
    procedure bAbortClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure EnableChannels( State : Boolean ) ;
    procedure ConvertWCPToTabText( FileName : string;
                                   RecStart, RecEnd : Integer ;
                                   UseTime : Boolean ;
                                   UseChannel : Array of Boolean ) ;
    procedure ConvertWCPToBinary( FileName : string;
                                  RecStart, RecEnd : Integer ;
                                  UseTime : Boolean ;
                                  UseChannel : Array of Boolean ;
                                  ExportFormat : TExportFormat ) ;
    function ConvertWCPToAxon( FileName : string ;
                               RecStart, RecEnd : Integer) : Boolean ;
  public
    { Public declarations }
  end;

var
   ExportFrm : TExportFrm ;


implementation

{$R *.DFM}

uses convert,global,fileio,shared,log,abffiles, Mdiform ;

procedure TExportFrm.FormShow(Sender: TObject);
{ -----------------------------------------
  Initialise control when form is displayed
  -----------------------------------------}
begin

     { Match the number of channel selection check boxes to the no. of channels
       and select all available channels }

     ckChannel0.Visible := True ;
     ckChannel0.Checked := True ;
     ckChannel1.Caption := Channel[0].ADCName ;
     if FH.NumChannels >= 2 then begin
        ckChannel1.Visible := True ;
        ckChannel1.Checked := True ;
        ckChannel1.Caption := Channel[1].ADCName ;
        end ;
     if FH.NumChannels >= 3 then begin
        ckChannel2.Visible := True ;
        ckChannel2.Checked := True ;
        ckChannel2.Caption := Channel[2].ADCName ;
        end ;
     if FH.NumChannels >= 4 then begin
        ckChannel3.Visible := True ;
        ckChannel3.Checked := True ;
        ckChannel3.Caption := Channel[3].ADCName ;
        end ;
     if FH.NumChannels >= 5 then begin
        ckChannel4.Visible := True ;
        ckChannel4.Checked := True ;
        ckChannel4.Caption := Channel[4].ADCName ;
        end ;
     if FH.NumChannels >= 6 then begin
        ckChannel5.Visible := True ;
        ckChannel5.Checked := True ;
        ckChannel5.Caption := Channel[5].ADCName ;
        end ;
     if FH.NumChannels >= 7 then begin
        ckChannel6.Visible := True ;
        ckChannel6.Checked := True ;
        ckChannel6.Caption := Channel[6].ADCName ;
        end ;
     if FH.NumChannels >= 8 then begin
        ckChannel7.Visible := True ;
        ckChannel7.Checked := True ;
        ckChannel7.Caption := Channel[7].ADCName ;
        end ;


     { Set range of records to be exported }
     rbAllRecords.checked := True ;
     edRecRange.LoLimit := 1 ;
     edRecRange.LoValue := 1 ;
     edRecRange.HiValue := 1 ;
     edRecRange.HiLimit := FH.NumRecords ;
     edRecRange.HiValue := FH.NumRecords ;

     // Range of samples to export (not used by CED or ABF)
     erSamples.LoLimit := 1 ;
     erSamples.LoValue := 1 ;
     erSamples.HiLimit := FH.NumSamples ;
     erSamples.HiValue := FH.NumSamples ;

     // Enable/disable channels and sample selection
     if rbpClamp.Checked or rbCED.Checked then EnableChannels ( False )
                                          else EnableChannels ( True ) ;

     end;


procedure TExportFrm.bOKClick(Sender: TObject);
{ --------------------------
  OK ... Export data to file
  --------------------------}
var
   RecStart,RecEnd : Integer ;
   ch : Integer ;
   UseChannel : Array[0..ChannelLimit] of Boolean ;
   OK : Boolean ;
begin

     bOK.Enabled := False ;
     bCancel.Enabled := False ;
     bAbort.Enabled := True ;

     { Get range of records to be exported }
     if rbAllRecords.Checked then begin
         RecStart := 1 ;
         RecEnd := FH.NumRecords ;
         end
     else begin
         RecStart := Round(edRecRange.LoValue) ;
         RecEnd := Round(edRecRange.HiValue) ;
         end ;

     { Get channels to be exported }
     for ch := 0 to ChannelLimit do UseChannel[ch] := False ;
     if ckChannel0.checked and ckChannel0.visible then UseChannel[0] := True ;
     if ckChannel1.checked and ckChannel1.visible then UseChannel[1] := True ;
     if ckChannel2.checked and ckChannel2.visible then UseChannel[2] := True ;
     if ckChannel3.checked and ckChannel3.visible then UseChannel[3] := True ;
     if ckChannel4.checked and ckChannel4.visible then UseChannel[4] := True ;
     if ckChannel5.checked and ckChannel5.visible then UseChannel[5] := True ;
     if ckChannel6.checked and ckChannel5.visible then UseChannel[6] := True ;
     if ckChannel7.checked and ckChannel5.visible then UseChannel[7] := True ;

     WriteToLogFile( format( 'File : %s', [FH.FileName] )) ;

     if rbpClamp.checked then begin
        Main.SaveDialog.FileName := ChangeFileExt( FH.FileName, 'dat' ) ;
        Main.SaveDialog.DefaultExt := 'DAT' ;
        Main.SaveDialog.Filter := 'Axon Files (*.DAT,*.ABF)|*.DAT;*.ABF' ;
        end
     else if rbCED.Checked then begin
        Main.SaveDialog.DefaultExt := 'DAT' ;
        Main.SaveDialog.Filter := 'CED Files (*.DAT)|*.DAT' ;
        end
     else if rbTabText.Checked then begin
        Main.SaveDialog.DefaultExt := 'txt' ;
        Main.SaveDialog.Filter := 'Tab Text (*.TXT)|*.TXT' ;
        end
     else begin
        Main.SaveDialog.DefaultExt := 'dat' ;
        Main.SaveDialog.Filter := 'Binary (*.DAT)|*.DAT';
        end ;

     Main.SaveDialog.FileName := ChangeFileExt( FH.FileName, '.'+Main.SaveDialog.DefaultExt ) ;
     Main.SaveDialog.options := [ofOverwritePrompt,ofHideReadOnly,ofPathMustExist] ;
     Main.SaveDialog.Title := 'Export File ' ;
     if Settings.DataDirectory <> '' then
        Main.SaveDialog.InitialDir := Settings.DataDirectory ;

     if Main.SaveDialog.execute then begin

        OK := True ;

        if FileExists( Main.SaveDialog.FileName ) then begin
           OK := DeleteFile( PChar(Main.SaveDialog.FileName) ) ;
           if not OK then
              MessageDlg( 'Unable to overwrite ' + Main.SaveDialog.FileName
                          + '. It may be in use by another program!',mtWarning, [mbOK], 0 ) ;
           end ;

        { Export to an Axon ABF format file }
        if OK and rbpClamp.checked then
           ConvertWCPToAxon( Main.SaveDialog.FileName, RecStart, RecEnd ) ;

        { Export to an ASCII tab text file }
        if OK and rbTabText.checked then
           ConvertWCPToTabText( Main.SaveDialog.FileName,
                                RecStart,RecEnd,ckTime.Checked,UseChannel) ;

        { Export to a 16 bit integer binary file }
        if OK and rbInteger.checked then
           ConvertWCPToBinary( Main.SaveDialog.FileName,
                               RecStart,RecEnd,
                               ckTime.Checked,UseChannel,IntegerFormat ) ;

        { Export to a single precision floating point file }
        if OK and rbFloat.checked then
           ConvertWCPToBinary( Main.SaveDialog.FileName,
                               RecStart, RecEnd,
                               ckTime.Checked, UseChannel, FloatingPointFormat ) ;
        end ;

     bCancel.Enabled := True ;
     bAbort.Enabled := False ;
     bOK.Enabled := True ;
     end ;


procedure TExportFrm.ConvertWCPToTabText(
          FileName : string;                { Name of file to export to }
          RecStart, RecEnd : Integer ;      { Start/end of records to export }
          UseTime : Boolean ;               { Include a time column }
          UseChannel : Array of Boolean ) ; { List of channels to export }

{ -------------------------------------------------
  Convert a WCP data file to a Tab Text format file
  -------------------------------------------------}
var
   Rec : Integer ;
   iStart, iEnd : Integer ;
   i,j,ch : Integer ;
   y,t : single ;
   s : string ;
   F : TextFile ;
   Buf : ^TIntArray ;
   RH : ^TRecHeader ;
   Done : Boolean ;
begin

     { Create buffers }
     New(RH) ;
     New(Buf) ;

     try

        { Create file to hold exported data }
        AssignFile( F, FileName ) ;
        Rewrite(F) ;

        { Write records to the data file }
        Rec := RecStart ;
        Done := False ;
        while not Done do begin

            { Read record from WCP file }
            GetRecord( FH, rH^, Rec, Buf^ ) ;

            { Only export, if it is accepted }
            if rH^.Status = 'ACCEPTED' then begin

               iStart := Round(erSamples.LoValue)-1 ;
               iEnd := Round(erSamples.HiValue)-1 ;
               t := 0.0 ;
               for i := iStart to iEnd do begin
                   s := '' ;
                   if UseTime then s := format( '%.4g', [t] ) ;
                   for ch := 0 to FH.NumChannels-1 do
                       if UseChannel[Ch] then begin
                          j := i*FH.NumChannels + Channel[ch].ChannelOffset ;
                          y := (Buf^[j]-Channel[ch].ADCZero)*Channel[ch].ADCScale ;
                          s:= s + format( #9'%.4g',[y] ) ;
                          end ;
                   WriteLn( F, s ) ;
                   t := t + rH^.dt ;
                   end ;
               end ;

            { Increment record counter and progress bar }
            Inc(Rec) ;
            Main.StatusBar.SimpleText := format(
                                         'Export : Record %d/%d exported to %s',
                                         [Rec,RecEnd,FileName] ) ;
            if (Rec > RecEnd) or bOK.Enabled then Done := True ;
            Application.ProcessMessages ;

            end ;

     finally
        Main.StatusBar.SimpleText := format(
                                     'Export : %d records exported to %s',
                                     [Rec-1,FileName] ) ;

        WriteToLogFile(Main.StatusBar.SimpleText) ;
        CloseFile(F) ;
        Dispose(Buf) ;
        Dispose(RH) ;
        end ;
     end ;


procedure TExportFrm.ConvertWCPToBinary(
          FileName : string;                { Name of file to export to }
          RecStart, RecEnd : Integer ;      { Start/end of records to export }
          UseTime : Boolean ;               { Include a time column }
          UseChannel : Array of Boolean ;   { List of channels to export }
          ExportFormat : TExportFormat      { Export format (integer/float point) }
          ) ;
{ --------------------------------------------------------------------------
  Convert a WCP data file to a binary format file (integer or floating point)
  --------------------------------------------------------------------------}
var
   Rec, nWritten : Integer ;
   iStart, iEnd : Integer ;
   iy : Smallint ;
   i,j,ch : Integer ;
   t,y : single ;
   FileHandle : Integer ;
   Buf : ^TIntArray ;
   RH : ^TRecHeader ;
   OK,Done : Boolean ;
begin

   OK := True ;
   { Create buffers }
   New(RH) ;
   New(Buf) ;

   try

       { Create file to hold exported data }
       FileHandle := FileCreate( FileName ) ;
       if FileHandle < 0 then begin
          OK := False ;
          WriteToLogFile( 'Unable to open ' + FileName ) ;
          end ;

       if OK then begin
          { Write records to the data file }
          nWritten := 0 ;
          Rec := RecStart ;
          Done := False ;
          while not Done do begin

               { Read record from WCP file }
               GetRecord( FH, rH^, Rec, Buf^ ) ;

               { Only export, if it is accepted }
               if rH^.Status = 'ACCEPTED' then begin

                  iStart := Round(erSamples.LoValue)-1 ;
                  iEnd := Round(erSamples.HiValue)-1 ;
                  t := 0.0 ;
                  for i := iStart to iEnd do begin
                      { Note. Time channel only available for floating point format }
                      if UseTime and (ExportFormat = FloatingPointFormat) then begin
                         FileWrite( FileHandle, t, SizeOf(t) ) ;
                         end ;
                      for ch := 0 to FH.NumChannels-1 do if UseChannel[Ch] then begin
                          j := i*FH.NumChannels + Channel[ch].ChannelOffset ;
                          if ExportFormat = FloatingPointFormat then begin
                             { Write 4 byte floating point }
                             y := (Buf^[j]-Channel[ch].ADCZero)*Channel[ch].ADCScale ;
                             FileWrite( FileHandle, y, SizeOf(y) ) ;
                             end
                          else begin
                             { Write 2 byte integer }
                             iy := Buf^[j] ;
                             FileWrite( FileHandle, iy , SizeOf(iy) )
                             end ;
                          end ;
                      t := t + rH^.dt ;
                      end ;
                  end ;

               { Increment record counter and progress bar }
               Main.StatusBar.SimpleText := format(
               'Export : Record %d/%d exported (binary) to %s',
               [Rec,RecEnd,FileName] ) ;

               Inc(Rec) ;
               if (Rec > RecEnd) or bOK.Enabled then Done := True ;
               Application.ProcessMessages ;

               end ;

          { Update log file }
          WriteToLogFile(format('Exported to %s', [FileName] )) ;
          if ExportFormat = FloatingPointFormat then
             WriteToLogFile(format('%d records written in floating point format.',
                                    [nWritten] ))
          else
             WriteToLogFile(format('%d records written in integer format.',
                                    [nWritten] )) ;

          end ;

   finally
       FileCloseSafe(FileHandle) ;
       Main.StatusBar.SimpleText := format(
                                     'Export : %d records exported (binary) to %s',
                                     [Rec-1,FileName] ) ;

       Dispose(Buf) ;
       Dispose(RH) ;
       end ;
   end ;


function TExportFrm.ConvertWCPToAxon(
         FileName : string ;
         RecStart, RecEnd : Integer       { Start/end of records to export }
         ) : Boolean ;
{ --------------------------------------------------
  Convert a WCP data file into an Axon ABF data file
  -------------------------------------------------- }
var
   DataStartsAtByte,NumRecordsWritten,NumBytesPerRecord : Integer ;
   Rec : Integer ;
   FileHandle,i,ch,ch1 : Integer ;
   OldRange : single ;
   Buf : ^TIntArray ;
   rH : ^TRecHeader ;
   PC6Header : ^TABF ;
   s : string ;
   Day,Month,Year,Min,Hour,Sec,Msec : Word ;
   lDay,lMonth,lYear,lMin,lHour,lSec : Integer ;
   OK,Done : Boolean ;
   ChannelGain : Single ;
begin

     OK := True ;

     New(Buf) ;
     New(rH) ;
     New(pc6Header) ;

     try

        { Open new Axon file }
        FileHandle := FileCreate( FileName ) ;
        if FileHandle < 0 then begin
           WriteToLogFile( 'Cannot create file ' + FileName ) ;
           OK := False ;
           end ;

        if OK then begin

           pc6Header^.FileType[1] := 'A' ;
           pc6Header^.FileType[2] := 'B' ;
           pc6Header^.FileType[3] := 'F' ;
           pc6Header^.FileType[4] := ' ' ;

           pc6Header^.FileVersionNumber := 1.1 ;
           pc6Header^.OperationMode := 5 ;
           pc6Header^.NumPointsIgnored := 0 ;

           DecodeDate( Now, Year, Month, Day ) ;
           lDay := Day ;
           lMonth := Month ;
           lYear := Year ;
           pc6Header^.FileStartDate := lDay + 100*lMonth + 10000*lYear ;
           DecodeTime( Now, Hour, Min, Sec, MSec ) ;
           lHour := Hour ;
           lMin := Min ;
           lSec := Sec ;
           pc6Header^.FileStartTime := lHour*3600 + lMin*60 + lSec ;

           pc6Header^.StopwatchTime := 0 ;
           pc6Header^.HeaderVersionNumber := 1.1 ;
           pc6Header^.nFileType := 1 ;
           pc6Header^.MSBinFormat := 0 ;

           pc6Header^.DataSectionPtr := 4 ;
           pc6Header^.TagSectionPtr := 0 ;
           pc6Header^.NumTagEntries := 0 ;
           pc6Header^.ScopeConfigPtr := 0 ;
           pc6Header^.NumScopes := 0 ;
           pc6Header^.DACFilePtr := 0 ;
           pc6Header^.DACFileNumEpisodes := 0 ;
           pc6Header^.DeltaArrayPtr := 0 ;
           pc6Header^.NumDeltas := 0 ;
           pc6Header^.VoiceTagPtr := 0 ;
           pc6Header^.VoiceTagEntries := 0 ;
           pc6Header^.SynchArrayPtr := 0 ;
           pc6Header^.SynchArraySize := 0 ;
           pc6Header^.DataFormat := 0 ;

           pc6Header^.ADCNumChannels := FH.NumChannels ;
           pc6Header^.ADCSampleInterval := ( FH.dt * 1E6 ) / FH.NumChannels ; {in microsecs}
           pc6Header^.ADCSecondSampleInterval := 0. ;
           pc6Header^.SynchTimeUnit := 0. ;
           pc6Header^.SecondsPerRun := 0 ;
           pc6Header^.NumSamplesPerEpisode := FH.NumSamples*FH.NumChannels ;
           pc6Header^.PreTriggerSamples := 50 ;
           pc6Header^.EpisodesPerRun := 1 ;
           pc6Header^.RunsPerTrial := 1 ;
           pc6Header^.NumberofTrials := 1 ;
           pc6Header^.AveragingMode := 0 ;
           pc6Header^.UndoRunCount := -1 ;
           pc6Header^.FirstEpisodeInRun := 1 ;
           pc6Header^.TriggerThreshold := 100 ;
           pc6Header^.TriggerSource := -2 ;
           pc6Header^.TriggerAction := 0 ;
           pc6Header^.TriggerPolarity := 0 ;
           pc6Header^.ScopeOutputInterval := 0. ;
           pc6Header^.EpisodeStartToStart := 1. ;
           pc6Header^.RunStartToStart := 1. ;
           pc6Header^.TrialStartToStart := 1. ;
           pc6Header^.AverageCount := 1 ;

           pc6Header^.DrawingStrategy := 1 ;
           pc6Header^.TiledDisplay := 0 ;
           pc6Header^.DataDisplayMode := 1 ;
           pc6Header^.DisplayAverageUpdate := -1 ;
           pc6Header^.ChannelStatsStrategy := 1 ;
           pc6Header^.CalculationPeriod := 16384 ;
           pc6Header^.SamplesPerTrace := FH.NumSamples ;
           pc6Header^.StartDisplayNum := 1 ;
           pc6Header^.FinishDisplayNum := 0 ;
           pc6Header^.MultiColor := 1 ;
           pc6Header^.ShowPNRawData := 0 ;

           pc6Header^.ADCRange := FH.ADCVoltageRange ;
           pc6Header^.DACRange := 10.24 ;
           pc6Header^.ADCResolution := Main.SESLabIO.ADCMaxValue+1 ;
           pc6Header^.DACResolution := Main.SESLabIO.ADCMaxValue+1 ;
           pc6Header^.AutoSampleEnable := 0 ;
           pc6Header^.AutoSampleAddItGain := 1. ;
           pc6Header^.AutoSampleADCNum := 0 ;

           pc6Header^.ExperimentType := 0 ;
           pc6Header^.AutoSampleEnable := 0 ;
           pc6Header^.AutoSampleADCNum := 0 ;
           pc6Header^.AutoSampleInstrument := 0 ;
           pc6Header^.AutoSampleAddItGain := 1. ;
           pc6Header^.AutoSampleFilter := 100000. ;
           pc6Header^.AutoSampleMembraneCap := 1. ;

           pc6Header^.ManualInfoStrategy := 0 ;
           pc6Header^.CellID1 := 1. ;
           pc6Header^.CellID2 := 2. ;
           pc6Header^.CellID3 := 3. ;

           { Name of program which created file }
           s := 'WinWCP' ;
           for i := 1 to High(pc6Header^.CreatorInfo) do begin
               pc6Header^.CreatorInfo[i] := ' ' ;
               if i < Length(s) then pc6Header^.CreatorInfo[i] := s[i];
               end ;

           { Experiment ident information }
           for i := 1 to High(pc6Header^.FileComment) do begin
               pc6Header^.FileComment[i] := ' ' ;
               if i < Length(FH.IdentLine) then
                  pc6Header^.FileComment[i] := FH.IdentLine[i];
               end ;

           { Analog input channel settings }

           for ch := 0 to 15 do begin

	            pc6Header^.ADCPToLChannelMap[ch] := ch ;
	            pc6Header^.ADCSamplingSeq[ch] := -1 ;

              for i := 1 to 10 do pc6Header^.ADCChannelName[ch,i] := ' ' ;
              s := format( 'Ch%d ',[ch] ) ;
              for i := 1 to 4 do pc6Header^.ADCChannelName[ch,i] := s[i] ;

              for i := 1 to 8 do pc6Header^.ADCUnits[ch,i] := ' ' ;
	            pc6Header^.ADCUnits[ch,1] := 'm' ;
              pc6Header^.ADCUnits[ch,2] := 'V' ;

	            pc6Header^.ProgrammableGain[ch] := 1. ;
	            pc6Header^.DisplayAmplification[ch] := 1. ;
	            pc6Header^.DisplayOffset[ch] := 0. ;
	            pc6Header^.InstrumentScaleFactor[ch] := 1. ;
	            pc6Header^.InstrumentOffset[ch] := 0. ;
	            pc6Header^.SignalGain[ch] := 1. ;
	            pc6Header^.SignalOffset[ch] := 0. ;
	            pc6Header^.SignalLowpassFilter[ch] := 100000. ;
	            pc6Header^.SignalHighpassFilter[ch] := 0. ;
              end ;

           { Analog output channel settings }

           for ch := 0 to 3 do begin
              for i := 1 to 10 do pc6Header^.DACChannelName[ch,i] := ' ' ;
              for i := 1 to 8 do pc6Header^.DACChannelUnits[ch,i] := ' ' ;
              pc6Header^.DACScaleFactor[ch] := 1. ;
              pc6Header^.DACHoldingLevel[ch] := 0. ;
              end ;

           pc6Header^.SignalType := 0 ;

           pc6Header^.OutEnable := 0 ;
           pc6Header^.SampleNumberOUT1 := 0 ;
           pc6Header^.SampleNumberOUT2 := 0 ;
           pc6Header^.FirstEpisodeOUT := 0 ;
           pc6Header^.LastEpisodeOut := 0 ;
           pc6Header^.PulseSamplesOUT1 := 0 ;
           pc6Header^.PulseSamplesOUT2 := 0 ;

           pc6Header^.DigitalEnable := 0 ;
           pc6Header^.WaveformSource := 0 ;
           pc6Header^.ActiveDACChannel := 0 ;
           pc6Header^.InterEpisodeLevel := 0 ;
           for i := 0 to High(pc6Header^.EpochType) do begin
               pc6Header^.EpochType[i] := 0 ;
               pc6Header^.EpochInitLevel[i] := 0. ;
               pc6Header^.EpochLevelInc[i] := 0. ;
               pc6Header^.EpochInitDuration[i] := 0 ;
               pc6Header^.EpochDurationInc[i] := 0 ;
               end ;
           pc6Header^.DigitalHolding := 0 ;
           pc6Header^.DigitalInterEpisode := 0 ;
           for i := 0 to High(pc6Header^.DigitalValue) do
               pc6Header^.DigitalValue[i] := 0 ;

           pc6Header^.DACFileStatus := 1. ;
           pc6Header^.DACFileOffset := 0. ;
           pc6Header^.DACFileEpisodeNum := 0 ;
           pc6Header^.DACFileADCNum := 0 ;
           for i := 1 to High(pc6Header^.DACFilePath) do
               pc6Header^.DACFilePath[i] := ' ' ;

           pc6Header^.ConditEnable := 0 ;
           pc6Header^.ConditChannel := 0 ;
           pc6Header^.ConditNumPulses := 0 ;
           pc6Header^.BaselineDuration := 1. ;
           pc6Header^.BaselineLevel := 0. ;
           pc6Header^.StepDuration := 1. ;
           pc6Header^.StepLevel := 0. ;
           pc6Header^.PostTrainPeriod := 1. ;
           pc6Header^.PostTrainLevel := 1. ;

           pc6Header^.ParamToVary := 0 ;
           for i := 1 to High(pc6Header^.ParamValueList) do
               pc6Header^.ParamValueList[i] := ' ' ;

           pc6Header^.AutoPeakEnable := 0 ;
           pc6Header^.AutoPeakPolarity := 0 ;
           pc6Header^.AutoPeakADCNum := 0 ;
           pc6Header^.AutoPeakSearchMode := 0 ;
           pc6Header^.AutoPeakStart := 0 ;
           pc6Header^.AutoPeakEnd := 0 ;
           pc6Header^.AutoPeakSmoothing := 1 ;
           pc6Header^.AutoPeakBaseline := -2 ;
           pc6Header^.AutoPeakAverage := 0 ;

           pc6Header^.ArithmeticEnable := 0 ;
           pc6Header^.ArithmeticUpperLimit := 1. ;
           pc6Header^.ArithmeticLowerLimit := 0. ;
           pc6Header^.ArithmeticADCNumA := 0 ;
           pc6Header^.ArithmeticADCNumB := 0 ;
           pc6Header^.ArithmeticK1 := 1. ;
           pc6Header^.ArithmeticK2 := 2. ;
           pc6Header^.ArithmeticK3 := 3. ;
           pc6Header^.ArithmeticK4 := 4. ;
           pc6Header^.ArithmeticOperator[1] := '+' ;
           pc6Header^.ArithmeticOperator[2] := ' ' ;
           for i := 1 to High(pc6Header^.ArithmeticUnits) do
               pc6Header^.ArithmeticUnits[i] := ' ' ;
           pc6Header^.ArithmeticK5 := 5. ;
           pc6Header^.ArithmeticK6 := 6. ;
           pc6Header^.ArithmeticExpression := 0 ;

           pc6Header^.PNEnable := 0 ;
           pc6Header^.PNPosition := 0 ;
           pc6Header^.PNPolarity := 1 ;
           pc6Header^.PNNumPulses := 4 ;
           pc6Header^.PNADCNum := 0 ;
           pc6Header^.PNHoldingLevel := 0. ;
           pc6Header^.PNSettlingTime := 100. ;
           pc6Header^.PNInterPulse := 100. ;

           pc6Header^.ListEnable := 0 ;

           { Get A/D voltage range from record }
           pc6Header^.ADCRange := RawFH.ADCVoltageRange ;


           { Channel scaling/units information }
           for ch := 0 to 15 do begin
               ch1 := MinInt([ch,RawFH.NumChannels-1]) ;
               pc6Header^.ADCSamplingSeq[ch] := Channel[ch1].ChannelOffset ;
               pc6Header^.SignalGain[ch] := 1. ;
            {   ChannelGain := RawFH.ADCVoltageRange / rH^.ADCVoltageRange[ch1] ;
               pc6Header^.InstrumentScaleFactor[ch] := Channel[ch1].ADCCalibrationFactor /
                                                       ChannelGain ;  }

               // Channel units
               for i := 1 to 8 do begin
                   if i <= Length(Channel[ch1].ADCUnits) then
                        pc6Header^.ADCUnits[ch,i] := Channel[ch1].ADCUnits[i]
                   else pc6Header^.ADCUnits[ch,i] := ' ' ;
                   end ;

               // Channel name
               for i := 1 to 10 do begin
                   if i <= Length(Channel[ch1].ADCName) then
                      pc6Header^.ADCChannelName[ch,i] := Channel[ch1].ADCName[i]
                   else pc6Header^.ADCChannelName[ch,i] := ' ' ;
                   end ;

               end ;

           { Write header block }
           FileSeek( FileHandle, 0, 0 ) ;
           if FileWrite(FileHandle,pc6Header^,Sizeof(pc6Header^))
              <> Sizeof(pc6Header^) then
              WriteToLogFile( 'Unable to write header to ' + FileName ) ;

           { Copy signal records from WCP to PCLAMP data file }

           NumBytesPerRecord := FH.NumSamples*FH.NumChannels*2 ;

           { Move file pointer to data section of pClamp file }
           DataStartsAtByte := 4*512 ;
           FileSeek( FileHandle, DataStartsAtByte, 0 ) ;

           { Copy records }
           NumRecordsWritten := 0 ;
           OldRange := -1. ;
           Rec := RecStart ;
           Done := False ;
           while not Done do begin
               { Read record from WCP file }
               GetRecord( FH, rH^, Rec, Buf^ ) ;
               { Only export, if it is accepted }
               if rH^.Status = 'ACCEPTED' then begin

                  // Update channel scaling factors
                  for ch := 0 to 15 do begin
                      ch1 := MinInt([ch,RawFH.NumChannels-1]) ;
                      ChannelGain := RawFH.ADCVoltageRange / rH^.ADCVoltageRange[ch1] ;
                      pc6Header^.InstrumentScaleFactor[ch] := Channel[ch1].ADCCalibrationFactor
                                                              *ChannelGain ;
                      end ;

                  { Note, if records do not have same A/D voltage range,
                    there will be scaling errors in the pCLAMP file }
                  if (OldRange <> rh^.ADCVoltageRange[0]) and (OldRange <> -1. ) then
                     MessageDlg(
                    'Data file incompatible. ABF records incorrectly scaled.',
                     mtWarning,[mbOK],0);
                  OldRange := rh^.ADCVoltageRange[0] ;

                  Inc(NumRecordsWritten) ;

                  { Write A/D samples to pClamp file }
                  if FileWrite( FileHandle, Buf^, NumBytesPerRecord )
                     <> NumBytesPerRecord then
                     WriteToLogFile( format('Error writing rec#%d to %s',
                                             [Rec,FileName])) ;

                  end ;

               { Display progress }
               Main.StatusBar.SimpleText := format(
               'Export : Record %d/%d exported to %s (ABF format)',
               [Rec,RecEnd,FileName] ) ;

               { Increment record counter and exit loop when done or aborted }
               Inc(Rec) ;
               if (Rec > RecEnd) or bOK.Enabled then Done := True ;
               { Allow other button clicks etc. to be processed }
               Application.ProcessMessages ;
               end ;

           { Update header with number of records written }
           pc6Header^.ActualAcqLength := FH.NumSamples*FH.NumChannels*NumRecordsWritten ;
           pc6Header^.ActualEpisodes := NumRecordsWritten ;

           { Write header to file }
           FileSeek( FileHandle, 0, 0 ) ;
           if FileWrite(FileHandle,pc6Header^,Sizeof(pc6Header^))
              <> Sizeof(pc6Header^) then
              WriteToLogFile( 'Unable to write header to ' + FileName ) ;

           WriteToLogFile( 'File : ' + FH.FileName ) ;
           WriteToLogFile( 'converted to pCLAMP (Axon ABF) file : ' + FileName ) ;

           // Final report
           Main.StatusBar.SimpleText := format(
           'Export : %d records from range %d-%d exported to %s (Axon ABF format)',
           [NumRecordsWritten,RecStart,RecEnd,FileName] ) ;

           { Close pClamp file }
           FileCloseSafe( FileHandle ) ;
           end ;

     finally

        Dispose(pc6Header) ;
        Dispose(rH) ;
        Dispose(Buf) ;
        end ;

     end ;


procedure TExportFrm.rbTabTextClick(Sender: TObject);
begin
     EnableChannels( True ) ;

     end;


procedure TExportFrm.rbpClampClick(Sender: TObject);
{ --------------------------------------------------------
  Enable all channels, if exporting to an Axon or CED file
  -------------------------------------------------------- }
begin
     ckTime.checked := True ;
     ckChannel0.checked := True ;
     if FH.NumChannels >=2 then ckChannel1.checked := True ;
     if FH.NumChannels >=3 then ckChannel2.checked := True ;
     if FH.NumChannels >=4 then ckChannel3.checked := True ;
     if FH.NumChannels >=5 then ckChannel4.checked := True ;
     if FH.NumChannels >=6 then ckChannel5.checked := True ;
     { Disable any changes to channels }
     EnableChannels ( False ) ;
     end;


procedure TExportFrm.EnableChannels( State : Boolean ) ;
{ ------------------------------------------------------
  Enable/disable changes to channel selected check boxes
  ------------------------------------------------------}
begin
     ckTime.Enabled := State ;
     ckChannel0.Enabled := State ;
     ckChannel1.Enabled := State ;
     ckChannel2.Enabled := State ;
     ckChannel3.Enabled := State ;
     ckChannel4.Enabled := State ;
     ckChannel5.Enabled := State ;

     erSamples.LoValue := 1 ;
     erSamples.HiValue := FH.NumSamples ;
     erSamples.Enabled := State ;

     end ;

procedure TExportFrm.rbIntegerClick(Sender: TObject);
{ ---------------------------------------------
  Time channel not available for integer output
  ---------------------------------------------}
begin
     EnableChannels( True ) ;
     ckTime.Checked := False ;
     ckTime.Enabled := False ;
     end;

procedure TExportFrm.bAbortClick(Sender: TObject);
{ -----------------------
  Abort exporting of data
  ----------------------- }
begin
     { OK Button disabled indicates that an export sequence is in progress
       Enabling it terminates the exporting code }
     bOK.Enabled := True ;
     end;

procedure TExportFrm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     { Prevent the form being closed if exporting is in progress }
     CanClose := bOK.Enabled ;
     end;

end.
