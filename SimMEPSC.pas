unit SimMEPSC;
{ ============================================================
  WinWCP - SimmEPSC.pas
           Miniature excitatory postsynaptic current simulation
           (c) J. Dempster, University of Strathclyde 1999
  ============================================================
  12/9/99
  30/10/99 ... NewFile method added
  3/12/00 ... Double exponential decay, LP filter and drifting added
  9/1/01 .... MEPC now simulated using multi-state channel model
              A + R <-> AR <-> AR* + B <-> ARB
  20/5/01 ... Binding rate can now be set, ion channel model graphic added
  24.6.03 ... No. of display grid lines can be changed
  01.01.04 .. Out of memory error blocked when windows resized to tiny size
  24.04.06 .. Record duration now set within dialog box
  21.06.10 .. Parameters now stored in Settings.MEPSCSim and winwcp.INI file
  16.11.11 .. No. Samples box added to control panel
  }


interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls,
  global, shared, maths, fileio, ValEdit, ScopeDisplay, math, ComCtrls,
  ValidatedEdit, seslabio, strutils ;

type
  TSimMEPSCFrm = class(TForm)
    GroupBox1: TGroupBox;
    bStart: TButton;
    bAbort: TButton;
    IonCurrentGrp: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    edUnitCurrent: TValidatedEdit;
    edNumChannelsAvg: TValidatedEdit;
    edNumChannelsStDev: TValidatedEdit;
    edNumRecords: TValidatedEdit;
    ModelGrp: TGroupBox;
    edOpenRate: TValidatedEdit;
    edCloseRate: TValidatedEdit;
    edUnbindRate: TValidatedEdit;
    edBlockRate: TValidatedEdit;
    edUnblockRate: TValidatedEdit;
    Image1: TImage;
    RecCondGrp: TGroupBox;
    Label9: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    edNoiseRMS: TValidatedEdit;
    edLPFilter: TValidatedEdit;
    edDrift: TValidatedEdit;
    rbLPFilterOn: TRadioButton;
    rbLPFilterOff: TRadioButton;
    edBindRate: TValidatedEdit;
    Shape1: TShape;
    edTransmitterDecayTime: TValidatedEdit;
    Label3: TLabel;
    Label5: TLabel;
    edRecordDuration: TValidatedEdit;
    scDisplay: TScopeDisplay;
    Label12: TLabel;
    edNumSamples: TValidatedEdit;
    procedure bStartClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bAbortClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormResize(Sender: TObject);
    procedure scDisplayCursorChange(Sender: TObject);
    procedure edNumSamplesKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure HeapBuffers( Operation : THeapBufferOp ) ;
    procedure EditFieldsToSettings ;
    function CheckNewDataFileNeeded : Boolean ;
  public
    { Public declarations }
     procedure ChangeDisplayGrid ;
     procedure ZoomOut ;
     procedure NewFile ;
  end;

var
  SimMEPSCFrm: TSimMEPSCFrm;

implementation

{$R *.DFM}

uses mdiform ;

const
     ChSim = 0 ;
var
   ADC : ^TSmallIntArray ; { Digitised signal buffer }

   BuffersAllocated : boolean ;{ Indicates if memory buffers have been allocated }

procedure TSimMEPSCFrm.HeapBuffers( Operation : THeapBufferOp ) ;
{ -----------------------------------------------
  Allocate/deallocation dynamic buffers from heap
  -----------------------------------------------}
begin
     case Operation of
          Allocate : begin
             if not BuffersAllocated then begin
                New(ADC) ;
                BuffersAllocated := True ;
                end ;
             end ;
          Deallocate : begin
             if BuffersAllocated then begin
                Dispose(ADC) ;
                BuffersAllocated := False ;
                end ;
             end ;
          end ;
     end ;


procedure TSimMEPSCFrm.FormShow(Sender: TObject);
{ --------------------------------------
  Initialisations when form is displayed
  --------------------------------------}
