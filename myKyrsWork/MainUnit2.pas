unit MainUnit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, jpeg, ShellAPI;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image5: TImage;
    Image6: TImage;
    Image4: TImage;
    Image7: TImage;

    procedure Image1Click(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5Click(Sender: TObject);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
  private
    { Private declarations }
  public
  id:integer;
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses MaterialForm, testUiForm, mainUnit, LoginForm;

{$R *.dfm}

procedure TForm2.Image1Click(Sender: TObject);
begin
  if(id=1) then
  begin
    Form3.zapolni(1);
    Form3.Show();
  end;
  if(id=2)then
  begin
    form10.zapoln(1);
    form10.Show();
    form2.Hide();
  end;
end;

procedure TForm2.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm2.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

procedure TForm2.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm2.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width-3;
  Image3.Height:=Image3.Height-2;
end;

procedure TForm2.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width+3;
  Image3.Height:=Image3.Height+2;
end;

procedure TForm2.Image2Click(Sender: TObject);
begin
  if(id=1)then
  begin
    Form3.zapolni(2);
    Form3.Show();
  end;
  if(id=2)then
  begin
    Form10.zapoln(2);
    Form10.Show();
    form2.Hide();
  end;
end;

procedure TForm2.Image3Click(Sender: TObject);
begin
  if(id=1)then
  begin
    Form3.zapolni(3);
    Form3.Show();
  end;
  if(id=2) then
  begin
    Form10.zapoln(3);
    Form10.Show();
    form2.Hide();
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Show();
end;

procedure TForm2.Image5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image5.Width:=Image5.Width-3;
  Image5.Height:=Image5.Height-2;
end;

procedure TForm2.Image5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image5.Width:=Image5.Width+3;
  Image5.Height:=Image5.Height+2;
end;

procedure TForm2.Image5Click(Sender: TObject);
begin
  Close();
end;

procedure TForm2.Image6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image6.Width:=Image6.Width-3;
  Image6.Height:=Image6.Height-2;
end;

procedure TForm2.Image6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image6.Width:=Image6.Width+3;
  Image6.Height:=Image6.Height+2;
end;

procedure TForm2.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width-3;
  Image4.Height:=Image4.Height-2;
end;

procedure TForm2.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width+3;
  Image4.Height:=Image4.Height+2;
end;

procedure TForm2.Image4Click(Sender: TObject);
begin
  PasswordDlg.Show;
end;

procedure TForm2.Image6Click(Sender: TObject);
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
    form2.Enabled:=false;
    MessageBox(0,'Отсутсвует файл справки','Ошибка', MB_OK Or MB_ICONERROR);
    form2.Enabled:=true;
    form2.SetFocus;
  end;
end;

end.
