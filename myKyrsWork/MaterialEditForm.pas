unit MaterialEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids,ShellAPI, jpeg, ExtCtrls ;

type
  TForm7 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
    procedure Image3Click(Sender: TObject);
    procedure Image3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4Click(Sender: TObject);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image4MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
  procedure save();
    { Public declarations }
  end;
var
  Form7: TForm7;
  fl:boolean;
  put:string;

implementation

uses MaterialEdit, AdminMenu;

{$R *.dfm}

procedure TForm7.save();
var
  f:textfile;
  i:integer;
begin
  if(put='')then
    exit;
  fl:=false;
  assignfile (f, put);
  rewrite(f);
  for i:=1  to form7.StringGrid1.RowCount-1 do
    writeln(f,form7.StringGrid1.Cells[1,i]+'%'+form7.StringGrid1.Cells[2,i]+'%'+form7.StringGrid1.Cells[3,i]+'%'+form7.StringGrid1.Cells[4,i]);
  closefile(f);
end;

procedure clear_tabl();
var
  i:integer;
begin
  for i:=1 to form7.StringGrid1.RowCount-1 do
    form7.StringGrid1.Rows[i].Clear;
  form7.StringGrid1.RowCount:=2;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex:=0;
end;

procedure TForm7.ComboBox1Change(Sender: TObject);
var
  f:textfile;
  i,j:integer;
  pa:string;
  sl: TStringList;
begin
  if(fl)then
    save();
  case ComboBox1.ItemIndex of
    0:begin
      clear_tabl();
      exit;
    end;
    1:put:=ExtractFileDir(ParamStr(0))+'\fldr\mszu.bm';
    2:put:=ExtractFileDir(ParamStr(0))+'\fldr\mmt.bm';
    3: put:=ExtractFileDir(ParamStr(0))+'\fldr\mp.bm';
  end;
  sl := TStringList.Create;
  assignfile (f, put);
  reset (f);
  while not EOF(f) do
  begin
    readln(f,pa );
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
    StringGrid1.Cells[2,i]:=sl[j];
    inc(j);
    StringGrid1.Cells[3,i]:=sl[j];
    inc(j);
    StringGrid1.Cells[4,i]:=sl[j];
    inc(j);
    StringGrid1.RowCount:= StringGrid1.RowCount+1;
  end;
  if(j<>0)then
    StringGrid1.RowCount:= StringGrid1.RowCount-1;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='№';
  StringGrid1.Cells[1,0]:='Название материала';
  StringGrid1.Cells[2,0]:='Описание';
  StringGrid1.Cells[3,0]:='Добавлено';
  StringGrid1.ColWidths[4]:=0;
  StringGrid1.Cells[4,0]:='Путь';
  fl:=false;
end;

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  clear_tabl();
  Form5.Show;
end;

procedure TForm7.Image1Click(Sender: TObject);
begin
  if(ComboBox1.ItemIndex<>0)then
    form8.Showmodal;
end;

procedure TForm7.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm7.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm7.Image2Click(Sender: TObject);
begin
  if(StringGrid1.Cells[4,StringGrid1.Row]<>'')then
  begin
    form8.edit1.text:=StringGrid1.Cells[1,StringGrid1.Row];
    form8.Memo1.Text:=StringGrid1.Cells[2,StringGrid1.Row];
    form8.OpenDialog1.FileName:=ExtractFileDir(ParamStr(0))+'\doc\'+StringGrid1.Cells[4,StringGrid1.Row];
    form8.Label3.Caption:='Файл: '+StringGrid1.Cells[4,StringGrid1.Row];
    form8.Image3.Visible:=true;
    form8.Image4.Visible:=false;
    form8.Showmodal;
  end;
end;

procedure TForm7.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

procedure TForm7.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm7.Image3Click(Sender: TObject);
var
  i,j:integer;
begin
  if(StringGrid1.Cells[0, StringGrid1.Row]<>'')then
  begin
    DeleteFile(ExtractFileDir(ParamStr(0))+'\doc\'+StringGrid1.Cells[4, StringGrid1.Row]);
    StringGrid1.Rows[StringGrid1.Row].Clear;
    for i:=1 to (StringGrid1.RowCount-1) do
      if(StringGrid1.Cells[0, i]='')then
      begin
        for j:=StringGrid1.Row to StringGrid1.RowCount-2 do
          begin
            StringGrid1.Cells[0, j]:=StringGrid1.Cells[0, j+1];
            StringGrid1.Cells[1, j]:=StringGrid1.Cells[1, j+1];
            StringGrid1.Cells[2, j]:=StringGrid1.Cells[2,  j+1];
            StringGrid1.Cells[3, j]:=StringGrid1.Cells[3,  j+1];
            StringGrid1.Cells[4, j]:=StringGrid1.Cells[4,  j+1];
          end;
        if(StringGrid1.RowCount>2)then
        begin
          StringGrid1.RowCount:=StringGrid1.RowCount-1;
          for j:=1 to  StringGrid1.RowCount-1 do
            StringGrid1.Cells[0, j]:=inttostr(j);
        end;
      end;
      fl:=true;
  end;
end;

procedure TForm7.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width-3;
  Image3.Height:=Image3.Height-2;
end;

procedure TForm7.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width+3;
  Image3.Height:=Image3.Height+2;
end;

procedure TForm7.Image4Click(Sender: TObject);
begin
  save();
  Close();
end;

procedure TForm7.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width-3;
  Image4.Height:=Image4.Height-2;
end;

procedure TForm7.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width+3;
  Image4.Height:=Image4.Height+2;
end;

end.