begin

     { Create buffers }
     HeapBuffers( Allocate ) ;

     bStart.Enabled := True ;
     bAbort.Enabled := False ;

     edNumSamples.Value := Settings.NumSamples ;
     edNumRecords.Value := Settings.MEPSCSim.NumRecords ;
     edRecordDuration.Value := Settings.MEPSCSim.RecordDuration ;
     edUnitCurrent.Value := Settings.MEPSCSim.UnitCurrent ;
     edTransmitterDecayTime.Value := Settings.MEPSCSim.TransmitterDecayTime ;
     edBindRate.Value := Settings.MEPSCSim.BindingRate ;
     edOpenRate.Value := Settings.MEPSCSim.OpenRate ;
     edCloseRate.Value := Settings.MEPSCSim.CloseRate ;
     edUnbindRate.Value := Settings.MEPSCSim.UnbindRate ;
     edBlockRate.Value := Settings.MEPSCSim.BlockRate ;
     edNoiseRMS.Value := Settings.MEPSCSim.NoiseRMS ;
     edLPFilter.Value := Settings.MEPSCSim.LPFilter ;
     rbLPFilterOn.Checked := Settings.MEPSCSim.LPFilterInUse ;
     edDrift.Value := Settings.MEPSCSim.Drift ;

     NewFile ;


     Resize ;
     end ;


procedure TSimMEPSCFrm.NewFile ;
{ ---------------------------------------------------------
  Update controls/display to account for change of data file
  ---------------------------------------------------------}
var
   ch,i : Integer ;
   dt : Single ;
begin

     Channel[ChSim].InUse := True ;
     if RawFH.NumRecords = 0 then begin
        Channel[ChSim].ADCUnits := 'pA' ;
        Channel[ChSim].ADCName := 'Im' ;
        Channel[ChSim].ADCZero := 0 ;
        Channel[ChSim].ChannelOffset := 0 ;
        RawFH.NumChannels := 1 ;
        end ;

     { Set up Display }
     scDisplay.MaxADCValue := Main.SESLabIO.ADCMaxValue ;
     scDisplay.MinADCValue := Main.SESLabIO.ADCMinValue ;
     scDisplay.DisplayGrid := Settings.DisplayGrid ;

     scDisplay.MaxPoints := Settings.NumSamples ;
     scDisplay.NumPoints := Settings.NumSamples ;
     scDisplay.NumChannels := 1 ;
     { Set channel information }
     for ch := 0 to scDisplay.NumChannels-1 do begin
         scDisplay.ChanOffsets[ch] := Channel[ch].ChannelOffset ;
         scDisplay.ChanUnits[ch] := Channel[Ch].ADCUnits ;
         scDisplay.ChanName[ch] := Channel[Ch].ADCName ;
         scDisplay.ChanScale[ch] := Channel[ch].ADCScale ;
         Channel[Ch].yMin := scDisplay.MinADCValue ;
         Channel[Ch].yMax := scDisplay.MaxADCValue ;
         scDisplay.yMin[ch] := Channel[Ch].yMin ;
         scDisplay.yMax[ch] := Channel[Ch].yMax ;
         if ch = ChSim then scDisplay.ChanVisible[ch] := True
                       else scDisplay.ChanVisible[ch] := False ;
         end ;

     scDisplay.xMin := 0 ;
     scDisplay.xMax := Settings.NumSamples - 1  ;
     scDisplay.HorizontalCursors[0] := Channel[ChSim].ADCZero ;

     dt := edRecordDuration.Value / Settings.NumSamples ;
     scDisplay.TScale := dt*Settings.TScale ;
     scDisplay.TUnits := Settings.TUnits ;

     edUnitCurrent.Units := Channel[ChSim].ADCUnits ;

     { Clear all channels }
     for i := 0 to scDisplay.NumChannels*Settings.NumSamples-1 do ADC^[i] := 0 ;

     scDisplay.SetDataBuf( ADC ) ;

     scDisplay.AddHorizontalCursor(0,Settings.Colors.Cursors,True,'z') ;

     Resize ;

     end ;


