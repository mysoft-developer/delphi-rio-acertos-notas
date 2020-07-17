program notas;

uses
  Vcl.Forms,
  unotas in 'unotas.pas' {FNotas},
  udm in 'udm.pas' {dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFNotas, FNotas);
  Application.Run;
end.
