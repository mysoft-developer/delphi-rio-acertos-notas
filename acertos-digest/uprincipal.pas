unit uprincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef;

type
  TFPrincipal = class(TForm)
    btnConsultar: TButton;
    dbGrid: TDBGrid;
    ds01: TDataSource;
    conn: TFDConnection;
    qr01: TFDQuery;
    linkMySQL: TFDPhysMySQLDriverLink;
    qr02: TFDQuery;
    btnAcertar: TButton;
    procedure btnConsultarClick(Sender: TObject);
    procedure btnAcertarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPrincipal: TFPrincipal;

implementation

{$R *.dfm}

procedure TFPrincipal.btnAcertarClick(Sender: TObject);
var
  s: string;

begin
  qr01.First;

  while not qr01.Eof do
  begin
    with qr02 do
    begin
      try
        s := 'delete from nfe_saoluiz.xml_202006 where idt=' + qr01.FieldByName('idt').AsString;

        Close;
        SQL.Clear;
        SQL.Add(s);
        ExecSQL;

      except
      end;

      try
        s := 'insert into nfe_saoluiz.xml_202006 set idt=' + qr01.FieldByName('idt').AsString;

        Close;
        SQL.Clear;
        SQL.Add(s);
        ExecSQL;

      except
      end;

      s := 'insert into posto_dinossauro.log values (0,now(),"admin",44,0,"",0,"' + s + '")';

      Close;
      SQL.Clear;
      SQL.Add(s);
      // ExecSQL;

      s := qr01.FieldByName('str_sql').AsString;

      Close;
      SQL.Clear;
      SQL.Add(s);
      ExecSQL;

      s := 'insert into posto_dinossauro.log values (0,now(),"admin",44,0,"",0,"' + s + '")';

      Close;
      SQL.Clear;
      SQL.Add(s);
      // ExecSQL;

      s := 'update posto_dinossauro.notas_fiscais_eletronicas set operacao="X",status=0,status2=0 where idt=' +
        qr01.FieldByName('idt').AsString;

      Close;
      SQL.Clear;
      SQL.Add(s);
      ExecSQL;

      s := 'insert into posto_dinossauro.log values (0,now(),"admin",44,0,"",0,"' + s + '")';

      Close;
      SQL.Clear;
      SQL.Add(s);
      // ExecSQL;

    end;

    qr01.Next;
  end;

  ShowMessage('Finalizado');
end;

procedure TFPrincipal.btnConsultarClick(Sender: TObject);
begin

  linkMySQL.VendorLib := ExtractFilePath(Application.ExeName) + 'libmySQL50.dll';

  conn.DriverName := 'MySQL';
  conn.Params.Clear;
  conn.Params.Values['DriverID'] := 'MySQL';
  conn.Params.Values['Server'] := '10.8.0.122';
  // conn.Params.Values['Server'] := '10.8.0.217';
  conn.Params.Values['Port'] := '3306';
  conn.Params.UserName := 'mysoftweb';
  conn.Params.Password := 'g3108f88';
  conn.Params.Database := 'posto_dinossauro';
  conn.Connected := True;

  with qr01 do
  begin
    Close;
    SQL.Clear;

    { SQL.Add('select b.idt,b.chave,a.str_sql from nfe_saoluiz.xml_202005 b');
      SQL.Add('inner join logs.dinossauro_log_202005 a');
      SQL.Add('on a.str_sql like concat("insert into nfe_saoluiz%",b.chave,"%")');
      SQL.Add('and b.protocolo="" and b.origem in (13,14)'); }

    { SQL.Add('select b.idt,b.chave,a.str_sql from nfe_saoluiz.xml_202005 b');
      SQL.Add('inner join logs.dinossauro_log_202005 a');
      SQL.Add('on a.str_sql like concat("update nfe_saoluiz%",b.chave,"%")');
      SQL.Add('and b.protocolo="" and b.origem in (1,2,13,14)');
      SQL.Add('group by b.idt order by a.id'); }

    { SQL.Add('select b.idt,b.chave,a.str_sql');
      SQL.Add('from nfe_saoluiz.xml_202005 b');
      SQL.Add('inner join logs.dinossauro_log_sis_202005 a');
      SQL.Add('on a.str_sql like concat("insert into nfe_saoluiz%",b.chave,"%")');
      SQL.Add('and b.protocolo=""');
      SQL.Add('and b.origem not in (1,2,13,14)');
      SQL.Add('group by b.idt');
      SQL.Add('order by a.id'); }

    { SQL.Add('select b.idt,b.chave,a.str_sql');
      SQL.Add('from nfe_saoluiz.xml_202005 b');
      SQL.Add('inner join logs.dinossauro_log_sis_202005 a');
      SQL.Add('on a.str_sql like concat("update nfe_saoluiz%",b.chave,"%")');
      SQL.Add('and b.protocolo=""');
      SQL.Add('and b.origem in (1,2,13,14)');
      SQL.Add('group by b.idt');
      SQL.Add('order by a.id desc'); }

    { SQL.Add('select b.idt,b.chave,a.str_sql');
      SQL.Add('from nfe_saoluiz.xml_202006 b');
      SQL.Add('inner join log a');
      SQL.Add('on a.str_sql like concat("update nfe_saoluiz%",b.chave,"%protocolo=%14%arquivo_xml=%")');
      SQL.Add('and b.protocolo like ""');
      SQL.Add('and b.origem in (1,2,13,14)');
      SQL.Add('group by b.idt');
      SQL.Add('order by a.id desc'); }

    {SQL.Add('select *');
    SQL.Add('from notas_fiscais_eletronicas a');
    SQL.Add('inner join notas_fiscais b on a.idt=b.idt and b.emissao=20200615');
    SQL.Add('inner join log c');
    SQL.Add('on c.str_sql like concat("update nfe_saoluiz%",a.chave,"%protocolo=%14%arquivo_xml=%")');
    SQL.Add('where a.operacao="X" and a.modelo=65');
    SQL.Add('group by a.idt');
    SQL.Add('order by c.id desc;');}

    SQL.Add('select b.idt,b.chave,a.str_sql');
    SQL.Add('from nfe_saoluiz.xml_202006 b');
    SQL.Add('inner join log_sis a');
    SQL.Add('on a.str_sql like concat("update nfe_saoluiz%",b.chave,"%protocolo=%14%arquivo_xml=%")');
    SQL.Add('and b.protocolo like "EMITIDO EM CONT"');
    SQL.Add('and b.origem in (22,23)');
    SQL.Add('group by b.idt');
    SQL.Add('order by a.id desc;');

    Open;
  end;

end;

end.