procedure TSimMEPSCFrm.bStartClick(Sender: TObject);
{ -------------------------
  Create simulated currents
  -------------------------}
type
    TState = (Unbound,Closed,Open,Blocked) ;
var
   iZeroLevel,i,j,Ch,iStart,Chan : Integer ;
   Done : Boolean ;
   Current,Drift,TEnd,TDwell,t : single ;
   State : TState ;
   RH : TRecHeader ;
begin

     { Set buttons to be active during simulation run }
     bStart.Enabled := False ;
     bAbort.Enabled := True ;

     // Get settings
     EditFieldsToSettings ;
     if not CheckNewDataFileNeeded then Exit ;

     RawFH.NumSamples := Settings.NumSamples ;
     RawFH.NumChannels := scDisplay.NumChannels ;
     RawFH.dt := edRecordDuration.Value / RawFH.NumSamples ;

     { Set scaling factor if this is an empty file }
     if RawFH.NumRecords = 0 then begin
        Channel[ChSim].ADCCalibrationFactor := 1. ;
        Channel[ChSim].ADCScale := Abs( Settings.MEPSCSim.UnitCurrent*
                                        (edNumChannelsAvg.Value +
                                         5.0*edNumChannelsStDev.Value)
                                         + 5.0*Settings.MEPSCSim.NoiseRMS ) / Main.SESLabIO.ADCMaxValue ;
        if Channel[ChSim].ADCScale = 0.0 then
           Channel[ChSim].ADCScale := 1./Main.SESLabIO.ADCMaxValue ;
        RawFH.ADCVoltageRange := 5.0 ;
        Channel[ChSim].ADCCalibrationFactor := RawFH.ADCVoltageRange /
                          ( Channel[ChSim].ADCScale * (Main.SESLabIO.ADCMaxValue+1) ) ;

        RawFH.MaxADCValue := Main.SESLabIO.ADCMaxValue ;
        RawFH.MinADCValue := -Main.SESLabIO.ADCMaxValue -1 ;
        end ;

     if Settings.MEPSCSim.UnitCurrent > 0.0 then
        Channel[ChSim].ADCZero := Main.SESLabIO.ADCMinValue div 2
     else Channel[ChSim].ADCZero := Main.SESLabIO.ADCMaxValue div 2 ;
     scDisplay.HorizontalCursors[0] := Channel[ChSim].ADCZero ;
     Channel[ChSim].ChannelOffset := 0 ;

     // Ensure display channel scaling factor is up to date
     scDisplay.ChanScale[ChSim] := Channel[ChSim].ADCScale ;

     { *** Simulation loop *** }

     Done := False ;
     iZeroLevel := Channel[ChSim].ADCZero ;
     Settings.MEPSCSim.NumRecordsDone := 0 ;
     while (not Done) do begin

        { Number of ion channels in mEPSC }
        Settings.MEPSCSim.NumChannels := Round( RandG( edNumChannelsAvg.Value,
                                         edNumChannelsStDev.Value )) ;

        { Initialise signal record to zero level }
        j := Channel[ChSim].ChannelOffset ;
        for i := 0 to RawFH.NumSamples-1 do begin
            ADC^[j] := Channel[ChSim].ADCZero ;
            j := j + RawFH.NumChannels ;
            end ;

        { Add open/close current sequence for each ion channel }
        iStart := RawFH.NumSamples div 10 ;
        for Chan := 0 to Settings.MEPSCSim.NumChannels-1 do begin

           { Initial starting point of MEPC }
           j := iStart*RawFH.NumChannels + Channel[ChSim].ChannelOffset ;

           { Initial state at start of MEPC ... agonist is bound, channel closed }
           State := Unbound ;

           TEnd := 0.0 ;
           t := 0.0 ;
           while j < (RawFH.NumSamples*RawFH.NumChannels) do begin

               case State of
                Unbound : begin
                   Current := 0.0 ;
                   if t < (Settings.MEPSCSim.TransmitterDecayTime*10.0) then
                      TDwell := -ln(random)/Settings.MEPSCSim.BindingRate*exp(-t/Settings.MEPSCSim.TransmitterDecayTime)
                   else TDwell := RawFH.NumSamples*RawFH.dt ;
                   State := Closed ;
                   end ;
                { Close state processing }
                Closed : begin
                   Current := 0.0 ;
                   TDwell := -Settings.MEPSCSim.TClosed*ln(random) ;
                   if Random <= Settings.MEPSCSim.PUnbind then State := Unbound
                                            else State := Open ;
                   end ;
                { Open state processing }
                Open : begin
                   Current := Settings.MEPSCSim.UnitCurrent ;
                   TDwell := -Settings.MEPSCSim.TOpen*ln(random) ;
                   if Random <= Settings.MEPSCSim.PClose then State := Closed
                                           else State := Blocked ;
                   end ;
                Blocked : begin
                   Current := 0.0 ;
                   TDwell := -Settings.MEPSCSim.TBlocked*ln(random) ;
                   State := Open ;
                   end ;
                end ;

               TEnd := TEnd + TDwell ;
               while (t <= TEnd) and (j < (RawFH.NumSamples*RawFH.NumChannels)) do begin
                    ADC^[j] := ADC^[j] + Round(Current/Channel[ChSim].ADCScale) ;
                    t := t + RawFH.dt ;
                    j := j + RawFH.NumChannels ;
                    end ;
               end ;
            end ;

        { Add Background noise & Drift }
        j := Channel[ChSim].ChannelOffset ;
        Drift := (2.0*(Random - 0.5)*edDrift.Value)/RawFH.NumSamples ;
        for i := 0 to RawFH.NumSamples-1 do begin
            ADC^[j] := ADC^[j] +
                       Round( (RandG(0.0,Settings.MEPSCSim.NoiseRMS)+Drift*i)
                               /Channel[ChSim].ADCScale ) ;
            j := j + RawFH.NumChannels ;
            end ;

        { Low pass filter signal (if required) }
        if rbLPFilterOn.Checked and (edLPFilter.Value > 0.0) then
           GaussianFilter( RawFH, ADC^, edLPFilter.Value*RawFH.dt ) ;

        { Save Record to file }
        Inc(RawFH.NumRecords) ;
        RH.Status := 'ACCEPTED' ;
        RH.RecType := 'TEST' ;
        RH.Number := RawfH.NumRecords ;
        RH.Time := RH.Number ;
        RH.dt := RawfH.dt ;
        for ch := 0 to RawFH.NumChannels-1 do
             RH.ADCVoltageRange[Ch] := RawFH.ADCVoltageRange ;
        RH.Value[vFitEquation] := 0.0 ;
        RH.AnalysisAvailable := False ;
        RH.Ident := ' ' ;
        PutRecord( RawfH, RH, RawfH.NumRecords, ADC^ ) ;

        scDisplay.Invalidate ;

        Inc(Settings.MEPSCSim.NumRecordsDone) ;
        if (Settings.MEPSCSim.NumRecordsDone >= Settings.MEPSCSim.NumRecords) or bStart.Enabled then Done := True ;

        // Report progress
        Main.StatusBar.SimpleText := format(
        ' Miniature EPSC Settings.MEPSCSim.lation : %d/%d records done ',
        [Settings.MEPSCSim.NumRecordsDone,Settings.MEPSCSim.NumRecords] ) ;

        Application.ProcessMessages ;

        end ;

     { Close form if Settings.MEPSCSim.lation has not been aborted }

     // Final report 
     Main.StatusBar.SimpleText := format(
     ' Miniature EPSC Settings.MEPSCSim.lation : %d records created ',
     [Settings.MEPSCSim.NumRecordsDone] ) ;

     bStart.Enabled := True ;
     bAbort.Enabled := False ;
     SaveHeader( RawFH ) ;

     WriteToLogFile(format('%d Settings.MEPSCSim.lated mEPSCs created',[Settings.MEPSCSim.NumRecords])) ;
     WriteToLogFile(format('Avg. number of channels %.0f',[edNumChannelsAvg.Value])) ;
     WriteToLogFile(format('Standard deviation %.0f',[edNumChannelsStDev.Value])) ;
     WriteToLogFile(format('Unitary current %.f',[edUnitCurrent.Value])) ;
     WriteToLogFile(format('Channel opening rate %.0f',[edOpenRate.Value])) ;
     WriteToLogFile(format('Channel closing rate %.0f',[edCloseRate.Value])) ;
     WriteToLogFile(format('Agonist unbinding rate %.0f',[edUnbindRate.Value])) ;
     WriteToLogFile(format('Channel blocking rate %.0f',[edBlockRate.Value])) ;
     WriteToLogFile(format('Channel unblocking rate %.0f',[edUnblockRate.Value])) ;

     end;


