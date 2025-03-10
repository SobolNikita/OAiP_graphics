unit c;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs,
  Vcl.MPlayer;

type
  TArr = array [1 .. 4, 1 .. 2, 1 .. 2] of integer;

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Timer2: TTimer;
    MediaPlayer1: TMediaPlayer;
    procedure FormPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
    FrameIndex: integer; // ������ �������� �����
    XImage, YImage: Integer; // ������� ����
    procedure DrawBackground; // ��������� ��� ��������� ����
    procedure DrawCharacter; // ��������� ��� ��������� ���������
  public
    { Public declarations }
    procedure DrawFrame;
  end;

  TMyCanvas = class(TCanvas)
    procedure DrawCharacter(X, Y, scale, RBody, RLeftH, RLeftH2, RRightH, RRightH2,
RLeftLeg, RLeftLeg2, RRightLeg, RRightLeg2, RStick, scaleStick: integer);
  end;

const CNT_RUN_FRAMES = 11;
      CNT_JUMP_FRAMES = 15;
      CNT_HIT_FRAMES = 1;
      LAST_RUN_FRAME = 28;

var
  Form1: TForm1;
  X, Y: integer;
  MC: TMyCanvas;
  bgScales: array[1..CNT_JUMP_FRAMES] of real = (
    1, 1, 1.05, 1.1, 1.15, 1.2, 1.25, 1.3, 1.25, 1.2, 1.15, 1.1, 1.05, 1, 1
  );
  Y_JUMP_POS: array[1..CNT_JUMP_FRAMES] of integer = (
    -3000, -2800, -2700, -2400, -2100, -2000, -2100, -2400, -2400, -2500, -2600, -2700, -2800, -2900, -3000
  );
implementation

{$R *.dfm}


function toRad(const val: integer): real;
begin
  Result := val * PI / 180.0;
end;

procedure TMyCanvas.DrawCharacter(X, Y, scale, RBody, RLeftH, RLeftH2, RRightH, RRightH2,
RLeftLeg, RLeftLeg2, RRightLeg, RRightLeg2, RStick, scaleStick: integer);
var X2, Y2, downBodyX, downBodyY, LeftArmX, LeftArmY: integer;
begin
  RBody := RBody mod 360;

  RLeftH := RLeftH mod 360;
  RLeftH2 := RLeftH2 mod 360;
  RRightH := RRightH mod 360;
  RRightH2 := RRightH2 mod 360;

  RLeftLeg := RLeftLeg mod 360;
  RLeftLeg2 := RLeftLeg2 mod 360;
  RRightLeg := RRightLeg mod 360;
  RRightLeg2 := RRightLeg2 mod 360;



  // ��������
  Form1.Canvas.MoveTo(X, Y);
  downBodyX := X + round(scale * 4 * sin(toRad(RBody)));
  downBodyY := Y + round(scale * 4 * cos(toRad(RBody)));
  Form1.Canvas.LineTo(downBodyX, downBodyY); // ����� ������

  // ������
  Form1.Canvas.Ellipse(X - round(scale * sin(toRad(RBody))) - scale,
                       Y - round(scale * cos(toRad(RBody))) - scale,
                       X - round(scale * sin(toRad(RBody))) + scale,
                       Y - round(scale * cos(toRad(RBody))) + scale);


// ����� ����
  X2 := X + round(scale * 3 * sin(toRad(RLeftH)));
  Y2 := Y + round(scale * 3 * cos(toRad(RLeftH)));
  LeftArmX := X2 + round(scale * 2 * sin(toRad(RLeftH2)));
 LeftArmY := Y2 + round(scale * 2 * cos(toRad(RLeftH2)));
  Form1.Canvas.Polyline([
    Point(X, Y),
    Point(X2, Y2),
    Point(LeftArmX, LeftArmY)]);


    // �����
    Form1.Canvas.MoveTo(LeftArmX, LeftArmY);
  Form1.Canvas.LineTo(LeftArmX - round(scaleStick * scale * 8 * sin(toRad(RStick))),
                      LeftArmY - round(scaleStick * scale * 8 * cos(toRad(RStick))));
  Form1.Canvas.MoveTo(LeftArmX, LeftArmY);
  Form1.Canvas.LineTo(LeftArmX + round(scaleStick * scale * 4 * sin(toRad(RStick))),
                      LeftArmY + round(scaleStick * scale * 4 * cos(toRad(RStick))));

