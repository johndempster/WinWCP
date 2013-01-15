unit Progress;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TProgressFrm = class(TForm)
    bStop: TButton;
    prBar: TProgressBar;
    reInfo: TRichEdit;
    procedure bStopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Abort : Boolean ;
    Done : Boolean ;
    procedure Initialise( StartAt : Integer ; EndAt : Integer ) ;
    procedure Increment ;
    function Position : Integer ;
  end;

var
  ProgressFrm: TProgressFrm;

implementation

{$R *.DFM}

procedure TProgressFrm.bStopClick(Sender: TObject);
begin
     Abort := True ;
     Done := True ;
     end;

procedure TProgressFrm.FormShow(Sender: TObject);
begin
     Abort := False ;
     end;

procedure TProgressFrm.Initialise(
          StartAt : Integer ;
          EndAt : Integer
          ) ;
begin
     prBar.Min := StartAt ;
     prBar.Max := EndAt ;
     prBar.Position := StartAt ;
     Done := False ;
     end ;


procedure TProgressFrm.Increment ;
begin
     if prBar.Position < prBar.Max then prBar.Position := prBar.Position + 1
                                   else Done := True ;
     Application.ProcessMessages ;
     end ;

function TProgressFrm.Position : Integer ;
begin
     Result := prBar.Position ;
     end ;
          

end.