procedure TSimMEPSCFrm.EditFieldsToSettings ;
// ------------------------------
// Save settings from edit fields
// ------------------------------
begin

     { Get parameters from edit boxes }

     Settings.NumSamples := Min(Round(edNumSamples.Value),Main.SESLabIO.ADCBufferLimit) ;
     Settings.NumSamples := 256*Max(Settings.NumSamples div 256,1) ;
     edNumSamples.Value := Settings.NumSamples ;

     Settings.MEPSCSim.NumRecords := Round(edNumRecords.Value) ;
     Settings.MEPSCSim.RecordDuration := edRecordDuration.Value ;
     Settings.MEPSCSim.UnitCurrent := edUnitCurrent.Value ;
     Settings.MEPSCSim.TransmitterDecayTime := edTransmitterDecayTime.Value ;

     Settings.MEPSCSim.BindingRate :=  edBindRate.Value ;
     Settings.MEPSCSim.OpenRate := edOpenRate.Value ;
     Settings.MEPSCSim.CloseRate :=  edCloseRate.Value ;
     Settings.MEPSCSim.UnbindRate :=  edUnbindRate.Value ;
     Settings.MEPSCSim.BlockRate := edBlockRate.Value ;
     Settings.MEPSCSim.UnBlockRate := edUnBlockRate.Value ;

     Settings.MEPSCSim.BindingRate := edBindRate.Value ;
     Settings.MEPSCSim.TClosed := 1.0/(edOpenRate.Value + edUnbindRate.Value) ;
     Settings.MEPSCSim.TOpen := 1.0 / (edCloseRate.Value + edBlockRate.Value) ;
     Settings.MEPSCSim.PUnbind := edUnbindRate.Value / (edUnbindRate.Value + edOpenRate.Value) ;
     Settings.MEPSCSim.TBlocked := 1.0 / edUnBlockRate.Value ;
     Settings.MEPSCSim.PClose := edCloseRate.Value / (edCloseRate.Value + edBlockRate.Value) ;

     Settings.MEPSCSim.NoiseRMS := edNoiseRMS.Value ;
     Settings.MEPSCSim.LPFilter := edLPFilter.Value ;

     Settings.MEPSCSim.LPFilterInUse := rbLPFilterOn.Checked ;
     Settings.MEPSCSim.Drift := edDrift.Value ;

     end ;


