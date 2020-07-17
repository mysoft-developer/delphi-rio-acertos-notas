object FPrincipal: TFPrincipal
  Left = 0
  Top = 0
  Caption = 'Principal'
  ClientHeight = 411
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnConsultar: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Consultar'
    TabOrder = 0
    OnClick = btnConsultarClick
  end
  object dbGrid: TDBGrid
    Left = 8
    Top = 39
    Width = 836
    Height = 354
    DataSource = ds01
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnAcertar: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Acertar'
    TabOrder = 2
    OnClick = btnAcertarClick
  end
  object ds01: TDataSource
    DataSet = qr01
    Left = 416
    Top = 80
  end
  object conn: TFDConnection
    Params.Strings = (
      'DriverID=MySQL')
    Left = 296
    Top = 80
  end
  object qr01: TFDQuery
    Connection = conn
    Left = 376
    Top = 80
  end
  object linkMySQL: TFDPhysMySQLDriverLink
    Left = 520
    Top = 80
  end
  object qr02: TFDQuery
    Connection = conn
    Left = 376
    Top = 136
  end
end
