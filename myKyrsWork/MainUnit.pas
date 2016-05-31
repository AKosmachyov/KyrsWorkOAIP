unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, jpeg,ShellAPI;

type
  TForm1 = class(TForm)
    Image2: TImage;
    Image1: TImage;
    Image5: TImage;
    Image6: TImage;
    Image4: TImage;
    Image7: TImage;
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6Click(Sender: TObject);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses testEditForm, MainUnit2, LoginForm;

{$R *.dfm}

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm1.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

procedure TForm1.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  form2.id:=1;
  form1.Hide();
  form2.Showmodal();
end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  form2.id:=2;
  Form1.Hide();
  form2.Showmodal();
end;

procedure TForm1.Image5Click(Sender: TObject);
begin
  Close();
end;

procedure TForm1.Image5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image5.Width:=Image5.Width+3;
  Image5.Height:=Image5.Height+2;
end;

procedure TForm1.Image5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image5.Width:=Image5.Width-3;
  Image5.Height:=Image5.Height-2;
end;

procedure TForm1.Image6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image6.Width:=Image6.Width+3;
  Image6.Height:=Image6.Height+2;
end;

procedure TForm1.Image6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image6.Width:=Image6.Width-3;
  Image6.Height:=Image6.Height-2;
end;

procedure TForm1.Image6Click(Sender: TObject);
var
 f:textfile;
 s:string;
begin
  assignfile (f, ExtractFileDir(ParamStr(0))+'\fldr\flspr.bm');
  reset (f);
  readln(f,s);
  closefile (f);
  if(FileExists(ExtractFileDir(ParamStr(0))+'\doc\'+s))then
    ShellExecute(Handle, 'open', PChar(ExtractFileDir(ParamStr(0))+'\doc\'+s), nil, nil, SW_SHOW)
  else
  begin
    form1.Enabled:=false;
    MessageBox(0,'Отсутсвует файл справки','Ошибка', MB_OK Or MB_ICONERROR);
    form1.Enabled:=true;
    form1.SetFocus;
  end;
end;

procedure TForm1.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width+3;
  Image4.Height:=Image4.Height+2;
end;

procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width-3;
  Image4.Height:=Image4.Height-2;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
  PasswordDlg.Show;
end;

end.
