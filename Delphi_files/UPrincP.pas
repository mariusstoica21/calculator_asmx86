unit UPrincP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,ImageButton,
  System.ImageList, Vcl.ImgList, Vcl.Imaging.jpeg, System.Actions, Vcl.ActnList,
  Vcl.ComCtrls,ShellAPI;

type
  TFPrincP = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    ImageList1: TImageList;
    Image1: TImage;
    ActionList1: TActionList;
    Press1: TAction;
    RichEdit1: TRichEdit;
    Press2: TAction;
    Press3: TAction;
    Press4: TAction;
    Press5: TAction;
    Press6: TAction;
    Press7: TAction;
    Press8: TAction;
    Press9: TAction;
    Press0: TAction;
    PressAdd: TAction;
    PressSub: TAction;
    PressMul: TAction;
    PressDiv: TAction;
    PressEqual: TAction;
    PressClear: TAction;
    procedure FormShow(Sender: TObject);
    procedure Press1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure setRichEdit(s:string);
    function checkLen():Boolean;
    procedure Press2Execute(Sender: TObject);
    procedure Press3Execute(Sender: TObject);
    procedure Press4Execute(Sender: TObject);
    procedure Press5Execute(Sender: TObject);
    procedure Press6Execute(Sender: TObject);
    procedure Press7Execute(Sender: TObject);
    procedure Press8Execute(Sender: TObject);
    procedure Press9Execute(Sender: TObject);
    procedure Press0Execute(Sender: TObject);
    procedure PressAddExecute(Sender: TObject);
    procedure PressSubExecute(Sender: TObject);
    procedure PressMulExecute(Sender: TObject);
    procedure PressDivExecute(Sender: TObject);
    procedure PressEqualExecute(Sender: TObject);
    procedure PressClearExecute(Sender: TObject);
  private
    { Private declarations }
    Btn1 : TImageButton;
    Btn2 : TImageButton;
    Btn3 : TImageButton;
    Btn4 : TImageButton;
    Btn5 : TImageButton;
    Btn6 : TImageButton;
    Btn7 : TImageButton;
    Btn8 : TImageButton;
    Btn9 : TImageButton;
    Btn0 : TImageButton;
    BtnAdd : TImageButton;
    BtnSub : TImageButton;
    BtnMul : TImageButton;
    BtnDiv : TImageButton;
    BtnEqual : TImageButton;
    BtnNone : TImageButton;
  public
    { Public declarations }
    str : string;
  end;

var
  FPrincP: TFPrincP;

implementation

{$R *.dfm}

//By pressing the buttons 0,1,2,3,4,5,6,7,8,9,+,-,*,/,= the string responsible
//for the operation will add the coresponding character

procedure TFPrincP.Press0Execute(Sender: TObject);
begin
  str := str + '0';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press1Execute(Sender: TObject);
begin
  str := str + '1';
  if checkLen() then
  begin
    setRichEdit(str);
  end;


end;

procedure TFPrincP.Press2Execute(Sender: TObject);
begin
  str := str + '2';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press3Execute(Sender: TObject);
begin
  str := str + '3';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press4Execute(Sender: TObject);
begin
  str := str + '4';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press5Execute(Sender: TObject);
begin
  str := str + '5';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press6Execute(Sender: TObject);
begin
  str := str + '6';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press7Execute(Sender: TObject);
begin
  str := str + '7';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press8Execute(Sender: TObject);
begin
  str := str + '8';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.Press9Execute(Sender: TObject);
begin
  str := str + '9';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.PressAddExecute(Sender: TObject);
begin
  str := str + '+';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

//By pressing the 'C' button (Clear), the operation string will be initialized
//and the RichEdit component will be cleared

procedure TFPrincP.PressClearExecute(Sender: TObject);
begin
  RichEdit1.Clear;
  str := '';
end;

procedure TFPrincP.PressDivExecute(Sender: TObject);
begin
  str := str + '/';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.PressEqualExecute(Sender: TObject);
var myText: TStringlist;
    txt: TextFile;
    s: string;
    allText: string;
    Path: string;
begin

  //The equal sign is added to the string. It is important for the assembly code
  //as it marks the ending of the operation

  str := str + '=';
  if checkLen() then
  begin
    setRichEdit(str);
  end;

  //Save the operation string to filename.txt
  myText:= TStringlist.create;
  try
    myText.Add(str);
    myText.SaveToFile('Others/filename.txt');
  finally
    myText.Free
  end;

  //Execute the assembly executable in order to read the string operation, parse
  //it, and execute it.

  Path := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName));
  Path := Path + 'Others\calculator.exe';
  ShellExecute(Handle, 'open',PChar(Path),
  nil, nil, SW_SHOWNORMAL);
  //Sleep for one second in order to wait for the opeation to be executed
  sleep(300);

  //The result of the operation is saved in result.txt file
  allText := '';
  AssignFile(Txt, 'Others/result.txt');
  Reset(txt);
  while not Eof(txt) do
  begin
    Readln(txt, s);
    allText := AllText + s;
  end;
  CloseFile(txt);

  //The RichEdit component displays the result
  setRichEdit(allText);

  str := '';


