unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Label_1: TLabel;
    Label_2: TLabel;
    Panel_1: TPanel;
    Button_1: TButton;
    Button_2: TButton;
    Timer_1: TTimer;
    TrackBar_1: TTrackBar;
    Edit_1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Timer_1Timer(Sender: TObject);
    procedure Button_1Click(Sender: TObject);
    procedure Button_2Click(Sender: TObject);
    procedure TrackBar_1Change(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure zShowText;
    Procedure zBmpCreate;
    procedure zSetBmp;
    procedure zSetLineHeight;
    procedure zShowLine(sender :TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.dfm}

var
  currline, LineHeight:integer;
  sItem:TStringList;
  bmp:TBitMap;
  bRect,R1:TRect;
  iDc:HDC;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Timer_1.Enabled:=False;
  iDC:=GetDc(Panel_1.handle);
  Currline:=0;
end;

procedure TForm1.zShowLine(sender :TObject);
begin
  zShowText;
end;

procedure TForm1.Timer_1Timer(Sender: TObject);
begin
  zShowLine(self);//��ʾ�ַ���
  //bitblt ת�ƾ���ͼ (Ŀ������LS x,y,���ߣ�Դ�����LS x,y,��դ�������
  BitBlt(iDc,0,0,Panel_1.Width,Panel_1.Height,
  Bmp.Canvas.Handle,0,Currline,srcCopy);        //�ı�currline��ʵ����������
  Inc(Currline,1);
  if Currline>=bRect.Bottom-panel_1.Height+100 then
  begin
    Timer_1.Enabled:=False;
    Currline:=0;
  end;
end;


procedure TForm1.zShowText;
var
  ss:string;
  ReadFile:TextFile;
begin
  AssignFile(ReadFile,Edit_1.Text);
  Reset(ReadFile);
  sItem:=TStringList.Create;
  with sItem do
    while not eof(ReadFile) do
    begin
      Readln(ReadFile,ss);
      add(ss);
    end;
  CloseFile(ReadFile);
  zBmpCreate;
  sItem.Free;//�ͷŴ�
end;

procedure TForm1.zBmpCreate;   //����ͼƬ
var
  i,y:integer; //y
begin
  if bmp<>nil then bmp.free;
  bmp:=TBitMap.Create;
  zSetBmp;
  R1.Right:=bRect.Right;
  R1.Bottom:=bRect.Bottom;
  y:=Panel_1.Height-100;
  for i:=0 to sItem.Count-1 do // ��0������  ѭ����ʾͼƬ
  begin
    R1.Top:=y;
    R1.Bottom:=R1.Top+LineHeight;
    //�ж���
    DrawText(Bmp.Canvas.Handle,pChar(sItem[i]),-1,R1,Dt_Center or Dt_Top);
    //�����
    //DrawText(Bmp.Canvas.Handle,pChar(sItem[i]),-1,R1,Dt_Left or Dt_Top);
    //�Ҷ���
    //DrawText(Bmp.Canvas.Handle,pChar(sItem[i]),-1,R1,Dt_Right or Dt_Top);

    Inc(y,LineHeight);
  end;
end;

procedure TForm1.zSetBmp;
begin
  zSetLineHeight;
  with bRect do //Rect ��������(����x,����y,����x,����y)
  begin
    Top:=0;
    Left:=0;
    Right:=Panel_1.Width;
    Bottom:=LineHeight*sItem.Count+Height;//�и�*����+form�߶�
  end;
  with Bmp do
  begin
    Height:=bRect.Bottom+100;//ͼƬ�߶�
    Width:=bRect.Right;
    with Canvas do  //canvas ����
    begin

      FillRect(bRect);
      Brush.Style:=bsClear;
    end;
  end;
end;

procedure TForm1.zSetLineHeight;
{�����м��}
var
  Metrics:TTextMetric;  //�������� API
begin
  GetTextMetrics(iDc,Metrics);
  LineHeight:=Metrics.tmHeight+Metrics.tmInternalLeading-Bmp.Canvas.Font.Height;
end;

procedure TForm1.Button_1Click(Sender: TObject);
begin
if Edit_1.Text='' then
  ShowMessage('�������ļ���ַ')
  else
    Timer_1.Enabled:=not Timer_1.Enabled;
end;

procedure TForm1.Button_2Click(Sender: TObject);
begin
  timer_1.Enabled :=false;
  Currline:=0;
  Button_1.Click;
end;

procedure TForm1.TrackBar_1Change(Sender: TObject);
begin
  Timer_1.Interval:=TrackBar_1.Position*5;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Bmp<>nil then Bmp.Free;
end;

end.