procedure TSimMEPSCFrm.FormClose(Sender: TObject;
  var Action: TCloseAction);
{ ------------------------
  Tidy up when form closed
  ------------------------}
begin

     HeapBuffers( Deallocate ) ;

     // Copy settings from edit fields into settings record
     EditFieldsToSettings ;

     SaveHeader( RawFH ) ;

     if RawFH.NumRecords > 0 then begin
        Main.mnShowRaw.Enabled := True ;
        Main.mnShowRaw.Click ;
        Main.mnZoomOutAll.Click ;
        end ;

     Action := caFree ;

     end;


procedure TSimMEPSCFrm.bAbortClick(Sender: TObject);
{ ------------------------------------
  ABORT button - Aborts Settings.MEPSCSim.lation run
  ------------------------------------}
begin
     bStart.Enabled := True ;
     bAbort.Enabled := False ;
     end;


procedure TSimMEPSCFrm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     { Prevent form being closed if a Settings.MEPSCSim.lation is running (Start button disabled) }
     if bStart.Enabled then CanClose := True
                       else CanClose := False ;
     end;

procedure TSimMEPSCFrm.FormResize(Sender: TObject);
{ ------------------------------------------------------
  Adjust size/position of controls when form is re-sized
  ------------------------------------------------------ }
begin
      RecCondGrp.Top := ClientHeight - RecCondGrp.Height - 5 ;
      ModelGrp.Top := RecCondGrp.Top ;
      ModelGrp.Width := ClientWidth - ModelGrp.Left - 5 ;
      scDisplay.Height := MaxInt( [ModelGrp.Top - scDisplay.Top - 10,2]) ;
      scDisplay.Width := MaxInt( [ModelGrp.Width,2]) ;
      end;



