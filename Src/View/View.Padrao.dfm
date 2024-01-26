object VwPadrao: TVwPadrao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'VwPadrao'
  ClientHeight = 456
  ClientWidth = 734
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 734
    Height = 456
    ActivePage = tsConsulta
    Align = alClient
    TabOrder = 0
    object tsConsulta: TTabSheet
      Caption = 'tsConsulta'
      object PanelTopo: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 720
        Height = 48
        Align = alTop
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 3
          Width = 12
          Height = 13
          Caption = 'Id'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 71
          Top = 3
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
        object EditId: TEdit
          Left = 8
          Top = 19
          Width = 57
          Height = 19
          TabOrder = 0
          OnKeyDown = EditIdKeyDown
          OnKeyPress = EditIdKeyPress
        end
        object EditDescricao: TEdit
          Left = 71
          Top = 19
          Width = 194
          Height = 19
          CharCase = ecUpperCase
          TabOrder = 1
          OnKeyDown = EditDescricaoKeyDown
        end
        object ButtonConsulta: TButton
          Left = 353
          Top = 3
          Width = 89
          Height = 38
          Caption = 'Consulta ( F5 )'
          TabOrder = 2
          OnClick = ButtonConsultaClick
        end
        object ButtonDeleta: TButton
          Left = 536
          Top = 3
          Width = 89
          Height = 38
          Caption = 'Deleta'
          TabOrder = 3
          OnClick = ButtonDeletaClick
        end
        object ButtonFecha: TButton
          Left = 627
          Top = 3
          Width = 89
          Height = 38
          Caption = 'Fecha (ESC)'
          TabOrder = 4
          OnClick = ButtonFechaClick
        end
        object ButtonNovo: TButton
          Left = 445
          Top = 3
          Width = 90
          Height = 38
          Caption = 'Novo ( F1 )'
          TabOrder = 5
          OnClick = ButtonNovoClick
        end
      end
      object GridConsulta: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 57
        Width = 720
        Height = 368
        Align = alClient
        DataSource = dsConsulta
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = GridConsultaDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Title.Alignment = taCenter
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESCRICAO'
            Title.Alignment = taCenter
            Title.Caption = 'DESCRI'#199#195'O'
            Width = 624
            Visible = True
          end>
      end
    end
    object tsDados: TTabSheet
      Caption = 'tsDados'
      ImageIndex = 1
      object PanelBotoes: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 94
        Height = 422
        Align = alLeft
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 0
        object ButtonNovo2: TButton
          Tag = 1
          Left = 1
          Top = 0
          Width = 90
          Height = 38
          Caption = 'Novo (F1)'
          TabOrder = 0
          OnClick = ButtonNovo2Click
        end
        object ButtonEdita: TButton
          Tag = 1
          Left = 1
          Top = 38
          Width = 90
          Height = 38
          Caption = 'Edita (F3)'
          TabOrder = 1
          OnClick = ButtonEditaClick
        end
        object ButtonCancela: TButton
          Tag = 1
          Left = 1
          Top = 76
          Width = 90
          Height = 38
          Caption = 'Cancela'
          Enabled = False
          TabOrder = 2
          OnClick = ButtonCancelaClick
        end
        object ButtonConfirma: TButton
          Tag = 1
          Left = 1
          Top = 114
          Width = 90
          Height = 38
          Caption = 'Confirma (F5)'
          Enabled = False
          TabOrder = 3
          OnClick = ButtonConfirmaClick
        end
        object BtnFecha2: TButton
          Tag = 1
          Left = 1
          Top = 152
          Width = 90
          Height = 38
          Caption = 'Fecha (ESC)'
          TabOrder = 4
          OnClick = BtnFecha2Click
        end
      end
      object PanelDados: TPanel
        Tag = 1
        AlignWithMargins = True
        Left = 103
        Top = 3
        Width = 620
        Height = 422
        Align = alClient
        BevelOuter = bvNone
        BorderStyle = bsSingle
        TabOrder = 1
        DesignSize = (
          618
          420)
        object Shape22: TShape
          Left = 508
          Top = 2
          Width = 109
          Height = 41
          Anchors = [akTop, akRight]
          Brush.Color = clMenu
        end
        object Label5: TLabel
          Left = 513
          Top = 3
          Width = 104
          Height = 18
          Alignment = taCenter
          Anchors = [akTop, akRight]
          AutoSize = False
          Caption = 'ID'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
        object DBText2: TDBText
          Left = 513
          Top = 18
          Width = 104
          Height = 22
          Alignment = taCenter
          Anchors = [akTop, akRight]
          DataField = 'ID'
          DataSource = dsRegistro
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
  end
  object dsConsulta: TDataSource
    Left = 28
    Top = 336
  end
  object dsRegistro: TDataSource
    Left = 28
    Top = 392
  end
end
