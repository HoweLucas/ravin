object bntcarregar: Tbntcarregar
  Left = 0
  Top = 0
  Caption = 'frmUsuario'
  ClientHeight = 281
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object memListaUsers: TMemo
    Left = 8
    Top = 8
    Width = 393
    Height = 225
    Lines.Strings = (
      'memListaUsers')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 120
    Top = 239
    Width = 153
    Height = 34
    Caption = 'Carregar usu'#225'rios'
    TabOrder = 1
    OnClick = Button1Click
  end
end
