object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 488
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 367
    Width = 75
    Height = 25
    Caption = 'Open'
    TabOrder = 0
  end
  object panelButtons: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 344
    Align = alLeft
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = -4
    ExplicitTop = -6
    ExplicitHeight = 399
    object buttonLoadData: TButton
      Left = 14
      Top = 7
      Width = 147
      Height = 25
      Caption = 'ToData'
      TabOrder = 0
      OnClick = buttonLoadDataClick
    end
    object buttonGetDataSet: TButton
      Left = 14
      Top = 38
      Width = 147
      Height = 25
      Caption = 'ToDataSet'
      TabOrder = 1
      OnClick = buttonGetDataSetClick
    end
    object buttonGetSQL: TButton
      Left = 14
      Top = 69
      Width = 147
      Height = 25
      Caption = 'GetQuery'
      TabOrder = 2
      OnClick = buttonGetSQLClick
    end
    object buttonGetEntity: TButton
      Left = 14
      Top = 100
      Width = 147
      Height = 25
      Caption = 'Find'
      TabOrder = 3
      OnClick = buttonGetEntityClick
    end
    object Button2: TButton
      Left = 14
      Top = 131
      Width = 147
      Height = 25
      Caption = 'ToJson'
      TabOrder = 4
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 14
      Top = 162
      Width = 147
      Height = 25
      Caption = 'FromJson'
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 14
      Top = 193
      Width = 147
      Height = 25
      Caption = 'Include'
      TabOrder = 6
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 14
      Top = 224
      Width = 147
      Height = 25
      Caption = 'ThenInclude'
      TabOrder = 7
      OnClick = Button5Click
    end
  end
  object Panel2: TPanel
    Left = 185
    Top = 0
    Width = 561
    Height = 344
    Align = alClient
    BevelKind = bkTile
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 2
    ExplicitHeight = 399
    object DBGrid1: TDBGrid
      Left = 0
      Top = 0
      Width = 557
      Height = 200
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object panelEdits: TPanel
      Left = 0
      Top = 200
      Width = 557
      Height = 140
      Align = alBottom
      BevelKind = bkTile
      BevelOuter = bvNone
      Caption = 'panelEdits'
      TabOrder = 1
      ExplicitTop = 255
    end
  end
  object mLog: TMemo
    Left = 0
    Top = 344
    Width = 746
    Height = 144
    Align = alBottom
    TabOrder = 3
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
    Top = 424
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 48
    Top = 424
  end
end
