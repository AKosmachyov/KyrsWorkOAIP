unit questionCreat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,ShellAPI, jpeg, Menus, CheckLst;

type
  TForm11 = class(TForm)
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    OpenDialog1: TOpenDialog;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    ComboBox1: TComboBox;
    CheckListBox1: TCheckListBox;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image7MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image7MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
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
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image9MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image9MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;
  errCode:array[1..5] of string =('Не выбран вариант для редактирования.','Не введён вопрос.','Отсутствует запрашиваемый файл','Пожалуйста, выберите правильный ответ!','Вопрос должен быть введён и количество ответов должно быть больше 2.');
  compliteCode:array [1..1] of string =('Материал успешно добавлен');
implementation

uses questionEdit, testEditForm;

{$R *.dfm}

procedure TForm11.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  label2.Caption:='';
  Memo1.Lines.Clear;
  Image6.Visible:=true;
  Image9.Visible:=false;
  OpenDialog1.FileName:='';
  RadioGroup1.Items.Clear;
  CheckListBox1.Items.Clear;
  ListBox1.Items.Clear;
end;

procedure errorMessage(a:byte);
begin
  Form11.Enabled:=false;
  MessageBox(0,PChar(errCode[a]),'Ошибка!', MB_OK Or MB_ICONERROR);
  Form11.Enabled:=true;
  Form11.SetFocus;
end;

procedure compliteMessage(a:byte);
begin
  form11.Enabled:=false;
  MessageBox(0,PAnsiChar(compliteCode[a]),'Выполнено', MB_OK Or MB_ICONINFORMATION);
  form11.Enabled:=true;
  form11.SetFocus;
end;

procedure TForm11.Label2Click(Sender: TObject);
begin
  if(label2.Caption<>'')and(FileExists(OpenDialog1.FileName)) then
    ShellExecute(Handle, 'open', PChar(OpenDialog1.FileName), nil, nil, SW_SHOW)
  else
    errorMessage(3);
end;

procedure TForm11.FormShow(Sender: TObject);
begin
  form11.Memo1.SetFocus;
end;

procedure TForm11.Image5Click(Sender: TObject);
begin
  OpenDialog1.FileName:='';
  label2.Caption:='';
end;

