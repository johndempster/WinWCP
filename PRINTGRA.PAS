unit Printgra;
{ =======================================================
  Updates printer page settings in Settings.Plot
  =======================================================}
// 11.05.09 Printer can now be selected

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Spin, Buttons, Global, Printers, Shared,
  ValEdit, XYPlotDisplay, ExtCtrls, ValidatedEdit ;

type
  TPrintGraphFrm = class(TForm)
    PrinterSelectGrp: TGroupBox;
    edPrinterName: TEdit;
    bPrinterSetup: TButton;
    PrinterSetupDialog: TPrinterSetupDialog;
    SettingsPan: TPanel;
    FontGrp: TGroupBox;
    Label7: TLabel;
    cbFontName: TComboBox;
    edFontSize: TValidatedEdit;
    Page: TNotebook;
    PrinterGrp: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edLeftMargin: TValidatedEdit;
    edRightMargin: TValidatedEdit;
    edTopMargin: TValidatedEdit;
    edBottomMargin: TValidatedEdit;
    MetafileGrp: TGroupBox;
    Label6: TLabel;
    Label9: TLabel;
    edBitmapWidth: TValidatedEdit;
    edBitmapHeight: TValidatedEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    edLineThickness: TValidatedEdit;
    bOK: TButton;
    bCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure bOKClick(Sender: TObject);
    procedure bPrinterSetupClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ToPrinter : Boolean ;
    Plot : TXYPlotDisplay ;

  end;

var
  PrintGraphFrm: TPrintGraphFrm;

implementation

{$R *.DFM}


procedure TPrintGraphFrm.FormShow(Sender: TObject);
{ --------------------------------------------
  Initialise edit boxes when form is displayed
  -------------------------------------------- }
var
    DeviceName : Array[0..100] of Char ;
    DeviceDriver : Array[0..100] of Char ;
    Port : Array[0..100] of Char ;
    DeviceMode : Cardinal ;

begin

     // Display selected printer
     Printer.GetPrinter( DeviceName, DeviceDriver,Port,DeviceMode);
     edPrinterName.Text := String(DeviceName) ;

     { Select appropriate page for printer page margins or
       metafile image size }
     if ToPrinter then begin
        Page.PageIndex := 0 ;
        Caption := ' Print ' ;
        PrinterSelectGrp.Visible := True ;
        SettingsPan.Top := PrinterSelectGrp.Top + PrinterSelectGrp.Height + 2 ;
        end
     else begin
        Page.PageIndex := 1 ;
        Caption := ' Copy Image ' ;
        PrinterSelectGrp.Visible := False ;
        SettingsPan.Top := PrinterSelectGrp.Top ;
        end ;

     edTopMargin.Value := Settings.Plot.TopMargin ;
     edBottomMargin.Value := Settings.Plot.BottomMargin ;
     edLeftMargin.Value := Settings.Plot.LeftMargin ;
     edRightMargin.Value := Settings.Plot.RightMargin ;
     edBitMapWidth.Value := Settings.BitMapWidth ;
     edBitMapHeight.Value := Settings.BitMapHeight ;

     { Fill Fonts list with typefaces available to printer }
     cbFontName.items := printer.fonts ;
     edFontSize.Value := Settings.Plot.FontSize ;
     edLineThickness.Value := Settings.Plot.LineThickness ;
     cbFontName.itemindex := cbFontName.items.indexof(Settings.Plot.FontName) ;
     if cbFontName.itemindex < 0 then  cbFontName.itemindex := 0 ;

     end;


procedure TPrintGraphFrm.bOKClick(Sender: TObject);
// ------------------------
// Accept settings and exit
// ------------------------
begin
     { Save new settings }
     Settings.Plot.TopMargin := edTopMargin.Value ;
     Settings.Plot.BottomMargin := edBottomMargin.Value ;
     Settings.Plot.LeftMargin:= edLeftMargin.Value  ;
     Settings.Plot.RightMargin := edRightMargin.Value ;
     Settings.Plot.FontName := cbFontName.text ;
     Settings.Plot.FontSize := Round(edFontSize.Value) ;
     Settings.Plot.LineThickness := Round(edLineThickness.Value) ;
     Settings.BitMapWidth := Round(edBitMapWidth.Value)  ;
     Settings.BitMapHeight := Round(edBitMapHeight.Value)  ;

     { Update settings in XYplot component }
     Plot.PrinterTopMargin := Round(Settings.Plot.TopMargin) ;
     Plot.PrinterBottomMargin := Round(Settings.Plot.BottomMargin) ;
     Plot.PrinterLeftMargin := Round(Settings.Plot.LeftMargin) ;
     Plot.PrinterRightMargin := Round(Settings.Plot.RightMargin) ;
     Plot.PrinterFontSize := Settings.Plot.FontSize ;
     Plot.PrinterLineWidth := Settings.Plot.LineThickness ;
     Plot.MetafileWidth := Settings.BitMapWidth ;
     Plot.MetafileHeight := Settings.BitMapHeight ;
     Plot.Invalidate ;

     end;


procedure TPrintGraphFrm.bPrinterSetupClick(Sender: TObject);
// -----------------------------
// Select printer / change setup
// -----------------------------
var
    DeviceName : Array[0..100] of Char ;
    DeviceDriver : Array[0..100] of Char ;
    Port : Array[0..100] of Char ;
    DeviceMode : Cardinal ;
begin
     PrinterSetupDialog.Execute ;
     Printer.GetPrinter( DeviceName, DeviceDriver,Port,DeviceMode);
     edPrinterName.Text := String(DeviceName) ;
     end ;

end.
