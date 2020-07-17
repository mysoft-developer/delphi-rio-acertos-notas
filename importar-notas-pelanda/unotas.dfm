object FNotas: TFNotas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Notas'
  ClientHeight = 665
  ClientWidth = 1199
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
  object Panel1: TPanel
    Left = 0
    Top = 625
    Width = 1199
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Color = clCream
    ParentBackground = False
    TabOrder = 0
    object btnImportar: TButton
      AlignWithMargins = True
      Left = 1121
      Top = 3
      Width = 75
      Height = 34
      Align = alRight
      Caption = 'Importar'
      TabOrder = 0
      OnClick = btnImportarClick
    end
    object btnDiretorio: TButton
      AlignWithMargins = True
      Left = 1040
      Top = 3
      Width = 75
      Height = 34
      Align = alRight
      Caption = 'Diretorio'
      TabOrder = 1
      OnClick = btnDiretorioClick
    end
    object edtCaminho: TEdit
      AlignWithMargins = True
      Left = 8
      Top = 8
      Width = 1021
      Height = 24
      Margins.Left = 8
      Margins.Top = 8
      Margins.Right = 8
      Margins.Bottom = 8
      Align = alClient
      Enabled = False
      TabOrder = 2
      ExplicitHeight = 21
    end
  end
  object Memo1: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 558
    Height = 524
    Align = alLeft
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object Memo2: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 533
    Width = 1193
    Height = 89
    Align = alBottom
    TabOrder = 2
  end
  object Memo3: TMemo
    AlignWithMargins = True
    Left = 567
    Top = 3
    Width = 629
    Height = 524
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 112
    Top = 128
  end
  object XMLDocument1: TXMLDocument
    Options = [doNodeAutoCreate, doNodeAutoIndent, doAttrNull, doAutoPrefix, doNamespaceDecl]
    ParseOptions = [poPreserveWhiteSpace]
    Left = 112
    Top = 208
  end
end
