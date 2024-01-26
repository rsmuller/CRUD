inherited VwCategoria: TVwCategoria
  Caption = 'CATEGORIA'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PageControl: TPageControl
    inherited tsDados: TTabSheet
      inherited PanelDados: TPanel
        Enabled = False
        object LabelDescricao: TLabel
          Left = 12
          Top = 6
          Width = 55
          Height = 13
          Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object DBEdit1: TDBEdit
          Tag = 1
          Left = 12
          Top = 23
          Width = 267
          Height = 21
          Hint = 'A DESCRI'#199#195'O'
          AutoSize = False
          CharCase = ecUpperCase
          DataField = 'DESCRICAO'
          DataSource = dsRegistro
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
end
