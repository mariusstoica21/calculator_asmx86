program Calculator;

uses
  Vcl.Forms,
  UPrincP in 'UPrincP.pas' {Form1},
  ImageButton in 'ImageButton.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

var
  FPrincP: TFPrincP;


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Silver');
  Application.CreateForm(TFPrincP, FPrincP);
  Application.Run;
end.
