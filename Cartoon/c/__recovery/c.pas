unit c;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs,
  Vcl.MPlayer;

type
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
    FrameIndex: integer; // Индекс текущего кадра
    XImage, YImage: Integer; // Позиция фона
    procedure DrawBackground; // Процедура для рисования фона
    procedure DrawCharacter; // Процедура для рисования персонажа
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
      CNT_HIT_FRAMES = 11;
      LAST_RUN_FRAME = 28;
      CNT_JUMP2_FRAMES = 25;
      CNT_WIN_FRAMES = 4;

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
  curaddY: integer;
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



  // туловище
  Form1.Canvas.MoveTo(X, Y);
  downBodyX := X + round(scale * 4 * sin(toRad(RBody)));
  downBodyY := Y + round(scale * 4 * cos(toRad(RBody)));
  Form1.Canvas.LineTo(downBodyX, downBodyY); // конец тулова

  // голова
  Form1.Canvas.Ellipse(X - round(scale * sin(toRad(RBody))) - scale,
                       Y - round(scale * cos(toRad(RBody))) - scale,
                       X - round(scale * sin(toRad(RBody))) + scale,
                       Y - round(scale * cos(toRad(RBody))) + scale);


// левая рука
  X2 := X + round(scale * 3 * sin(toRad(RLeftH)));
  Y2 := Y + round(scale * 3 * cos(toRad(RLeftH)));
  LeftArmX := X2 + round(scale * 2 * sin(toRad(RLeftH2)));
 LeftArmY := Y2 + round(scale * 2 * cos(toRad(RLeftH2)));
  Form1.Canvas.Polyline([
    Point(X, Y),
    Point(X2, Y2),
    Point(LeftArmX, LeftArmY)]);


    // палка
    Form1.Canvas.MoveTo(LeftArmX, LeftArmY);
  Form1.Canvas.LineTo(LeftArmX - round(scaleStick * scale * 8 * sin(toRad(RStick))),
                      LeftArmY - round(scaleStick * scale * 8 * cos(toRad(RStick))));
  Form1.Canvas.MoveTo(LeftArmX, LeftArmY);
  Form1.Canvas.LineTo(LeftArmX + round(scaleStick * scale * 4 * sin(toRad(RStick))),
                      LeftArmY + round(scaleStick * scale * 4 * cos(toRad(RStick))));

// правая рука

  X2 := X + round(scale * 3 * sin(toRad(RRIghtH)));
  Y2 := Y + round(scale * 3 * cos(toRad(RRIghtH)));
  Form1.Canvas.Polyline([
    Point(X, Y),
    Point(X2, Y2),
    Point(X2 + round(scale * 2 * sin(toRad(RRIghtH2))),
          Y2 + round(scale * 2 * cos(toRad(RRIghtH2))))
    ]);

// левая нога
  X2 := downBodyX + round(scale * 3 * sin(toRad(RLeftLeg)));
  Y2 := downBodyY + round(scale * 3 * cos(toRad(RLeftLeg)));
  Form1.Canvas.Polyline([
    Point(downBodyX, downBodyY),
    Point(X2, Y2),
    Point(X2 + round(scale * 2 * sin(toRad(RLeftLeg2))),
          Y2 + round(scale * 2 * cos(toRad(RLeftLeg2))))
  ]);

