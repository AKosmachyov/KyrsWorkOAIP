unit MaterialEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, jpeg;

type
  TForm8 = class(TForm)
    Edit1: TEdit;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;
  compliteCode:array [1..1] of string =('Материал успешно добавлен');
implementation

uses MaterialEditForm;

{$R *.dfm}

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  label3.Caption:='';
  edit1.Text:='';
  OpenDialog1.FileName:='';
  image4.Visible:=true;
  image3.Visible:=False;
  memo1.Clear;
end;

procedure compliteMessage(a:byte);
begin
  form8.Enabled:=false;
  MessageBox(0,PAnsiChar(compliteCode[a]),'Выполнено', MB_OK Or MB_ICONINFORMATION);
  form8.Enabled:=true;
  form8.SetFocus;
end;

procedure TForm8.Image1Click(Sender: TObject);
begin
  if(OpenDialog1.Execute())then
  begin
    label3.Font.Color:= clBlack;
    Label3.Caption:='Файл: '+ExtractFileName(OpenDialog1.FileName);
    if(edit1.Text='')then
      edit1.Text:=ExtractFileName(OpenDialog1.FileName);
    edit1.SetFocus;
  end;
end;

procedure TForm8.Image2Click(Sender: TObject);
begin
  Close();
end;

procedure save();
var
  name:string;
  opis:string;
  gl:string;
begin
  randomize();
  name:=form8.Edit1.Text;
  opis:=form8.memo1.Text;
  if(opis='')then
    opis:='Отсутствует';
  if(form8.OpenDialog1.FileName<>'')and(name<>'')then
  begin
    if(form8.Image3.Visible) then
    begin
      if(ExtractFileName(form8.OpenDialog1.FileName)=form7.StringGrid1.Cells[4,form7.StringGrid1.Row]) then
        gl:=form8.OpenDialog1.FileName
      else
      begin
        gl:= ExtractFileDir(ParamStr(0))+'\doc\'+inttostr(Random(8000))+Inttostr(GetTickCount)+ExtractFileExt(form8.OpenDialog1.FileName);
        CopyFile(PChar(form8.OpenDialog1.FileName),PChar(gl), true);
      end;
      form7.StringGrid1.Cells[1,form7.StringGrid1.RowCount-1]:=name;
      form7.StringGrid1.Cells[2,form7.StringGrid1.RowCount-1]:=opis;
      form7.StringGrid1.Cells[3,form7.StringGrid1.RowCount-1]:=Datetostr(now);
      form7.StringGrid1.Cells[4,form7.StringGrid1.RowCount-1]:=ExtractFileName(gl);
      compliteMessage(1);
      form7.save();
      form8.close();
      exit;
    end;
    if(form7.StringGrid1.Cells[0,form7.StringGrid1.RowCount-1]<>'')then
      form7.StringGrid1.RowCount:=form7.StringGrid1.RowCount+1;
    gl:= ExtractFileDir(ParamStr(0))+'\doc\'+inttostr(Random(8000))+Inttostr(GetTickCount)+ExtractFileExt(form8.OpenDialog1.FileName);
    CopyFile(PChar(form8.OpenDialog1.FileName),PChar(gl), true);
    form7.StringGrid1.Cells[0,form7.StringGrid1.RowCount-1]:=inttostr(form7.StringGrid1.RowCount-1);
    form7.StringGrid1.Cells[1,form7.StringGrid1.RowCount-1]:=name;
    form7.StringGrid1.Cells[2,form7.StringGrid1.RowCount-1]:=opis;
    form7.StringGrid1.Cells[3,form7.StringGrid1.RowCount-1]:=Datetostr(now);
    form7.StringGrid1.Cells[4,form7.StringGrid1.RowCount-1]:=ExtractFileName(gl);
    compliteMessage(1);
    form7.save();
    form8.close();
  end
  else
  begin
    form8.Enabled:=false;
    MessageBox(0,'Ошибка при добавлении материала! Выберите путь и укажите имя.','Ошибка', MB_OK Or MB_ICONERROR);
    form8.Enabled:=true;
    form8.SetFocus;
  end;
end;

procedure TForm8.Image3Click(Sender: TObject);
begin
 save();
end;

procedure TForm8.Image4Click(Sender: TObject);
begin
  save();
end;

procedure TForm8.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm8.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm8.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

procedure TForm8.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm8.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width-3;
  Image3.Height:=Image3.Height-2;
end;

procedure TForm8.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width+3;
  Image3.Height:=Image3.Height+2;
end;

procedure TForm8.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width-3;
  Image4.Height:=Image4.Height-2;
end;

procedure TForm8.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width+3;
  Image4.Height:=Image4.Height+2;
end;

end.
