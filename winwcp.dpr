program winwcp;

uses
  Forms,
  MDIForm in 'MDIForm.pas' {Main},
  winwcp_TLB in 'winwcp_TLB.pas',
  AutoUnit in 'AutoUnit.pas' {AUTO: CoClass},
  Global in 'Global.pas',
  ImportRawUnit in 'ImportRawUnit.pas' {ImportRawFrm},
  Leaksub in 'LEAKSUB.PAS' {LeakSubFrm},
  Log in 'Log.pas' {LogFrm},
  Measure in 'MEASURE.PAS' {MeasureFrm},
  Printgra in 'PRINTGRA.PAS' {PrintGraphFrm},
  PrintRec in 'PRINTREC.PAS' {PrintRecFrm},
  Progress in 'Progress.pas' {ProgressFrm},
  Pwrspec in 'Pwrspec.pas' {PwrSpecFrm},
  Qanal in 'QANAL.PAS' {QuantFrm},
  Rec in 'REC.PAS' {RecordFrm},
  Recedit in 'RECEDIT.PAS' {EditFrm},
  Sealtest in 'SEALTEST.PAS' {SealTestFrm},
  Setaxes in 'SETAXES.PAS' {SetAxesFrm},
  InputChannelSetup in 'InputChannelSetup.pas' {InputChannelSetupFrm},
  Setvar in 'SETVAR.PAS' {SetVarFrm},
  Shared in 'Shared.pas',
  Simhh in 'SIMHH.PAS' {VClampSim},
  Simsyn in 'Simsyn.pas' {SynapseSim},
  StimModule in 'StimModule.pas' {Stimulator: TDataModule},
  VP500Panel in 'VP500Panel.pas' {VP500PanelFrm},
  About in 'About.pas' {AboutDlg},
  AmpModule in 'AmpModule.pas' {Amplifier: TDataModule},
  Average in 'AVERAGE.PAS' {AvgFrm},
  Ced1902u in 'Ced1902u.pas' {CED1902Frm},
  Convert in 'Convert.pas',
  Copyrec in 'COPYREC.PAS' {CopyRecDlg},
  Curvfit in 'CURVFIT.PAS' {FitFrm},
  Defset in 'DEFSET.PAS' {DefSetFrm},
  Drvfun in 'DRVFUN.PAS' {DrvFunFrm},
  exportUnit in 'exportUnit.pas' {ExportFrm},
  Filter in 'Filter.pas' {FilterFrm},
  SimMEPSC in 'SimMEPSC.pas' {SimMEPSCFrm},
  Maths in '..\Components\Maths.pas',
  HW_Types in '..\Components\HW_Types.pas',
  TVicLib in '..\Components\TVicLib.pas',
  Zero in 'ZERO.PAS' {ZeroFrm},
  Setfitpa in 'SETFITPA.PAS' {SetFitParsFrm},
  ImportASCIIUnit in 'ImportASCIIUnit.pas' {ImportASCIIFrm},
  FilePropsUnit in 'FilePropsUnit.pas' {FilePropsDlg},
  Replay in 'Replay.pas' {ReplayFrm},
  Fileio in 'FILEIO.PAS',
  RecPlotUnit in 'RecPlotUnit.pas' {RecPlotFrm},
  TritonPanelUnit in 'TritonPanelUnit.pas' {TritonPanelFrm},
  PrintTableUnit in 'PrintTableUnit.pas' {PrintTableFrm},
  EditProtocolUnit in 'EditProtocolUnit.pas' {EditProtocolFrm},
  LabInterfaceSetup in 'LabInterfaceSetup.pas' {LabInterfaceSetupFrm},
  HTMLHelpViewer in '..\Components\HTMLHelpViewer.pas',
  DirectorySelectUnit in 'DirectorySelectUnit.pas' {DirectorySelectFrm};

{$R *.TLB}

{$R *.res}

begin
  Application.Initialize;
  Application.HelpFile := 'winwcp.chm';
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TImportRawFrm, ImportRawFrm);
  Application.CreateForm(TPrintGraphFrm, PrintGraphFrm);
  Application.CreateForm(TPrintRecFrm, PrintRecFrm);
  Application.CreateForm(TProgressFrm, ProgressFrm);
  Application.CreateForm(TSetAxesFrm, SetAxesFrm);
  Application.CreateForm(TSetVarFrm, SetVarFrm);
  Application.CreateForm(TStimulator, Stimulator);
  Application.CreateForm(TAmplifier, Amplifier);
  Application.CreateForm(TCopyRecDlg, CopyRecDlg);
  Application.CreateForm(TFilterFrm, FilterFrm);
  Application.CreateForm(TZeroFrm, ZeroFrm);
  Application.CreateForm(TSetFitParsFrm, SetFitParsFrm);
  Application.CreateForm(TImportASCIIFrm, ImportASCIIFrm);
  Application.CreateForm(TExportFrm, ExportFrm);
  Application.CreateForm(TPrintTableFrm, PrintTableFrm);
  Application.CreateForm(TDirectorySelectFrm, DirectorySelectFrm);
  Application.Run;
end.
