unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, MPlayer, Grids, StdCtrls,ShellAPI, jpeg;

type
  TForm3 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
  procedure zapolni(id:integer);
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses LoginForm;

{$R *.dfm}

procedure clear_tabl();
var
  i:integer;
begin
  for i:=1 to Form3.StringGrid1.RowCount-1 do
    Form3.StringGrid1.Rows[i].Clear;
  Form3.StringGrid1.RowCount:=2;
end;

procedure TForm3.zapolni(id:integer);
var
  f:textfile;
  i,j:integer;
  pa,put:string;
  sl: TStringList;
begin
  if (id=1)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\mszu.bm';
  if (id=2)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\mmt.bm';
  if (id=3)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\mp.bm';
  sl := TStringList.Create;
  assignfile (f, put);
  reset (f);
  while not EOF(f) do
  begin
    readln(f,pa);
    ExtractStrings(['%'],['%'],PChar(pa),sl);
  end;
  closefile (f);
  j:=0;
  clear_tabl();
  for i:=1 to sl.Count div 4 do
  begin
    StringGrid1.Cells[0,i]:=inttostr(i);
    StringGrid1.Cells[1,i]:=sl[j];
    inc(j);
    StringGrid1.Cells[3,i]:=sl[j];
    inc(j);
    StringGrid1.Cells[2,i]:=sl[j];
    inc(j);
    StringGrid1.Cells[4,i]:=sl[j];
    inc(j);
    StringGrid1.RowCount:= StringGrid1.RowCount+1;
  end;
  if(j<>0)then
    StringGrid1.RowCount:= StringGrid1.RowCount-1;
  label1.Caption:='Описание материала: '+StringGrid1.Cells[3,1];
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='№';
  StringGrid1.Cells[1,0]:='Название материала';
  StringGrid1.Cells[2,0]:='Добавлено';
  StringGrid1.Cells[3,0]:='Описание';
  StringGrid1.ColWidths[4]:=0;
  StringGrid1.Cells[4,0]:='Путь';
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  clear_tabl();
  label1.Caption:='Описание материала';
end;

procedure TForm3.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  label1.Caption:='Описание материала: '+StringGrid1.Cells[3,StringGrid1.Row];
end;

procedure TForm3.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm3.Image1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm3.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm3.Image2Click(Sender: TObject);
begin
  if(StringGrid1.Cells[4,StringGrid1.Row]<>'')and FileExists(ExtractFileDir(ParamStr(0))+'\doc\'+StringGrid1.Cells[4,StringGrid1.Row])then
    ShellExecute(Handle, 'open', PChar(ExtractFileDir(ParamStr(0))+'\doc\'+StringGrid1.Cells[4,StringGrid1.Row]), nil, nil, SW_SHOW)
  else
  begin
    form3.Enabled:=false;
    MessageBox(0,'Отсутствует запрашиваемый файл','Ошибка!', MB_OK Or MB_ICONWARNING);
    form3.Enabled:=true;
    form3.SetFocus;
  end;
end;

procedure TForm3.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm3.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

end.