// правая нога
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
    BitMap.LoadFromFile('Images/fon.bmp');
    DestRect := Rect(XImage, YImage, Round(BitMap.Width * Scale), Round(BitMap.Height * Scale));
    Canvas.StretchDraw(DestRect, BitMap);
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
var frames: array[1..CNT_RUN_FRAMES + CNT_JUMP_FRAMES + CNT_HIT_FRAMES + CNT_JUMP2_FRAMES + CNT_WIN_FRAMES] of array[1..14] of integer =
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

        (500, 800, 50, 270, 190, 150, 150, 180, 190, 250, 240, 245, 0, 0),

        (500, 700, 50, 290, 120, 200, 250, 160, 220, 300, 200, 310, 0, 0),

        (500, 600, 50, 350, 90, 220, 240, 190, 270, 300, 200, 310, 0, 0),

        (500, 550, 50, 355, 60, 150, 270, 150, 320, 320, 260, 320, 0, 0),

        (500, 500, 50, 0,  320, 110, 40,  110, 355, 340, 30, 10, 340, 1),

        (500, 500, 50, 0,  320, 70, 40,  150, 340, 350, 30, 10, 350, 1),

        (500, 500, 50, 0,  320, 10, 40,  140, 330, 10, 40, 10, 350, 1),

        (500, 500, 50, 0,  320, 70, 40,  150, 340, 350, 30, 10, 350, 1),

        (500, 500, 50, 0,  320, 10, 40,  140, 330, 10, 40, 10, 350, 1),

         (500, 500, 50, 0,  320, 70, 40,  150, 340, 350, 30, 10, 350, 2),

        (500, 500, 50, 0,  320, 110, 40,  110, 355, 340, 30, 10, 340, 2),

        // jump 2

        (500, 500, 50, 5, 110, 190, 150, 205, 10, 270, 25, 0, 52, 2),

        (500, 450, 50, 10, 170, 180, 135, 145, 335, 305, 55, 350, 246, 2),

        (500, 450, 50, 0, 180, 180, 135, 145, 340, 250, 30, 25, 249, 2),

        (500, 400, 50, 340, 200, 210, 90, 193, 340, 330, 30, 320, 240, 2),

        (500, 400, 50, 20, 215, 230, 170, 190, 0, 340, 50, 350, 289, 2),

        (500, 350, 50, 40, 215, 215, 165, 190, 30, 25, 120, 55, 283, 2),

        (500, 350, 50, 50, 215, 210, 185, 190, 135, 85, 95, 90, 289, 2),

        (500, 350, 50, 110, 200, 205, 180, 190, 190, 135, 200, 185, 282, 0),

        (500, 350, 50, 120, 200, 205, 180, 190, 190, 135, 200, 185, 282, 0),

        (500, 350, 50, 130, 200, 205, 180, 190, 190, 135, 200, 185, 282, 0),

        (500, 350, 50, 140, 200, 205, 180, 190, 190, 135, 200, 185, 282, 0),

        (500, 350, 50, 160, 200, 205, 180, 190, 190, 135, 200, 185, 282, 0),

        (500, 350, 50, 181, 328, 45, 25, 315, 175, 180, 205, 190, 0, 0),

        (500, 400, 50, 160, 10, 310, 15, 315, 135, 140, 145, 150, 0, 0),

        (500, 400, 50, 150, 80, 0, 340, 315, 100, 115, 115, 130, 0, 0),

        (500, 400, 50, 320, 200, 205, 180, 190, 230, 220, 200, 185, 282, 0),

        (500, 450, 50, 315, 200, 205, 180, 190, 225, 215, 200, 185, 282, 0),

        (500, 500, 50, 310, 200, 205, 180, 190, 225, 215, 200, 185, 282, 0),

        (500, 550, 50, 300, 200, 205, 180, 190, 220, 210, 200, 195, 282, 0),

        (500, 600, 50, 295, 200, 205, 180, 190, 225, 210, 200, 200, 282, 0),

        (500, 650, 50, 290, 200, 205, 180, 190, 220, 215, 195, 190, 282, 0),

        (500, 700, 50, 285, 200, 205, 180, 190, 225, 230, 200, 185, 282, 0),

        (500, 750, 50, 280, 200, 205, 180, 190, 225, 215, 200, 185, 282, 0),

        (500, 775, 50, 275, 190, 205, 180, 190, 220, 210, 195, 190, 0, 0),

        (500, 800, 50, 270, 190, 205, 150, 180, 210, 250, 240, 185, 0, 0),

        //win

        {
          X, Y, scale, RBody, RLeftH, RLeftH2, RRightH, RRightH2,
          RLeftLeg, RLeftLeg2, RRightLeg, RRightLeg2: integer
        }

        (500, 500, 50, 0, 235, 180, 125, 180, 340, 0, 20, 0, 0, 0),

        (500, 500, 50, 0, 225, 180, 135, 180, 340, 0, 20, 0, 0, 0),

        (500, 500, 50, 0, 215, 180, 145, 180, 340, 0, 20, 0, 0, 0),

        (500, 500, 50, 0, 225, 180, 135, 180, 340, 0, 20, 0, 0, 0)

);


