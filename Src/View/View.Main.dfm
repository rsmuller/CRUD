object VwMain: TVwMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Menu Principal'
  ClientHeight = 284
  ClientWidth = 615
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnCategoria: TButton
    Left = 8
    Top = 7
    Width = 75
    Height = 25
    Caption = 'Categorias'
    TabOrder = 0
    OnClick = btnCategoriaClick
  end
end
