program Project1;

uses
  Vcl.Forms,
  UPrincP in 'UPrincP.pas' {Form1},
  ImageButton in 'ImageButton.pas';

{$R *.res}

var
  FPrincP: TFPrincP;


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFPrincP, FPrincP);
  Application.Run;
end.