// ������ ����

  X2 := X + round(scale * 3 * sin(toRad(RRIghtH)));
  Y2 := Y + round(scale * 3 * cos(toRad(RRIghtH)));
  Form1.Canvas.Polyline([
    Point(X, Y),
    Point(X2, Y2),
    Point(X2 + round(scale * 2 * sin(toRad(RRIghtH2))),
          Y2 + round(scale * 2 * cos(toRad(RRIghtH2))))
    ]);

// ����� ����
  X2 := downBodyX + round(scale * 3 * sin(toRad(RLeftLeg)));
  Y2 := downBodyY + round(scale * 3 * cos(toRad(RLeftLeg)));
  Form1.Canvas.Polyline([
    Point(downBodyX, downBodyY),
    Point(X2, Y2),
    Point(X2 + round(scale * 2 * sin(toRad(RLeftLeg2))),
          Y2 + round(scale * 2 * cos(toRad(RLeftLeg2))))
  ]);

// ������ ����
  X2 := downBodyX + round(scale * 3 * sin(toRad(RRightLeg)));
  Y2 := downBodyY + round(scale * 3 * cos(toRad(RRightLeg)));
  Form1.Canvas.Polyline([
    Point(downBodyX, downBodyY),
    Point(X2, Y2),
    Point(X2 + round(scale * 2 * sin(toRad(RRightLeg2))),
          Y2 + round(scale * 2 * cos(toRad(RRightLeg2))))
  ]);
end;

procedure TForm1.DrawBackground;
var
  BitMap: TBitmap;
  DestRect: TRect;
  scale: real;
begin

  scale := 1;

  if (FrameIndex >= LAST_RUN_FRAME) and (FrameIndex < LAST_RUN_FRAME + 15) then
  begin
    scale := bgScales[((FrameIndex-LAST_RUN_FRAME) mod CNT_JUMP_FRAMES + 1)];
    if FrameIndex >= LAST_RUN_FRAME + 4 then
      XImage := XImage - 15;
      YImage := Y_JUMP_POS[((FrameIndex-LAST_RUN_FRAME) mod CNT_JUMP_FRAMES + 1)];
  end;


  BitMap := TBitmap.Create;
  try
    BitMap.LoadFromFile('Images/fon.bmp'); // ������� ���� � ����������� ����
    DestRect := Rect(XImage, YImage, Round(BitMap.Width * Scale), Round(BitMap.Height * Scale));
    Canvas.StretchDraw(DestRect, BitMap);
    //Canvas.Draw(XImage, YImage, BitMap); // ������ ���
  finally
    BitMap.Free;
  end;
end;

procedure drawPerson(var a: array of integer);
begin
  MC.DrawCharacter(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9],
   a[10], a[11], a[12], a[13]);
end;


