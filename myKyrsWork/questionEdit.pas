unit questionEdit;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TForm12 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Image11: TImage;
    Image22: TImage;
    Image1: TImage;
    Image2: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image11Click(Sender: TObject);
    procedure Image11MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image22MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image22MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
    typeQuest:Byte;
  end;

var
  Form12: TForm12;

implementation
uses questionCreat;

{$R *.dfm}

procedure TForm12.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  label1.Caption:='';
  edit1.Text:='';
end;

procedure TForm12.FormShow(Sender: TObject);
begin
  edit1.SetFocus;
end;

procedure showEditNotification();
begin
  Form12.Enabled:=false;
  Windows.MessageBox(0,'Успешно отредактировано','Выполнено', MB_OK Or MB_ICONINFORMATION);
  Form12.Enabled:=true;
  Form12.Close();
end;

procedure TForm12.Image11Click(Sender: TObject);
begin
  if(edit1.Text='')then
    exit;
  if(Image22.Visible)then
  begin
    case typeQuest of
      0:begin
        form11.RadioGroup1.Items[form11.RadioGroup1.ItemIndex]:=edit1.Text;
        showEditNotification();
        Exit;
      end;
      1:begin
        form11.CheckListBox1.Items[form11.CheckListBox1.ItemIndex]:=edit1.Text;
        showEditNotification();
        Exit;
      end;
      2:begin
        form11.ListBox1.Items[form11.ListBox1.ItemIndex]:=edit1.Text;
        showEditNotification();
        Exit;
      end;
    end;
  end;
  case typeQuest of
    0:Form11.RadioGroup1.Items.Add(edit1.Text);
    1:Form11.CheckListBox1.Items.Add(edit1.Text);
    2:Form11.ListBox1.Items.Add(edit1.Text);
  end;
  Close();
end;

procedure TForm12.Image22MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image22.Width:=Image22.Width-3;
  Image22.Height:=Image22.Height-2;
end;

procedure TForm12.Image22MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image22.Width:=Image22.Width+3;
  Image22.Height:=Image22.Height+2;
end;

procedure TForm12.Image11MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image11.Width:=Image11.Width-3;
  Image11.Height:=Image11.Height-2;
end;

procedure TForm12.Image11MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image11.Width:=Image11.Width+3;
  Image11.Height:=Image11.Height+2;
end;

procedure TForm12.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width-3;
  Image1.Height:=Image1.Height-2;
end;

procedure TForm12.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Image1.Width:=Image1.Width+3;
  Image1.Height:=Image1.Height+2;
end;

procedure TForm12.Image1Click(Sender: TObject);
begin
  Close();
end;

end.
