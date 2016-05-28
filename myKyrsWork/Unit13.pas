unit Unit13;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, ComCtrls, ExtCtrls, jpeg;

type
  TForm13 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Edit3: TEdit;
    Memo1: TMemo;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
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
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;
  clear:boolean;

implementation

uses mainUnit;

{$R *.dfm}

procedure st_zapolnenie();
var i:integer;
begin
form13.Memo1.Lines.Clear;
form13.edit3.text:='';
form13.StringGrid1.Cells[0,0]:='';
for i:=1 to form13.StringGrid1.RowCount-1 do
begin
Form13.StringGrid1.Rows[i].Clear;
form13.StringGrid1.Cells[0,i]:='ЗАП.'+inttostr(i);
end;
for i:=1 to form13.StringGrid1.ColCount-2 do
begin
Form13.StringGrid1.ColWidths[i]:=30;
form13.StringGrid1.Cells[i,0]:='П.'+inttostr(i);
end;
form13.StringGrid1.Cells[0,form13.StringGrid1.RowCount-1]:='Потреб-ти' ;
form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,0]:='Запасы' ;
form13.StringGrid1.Col:=1;
Form13.StringGrid1.Row:=1;
end;

procedure TForm13.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Show();
end;

procedure TForm13.FormShow(Sender: TObject);
begin
st_zapolnenie();
clear:=false;
end;

procedure TForm13.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
if(ARow=0)or(ACol=0)or(ACol=StringGrid1.ColCount-1) and (ARow=StringGrid1.RowCount-1)
then
begin
Image1.Enabled:=False;
edit3.Text:='';
Edit3.Enabled:=false;
exit;
end
else
begin
Edit3.Text:= StringGrid1.Cells[ACol,ARow];
Image1.Enabled:=True;
Edit3.Enabled:=True;
edit3.SetFocus;
end;
end;

function proverka_na_otk():boolean;
var i,mag,skl:integer;
begin
skl:=0;
mag:=0;
for i:=1 to form13.StringGrid1.RowCount-2 do
skl:=skl+strtoint(form13.StringGrid1.Cells[form13.StringGrid1.Colcount-1,i]);
for i:=1 to form13.StringGrid1.ColCount-2 do
mag:=mag+strtoint(form13.StringGrid1.Cells[i,form13.StringGrid1.RowCount-1]);

if(skl=mag)
then
proverka_na_otk:=true
else
proverka_na_otk:=false;
end;

procedure msevzugla();
const
 n = 150;
var
 i, j, sum: integer;
zap,pot:array[1..n] of integer;
mas,koef: array[1..n,1..n] of integer;
begin
 if Clear
  then begin ShowMessage('Необходимо очистить таблицу!'); Exit; end;

if(proverka_na_otk()=false)
then
begin
MessageBox(0,'Данная транспортная задача не является закрытой','Ошибка', MB_OK Or MB_ICONERROR);
exit;
end;

 for i:=1 to form13.StringGrid1.RowCount-2 do
  for j:=1 to form13.StringGrid1.ColCount-2 do
   if form13.StringGrid1.Cells[j,i] <> ''
    then koef[i,j]:=StrToInt(form13.StringGrid1.Cells[j,i])
    else
     begin ShowMessage('Недостаточно данных!'); Exit; end;

 for i:=1 to form13.StringGrid1.ColCount-2 do
  if form13.StringGrid1.Cells[i,form13.StringGrid1.RowCount-1] = ''
   then
    begin ShowMessage('Недостаточно данных!'); Exit; end;
 for i:=1 to form13.StringGrid1.RowCount-2 do
  if form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i] = ''
   then
    begin ShowMessage('Недостаточно данных!'); Exit; end;
