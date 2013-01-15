unit exportUnit;
{ ================================================================
  WinWCP (c) J. Dempster, University of Strathclyde, 1998-99
  Data file export module
  ================================================================
  5/2/00
  28/2/00 ... Change File Name now works, channel captions updated
  9/2/02 ... V2.2.6 ASCII text export added
  26/2/02 ... V2.3.0 ASCII text export now works properly
              Progress reported to main status bar
  14/08/02 ... Bug which prevented export when output file did not exist fixed  (V2.3.4)
  1/12/03 .... Export now uses TADCDataFile component
  19/04/03 ... Modified for use by WinWCP
  22/04/04 ... IGOR export added
  19/10/06 ... Now exports average and leak-subtracted as well as raw records
  18/12/06 ... Export to IGOR Binary Wave format files now works
  01/02/06 ... Exports to EDR files now scaled correctly
               A/D Voltage range differences stored within WCP records
               stored in .ChannelGain
  05.09.07 ... Bugs in export file naming fixed.
               Files can now be exported to folders with '.' in name
               new function used CreateExportFileName
  27.01.08 ... Sampling interval for export file now derived from record header
               of selected series of records. If sampling interval varies within
               exported series, a warning message is displayed
  30.05.08 ... FP Errors when RH.ADCVoltageRange = 0 fixed
  }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, RangeEdit, global, ADCDataFile, maths, strutils ;

