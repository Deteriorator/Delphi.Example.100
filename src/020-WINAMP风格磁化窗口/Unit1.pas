unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
    procedure WMMOVE(var Msg: TMessage); message WM_MOVE;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.WMMOVE(var Msg: TMessage);
begin
  Inherited;
  if (Left < 10) and (Top < 10) and
  (Left <> 0) and (Top <> 0) then //�趨�ƶ������Ͻ� 10 �㷶Χ��ʱ���������
  begin
    Left := 0;
    Top := 0;
    Msg.Result := 0;
  end;
end;

end.