procedure TSimMEPSCFrm.scDisplayCursorChange(Sender: TObject);
begin
     Channel[ChSim].yMin := scDisplay.YMin[ChSim] ;
     Channel[ChSim].yMax := scDisplay.YMax[ChSim] ;
     end;


procedure TSimMEPSCFrm.ChangeDisplayGrid ;
{ --------------------------------------------
  Update grid pattern on oscilloscope display
  -------------------------------------------- }
begin
     scDisplay.MaxADCValue := Main.SESLabIO.ADCMaxValue ;
     scDisplay.MinADCValue := Main.SESLabIO.ADCMinValue ;
     scDisplay.DisplayGrid := Settings.DisplayGrid ;

     scDisplay.Invalidate ;
     end ;


procedure  TSimMEPSCFrm.ZoomOut ;
{ ---------------------------------
  Set minimum display magnification
  --------------------------------- }
begin
     scDisplay.MaxADCValue := Main.SESLabIO.ADCMaxValue ;
     scDisplay.MinADCValue := Main.SESLabIO.ADCMinValue ;
     scDisplay.ZoomOut ;
     end ;

function TSimMEPSCFrm.CheckNewDataFileNeeded : Boolean ;
// ------------------------------------------------------------
// Check record size and created a new file if size has changed
// ------------------------------------------------------------
var
    NewFileNeeded : Boolean ;
    NewFileName : String ;
begin

     NewFileNeeded := False ;
     Result := True ;

     // Not required if file is empty
     if RawFH.NumRecords <= 0 then Exit ;

     if RawFH.NumChannels <> 1 then NewFileNeeded := True ;
     if RawFH.NumSamples <> Round(edNumSamples.Value) then NewFileNeeded := True ;

     if NewFileNeeded then begin
        // New file with '+' added to end of file name
        NewFileName := ANSIReplaceText( RawFH.FileName,'.wcp','+.wcp') ;
        if not FileExists(NewFileName) then begin
           Main.CreateNewDataFile( NewFileName ) ;
           end
        else begin
           ShowMessage('Additional data file ' + NewFileName + ' already exists. New data file required!') ;
           Result := False ;
           end ;

        end ;
     end ;



procedure TSimMEPSCFrm.edNumSamplesKeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #13 then EditFieldsToSettings ;
     end;

initialization
     BuffersAllocated := False ;
end.