end;

procedure TFPrincP.PressMulExecute(Sender: TObject);
begin
  str := str + '*';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;

procedure TFPrincP.PressSubExecute(Sender: TObject);
begin
  str := str + '-';
  if checkLen() then
  begin
    setRichEdit(str);
  end;
end;


//This procedure adds style for the string operation
procedure TFPrincP.setRichEdit(s:string);
begin
  RichEdit1.Clear;
  RichEdit1.styleElements:=richedit1.styleElements-[seFont];
  RichEdit1.SelText := s;
  RichEdit1.SelAttributes.Style := [fsBold];

end;

//This function will display an error if the operation string is longer than
//25 characters
function TFPrincP.checkLen: Boolean;
begin
  if str.Length > 25 then
  begin
    ShowMessage('Operation is too long! Only 25 characters allowed!');
    result := false;
  end else begin
    result := true;
  end;
end;

//On Form Create, the string operation is initialized
procedure TFPrincP.FormCreate(Sender: TObject);
begin
  str := '';
end;

procedure TFPrincP.FormShow(Sender: TObject);
begin

  //Style elements for the RichEdit component
  RichEdit1.Clear;
  RichEdit1.styleElements:=richedit1.styleElements-[seFont];
  RichEdit1.SelAttributes.Color := $00E8833F;
  RichEdit1.SelAttributes.Style := [fsBold];


  //Style elements for the buttons
  Btn1 := TImageButton.Create(self);
  Btn1.Images := ImageList1;
  Btn1.Index := 0;
  Btn1.HoverIndex := 0;
  Btn1.DownIndex := 0;
  Btn1.Width := ImageList1.Width;
  Btn1.Height := ImageList1.Height;
  Btn1.Parent := Panel1;
  Btn1.Top := 245;
  Btn1.Left := 20;
  Btn1.Action := Press1;

  Btn2 := TImageButton.Create(self);
  Btn2.Images := ImageList1;
  Btn2.Index := 1;
  Btn2.HoverIndex := 1;
  Btn2.DownIndex := 1;
  Btn2.Width := ImageList1.Width;
  Btn2.Height := ImageList1.Height;
  Btn2.Parent := Panel1;
  Btn2.Top := 245;
  Btn2.Left := 110;
  Btn2.Action := Press2;

  Btn3 := TImageButton.Create(self);
  Btn3.Images := ImageList1;
  Btn3.Index := 2;
  Btn3.HoverIndex := 2;
  Btn3.DownIndex := 2;
  Btn3.Width := ImageList1.Width;
  Btn3.Height := ImageList1.Height;
  Btn3.Parent := Panel1;
  Btn3.Top := 245;
  Btn3.Left := 200;
  Btn3.Action := Press3;

  Btn4 := TImageButton.Create(self);
  Btn4.Images := ImageList1;
  Btn4.Index := 3;
  Btn4.HoverIndex := 3;
  Btn4.DownIndex := 3;
  Btn4.Width := ImageList1.Width;
  Btn4.Height := ImageList1.Height;
  Btn4.Parent := Panel1;
  Btn4.Top := 335;
  Btn4.Left := 20;
  Btn4.Action := Press4;

  Btn5 := TImageButton.Create(self);
  Btn5.Images := ImageList1;
  Btn5.Index := 4;
  Btn5.HoverIndex := 4;
  Btn5.DownIndex := 4;
  Btn5.Width := ImageList1.Width;
  Btn5.Height := ImageList1.Height;
  Btn5.Parent := Panel1;
  Btn5.Top := 335;
  Btn5.Left := 110;
  Btn5.Action := Press5;

  Btn6 := TImageButton.Create(self);
  Btn6.Images := ImageList1;
  Btn6.Index := 5;
  Btn6.HoverIndex := 5;
  Btn6.DownIndex := 5;
  Btn6.Width := ImageList1.Width;
  Btn6.Height := ImageList1.Height;
  Btn6.Parent := Panel1;
  Btn6.Top := 335;
  Btn6.Left := 200;
  Btn6.Action := Press6;

  Btn7 := TImageButton.Create(self);
  Btn7.Images := ImageList1;
  Btn7.Index := 6;
  Btn7.HoverIndex := 6;
  Btn7.DownIndex := 6;
  Btn7.Width := ImageList1.Width;
  Btn7.Height := ImageList1.Height;
  Btn7.Parent := Panel1;
  Btn7.Top := 425;
  Btn7.Left := 20;
  Btn7.Action := Press7;

  Btn8 := TImageButton.Create(self);
  Btn8.Images := ImageList1;
  Btn8.Index := 7;
  Btn8.HoverIndex := 7;
  Btn8.DownIndex := 7;
  Btn8.Width := ImageList1.Width;
  Btn8.Height := ImageList1.Height;
  Btn8.Parent := Panel1;
  Btn8.Top := 425;
  Btn8.Left := 110;
  Btn8.Action := Press8;

  Btn9 := TImageButton.Create(self);
  Btn9.Images := ImageList1;
  Btn9.Index := 8;
  Btn9.HoverIndex := 8;
  Btn9.DownIndex := 8;
  Btn9.Width := ImageList1.Width;
  Btn9.Height := ImageList1.Height;
  Btn9.Parent := Panel1;
  Btn9.Top := 425;
  Btn9.Left := 200;
  Btn9.Action := Press9;

  Btn0 := TImageButton.Create(self);
  Btn0.Images := ImageList1;
  Btn0.Index := 10;
  Btn0.HoverIndex := 10;
  Btn0.DownIndex := 10;
  Btn0.Width := ImageList1.Width;
  Btn0.Height := ImageList1.Height;
  Btn0.Parent := Panel1;
  Btn0.Top := 515;
  Btn0.Left := 110;
  Btn0.Action := Press0;

  BtnNone := TImageButton.Create(self);
  BtnNone.Images := ImageList1;
  BtnNone.Index := 9;
  BtnNone.HoverIndex := 9;
  BtnNone.DownIndex := 9;
  BtnNone.Width := ImageList1.Width;
  BtnNone.Height := ImageList1.Height;
  BtnNone.Parent := Panel1;
  BtnNone.Top := 515;
  BtnNone.Left := 20;
  BtnNone.Action := PressClear;

  BtnEqual := TImageButton.Create(self);
  BtnEqual.Images := ImageList1;
  BtnEqual.Index := 15;
  BtnEqual.HoverIndex := 15;
  BtnEqual.DownIndex := 15;
  BtnEqual.Width := ImageList1.Width;
  BtnEqual.Height := ImageList1.Height;
  BtnEqual.Parent := Panel1;
  BtnEqual.Top := 515;
  BtnEqual.Left := 200;
  BtnEqual.Action := PressEqual;


  BtnAdd := TImageButton.Create(self);
  BtnAdd.Images := ImageList1;
  BtnAdd.Index := 11;
  BtnAdd.HoverIndex := 11;
  BtnAdd.DownIndex := 11;
  BtnAdd.Width := ImageList1.Width;
  BtnAdd.Height := ImageList1.Height;
  BtnAdd.Parent := Panel1;
  BtnAdd.Top := 245;
  BtnAdd.Left := 290;
  BtnAdd.Action := PressAdd;

  BtnSub := TImageButton.Create(self);
  BtnSub.Images := ImageList1;
  BtnSub.Index := 12;
  BtnSub.HoverIndex := 12;
  BtnSub.DownIndex := 12;
  BtnSub.Width := ImageList1.Width;
  BtnSub.Height := ImageList1.Height;
  BtnSub.Parent := Panel1;
  BtnSub.Top := 335;
  BtnSub.Left := 290;
  BtnSub.Action := PressSub;

  BtnMul := TImageButton.Create(self);
  BtnMul.Images := ImageList1;
  BtnMul.Index := 13;
  BtnMul.HoverIndex := 13;
  BtnMul.DownIndex := 13;
  BtnMul.Width := ImageList1.Width;
  BtnMul.Height := ImageList1.Height;
  BtnMul.Parent := Panel1;
  BtnMul.Top := 425;
  BtnMul.Left := 290;
  BtnMul.Action := PressMul;

  BtnDiv := TImageButton.Create(self);
  BtnDiv.Images := ImageList1;
  BtnDiv.Index := 14;
  BtnDiv.HoverIndex := 14;
  BtnDiv.DownIndex := 14;
  BtnDiv.Width := ImageList1.Width;
  BtnDiv.Height := ImageList1.Height;
  BtnDiv.Parent := Panel1;
  BtnDiv.Top := 515;
  BtnDiv.Left := 290;
  BtnDiv.Action := PressDiv;



end;

end.
