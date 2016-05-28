program Project2;

uses
  Forms,
  MainUnit in 'MainUnit.pas',
  MainUnit2 in 'MainUnit2.pas',
  Unit3 in 'Unit3.pas',
  LoginForm in 'LoginForm.pas',
  AdminMenu in 'AdminMenu.pas',
  PasswordEdit in 'PasswordEdit.pas',
  MaterialEditForm in 'MaterialEditForm.pas',
  MaterialEdit in 'MaterialEdit.pas',
  testEditForm in 'testEditForm.pas',
  testUiForm in 'testUiForm.pas',
  questionCreat in 'questionCreat.pas',
  questionEdit in 'questionEdit.pas',
  Unit13 in 'Unit13.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TPasswordDlg, PasswordDlg);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.Run;
end.
