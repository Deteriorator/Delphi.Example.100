program ��������ͼƬ��ʾ����;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form6},
  Unit2 in 'Unit2.pas' {SplashForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TSplashForm, SplashForm);
  Application.Run;
end.
