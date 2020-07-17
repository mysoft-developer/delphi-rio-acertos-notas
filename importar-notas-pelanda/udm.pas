unit udm;

interface

uses
  System.SysUtils, System.Classes, FMX.Dialogs, FMX.Forms,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uDWConstsData, uRESTDWPoolerDB, uDWAbout, uSystemEvents;

type
  Tdm = class(TDataModule)
    conn: TRESTDWDataBase;
    qr: TRESTDWClientSQL;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  try
    with conn do
    begin
      Active := False;
      ClientConnectionDefs.Active := True;

      // mysql
      ClientConnectionDefs.ConnectionDefs.HostName := '52.5.170.173';
      ClientConnectionDefs.ConnectionDefs.DatabaseName := 'lixo';
      ClientConnectionDefs.ConnectionDefs.dbPort := 3306;

      ClientConnectionDefs.ConnectionDefs.Username := 'mysoftweb';
      ClientConnectionDefs.ConnectionDefs.Password := 'g3108f88';
      ClientConnectionDefs.ConnectionDefs.Protocol := 'mysql-5';
      ClientConnectionDefs.ConnectionDefs.DriverType := TDWDatabaseType.dbtMySQL;

      // dwdataware
      PoolerService := '52.5.170.173';
      PoolerPort := 8088;
      Login := 'mysoftweb';
      Password := 'g3108f88';
      Active := True;
    end;
  except
    on ex: Exception do
    begin
      raise Exception.Create('Nao foi possivel conectar ao Servidor DW!' + #13#10 + ex.Message);

      Application.Terminate;
    end;
  end;
end;

end.