for i:=1 to form13.StringGrid1.RowCount-2  do
zap[i]:=strtoint(form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]);
for i:=1 to form13.StringGrid1.ColCount-2  do
pot[i]:=strtoint(form13.StringGrid1.Cells[i,form13.StringGrid1.RowCount-1]);
 for i:=1 to form13.StringGrid1.RowCount-2  do
  for j:=1 to form13.StringGrid1.ColCount-2 do
   if (StrToInt(form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]) <> 0) and (StrToInt(form13.StringGrid1.Cells[j,form13.StringGrid1.RowCount-1]) <> 0)
    then
     if StrToInt(form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]) >= StrToInt(form13.StringGrid1.Cells[j,form13.StringGrid1.RowCount-1])
      then
       begin
        mas[i,j]:=StrToInt(form13.StringGrid1.Cells[j,form13.StringGrid1.RowCount-1]);
        form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]:=inttostr(StrToInt(form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i])-StrToInt(form13.StringGrid1.Cells[j,form13.StringGrid1.RowCount-1]));
        form13.StringGrid1.Cells[j,form13.StringGrid1.RowCount-1]:='0';
       end
      else
       begin
        mas[i,j]:=StrToInt(form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]);
        form13.StringGrid1.Cells[i,form13.StringGrid1.RowCount-1]:=inttostr(StrToInt(form13.StringGrid1.Cells[j,form13.StringGrid1.RowCount-1])-StrToInt(form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]));
       form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]:='0';
       end
    else mas[i,j]:=0;

 sum:=0;   
 for i:=1 to form13.StringGrid1.RowCount-2 do
  for j:=1 to form13.StringGrid1.ColCount-2 do
   begin
    form13.StringGrid1.Cells[j,i]:=form13.StringGrid1.Cells[j,i]+' ('+IntToStr(mas[i,j])+')';
    sum:=sum+mas[i,j]*koef[i,j];
   end;
for i:=1 to form13.StringGrid1.RowCount-2  do
form13.StringGrid1.Cells[form13.StringGrid1.ColCount-1,i]:=inttostr(zap[i]);
for i:=1 to form13.StringGrid1.ColCount-2  do
form13.StringGrid1.Cells[i,form13.StringGrid1.RowCount-1]:=inttostr(pot[i]);
form13.memo1.Lines.Add('   S = '+IntToStr(sum));
 Clear:=true;

end;

procedure TForm13.Image1Click(Sender: TObject);
var
i,kod:integer;
begin
val(Edit3.Text,i,kod);
if(kod<>0)
then
begin
form13.Enabled:=false;
MessageBox(0,'В матрицу могут быть добавлены только числа','Ошибка', MB_OK Or MB_ICONERROR);
form13.Enabled:=true;
Edit3.SelectAll;
Edit3.SetFocus;
form13.SetFocus;
exit;
end;
StringGrid1.Cells[StringGrid1.Col,StringGrid1.Row]:=Edit3.Text;
if(form13.StringGrid1.row<>form13.StringGrid1.RowCount-1)
then
form13.StringGrid1.row:=form13.StringGrid1.row+1
else
if (form13.StringGrid1.Col<>form13.StringGrid1.ColCount-1)
then
begin
form13.StringGrid1.row:=1;
form13.StringGrid1.Col:=form13.StringGrid1.Col+1;
end
else
exit;
end;

procedure TForm13.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image1.Width:=Image1.Width-3;
Image1.Height:=Image1.Height-2;
end;

procedure TForm13.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image1.Width:=Image1.Width+3;
Image1.Height:=Image1.Height+2;
end;

procedure TForm13.Image2Click(Sender: TObject);
begin
 if MessageBox(0,'Все внесённые данные будут потеряны','Внивание!', MB_YESNO Or MB_ICONWARNING)= mrYes
  then
  begin
st_zapolnenie();
clear:=false;
end;
end;

procedure TForm13.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image2.Width:=Image2.Width-3;
Image2.Height:=Image2.Height-2;
end;

procedure TForm13.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image2.Width:=Image2.Width+3;
Image2.Height:=Image2.Height+2;
end;

procedure TForm13.Image3Click(Sender: TObject);
begin
if(ComboBox1.ItemIndex=0)
then
begin
MessageBox(0,'Выберите пожалуйста метод решения задачи','Ошибка', MB_OK Or MB_ICONERROR);
exit;
end;
if(ComboBox1.ItemIndex=1)
then
msevzugla();
end;

procedure TForm13.Image4Click(Sender: TObject);
begin
Close();
end;

procedure TForm13.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image4.Width:=Image4.Width-3;
Image4.Height:=Image4.Height-2;
end;

procedure TForm13.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image4.Width:=Image4.Width+3;
Image4.Height:=Image4.Height+2;
end;

procedure TForm13.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image3.Width:=Image3.Width+3;
Image3.Height:=Image3.Height+2;
end;

procedure TForm13.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image3.Width:=Image3.Width-3;
Image3.Height:=Image3.Height-2;
end;

procedure TForm13.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
StringGrid1.RowCount:=strtoint(Edit1.text)+2;
st_zapolnenie();
end;

procedure TForm13.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
StringGrid1.ColCount:=strtoint(Edit2.text)+2;
StringGrid1.ColWidths[StringGrid1.ColCount-1]:=55
;
st_zapolnenie();
end;

end.