procedure TForm11.Image6Click(Sender: TObject);
var
gl:string;
i:integer;
begin
  randomize();
  case ComboBox1.ItemIndex of
  0:if(RadioGroup1.ItemIndex=-1) then
  begin
    errorMessage(4);
    exit;
  end;
  1:if(CheckListBox1.Items.Count=-1) then
  begin
    errorMessage(4);
    exit;
  end;
  2:if(ListBox1.Items.Count=0) then
  begin
    errorMessage(4);
    exit;
  end;
  end;
  gl:='Отсутсвует';
  if(OpenDialog1.FileName<>'')then
  begin
    gl:= ExtractFileDir(ParamStr(0))+'\doc\'+inttostr(Random(8000))+Inttostr(GetTickCount)+ExtractFileExt(OpenDialog1.FileName);
    CopyFile(PChar(OpenDialog1.FileName),PChar(gl), true);
  end;
  if(image9.Visible) then
    if(Memo1.Text<>'')then
    begin
      form9.StringGrid1.Cells[1,form9.StringGrid1.Row]:=Memo1.Text;
      form9.StringGrid1.Cells[3,form9.StringGrid1.Row]:=ExtractFileName(gl);
      form9.StringGrid1.Cells[5,form9.StringGrid1.Row]:='';
      case ComboBox1.ItemIndex of
      0:begin
        form9.StringGrid1.Cells[2,form9.StringGrid1.Row]:=RadioGroup1.Items[RadioGroup1.ItemIndex];
        Form9.StringGrid1.Cells[4,Form9.StringGrid1.row]:='0';
        for i:=0 to RadioGroup1.Items.Count-1 do
          form9.StringGrid1.Cells[5,form9.StringGrid1.Row]:=form9.StringGrid1.Cells[5,form9.StringGrid1.Row]+'&'+RadioGroup1.Items[i];
      end;
      1:begin
        form9.StringGrid1.Cells[5,form9.StringGrid1.Row]:='';
        form9.StringGrid1.Cells[2,form9.StringGrid1.Row]:='' ;
        for i:=0 to CheckListBox1.Items.Count-1 do
        begin
          if CheckListBox1.Checked[i] then
            form9.StringGrid1.Cells[2,form9.StringGrid1.Row]:=form9.StringGrid1.Cells[2,form9.StringGrid1.Row]+CheckListBox1.Items[i]+'_';
        end;
        Form9.StringGrid1.Cells[4,Form9.StringGrid1.Row]:='1';
        for i:=0 to CheckListBox1.Items.Count-1 do
          form9.StringGrid1.Cells[5,form9.StringGrid1.Row]:=form9.StringGrid1.Cells[5,form9.StringGrid1.Row]+'&'+CheckListBox1.Items[i];
      end;
      2:begin
        form9.StringGrid1.Cells[2,form9.StringGrid1.Row]:='';
        Form9.StringGrid1.Cells[4,Form9.StringGrid1.Row]:='2';
        for i:=0 to ListBox1.Items.Count-1 do
        begin
          form9.StringGrid1.Cells[2,form9.StringGrid1.Row]:=form9.StringGrid1.Cells[2,form9.StringGrid1.Row]+ListBox1.Items[i]+'_';
          form9.StringGrid1.Cells[5,form9.StringGrid1.Row]:=form9.StringGrid1.Cells[5,form9.StringGrid1.Row]+ListBox1.Items[i]+'&';
        end;

      end;
      end;
      compliteMessage(1);
      Form9.sohran();
      Close();
      exit;
    end
    else
    begin
      errorMessage(5);
      exit;
    end;
  if(Form9.StringGrid1.Cells[0,Form9.StringGrid1.RowCount-1]<>'')then
    Form9.StringGrid1.RowCount:=Form9.StringGrid1.RowCount+1;
  if(Memo1.Text='') then
  begin
    errorMessage(5);
    exit;
  end;
  Form9.StringGrid1.Cells[0,Form9.StringGrid1.RowCount-1]:=inttostr(Form9.StringGrid1.RowCount-1);
  Form9.StringGrid1.Cells[1,Form9.StringGrid1.RowCount-1]:=Memo1.Text;
    Case ComboBox1.ItemIndex of
  0:begin
    if(RadioGroup1.Items.Count>=2)then
    begin
      Form9.StringGrid1.Cells[2,Form9.StringGrid1.RowCount-1]:=RadioGroup1.Items[RadioGroup1.ItemIndex];
      Form9.StringGrid1.Cells[3,Form9.StringGrid1.RowCount-1]:=ExtractFileName(gl);
      Form9.StringGrid1.Cells[4,Form9.StringGrid1.RowCount-1]:='0';
      for i:=0 to RadioGroup1.Items.Count-1 do
        Form9.StringGrid1.Cells[5,Form9.StringGrid1.RowCount-1]:=Form9.StringGrid1.Cells[5,Form9.StringGrid1.RowCount-1]+'&'+RadioGroup1.Items[i];
      compliteMessage(1);
    end
    else
    begin
      errorMessage(5);
      exit;
    end;
    end;
  1:begin
    if(CheckListBox1.Items.Count>=2)then
    begin
      for i:=0 to CheckListBox1.Items.Count-1 do
      begin
        if CheckListBox1.Checked[i] then
          form9.StringGrid1.Cells[2,form9.StringGrid1.RowCount-1]:=form9.StringGrid1.Cells[2,form9.StringGrid1.RowCount-1]+CheckListBox1.Items[i]+'_';
      end;
      form9.StringGrid1.Cells[3,form9.StringGrid1.RowCount-1]:=ExtractFileName(gl);
      Form9.StringGrid1.Cells[4,Form9.StringGrid1.RowCount-1]:='1';
      for i:=0 to CheckListBox1.Items.Count-1 do
        form9.StringGrid1.Cells[5,form9.StringGrid1.RowCount-1]:=form9.StringGrid1.Cells[5,form9.StringGrid1.RowCount-1]+'&'+CheckListBox1.Items[i];
      compliteMessage(1);
    end
    else
    begin
      errorMessage(5);
      exit;
    end;
  end;
  2:begin
    if(ListBox1.Items.Count>=1)then
    begin
      for i:=0 to ListBox1.Items.Count-1 do
      begin
        form9.StringGrid1.Cells[2,form9.StringGrid1.RowCount-1]:=form9.StringGrid1.Cells[2,form9.StringGrid1.RowCount-1]+ListBox1.Items[i]+'_';
        form9.StringGrid1.Cells[5,form9.StringGrid1.RowCount-1]:=form9.StringGrid1.Cells[5,form9.StringGrid1.RowCount-1]+ListBox1.Items[i]+'&';
      end;
      form9.StringGrid1.Cells[3,form9.StringGrid1.RowCount-1]:=ExtractFileName(gl);
      Form9.StringGrid1.Cells[4,Form9.StringGrid1.RowCount-1]:='2';
      compliteMessage(1);
    end
    else
    begin
      errorMessage(5);
      exit;
    end;
  end;
  end;
  Form9.sohran();
  Close();
end;

procedure TForm11.Image1Click(Sender: TObject);
begin
  if(Memo1.Text<>'')
  then
  begin
    Form12.Label1.Caption:='Введите вариант ответа для добавления';
    Form12.typeQuest:=ComboBox1.ItemIndex;
    Form12.Image11.Visible:=true;
    Form12.Image22.Visible:=false;
    Form12.Showmodal();
  end
  else
    errorMessage(2);
end;

procedure openEditDialog(text:string);
begin
   Form12.Label1.Caption:='Редактируйте вариант ответа';
   Form12.edit1.Text:=text;
   Form12.Image11.Visible:=false;
   Form12.Image22.Visible:=true;
   Form12.Showmodal();
end;

procedure TForm11.Image2Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0:begin
      if(RadioGroup1.ItemIndex<>-1)then
      begin
        Form12.typeQuest:=0;
        openEditDialog(RadioGroup1.Items[RadioGroup1.ItemIndex])
      end
      else
        errorMessage(1);
    end;
    1:begin
      if(CheckListBox1.ItemIndex<>-1)then
      begin
        Form12.typeQuest:=1;
        openEditDialog(CheckListBox1.Items[CheckListBox1.ItemIndex]);
      end
      else
       errorMessage(1);
    end;
    2:begin
      if(ListBox1.ItemIndex<>-1)then
      begin
        Form12.typeQuest:=2;
        openEditDialog(ListBox1.Items[ListBox1.ItemIndex]);
      end
      else
        errorMessage(1);
    end;
  end;
end;

procedure TForm11.Image3Click(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0:begin
      if(RadioGroup1.ItemIndex<>-1)then
        RadioGroup1.Items.Delete(RadioGroup1.ItemIndex);
    end;
    1:begin
      if(CheckListBox1.ItemIndex<>-1) then
        CheckListBox1.Items.Delete(CheckListBox1.ItemIndex);
    end;
    2:begin
      if(ListBox1.ItemIndex<>-1) then
        ListBox1.Items.Delete(ListBox1.ItemIndex);
    end;
  end;
end;

procedure TForm11.Image7Click(Sender: TObject);
begin
  Close();
end;

procedure TForm11.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image2.Width:=Image2.Width-3;
Image2.Height:=Image2.Height-2;
end;

procedure TForm11.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image2.Width:=Image2.Width+3;
Image2.Height:=Image2.Height+2;
end;

procedure TForm11.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image1.Width:=Image1.Width-3;
Image1.Height:=Image1.Height-2;
end;

procedure TForm11.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image1.Width:=Image1.Width+3;
Image1.Height:=Image1.Height+2;
end;

procedure TForm11.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image3.Width:=Image3.Width-3;
Image3.Height:=Image3.Height-2;
end;

procedure TForm11.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image3.Width:=Image3.Width+3;
Image3.Height:=Image3.Height+2;
end;

procedure TForm11.Image4Click(Sender: TObject);
begin
  if(OpenDialog1.Execute())then
    label2.Caption:='Прикреплено вложение: '+ ExtractFileName(OpenDialog1.FileName)+' (для просмотра кликните по данному тексту)';
end;

procedure TForm11.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width-3;
  Image4.Height:=Image4.Height-2;
end;       

procedure TForm11.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image4.Width:=Image4.Width+3;
Image4.Height:=Image4.Height+2;
end;

procedure TForm11.Image5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image5.Width:=Image5.Width-3;
Image5.Height:=Image5.Height-2;
end;

procedure TForm11.Image5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image5.Width:=Image5.Width+3;
Image5.Height:=Image5.Height+2;
end;

procedure TForm11.Image6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image6.Width:=Image6.Width-3;
Image6.Height:=Image6.Height-2;
end;

procedure TForm11.Image7MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image7.Width:=Image7.Width+3;
Image7.Height:=Image7.Height+2;
end;

procedure TForm11.Image7MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image7.Width:=Image7.Width-3;
Image7.Height:=Image7.Height-2;
end;

procedure TForm11.Image9MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image9.Width:=Image9.Width-3;
Image9.Height:=Image9.Height-2;
end;

procedure TForm11.Image9MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image9.Width:=Image9.Width+3;
Image9.Height:=Image9.Height+2;
end;

procedure TForm11.Image6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
Image6.Width:=Image6.Width+3;
Image6.Height:=Image6.Height+2;
end;

procedure TForm11.ComboBox1Change(Sender: TObject);
begin
  CheckListBox1.Visible:=False;
  RadioGroup1.Visible:=False;
  ListBox1.Visible:=False;
  case ComboBox1.ItemIndex of
    0:RadioGroup1.Visible:=True;
    1:CheckListBox1.Visible:=True;
    2:ListBox1.Visible:=True;
  end;
end;

end.