procedure TForm1.DrawCharacter;
begin
  if (curaddY < 0) and (YImage > -1200) then
  begin
    curaddY := -curaddY;
  end;
  if (curaddY > 0) and (YImage <= -3000) then
  begin
    curaddY := 0;
  end;

  //win
  if FrameIndex >= CNT_RUN_FRAMES +CNT_JUMP_FRAMES + CNT_HIT_FRAMES + 40 + CNT_JUMP2_FRAMES then
  begin
    drawPerson(frames[CNT_RUN_FRAMES + CNT_JUMP_FRAMES + CNT_JUMP2_FRAMES + CNT_HIT_FRAMES + ((FrameIndex - (CNT_RUN_FRAMES +CNT_JUMP_FRAMES + CNT_HIT_FRAMES + 40 + CNT_JUMP2_FRAMES)) mod CNT_WIN_FRAMES) + 1]);
    XImage := XImage + 12;
  end
  else if FrameIndex >= CNT_RUN_FRAMES +CNT_JUMP_FRAMES + CNT_HIT_FRAMES + 40 then
begin
  //прыжок второй
    drawPerson(frames[CNT_RUN_FRAMES + CNT_JUMP_FRAMES + CNT_HIT_FRAMES + ((FrameIndex - (CNT_RUN_FRAMES +CNT_JUMP_FRAMES + CNT_HIT_FRAMES + 42)) mod CNT_JUMP2_FRAMES) + 1]);
    XImage := XImage - 70;
    YImage := YImage - curaddY;
  end
else if FrameIndex >= CNT_RUN_FRAMES +CNT_JUMP_FRAMES + CNT_HIT_FRAMES + 13 then
      begin
  //бег второй
    frames[FrameIndex mod CNT_RUN_FRAMES + 1, 14] := 2;
    drawPerson(frames[FrameIndex mod CNT_RUN_FRAMES + 1]);
    XImage := XImage - 40;
  end
  else
  if FrameIndex >= LAST_RUN_FRAME + 15 then
  begin
  //НЕТ УВЕЛИЧЕНИЯ,  НЕЕ + 1
   drawPerson(frames[CNT_RUN_FRAMES +CNT_JUMP_FRAMES+ ((FrameIndex-LAST_RUN_FRAME) mod CNT_HIT_FRAMES  )]);
  //  drawPerson(frames[CNT_RUN_FRAMES + CNT_JUMP_FRAMES]);
    XImage := XImage + 8;
  end
  else if FrameIndex >= LAST_RUN_FRAME then
  begin
  //прыжок
    drawPerson(frames[CNT_RUN_FRAMES + ((FrameIndex-LAST_RUN_FRAME) mod CNT_JUMP_FRAMES + 1)]);
    XImage := XImage - 15;
  end
  else
  begin
  //бег первый
    drawPerson(frames[FrameIndex mod CNT_RUN_FRAMES + 1]);
  end;
end;


procedure TForm1.DrawFrame;
begin
  MC := TMyCanvas.Create; // используем конструктор родительского класса
  MC.Handle := Canvas.Handle; // назначаем холст окна областью вывода
  DrawBackground; // Рисуем фон
 DrawCharacter; // Рисуем персонажа
end;

// Метод для рисования пробного кадра
procedure TForm1.Button2Click(Sender: TObject);
begin
  drawPerson(frames[CNT_RUN_FRAMES + CNT_JUMP_FRAMES + CNT_HIT_FRAMES + CNT_JUMP2_FRAMES + 1]); // номер проверяемого кадра
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //Музыка
  curaddY := -40;
  MediaPlayer1.FileName := 'music/fon_music.mp3';
  MediaPlayer1.Open;
  MediaPlayer1.Play;
  //Музыка
  Canvas.Pen.Width := 4;
  XImage := 0; // Инициализация позиции фона
  YImage := -3000; // Инициализация позиции фона
  Timer2.Enabled := True;

  X := 100;
  Y := 100;
  FrameIndex := 1; // Начинаем с первого кадра
  Timer1.Enabled := True; // Запускаем таймер
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Canvas.Brush.Color := clWhite;
  Color := clWhite;
  Canvas.Pen.Mode := pmNotXor;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  FrameIndex := FrameIndex + 1; // Переход к следующему кадру
  X := X + 1;
  if (X >= ClientWidth - 20) then
    Timer1.Enabled := false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  DrawFrame; // Рисуем текущий кадр
   XImage := XImage - 12;
end;

end.

// ОСНОВА
