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
RLeftLeg, RLeftLeg2, RRightLeg, RRightLeg2: integer);
  end;

const CNT_FRAMES = 11;

var
  Form1: TForm1;
  X, Y: integer;
  MC: TMyCanvas;

implementation

{$R *.dfm}

//procedure TMyCanvas.DrawCharacter(X, Y, Xpr, Ypr, LeftArm1X, LeftArm1Y,
//  LeftArm2X, LeftArm2Y, RightArm1X, RightArm1Y, RightArm2X, RightArm2Y,
//  LeftLeg1X, LeftLeg1Y, LeftLeg2X, LeftLeg2Y, RightLeg1X, RightLeg1Y,
//  RightLeg2X, RightLeg2Y: integer);
//begin
  // голова
  //Form1.Canvas.Ellipse(47 * Xpr + X, 40 * Ypr + Y, 57 * Xpr + X, 30 * Ypr + Y);

  // туловище
//  Form1.Canvas.MoveTo(52 * Xpr + X, 40 * Ypr + Y);
//  Form1.Canvas.LineTo(52 * Xpr + X, 62 * Ypr + Y); // конец тулова
//
//  // левая рука
//  Form1.Canvas.Polyline([Point(52 * Xpr + X, 45 * Ypr + Y),
//    Point(LeftArm1X * Xpr + X, LeftArm1Y * Ypr + Y), Point(LeftArm2X * Xpr + X,
//    LeftArm2Y * Ypr + Y)]);
//
//  // правая рука
//  Form1.Canvas.Polyline([Point(52 * Xpr + X, 45 * Ypr + Y),
//    Point(RightArm1X * Xpr + X, RightArm1Y * Ypr + Y),
//    Point(RightArm2X * Xpr + X, RightArm2Y * Ypr + Y)]);
//
//  // левая нога
//  Form1.Canvas.Polyline([Point(52 * Xpr + X, 62 * Ypr + Y),
//    Point(LeftLeg1X * Xpr + X, LeftLeg1Y * Ypr + Y), Point(LeftLeg2X * Xpr + X,
//    LeftLeg2Y * Ypr + Y)]);
//
//  // правая нога
//  Form1.Canvas.Polyline([Point(52 * Xpr + X, 62 * Ypr + Y),
//    Point(RightLeg1X * Xpr + X, RightLeg1Y * Ypr + Y),
//    Point(RightLeg2X * Xpr + X, RightLeg2Y * Ypr + Y)]);
//end;

function toRad(const val: integer): real;
begin
  Result := val * PI / 180.0;
end;

procedure TMyCanvas.DrawCharacter(X, Y, scale, RBody, RLeftH, RLeftH2, RRightH, RRightH2,
RLeftLeg, RLeftLeg2, RRightLeg, RRightLeg2: integer);
var X2, Y2, downBodyX, downBodyY: integer;
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
  Form1.Canvas.Polyline([
    Point(X, Y),
    Point(X2, Y2),
    Point(X2 + round(scale * 2 * sin(toRad(RLeftH2))),
          Y2 + round(scale * 2 * cos(toRad(RLeftH2))))
    ]);

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
begin
  BitMap := TBitmap.Create;
  try
    BitMap.LoadFromFile('Images/fon.bmp'); // Укажите путь к изображению фона
    Canvas.Draw(XImage, YImage, BitMap); // Рисуем фон
  finally
    BitMap.Free;
  end;
end;

procedure drawPerson(var a: array of integer);
begin
  MC.DrawCharacter(a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9],
   a[10], a[11]);
end;


{
  X, Y, scale, RBody, RLeftH, RLeftH2, RRightH, RRightH2,
  RLeftLeg, RLeftLeg2, RRightLeg, RRightLeg2: integer
}
var frames: array[1..CNT_FRAMES] of array[1..12] of integer =
  (
        (500, 500, 50, 350, 280, 45, 35, 135, 340, 300, 60, 10),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0),

        (500, 500, 50, 0, 315, 0, 45, 0, 340, 0, 20, 0)
);

procedure TForm1.DrawCharacter;
begin
  drawPerson(frames[FrameIndex]);
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
  drawPerson(frames[1]);
//  Form1.Canvas.Ellipse(470, 400, 570, 300); // голова
//  Form1.Canvas.MoveTo(520, 400); // от головы
//  Form1.Canvas.LineTo(520, 610); // конец тулова
//  Form1.Canvas.Polyline([Point(520, 450), Point(480, 500), Point(470, 460)]);
//  // левая рука
//  Form1.Canvas.Polyline([Point(520, 450), Point(540, 500), Point(570, 460)]);
//  // правая рука
//  Form1.Canvas.Polyline([Point(520, 610), Point(530, 700), Point(500, 750)]);
//  // правая нога
//  Form1.Canvas.Polyline([Point(520, 610), Point(570, 690), Point(560, 730)]);
//  // левая нога
//  Form1.Canvas.Polyline([Point(510, 490), Point(410, 630)]); // палка
//  Form1.Canvas.Polyline([Point(510, 490), Point(650, 320)]); // палка
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  //Музыка
  MediaPlayer1.FileName := 'music/fon_music.mp3';
  MediaPlayer1.Open;
  MediaPlayer1.Play;
  //Музыка

  XImage := 0; // Инициализация позиции фона
  YImage := 0; // Инициализация позиции фона
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
  FrameIndex := FrameIndex mod CNT_FRAMES + 1; // Переход к следующему кадру
  X := X + 1;
  if (X >= ClientWidth - 20) then
    Timer1.Enabled := false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  DrawFrame; // Рисуем текущий кадр
  // Обновляем позицию фона
  XImage := XImage - 1; // Двигаем фон влево
end;

end.

// ОСНОВА
