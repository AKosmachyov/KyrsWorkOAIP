unit LoginForm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons,Dialogs, jpeg, ExtCtrls ;

type
  TPasswordDlg = class(TForm)
    Label1: TLabel;
    Password: TEdit;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PasswordDlg: TPasswordDlg;

implementation

uses AdminMenu;

{$R *.dfm}

function getOldPass(): String;
var
 f:textfile;
 tmp:string;
begin
  assignfile (f, ExtractFileDir(ParamStr(0))+'\fldr\ps.bm');
  reset (f);
  readln(f,tmp);
  getOldPass:=tmp;
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

procedure TPasswordDlg.Image1Click(Sender: TObject);
begin
  if(shifr(Password.Text)=getOldPass())then
  begin
    Password.Text:='';
    PasswordDlg.Close;
    Form5.ShowModal;
  end
  else
  begin
    PasswordDlg.Enabled:=false;
    MessageBox(0,'Пароль введён неверно!','Ошибка!', MB_OK Or MB_ICONERROR);
    PasswordDlg.Enabled:=true;
    PasswordDlg.SetFocus;
    Password.SetFocus;
    Password.SelectAll;
  end;
end;

procedure TPasswordDlg.Image2Click(Sender: TObject);
begin
  Close();
end;

end.

