unit unotas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Types,
  System.IOUtils, Xml.xmldom, Xml.XMLIntf, Datasnap.Xmlxform, Xml.XmlTransform, Datasnap.Provider, Xml.XMLDoc,
  Xml.Win.msxmldom, Xml.adomxmldom, Xml.omnixmldom;

type
  TFNotas = class(TForm)
    Panel1: TPanel;
    btnImportar: TButton;
    btnDiretorio: TButton;
    edtCaminho: TEdit;
    FileOpenDialog1: TFileOpenDialog;
    XMLDocument1: TXMLDocument;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    procedure btnDiretorioClick(Sender: TObject);
    procedure btnImportarClick(Sender: TObject);
  private
    { Private declarations }
    procedure gravarDados;
  public
    { Public declarations }
  end;

var
  FNotas: TFNotas;

implementation

uses
  Winapi.MSXMLIntf, udm;

{$R *.dfm}

function StringToHex(texto: ansistring): ansistring;
var
  Tamanho, i: integer;
  PalavraHex: ansistring;

begin
  PalavraHex := '';

  Tamanho := Length(texto);

  for i := 1 to Tamanho do
  begin
    PalavraHex := PalavraHex + IntToHex(Ord(texto[i]), 2);
  end;

  Result := PalavraHex;
end;

procedure TFNotas.btnDiretorioClick(Sender: TObject);
begin
  if FileOpenDialog1.Execute then
    edtCaminho.Text := FileOpenDialog1.FileName;
end;

procedure TFNotas.btnImportarClick(Sender: TObject);
var
  S: string;
  i, x: integer;

  Xml: IXMLNode;
  procNFe: IXMLNode;
  NFe: IXMLNode;
  infNFe: IXMLNode;
  ide: IXMLNode;
  emit: IXMLNode;

  emit_CNPJ: string;
  emit_xNome: string;

  dest: IXMLNode;

  dest_CNPJ: string;
  dest_xNome: string;

  nNF: string;
  natOp: string;
  modelo: string;
  serie: string;
  dhEmi: string;

  protNFe: IXMLNode;
  infProt: IXMLNode;

  cStat: string;
  xMotivo: string;
  chNFe: string;

  total: IXMLNode;
  ICMSTot: IXMLNode;
  vNF: string;

  xmlHexa: ansistring;
  stream: TMemoryStream;

  origem: string;
  destino: string;

  st: TMemoryStream;

