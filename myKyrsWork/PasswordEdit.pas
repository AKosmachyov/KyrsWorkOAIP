unit PasswordEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, jpeg, ExtCtrls;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  errCode:array [1..4] of string =('Ошибка! Поля не заполнены!','Ошибка! Пароль должен содержать минимум 8 символов!','Ошибка! Текущий пароль введён не верно!','Ошибка! Введённые новые пароли не совпадают!');
  oldPass:string;
implementation

{$R *.dfm}
procedure errMessage(a:byte);
begin
  form6.Enabled:=false;
  MessageBox(0,PAnsiChar(errCode[a]),'Ошибка', MB_OK Or MB_ICONINFORMATION);
  form6.Enabled:=true;
  form6.SetFocus;
  //edit1.SetFocus;
end;

function getOldPass(): String;
var
 f:textfile;
 tmp:string;
begin
  assignfile (f, ExtractFileDir(ParamStr(0))+'\fldr\ps.bm');
  reset (f);
  readln(f,tmp);
  getOldPass:= tmp;
  closefile (f);
end;

function shifr(S : String): String;
var i : Integer;
begin
  for i := 1 to Length(S) do
  begin
    S[i] := Chr(not Ord(S[i]));
  end;
  Result := S;
end;

procedure writeNewPass(s:string);
var
 f:textfile;
begin
  assignfile (f, ExtractFileDir(ParamStr(0))+'\fldr\ps.bm');
  rewrite (f);
  writeln(f,shifr(s));
  closefile(f);
end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edit1.Text:='';
  edit2.Text:='';
  edit3.Text:='';
  oldPass:='';
end;

procedure TForm6.Image1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm6.Image2Click(Sender: TObject);
begin
  if((Edit1.Text<>'') and (Edit2.Text<>'') and (Edit3.Text<>''))then
    if (shifr(Edit1.Text)=oldPass) then
      if(Length(Edit2.Text)>=8)then
        if(Edit2.Text=Edit3.Text)then
        begin
          writeNewPass(Edit2.Text);
          form6.Enabled:=false;
          MessageBox(0,'Пароль успешно изменён','Выполнено', MB_OK Or MB_ICONINFORMATION);
          form6.Enabled:=true;
          form6.SetFocus;
          Close();
        end
        else
        begin
        errMessage(4);
        exit;
        end
      else
      begin
        errMessage(2);
        exit;
      end
    else
    begin
      errMessage(3);
      exit;
    end
  else
  begin
    errMessage(1);
  end;
end;

procedure TForm6.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

procedure TForm6.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm6.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm6.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  oldPass:=getOldPass();
end;

end.