{
  X, Y, scale, RBody, RLeftH, RLeftH2, RRightH, RRightH2,
  RLeftLeg, RLeftLeg2, RRightLeg, RRightLeg2: integer
}
var frames: array[1..CNT_RUN_FRAMES + CNT_JUMP_FRAMES + CNT_HIT_FRAMES] of array[1..14] of integer =
  (
        //run

        (500, 500, 50, 350, 280, 45, 35, 135, 340, 300, 60, 10, -45, 1),

        (500, 500, 50, 350, 300, 60, 20, 120, 355, 270, 20, 350, -40, 1),

        (500, 500, 50, 350, 340, 45, 355, 45, 355, 0, 20, 270, -25, 1),

       (500, 500, 50, 350, 280, 45, 35, 135, 340, 300, 60, 10, -45, 1),

        (500, 500, 50, 350, 300, 60, 20, 120, 355, 270, 20, 350, -40, 1),

        (500, 500, 50, 350, 340, 45, 355, 45, 355, 0, 20, 270, -25, 1),

         (500, 500, 50, 350, 280, 45, 35, 135, 340, 300, 60, 10, -45, 1),

         (500, 500, 50, 350, 300, 60, 20, 120, 355, 270, 20, 350, -40, 1),

        (500, 500, 50, 350, 280, 45, 35, 135, 340, 300, 60, 10, -45, 1),

        (500, 500, 50, 350, 300, 60, 20, 120, 355, 270, 20, 350, -40, 1),

        (500, 500, 50, 350, 340, 45, 355, 45, 355, 0, 20, 270, -25, 1),

        //jump

        (500, 500, 50, 5, 110, 190, 150, 205, 10, 270, 25, 0, 52, 1),

        (500, 450, 55, 10, 170, 180, 135, 145, 335, 305, 55, 350, 246, 1),

        (500, 450, 60, 0, 180, 180, 135, 145, 340, 250, 30, 25, 249, 1),

        (500, 400, 60, 340, 200, 210, 90, 193, 340, 330, 30, 320, 240, 1),

        (500, 400, 65, 20, 215, 230, 170, 190, 0, 340, 50, 350, 289, 1),

        (500, 350, 65, 40, 215, 215, 165, 190, 30, 25, 120, 55, 283, 1),

        (500, 350, 70, 50, 215, 210, 185, 190, 135, 85, 95, 90, 289, 1),

        (500, 350, 70, 110, 200, 205, 180, 190, 190, 135, 200, 185, 282, 0),

        (500, 350, 65, 181, 328, 45, 25, 315, 175, 180, 205, 190, 0, 0),

        (500, 400, 65, 160, 10, 310, 15, 315, 135, 140, 145, 150, 0, 0),

        (500, 400, 60, 150, 80, 0, 340, 315, 100, 115, 115, 130, 0, 0),

        (500, 450, 60, 30, 270, 315, 315, 320, 45, 100, 60, 100, 0, 0),

        (500, 450, 55, 350, 170, 140, 90, 135, 340, 110, 20, 100, 0, 0),

        (500, 600, 55, 305, 170, 140, 90, 135, 320, 50, 340, 50, 0, 0),

        (500, 800, 50, 270, 190, 150, 150, 180, 190, 250, 240, 245, 0, 0),


        //hit

        (500, 800, 50, 270, 190, 150, 150, 180, 190, 250, 240, 245, 0, 0)

);


procedure TForm1.DrawCharacter;
begin
  if FrameIndex >= LAST_RUN_FRAME + 15 then
  begin
    drawPerson(frames[CNT_RUN_FRAMES + CNT_JUMP_FRAMES]);
    XImage := XImage + 8;
  end
  else if FrameIndex >= LAST_RUN_FRAME then
  begin
    drawPerson(frames[CNT_RUN_FRAMES + ((FrameIndex-LAST_RUN_FRAME) mod CNT_JUMP_FRAMES + 1)]);
    XImage := XImage - 15;
  end
  else
  begin
    drawPerson(frames[FrameIndex mod CNT_RUN_FRAMES + 1]);
  end;
end;

procedure TForm1.DrawFrame;
begin
  MC := TMyCanvas.Create; // ���������� ����������� ������������� ������
  MC.Handle := Canvas.Handle; // ��������� ����� ���� �������� ������
  DrawBackground; // ������ ���
  DrawCharacter; // ������ ���������
end;

// ����� ��� ��������� �������� �����
procedure TForm1.Button2Click(Sender: TObject);
begin
  drawPerson(frames[1]); // ����� ������������ �����
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  //������
  MediaPlayer1.FileName := 'music/fon_music.mp3';
  MediaPlayer1.Open;
  MediaPlayer1.Play;
  //������

  XImage := 0; // ������������� ������� ����
  YImage := -3000; // ������������� ������� ����
  Timer2.Enabled := True;

  X := 100;
  Y := 100;
  FrameIndex := 1; // �������� � ������� �����
  Timer1.Enabled := True; // ��������� ������
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Canvas.Brush.Color := clWhite;
  Color := clWhite;
  Canvas.Pen.Mode := pmNotXor;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  FrameIndex := FrameIndex + 1; // ������� � ���������� �����

  X := X + 1;
  if (X >= ClientWidth - 20) then
    Timer1.Enabled := false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  DrawFrame; // ������ ������� ����
  // ��������� ������� ����
  XImage := XImage - 8; // ������� ��� �����
end;

end.

// ������
