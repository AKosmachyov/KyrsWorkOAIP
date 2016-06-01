unit testUiForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,ShellAPI, jpeg, CheckLst;

type
  TForm10 = class(TForm)
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label2: TLabel;
    Timer1: TTimer;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    CheckListBox1: TCheckListBox;
    Edit1: TEdit;
    Label6: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
    procedure Image5Click(Sender: TObject);
    procedure Image5MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6Click(Sender: TObject);
    procedure Image6MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image6MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
   procedure zapoln(id:integer);
  end;

var
  Form10: TForm10;
  i,nomv:integer;
  bal:integer;
  otvet,timeStr:string;
  isnom,sl: TStringList;

implementation

uses MainUnit2;

{$R *.dfm}
function DecodeBase64(const CinLine: string): string;
const
  RESULT_ERROR = -2;
var
  inLineIndex: Integer;
  c: Char;
  x: SmallInt;
  c4: Word;
  StoredC4: array[0..3] of SmallInt;
  InLineLength: Integer;
begin
  Result := '';
  inLineIndex := 1;
  c4 := 0;
  InLineLength := Length(CinLine);

  while inLineIndex <=InLineLength do
  begin
    while (inLineIndex <=InLineLength) and (c4 < 4) do
    begin
      c := CinLine[inLineIndex];
      case c of
        '+'     : x := 62;
        '/'     : x := 63;
        '0'..'9': x := Ord(c) - (Ord('0')-52);
        '='     : x := -1;
        'A'..'Z': x := Ord(c) - Ord('A');
        'a'..'z': x := Ord(c) - (Ord('a')-26);
      else
        x := RESULT_ERROR;
      end;
      if x <> RESULT_ERROR then
      begin
        StoredC4[c4] := x;
        Inc(c4);
      end;
      Inc(inLineIndex);
    end;

    if c4 = 4 then
    begin
      c4 := 0;
      Result := Result + Char((StoredC4[0] shl 2) or (StoredC4[1] shr 4));
      if StoredC4[2] = -1 then Exit;
      Result := Result + Char((StoredC4[1] shl 4) or (StoredC4[2] shr 2));
      if StoredC4[3] = -1 then Exit;
      Result := Result + Char((StoredC4[2] shl 6) or (StoredC4[3]));
    end;
  end;
end;

procedure nvopros();
var
  i,rr:integer;
  oe,chList: TStringList;
begin
  form10.RadioGroup1.Items.Clear;
  form10.CheckListBox1.Items.Clear;
  Form10.Edit1.Text:='';
  randomize();
  oe := TStringList.Create;
  rr:=random((sl.Count div 5));
  while (isnom.IndexOf(inttostr(rr))<>-1)do
    rr:=random((sl.Count div 5));;
  isnom.Add(inttostr(rr));
  if(sl[rr*5+2]<>'Отсутсвует')then
  begin
    form10.Image6.Visible:=true;
    form10.Image6.Hint:=sl[rr*5+2];
  end
  else
    form10.Image6.Visible:=false;
  form10.Label1.Caption:='Вопрос: '+sl[rr*5];
  if (sl[rr*5+3]='0') then
  begin
    otvet:=sl[rr*5+1];
    ExtractStrings(['&'],['&'],PChar(sl[rr*5+4]),oe);
    for i:=0 to oe.Count-1 do
      form10.RadioGroup1.Items.Add(oe[i]);
    form10.RadioGroup1.ItemIndex:=-1;
    Form10.RadioGroup1.Visible:=True;
  end;
  if sl[rr*5+3]='1' then
  begin
    otvet:= sl[rr*5+1];
    ExtractStrings(['&'],['&'],PChar(sl[rr*5+4]),oe);
    for i:=0 to oe.Count-1 do
      form10.CheckListBox1.Items.Add(oe[i]);
    Form10.CheckListBox1.Visible:=True;
  end;
  if sl[rr*5+3]='2' then
  begin
    otvet:= sl[rr*5+1];
    Form10.Edit1.Visible:=True;
  end;
    form10.Caption:='Вопрос № '+inttostr(nomv);
end;

procedure TForm10.zapoln(id:integer);
var
  f:textfile;
  pa,put:string;
  timeFile:TstringList;
begin
  if (id=1)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\tesmszu.bm';
  if (id=2)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\tesmmt.bm';
  if (id=3)then
    put:=ExtractFileDir(ParamStr(0))+'\fldr\tesmp.bm';
  sl := TStringList.Create;
  assignfile (f, put);
  reset (f);
  while not EOF(f) do
  begin
    readln(f,pa);
    ExtractStrings(['%'],['%'],PChar(DecodeBase64(pa)),sl);
  end;
  closefile (f);
  timeFile := TStringList.Create;
  assignfile (f,ExtractFileDir(ParamStr(0))+'\fldr\meta.bm' );
  reset (f);
  readln(f,pa);
  ExtractStrings(['%'],['%'],PChar(pa),timeFile);
  closefile (f);
  timeStr:=(timeFile[id-1]);
  Label6.Caption:=timeStr;
end;

procedure TForm10.Timer1Timer(Sender: TObject);
begin
  i:=i-1;
  if(i<120) then
    label3.Font.Color:=clRed;
  Label2.Caption:='Время до окончания теста: ';
  if((i mod 60)<10)then
    label3.Caption:=inttostr(i div 60)+':0'+inttostr(i mod 60)
  else
    label3.Caption:=inttostr(i div 60)+':'+inttostr(i mod 60);
  Label3.Visible:=true;
  Label2.Visible:=true;
  if i=0 then
  begin
    Timer1.Enabled:=false;
    form10.Enabled:=false;
    MessageBox(0,PAnsiChar('У Вас закончилось время, выполение теста прервано. Ваш результат: '+inttostr(bal)+' баллов(а)! После нажатия кнопки ОК тестирование будет завершено!'),'Информация', MB_OK Or MB_ICONINFORMATION);
    form10.Enabled:=true;
    form10.SetFocus;
    close();
  end;
end;

procedure TForm10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form10.Caption:='Выполнение теста';
  label2.Caption:='';
  label3.Caption:='';
  Label3.Visible:=false;
  Label2.Visible:=false;
  Panel1.Visible:=true;
  Image6.Visible:=false;
  RadioGroup1.Items.Clear;
  Timer1.Enabled:=false;
  bal:=0;
  Form2.Show;
end;

procedure TForm10.FormShow(Sender: TObject);
begin
  nomv:=1;
  isnom:=TStringList.Create;
  CheckListBox1.Visible:=False;
  RadioGroup1.Visible:=False;
  Edit1.Visible:=False;
end;

procedure TForm10.Button5Click(Sender: TObject);
begin
  ShowMessage(inttostr(random(2)));
end;

procedure TForm10.Image2Click(Sender: TObject);
begin
  Close();
end;

procedure TForm10.Image2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width-3;
  Image2.Height:=Image2.Height-2;
end;

procedure TForm10.Image2MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image2.Width:=Image2.Width+3;
  Image2.Height:=Image2.Height+2;
end;

procedure TForm10.Image3Click(Sender: TObject);
begin
  if(sl.Count<=49)then
  begin
    form10.Enabled:=false;
    MessageBox(0,'Для начала теста по теме необходимо минимум 10 вопросов! Добавьте вопросы в панеле администратора','Информация', MB_OK Or MB_ICONINFORMATION);
    form10.Enabled:=true;
    form10.SetFocus;
    exit;
  end;
  i:=StrToint(timeStr)*60;
  Timer1.Enabled:=true;
  Label2.Caption:='Время до окончания теста: ';
  label3.Caption:=timeStr+':00';
  Label3.Visible:=true;
  Label2.Visible:=true;
  Label3.Font.Color:=clGreen;
  Panel1.Visible:=false;
  nvopros();
end;

procedure TForm10.Image3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width-3;
  Image3.Height:=Image3.Height-2;
end;

procedure TForm10.Image3MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image3.Width:=Image3.Width+3;
  Image3.Height:=Image3.Height+2;
end;

procedure TForm10.Image4Click(Sender: TObject);
begin
  Timer1.Enabled:=false;
  form10.Enabled:=false;
  MessageBox(0,PAnsiChar('Выполение теста прервано. Ваш результат: '+inttostr(bal)+' баллов! После нажатия кнопки ОК тестирование будет завершено!'),'Информация', MB_OK Or MB_ICONINFORMATION);
  form10.Enabled:=true;
  close();
end;

procedure TForm10.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width-3;
  Image4.Height:=Image4.Height-2;
end;

procedure TForm10.Image4MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image4.Width:=Image4.Width+3;
  Image4.Height:=Image4.Height+2;
end;

procedure TForm10.Image5Click(Sender: TObject);
var
  i:integer;
  userOtvet:string;
  realOtvet:TStringList;
begin
  if(nomv=10) then
  begin
    if(RadioGroup1.Visible=True)then
    begin
      if(RadioGroup1.Items[RadioGroup1.ItemIndex]=otvet)then
        inc(bal);
    end;
    if (CheckListBox1.Visible = True) then
    begin
      for i:=0 to CheckListBox1.Items.Count-1 do
        if (CheckListBox1.Checked[i]) then
          userOtvet:=userOtvet+CheckListBox1.Items[i]+'_';
      if(userOtvet=otvet)then
        inc(bal);
    end;
    if (Edit1.Visible = True) then
    begin
      realOtvet := TStringList.Create;
      ExtractStrings(['_'],['_'],PChar(otvet),realOtvet);
      for i:=0 to realOtvet.Count-1 do
        if Form10.Edit1.Text=realOtvet[i] then
          inc(bal);

    end;
  end;
  if(nomv<10)then
  begin
    if (RadioGroup1.Visible= True) then
    begin
      if(RadioGroup1.ItemIndex=-1)then
      begin
        form10.Enabled:=false;
        MessageBox(0,'Для продолжения теста необходимо выбрать вариант ответа!','Информация', MB_OK Or MB_ICONQUESTION);
        form10.Enabled:=true;
        form10.SetFocus;
        exit;
      end;
      if(RadioGroup1.Items[RadioGroup1.ItemIndex]=otvet)then
        inc(bal);
      inc(nomv);
      RadioGroup1.Visible:=False;
      nvopros();                 
      Exit;
    end;
    if (CheckListBox1.Visible = True) then
    begin
      for i:=0 to CheckListBox1.Items.Count-1 do
        if (CheckListBox1.Checked[i]) then
          userOtvet:=userOtvet+CheckListBox1.Items[i]+'_';
      if(userOtvet=otvet)then
        inc(bal);
      inc(nomv);
      CheckListBox1.Visible:=False;
      nvopros();
      Exit;
    end;
    if (Edit1.Visible = True) then
    begin
      realOtvet := TStringList.Create;
      ExtractStrings(['_'],['_'],PChar(otvet),realOtvet);
      for i:=0 to realOtvet.Count-1 do
        if Form10.Edit1.Text=realOtvet[i] then
        begin
          inc(bal);
          Break;
        end;
      inc(nomv);
      Form10.Edit1.Visible:=False;
      nvopros();
    end;
  end
  else
  begin
    Timer1.Enabled:=false;
    form10.Enabled:=false;
    MessageBox(0,PAnsiChar('Ваш результат: '+inttostr(bal)+' баллов(а)! После нажатия кнопки ОК тестирование будет завершено!'),'Информация', MB_OK Or MB_ICONINFORMATION);
    form10.Enabled:=true;
    form10.SetFocus;
    close();
  end;
end;

procedure TForm10.Image5MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image5.Width:=Image5.Width+3;
  Image5.Height:=Image5.Height+2;
end;

procedure TForm10.Image5MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image5.Width:=Image5.Width-3;
  Image5.Height:=Image5.Height-2;
end;

procedure TForm10.Image6Click(Sender: TObject);
begin
  if(FileExists(ExtractFileDir(ParamStr(0))+'\doc\'+Image6.Hint))then
    ShellExecute(Handle, 'open', PChar(ExtractFileDir(ParamStr(0))+'\doc\'+Image6.Hint), nil, nil, SW_SHOW)
  else
  begin
    form10.Enabled:=false;
    MessageBox(0,'Отсутствует запрашиваемый файл','Ошибка!', MB_OK Or MB_ICONWARNING);
    form10.Enabled:=true;
    form10.SetFocus;
  end;
end;

procedure TForm10.Image6MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image6.Width:=Image6.Width-3;
  Image6.Height:=Image6.Height-2;
end;

procedure TForm10.Image6MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image6.Width:=Image6.Width+3;
  Image6.Height:=Image6.Height+2;
end;

end.