type
  TExportFrm = class(TForm)
    GroupBox8: TGroupBox;
    rbAllRecords: TRadioButton;
    rbRange: TRadioButton;
    edRange: TRangeEdit;
    ChannelsGrp: TGroupBox;
    ckCh0: TCheckBox;
    ckCh1: TCheckBox;
    ckCh2: TCheckBox;
    ckCh3: TCheckBox;
    ckCh4: TCheckBox;
    ckCh5: TCheckBox;
    ckCh6: TCheckBox;
    ckCh7: TCheckBox;
    GroupBox3: TGroupBox;
    edFileName: TEdit;
    GroupBox2: TGroupBox;
    rbABF: TRadioButton;
    rbCFS: TRadioButton;
    bChangeName: TButton;
    bOK: TButton;
    bCancel: TButton;
    SaveDialog: TSaveDialog;
    rbASCII: TRadioButton;
    rbEDR: TRadioButton;
    ExportFile: TADCDataFile;
    rbWCP: TRadioButton;
    rbIGOR: TRadioButton;
    procedure FormShow(Sender: TObject);
    procedure bChangeNameClick(Sender: TObject);
    procedure rbABFClick(Sender: TObject);
    procedure rbLDTClick(Sender: TObject);
    procedure rbCFSClick(Sender: TObject);
    procedure rbASCIIClick(Sender: TObject);
    procedure rbEDRClick(Sender: TObject);
    procedure k(Sender: TObject);
    procedure rbIGORClick(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure rbRangeClick(Sender: TObject);
    procedure rbAllRecordsClick(Sender: TObject);
    procedure edRangeKeyPress(Sender: TObject; var Key: Char);
    procedure rbWCPClick(Sender: TObject);
  private
    { Private declarations }
    BaseExportFileName : string ;
    procedure SetChannel( CheckBox : TCheckBox ; ch : Integer ) ;
    function CreateExportFileName(FileName : string ) : String ;

    procedure ExportToFile;
    procedure ExportToIGORFile;
  public
    { Public declarations }
  end;

var
  ExportFrm: TExportFrm;

implementation

uses Mdiform, fileio ;

{$R *.DFM}


procedure TExportFrm.FormShow(Sender: TObject);
// ------------------------------
// Initialise form when displayed
// ------------------------------
begin

     { Set block of EDR file to be exported }
     edRange.LoValue := 1.0 ;
     edRange.HiLimit := FH.NumRecords ;
     edRange.HiValue := edRange.HiLimit ;

     { Update O/P file name channel selection options }
     BaseExportFileName := FH.FileName ;
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := True ;

     end;


procedure TExportFrm.SetChannel(
          CheckBox : TCheckBox ;
          ch : Integer
          ) ;
// ---------------------------
// Set channel selection state
// ---------------------------
begin
     if ch < FH.NumChannels then begin
        CheckBox.Visible := True ;
        CheckBox.Checked := Channel[ch].InUse ;
        CheckBox.Caption := Channel[ch].ADCName ;
        end
     else CheckBox.Visible := False ;
     end ;


procedure TExportFrm.ExportToFile;
// -------------------------------------------------
// Copy selected section of data file to export file
// -------------------------------------------------
type
    TSmallIntArray1 = Array[0..9999999] of SmallInt ;
var
   StartAt,EndAt,ch,i,j : Integer ;
   UseChannel : Array[0..WCPMaxChannels-1] of Boolean ; // Channels to be exported
   NumBytesPerBuf : Integer ;       // Buffer size
   InBuf : ^TSmallIntArray1 ;       // Source data buffer
   OutBuf : ^TSmallIntArray1 ;      // Output data buffer
   chOut : Integer ;
   iRec : Integer ;                 // Record counter
   RH : TRecHeader ;                // WCP record header
   NumRecordsExported : Integer ;
   ExportType : TADCDataFileType ;
   FileName : String ;
   ScanIntervalChanged : Boolean ;
   ErrMsg : String ;
begin

     if rbAllRecords.Checked then begin
        StartAt := 1 ;
        EndAt := FH.NumRecords ;
        end
     else begin
        StartAt := Round(edRange.LoValue) ;
        EndAt := Round(edRange.HiValue) ;
        end ;

     // Channels to be exported
     UseChannel[0] :=  ckCh0.Checked ;
     UseChannel[1] :=  ckCh1.Checked ;
     UseChannel[2] :=  ckCh2.Checked ;
     UseChannel[3] :=  ckCh3.Checked ;
     UseChannel[4] :=  ckCh4.Checked ;
     UseChannel[5] :=  ckCh5.Checked ;
     UseChannel[6] :=  ckCh6.Checked ;
     UseChannel[7] :=  ckCh7.Checked ;

     // Add record range to file name
     FileName := CreateExportFileName(BaseExportFileName) ;

     // If destination file already exists, allow user to abort
     if FileExists( FileName ) then begin
        if MessageDlg( FileName + ' exists! Overwrite?!',
           mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Exit ;
        end ;

     // Export file type
     if rbABF.Checked then ExportType := ftAxonABF
     else if rbASCII.Checked then ExportType := ftASC
     else if rbCFS.Checked then ExportType := ftCFS
     else if rbEDR.Checked then ExportType := ftEDR
     else ExportType := ftWCP ;

     // Create empty export data file
     ExportFile.CreateDataFile( FileName,
                                ExportType ) ;

     // Set file parameters
     ExportFile.NumScansPerRecord := FH.NumSamples ;
     ExportFile.MaxADCValue := FH.MaxADCValue ;
     ExportFile.MinADCValue := FH.MinADCValue ;
     ExportFile.ScanInterval := FH.dt ;
     ExportFile.IdentLine := FH.IdentLine ;
     ExportFile.ABFAcquisitionMode := ftEpisodic ;

     NumBytesPerBuf := FH.NumSamples*FH.NumChannels*2 ;
     GetMem( InBuf, NumBytesPerBuf ) ;
     GetMem( OutBuf, NumBytesPerBuf ) ;

     Try

     chOut := 0 ;
     for ch := 0 to FH.NumChannels-1 do if UseChannel[ch] then begin
         ExportFile.ChannelOffset[chOut] := chOut ;
         ExportFile.ChannelADCVoltageRange[chOut] := FH.ADCVoltageRange ;
         ExportFile.ChannelName[chOut] := Channel[ch].ADCName ;
         ExportFile.ChannelUnits[chOut] := Channel[ch].ADCUnits ;
         ExportFile.ChannelScale[chOut] := Channel[ch].ADCSCale ;
         ExportFile.ChannelCalibrationFactor[chOut] := Channel[ch].ADCCalibrationFactor ;
         ExportFile.ChannelGain[chOut] := Channel[ch].ADCAmplifierGain ;
         Inc(chOut) ;
         end ;
     ExportFile.NumChannelsPerScan := chOut ;

     { Copy records }
     NumRecordsExported := 0 ;
     ScanIntervalChanged := False ;
     ExportFile.ScanInterval :=  FH.dt ;
     for iRec := StartAt to EndAt do begin

         // Read record
         GetRecord(FH,RH,iRec,InBuf^) ;

         // Skip if record rejected
         if not ANSIContainsText(RH.Status,'ACCEPTED') then continue ;

         // Copy required channels
         j := 0 ;
         for i := 0 to FH.NumSamples-1 do begin
             for ch := 0 to FH.NumChannels-1 do if UseChannel[ch] then begin
                 OutBuf^[j] := InBuf^[(i*FH.NumChannels)+Channel[ch].ChannelOffset] ;
                 Inc(j) ;
                 end ;
             end ;

         Inc(NumRecordsExported) ;
         ExportFile.RecordNum := NumRecordsExported ;

         // Use last know dt value if record header dt invalid
         if RH.dt <= 0.0 then RH.dt := ExportFile.ScanInterval ;

         // Get time interval between channel scans
         if iRec <> StartAt then begin
            if ExportFile.ScanInterval <> RH.dt then ScanIntervalChanged := True ;
            end ;
         ExportFile.ScanInterval := RH.dt ;

         if ExportType = ftWCP then begin
            // Update record header (WCP file only)
            chOut := 0 ;
            for ch := 0 to FH.NumChannels-1 do if UseChannel[ch] then begin
                if RH.ADCVoltageRange[ch] = 0.0 then
                   RH.ADCVoltageRange[ch] := FH.ADCVoltageRange ;
                ExportFile.ChannelGain[chOut] := FH.ADCVoltageRange /
                                                 RH.ADCVoltageRange[ch] ;
                Inc(chOut) ;
                end ;

            ExportFile.WCPNumZeroAvg := 20 ;
            ExportFile.WCPRecordAccepted := True ;
            ExportFile.WCPRecordType := 'TEST' ;
            ExportFile.WCPRecordNumber := iRec ; ;
            ExportFile.WCPRecordTime := RH.time ;

            end
         else begin
            // Adjust calibration factor for variations in channel gain (all other formats)
            chOut := 0 ;
            for ch := 0 to FH.NumChannels-1 do if UseChannel[ch] then begin
                if RH.ADCVoltageRange[ch] = 0.0 then RH.ADCVoltageRange[ch] := FH.ADCVoltageRange ;
                ExportFile.ChannelCalibrationFactor[chOut] := Channel[ch].ADCCalibrationFactor *
                                                              (FH.ADCVoltageRange/RH.ADCVoltageRange[ch]) ;
                Inc(chOut) ;
                end ;
            end ;

         // Write to export file
         ExportFile.SaveADCBuffer( 0, FH.NumSamples, OutBuf^ ) ;

         // Report progress
         Main.StatusBar.SimpleText := format(
         ' EXPORT: Exporting record %d/%d to %s ',
         [iRec,EndAt,FileName]) ;

         end ;

     // Close export data file
     ExportFile.CloseDataFile ;

     // Final Report
     Main.StatusBar.SimpleText := format(
     ' EXPORT: %d records exported to %s ',
     [EndAt-StartAt+1,FileName]) ;
     WriteToLogFile( Main.StatusBar.SimpleText ) ;

     if ScanIntervalChanged then begin
        ErrMsg := 'Warning: time calibration errors in exported file! Sampling interval varies within exported records.' ;
        ShowMessage( ErrMsg ) ;
        WriteToLogFile( ErrMsg ) ;
        end ;

     Finally
        // Free allocated buffers
        FreeMem( InBuf ) ;
        FreeMem( OutBuf ) ;
        end ;

     end;


procedure TExportFrm.ExportToIGORFile;
// -----------------------------------------------------------
// Copy selected section of data file to IGOR Binary Wave file
// -----------------------------------------------------------
type
    TSmallIntArray1 = Array[0..9999999] of SmallInt ;
var
   StartAt,EndAt,ch,i,j : Integer ;
   UseChannel : Array[0..WCPMaxChannels-1] of Boolean ; // Channels to be exported
   NumBytesPerBuf : Integer ;       // Buffer size
   InBuf : ^TSmallIntArray1 ;       // Source data buffer
   OutBuf : ^TSmallIntArray1 ;      // Output data buffer
   iRec : Integer ;                 // Record counter
   RH : TRecHeader ;                // WCP record header
   NumRecordsExported : Integer ;
   FileName : String ;
begin


     if rbAllRecords.Checked then begin
        StartAt := 1 ;
        EndAt := FH.NumRecords ;
        end
     else begin
        StartAt := Round(edRange.LoValue) ;
        EndAt := Round(edRange.HiValue) ;
        end ;

     // Channels to be exported
     UseChannel[0] :=  ckCh0.Checked ;
     UseChannel[1] :=  ckCh1.Checked ;
     UseChannel[2] :=  ckCh2.Checked ;
     UseChannel[3] :=  ckCh3.Checked ;
     UseChannel[4] :=  ckCh4.Checked ;
     UseChannel[5] :=  ckCh5.Checked ;
     UseChannel[6] :=  ckCh6.Checked ;
     UseChannel[7] :=  ckCh7.Checked ;

     // Set file parameters
     ExportFile.NumScansPerRecord := FH.NumSamples ;
     ExportFile.MaxADCValue := FH.MaxADCValue ;
     ExportFile.MinADCValue := FH.MinADCValue ;
     ExportFile.ScanInterval := FH.dt ;
     ExportFile.IdentLine := FH.IdentLine ;
     ExportFile.ABFAcquisitionMode := ftEpisodic ;

     NumBytesPerBuf := FH.NumSamples*FH.NumChannels*2 ;
     GetMem( InBuf, NumBytesPerBuf ) ;
     GetMem( OutBuf, NumBytesPerBuf ) ;

     Try

     for ch := 0 to FH.NumChannels-1 do if UseChannel[ch] then begin

         // Create export file name
         FileName := CreateExportFileName(BaseExportFileName) ;

         // Add channel
         FileName := ANSIReplaceText( FileName,
                                      '.ibw',
                                     format( '[%s].ibw',[Channel[ch].ADCName])) ;

         // If destination file already exists, allow user to abort
         if FileExists( FileName ) then begin
            if MessageDlg( FileName + ' exists! Overwrite?!',
               mtConfirmation, [mbYes, mbNo], 0) <> mrYes then Break ;
            end ;

         // Create empty export data file
         ExportFile.CreateDataFile( FileName, ftIBW ) ;

         // Set file parameters
         ExportFile.NumChannelsPerScan := 1 ;
         ExportFile.NumScansPerRecord := EndAt - StartAt + 1 ;
         ExportFile.MaxADCValue := FH.MaxADCValue ;
         ExportFile.MinADCValue := FH.MinADCValue ;
         ExportFile.ScanInterval := FH.dt ;
         ExportFile.IdentLine := FH.IdentLine ;
         ExportFile.RecordNum := 1 ;
         ExportFile.ABFAcquisitionMode := ftGapFree ;
         ExportFile.NumChannelsPerScan := 1 ;

         ExportFile.ChannelOffset[0] := 0 ;
         ExportFile.ChannelADCVoltageRange[0] := FH.ADCVoltageRange ;
         ExportFile.ChannelName[0] := Channel[ch].ADCName ;
         ExportFile.ChannelUnits[0] := Channel[ch].ADCUnits ;
         ExportFile.ChannelScale[0] := Channel[ch].ADCSCale ;
         ExportFile.ChannelCalibrationFactor[0] := Channel[ch].ADCCalibrationFactor ;
         ExportFile.ChannelGain[0] := Channel[ch].ADCAmplifierGain ;

         //{ Copy records }
         NumRecordsExported := 0 ;
         for iRec := StartAt to EndAt do begin

             // Read record
            GetRecord(FH,RH,iRec,InBuf^) ;

            // Copy required channel
            j := Channel[ch].ChannelOffset ;
            for i := 0 to FH.NumSamples-1 do begin
                OutBuf^[i] := InBuf^[j] ;
                 j := j + FH.NumChannels ;
                 end ;

            Inc(NumRecordsExported) ;
            ExportFile.RecordNum := NumRecordsExported ;

            // Adjust calibration factor for variations in channel gain (all other formats)
            ExportFile.ChannelCalibrationFactor[0] := Channel[ch].ADCCalibrationFactor *
                                                      (FH.ADCVoltageRange/RH.ADCVoltageRange[ch]) ;
            ExportFile.ScanInterval := RH.dt ;

            // Write to export file
            ExportFile.SaveADCBuffer( 0, FH.NumSamples, OutBuf^ ) ;

            // Report progress
            Main.StatusBar.SimpleText := format(
            ' EXPORT: Exporting record %d/%d to %s ',
            [iRec,EndAt,FileName]) ;
            end ;

         // Close export data file
         ExportFile.CloseDataFile ;

         // Final Report
         Main.StatusBar.SimpleText := format(
         ' EXPORT: %d records exported to %s ',
         [EndAt-StartAt+1,FileName]) ;
         WriteToLogFile( Main.StatusBar.SimpleText ) ;

         end ;

     Finally
        // Free allocated buffers
        FreeMem( InBuf ) ;
        FreeMem( OutBuf ) ;
        end ;

     end;


procedure TExportFrm.bChangeNameClick(Sender: TObject);
{ ------------------------------------------
  Change name/location of export destination
  ------------------------------------------ }
var
   ExportFileExt : string ;
begin

     ExportFileExt := ExtractFileExt(CreateExportFileName(BaseExportFileName )) ;

     SaveDialog.DefaultExt := ExportFileExt ;
     SaveDialog.options := [ofOverwritePrompt,ofHideReadOnly,ofPathMustExist] ;
     SaveDialog.Filter := ' Files (*' + SaveDialog.DefaultExt + ')|*' +
                            SaveDialog.DefaultExt + '|' ;

     SaveDialog.FileName := ChangeFileExt(BaseExportFileName,ExportFileExt) ;
     SaveDialog.Title := 'Export File ' ;
     if Settings.DataDirectory <> '' then
        SaveDialog.InitialDir := Settings.DataDirectory ;

     if SaveDialog.Execute then BaseExportFileName := SaveDialog.FileName ;

     edFileName.text := CreateExportFileName(BaseExportFileName) ;

     end;


procedure TExportFrm.rbABFClick(Sender: TObject);
// ---------------------------------
// Axon Binary File option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := True ;
     end;


procedure TExportFrm.rbLDTClick(Sender: TObject);
// ---------------------------------
// Qub data file option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := True ;
     end;


procedure TExportFrm.rbCFSClick(Sender: TObject);
// ---------------------------------
// CED Filing System option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := True ;
     end;


function TExportFrm.CreateExportFileName(
         FileName : string
         ) : String ;
// ---------------------------------------------------
// Update control settings when export format changed
// ---------------------------------------------------
var
    StartAt,EndAt : Integer ;
begin

     SetChannel( ckCh0, 0 ) ;
     SetChannel( ckCh1, 1 ) ;
     SetChannel( ckCh2, 2 ) ;
     SetChannel( ckCh3, 3 ) ;
     SetChannel( ckCh4, 4 ) ;
     SetChannel( ckCh5, 5 ) ;
     SetChannel( ckCh6, 6 ) ;
     SetChannel( ckCh7, 7 ) ;

     ChangeFileExt( FileName, '.tmp' ) ;

     // Add record range to file name
     if rbAllRecords.Checked then begin
        StartAt := 1 ;
        EndAt := FH.NumRecords ;
        end
     else begin
        StartAt := Round(edRange.LoValue) ;
        EndAt := Round(edRange.HiValue) ;
        end ;

     // Set file extension to .tmp to locate end of file later
     FileName := ChangeFileExt( FileName, '.tmp' ) ;

     // Add record range
     FileName := ANSIReplaceText( FileName,
                                  '.tmp',
                                  format('[%d-%d].tmp',[StartAt,EndAt]) ) ;

     if rbABF.Checked then FileName := ChangeFileExt( FileName, '.abf' ) ;
     if rbCFS.Checked then FileName := ChangeFileExt( FileName, '.cfs' ) ;
     if rbASCII.Checked then FileName := ChangeFileExt( FileName, '.txt' ) ;
     if rbEDR.Checked then FileName := ChangeFileExt( FileName, '.edr' ) ;
     if rbIGOR.Checked then FileName := ChangeFileExt( FileName, '.ibw' ) ;
     if rbWCP.Checked then FileName := ChangeFileExt( FileName, '.wcp' ) ;

     Result := FileName ;
     edFileName.Text := FileName ;

     end ;


procedure TExportFrm.rbASCIIClick(Sender: TObject);
// ---------------------------------
// ASCII text file option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := False ;
     end;


procedure TExportFrm.rbEDRClick(Sender: TObject);
// ---------------------------------
// WinEDR file option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := True ;
     end;


procedure TExportFrm.k(Sender: TObject);
// ---------------------------------
// Axon Binary File option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := False ;
     end;


procedure TExportFrm.rbIGORClick(Sender: TObject);
// ---------------------------------
// Axon Binary File option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := True ;
     end;


procedure TExportFrm.bOKClick(Sender: TObject);
// ----------------------
// Export to output file
// ----------------------
begin

    if rbIGOR.Checked then ExportToIGORFile
                      else ExportToFile ;

    end ;


procedure TExportFrm.rbRangeClick(Sender: TObject);
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     end;


procedure TExportFrm.rbAllRecordsClick(Sender: TObject);
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     end;



procedure TExportFrm.edRangeKeyPress(Sender: TObject; var Key: Char);
begin
     if Key = #13 then begin
        edFileName.Text := CreateExportFileName(BaseExportFileName) ;
        end;
     end;

procedure TExportFrm.rbWCPClick(Sender: TObject);
// ---------------------------------
// WCP File option selected
// ---------------------------------
begin
     edFileName.Text := CreateExportFileName(BaseExportFileName) ;
     ChannelsGrp.Enabled := True ;
     end;

end.