begin
  Memo1.Lines.Clear;
  for S in TDirectory.GetFiles(edtCaminho.Text, '*.xml', TSearchOption.soAllDirectories) do
    Memo1.Lines.Add(S);

  Application.ProcessMessages;

  Memo3.Lines.Clear;
  for i := 0 to Memo1.Lines.Count - 1 do
  begin
    origem := Memo1.Lines[i];

    Memo2.Lines.Clear;
    Memo2.Lines.LoadFromFile(origem);

    XMLDocument1.Xml.Clear;
    XMLDocument1.Xml.Add(Memo2.Text);
    XMLDocument1.Active := True;

    st := TMemoryStream.Create;
    try
      st.LoadFromFile(Memo1.Lines[i]);

      if st.Size > 0 then
      begin
        SetLength(xmlHexa, st.Size);
        Move(st.Memory^, xmlHexa[1], st.Size);
      end;

    finally
      FreeAndNil(st);
    end;

    try
      xmlHexa := StringToHex(xmlHexa);
    except
    end;

    Xml := XMLDocument1.DocumentElement;
    try
      procNFe := Xml.ChildNodes.FindNode('procNFe');
      NFe := procNFe.ChildNodes.FindNode('NFe');
      infNFe := NFe.ChildNodes.FindNode('infNFe');
      ide := infNFe.ChildNodes.FindNode('ide');
      emit := infNFe.ChildNodes.FindNode('emit');
      dest := infNFe.ChildNodes.FindNode('dest');
      total := infNFe.ChildNodes.FindNode('total');

      nNF := ide.ChildNodes.FindNode('nNF').Text;
      modelo := ide.ChildNodes.FindNode('mod').Text;
      serie := ide.ChildNodes.FindNode('serie').Text;
      dhEmi := ide.ChildNodes.FindNode('dhEmi').Text;
      natOp := ide.ChildNodes.FindNode('natOp').Text;

      emit_CNPJ := emit.ChildNodes.FindNode('CNPJ').Text;
      emit_xNome := emit.ChildNodes.FindNode('xNome').Text;

      try
        dest_CNPJ := dest.ChildNodes.FindNode('CNPJ').Text;
      except
        try
          dest_CNPJ := dest.ChildNodes.FindNode('CPF').Text;
        except
          dest_CNPJ := '';
        end;
      end;
      dest_xNome := dest.ChildNodes.FindNode('xNome').Text;

      ICMSTot := total.ChildNodes.FindNode('ICMSTot');
      vNF := ICMSTot.ChildNodes.FindNode('vNF').Text;

      try
        protNFe := procNFe.ChildNodes.FindNode('protNFe');
        infProt := protNFe.ChildNodes.FindNode('infProt');
        cStat := infProt.ChildNodes.FindNode('cStat').Text;
        xMotivo := infProt.ChildNodes.FindNode('xMotivo').Text;
        chNFe := infProt.ChildNodes.FindNode('chNFe').Text;
      except
        cStat := '0';
        xMotivo := '';
        chNFe := '';
      end;

      Memo3.Lines.Add(concat(nNF, ' - ', modelo, ' - ', serie, ' - ', dhEmi, ' - ', natOp,
        ' - ' + emit_CNPJ + ' - ' + emit_xNome + ' - ' + dest_CNPJ + ' - ' + dest_xNome + ' - ' + vNF + ' - ' + cStat +
        ' - ' + xMotivo + ' - ' + chNFe));

      if (modelo = '55') and (serie = '50') then
      begin
        destino := 'c:\tmp\xml\' + chNFe + '.xml';
        try
          CopyFile(Pchar(origem), Pchar(destino), False);
        except
        end;
      end;

      { with dm.qr do
        begin
        Close;
        SQL.Clear;
        SQL.Add('replace into nf set');
        SQL.Add('emit_cnpj="' + emit_CNPJ + '",');
        SQL.Add('emit_nome="' + emit_xNome + '",');
        SQL.Add('modelo="' + modelo + '",');
        SQL.Add('nota="' + nNF + '",');
        SQL.Add('serie="' + serie + '",');
        SQL.Add('chave="' + chNFe + '",');
        SQL.Add('emissao="' + Copy(dhEmi, 1, 10) + '",');
        SQL.Add('hora="' + Copy(dhEmi, 12, 8) + '",');
        SQL.Add('natureza="' + natOp + '",');
        SQL.Add('dest_cnpj="' + dest_CNPJ + '",');
        SQL.Add('dest_nome="' + dest_xNome + '",');
        SQL.Add('status="' + cStat + '",');
        SQL.Add('descricao="' + xMotivo + '",');
        SQL.Add('valor=' + vNF);
        ExecSQL;
        end; }

      with dm.qr do
      begin
        Close;
        SQL.Clear;
        SQL.Add('replace into xmls set');
        SQL.Add('chave="' + chNFe + '",');
        SQL.Add('arquivo=X' + char(39) + xmlHexa + char(39));
        ExecSQL;
      end;

      st := TMemoryStream.Create;
      try
        st.LoadFromFile(StringReplace(Memo1.Lines[i],'.xml','.pdf',[]));

        if st.Size > 0 then
        begin
          SetLength(xmlHexa, st.Size);
          Move(st.Memory^, xmlHexa[1], st.Size);
        end;

      finally
        FreeAndNil(st);
      end;

      try
        xmlHexa := StringToHex(xmlHexa);
      except
      end;

      with dm.qr do
      begin
        Close;
        SQL.Clear;
        SQL.Add('replace into pdfs set');
        SQL.Add('chave="' + chNFe + '",');
        SQL.Add('arquivo=X' + char(39) + xmlHexa + char(39));
        ExecSQL;
      end;

      Application.ProcessMessages;
    except
      on e: Exception do
        Memo3.Lines.Add(e.Message);
    end;

    XMLDocument1.Active := False;
  end;

  Showmessage('Pronto!' + #13 + Memo1.Lines.Count.ToString + #13 + Memo3.Lines.Count.ToString);
end;

procedure TFNotas.gravarDados;
begin

end;

end.
