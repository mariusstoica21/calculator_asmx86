unit ImageButton;

// 2013 bummi

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ExtCtrls, StdCtrls,ImgList;

Type

  TState = (MouseIn, MouseOut, Pressed);

  TImageButton = class(TGraphicControl)
  private
    FChangeLink:TChangeLink;
    FImages: TCustomImageList;
    FDownIndex: Integer;
    FIndex: Integer;
    FHoverIndex: Integer;
    FState: TState;
    FCaption: String;
    FOwner: TComponent;
    FAutoWidth: Boolean;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMLBUTTONDOWN(var Message: TMessage); message WM_LBUTTONDOWN;
    procedure WMLBUTTONUP(var Message: TMessage); message WM_LBUTTONUP;
    procedure SetDownIndex(const Value: Integer);
    procedure SetHoverIndex(const Value: Integer);
    procedure SetIndex(const Value: Integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetCaption(const Value: String);
    procedure ImagelistChange(Sender: TObject);
    procedure SetAutoWidth(const Value: Boolean);
    procedure CheckAutoWidth;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; Override;
  published
    property AutoWidth:Boolean read FAutoWidth Write SetAutoWidth;
    property Caption;
    property DownIndex: Integer read FDownIndex Write SetDownIndex;
    property Font;
    property HoverIndex: Integer read FHoverIndex Write SetHoverIndex;
    property Images: TCustomImageList read FImages write SetImages;
    property Index: Integer read FIndex Write SetIndex;
  End;

procedure Register;

implementation

procedure TImageButton.ImagelistChange(Sender:TObject);
begin
   invalidate;
   CheckAutoWidth;
end;

Constructor TImageButton.create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FOwner := AOwner;
  FState := MouseOut;
  Width := 200;
  Height := 200;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange := ImagelistChange;
end;

Destructor TImageButton.Destroy;
begin
  if Assigned(FImages) then FImages.UnRegisterChanges(FChangeLink);
  FChangeLink.Free;
  inherited Destroy;
end;

procedure TImageButton.Paint;
var
  ico: TIcon;
  idx: Integer;
  DestRect: TRect;
  L_Caption: String;
begin
  inherited;
  idx := -1;
  if Assigned(FImages) then
  begin
    case FState of
      MouseIn:
        if FImages.Count > HoverIndex then
          idx := HoverIndex;
      MouseOut:
        if FImages.Count > Index then
          idx := Index;
      Pressed:
        if FImages.Count > DownIndex then
          idx := DownIndex;
    end;
    if idx > -1 then
      try
        ico := TIcon.create;
        FImages.GetIcon(idx, ico);
        Canvas.Draw(0, 0, ico);
      finally
        ico.Free;
      end;
  end
  else
  begin
    Canvas.Rectangle(ClientRect);
  end;
  Canvas.Brush.Style := bsClear;
  DestRect := ClientRect;
  L_Caption := Caption;
  Canvas.Font.Assign(Font);
  Canvas.TextRect(DestRect, L_Caption, [tfVerticalCenter, tfCenter, tfSingleLine]);
end;


procedure TImageButton.CheckAutoWidth;
begin
  if FAutoWidth and Assigned(FImages) then
    begin
      Width := FImages.Width;
      Height := FImages.Height;
    end;

end;

procedure TImageButton.SetAutoWidth(const Value: Boolean);
begin
  FAutoWidth := Value;
  CheckAutoWidth;
end;

procedure TImageButton.SetCaption(const Value: String);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TImageButton.SetDownIndex(const Value: Integer);
begin
  FDownIndex := Value;
  Invalidate;
end;

procedure TImageButton.SetHoverIndex(const Value: Integer);
begin
  FHoverIndex := Value;
  Invalidate;
end;

procedure TImageButton.SetImages(const Value: TCustomImageList);
begin
  if Assigned(FImages) then FImages.UnRegisterChanges(FChangeLink);
  FImages := Value;
  if Assigned(FImages) then
      begin
        FImages.RegisterChanges(FChangeLink);
        FImages.FreeNotification(FOwner);
        CheckAutoWidth;
      end;
  Invalidate;
end;

procedure TImageButton.SetIndex(const Value: Integer);
begin
  FIndex := Value;
  Invalidate;
end;

procedure TImageButton.WMLBUTTONDOWN(var Message: TMessage);
begin
  inherited;
  FState := Pressed;
  Invalidate;
end;

procedure TImageButton.WMLBUTTONUP(var Message: TMessage);
begin
  inherited;
  FState := MouseIn;
  Invalidate;
end;

procedure TImageButton.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

Procedure TImageButton.CMMouseEnter(var Message: TMessage);
Begin
  inherited;
  if (csDesigning in ComponentState) then
    Exit;
  if FState <> MouseIn then
  begin
    FState := MouseIn;
    Invalidate;
  end;
end;

Procedure TImageButton.CMMouseLeave(var Message: TMessage);
Begin
  inherited;
  if (csDesigning in ComponentState) then
    Exit;
  if FState <> MouseOut then
  begin
    FState := MouseOut;
    Invalidate;
  end;
end;

procedure TImageButton.CMTextChanged(var Message: TMessage);
begin
  invalidate;
end;

procedure Register;
begin
  RegisterComponents('Own', [TImageButton])
end;

end.
