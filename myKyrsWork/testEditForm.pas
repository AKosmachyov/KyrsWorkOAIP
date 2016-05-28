unit testEditForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ExtCtrls, jpeg;

type
  TForm9 = class(TForm)
    Label1: TLabel;
    StringGrid1: TStringGrid;
    ComboBox1: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ComboBox1Change(Sender: TObject);
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
  procedure sohran();
    { Public declarations }
  end;

var
  Form9: TForm9;
  fl:boolean;
  put:string;
implementation

uses questionCreat,AdminMenu;

{$R *.dfm}

procedure TForm9.sohran();
var
f:textfile;
i:integer;
begin
  if(put='')then
    exit;
  fl:=false;
  assignfile (f, put);
  rewrite(f);
  for i:=1  to form9.StringGrid1.RowCount-1 do
    writeln(f,form9.StringGrid1.Cells[1,i]+'%'+form9.StringGrid1.Cells[2,i]+'%'+form9.StringGrid1.Cells[3,i]+'%'+form9.StringGrid1.Cells[4,i]+'%'+form9.StringGrid1.Cells[5,i]);
  closefile(f);
end;

procedure clear_tabl();
var
  i:integer;
begin
  For i:=1 to Form9.StringGrid1.RowCount do
  begin
    Form9.StringGrid1.Rows[i].Clear;
  end;
  Form9.StringGrid1.RowCount:=2;
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0,0]:='№';
  StringGrid1.Cells[1,0]:='Вопрос';
  StringGrid1.Cells[2,0]:='Правильный ответ';
  StringGrid1.Cells[3,0]:='Вкладыш';
  StringGrid1.ColWidths[4]:=0;
  StringGrid1.ColWidths[5]:=0;
  StringGrid1.Cells[4,0]:='Тип вопроса';
  StringGrid1.Cells[5,0]:='Варианты ответа';
  fl:=false;
end;

procedure TForm9.FormShow(Sender: TObject);
begin
  ComboBox1.ItemIndex:=0;
end;

procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  clear_tabl();
  Form5.Show;
end;

procedure TForm9.ComboBox1Change(Sender: TObject);
var
  f:textfile;
  i,j:integer;
  pa:string;
  sl: TStringList;
begin
  if(fl) then
    sohran();
  if (ComboBox1.ItemIndex=0)then
  begin
    clear_tabl();
    exit;
  end;
  if (ComboBox1.ItemIndex=1)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\tesmszu.bm';
  if (ComboBox1.ItemIndex=2)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\tesmmt.bm';
  if (ComboBox1.ItemIndex=3) then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\tesmp.bm';
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
  for i:=1 to sl.Count div 5 do
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
    StringGrid1.Cells[5,i]:=sl[j];
    Inc(j);
    StringGrid1.RowCount:= StringGrid1.RowCount+1;
  end;
  if(j<>0) then
    StringGrid1.RowCount:= StringGrid1.RowCount-1;
end;

procedure TForm9.Image1Click(Sender: TObject);
begin
  if(ComboBox1.ItemIndex<>0)then
  begin
    Form11.ShowModal;
  end;
end;

procedure TForm9.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm9.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm9.Image2Click(Sender: TObject);
var
sl,s1: TStringList;
i,j:integer;
begin
  if(StringGrid1.Cells[1,StringGrid1.Row]<>'') then
  begin
    sl := TStringList.Create;
    ExtractStrings(['&'],['&'],PChar(StringGrid1.Cells[5,StringGrid1.Row]),sl);
    form11.Memo1.Text:=StringGrid1.Cells[1,StringGrid1.Row];
    case StrToInt(StringGrid1.Cells[4,StringGrid1.Row]) of
    0:for i:=0 to sl.Count-1 do
    begin
        form11.RadioGroup1.Items.Add(sl[i]);
        if(sl[i]=StringGrid1.Cells[2,StringGrid1.Row])then
          form11.RadioGroup1.ItemIndex:=i;
        Form11.ComboBox1.ItemIndex:=0;
        Form11.ComboBox1Change(Sender);
    end;
    1:begin
      s1 := TStringList.Create;
      ExtractStrings(['_'],['_'],PChar(StringGrid1.Cells[2,StringGrid1.Row]),s1);
      for i:=0 to sl.Count-1 do
      begin
        form11.CheckListBox1.Items.Add(sl[i]);
        for j:=0 to s1.Count-1 do
        begin
          if(sl[i]=s1[j])then
            form11.CheckListBox1.Checked[i]:=True;
        end;
      end;
      Form11.ComboBox1.ItemIndex:=1;
      Form11.ComboBox1Change(Sender);
    end;
    2:begin
      sl.Clear;
      ExtractStrings(['_'],['_'],PChar(StringGrid1.Cells[2,StringGrid1.Row]),sl);
      for i:=0 to sl.Count-1 do
      begin
        Form11.ListBox1.Items.Add(sl[i]);
      end;
      form11.image6.Visible:=false;
      form11.image9.Visible:=true;
      if(StringGrid1.Cells[3,StringGrid1.Row]<>'Отсутсвует')then
      begin
        form11.OpenDialog1.FileName:=ExtractFileDir(ParamStr(0))+'\doc\'+StringGrid1.Cells[3,StringGrid1.Row];
        form11.label2.Caption:='Прикреплено вложение: '+ ExtractFileName(form11.OpenDialog1.FileName)+' (для просмотра кликните по данному тексту)';
      end;
      Form11.ComboBox1.ItemIndex:=2;
      Form11.ComboBox1Change(Sender);
    end;
    end;
    Form11.Image6.Visible:=False;
    Form11.Image9.Visible:=True;
    form11.ShowModal;
  end;
end;

procedure TForm9.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

procedure TForm9.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm9.Image3Click(Sender: TObject);
var
i,j:integer;
begin
  if(StringGrid1.Cells[0, StringGrid1.Row]<>'')then
  begin
    DeleteFile(ExtractFileDir(ParamStr(0))+'\doc\'+StringGrid1.Cells[3, StringGrid1.Row]);
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

procedure TForm9.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width-3;
  Image3.Height:=Image3.Height-2;
end;

procedure TForm9.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width+3;
  Image3.Height:=Image3.Height+2;
end;

procedure TForm9.Image4Click(Sender: TObject);
begin
  sohran();
  Close();
end;

procedure TForm9.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width-3;
  Image4.Height:=Image4.Height-2;
end;

procedure TForm9.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width+3;
  Image4.Height:=Image4.Height+2;
end;

end.
