unit c;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    procedure FormPaint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
    FrameIndex: Integer; // Индекс текущего кадра
  public
    { Public declarations }
    procedure DrawFrame;
  end;

  TMyCanvas = class(TCanvas)
    procedure _1Run(X, Y, Xpr, Ypr: Integer);
    procedure _2Run(X, Y, Xpr, Ypr: Integer);
    procedure _3Run(X, Y: Integer; Xpr, Ypr: Integer);
    procedure _4Run(X, Y: Integer; Xpr, Ypr: Integer);
    procedure Frame3(X, Y: Integer; Xpr, Ypr: Integer);
  end;

var
  Form1: TForm1;
  X, Y: Integer;
  IsDrawingFirst: boolean;
  MC: TMyCanvas;

implementation

{$R *.dfm}

procedure TMyCanvas._1Run(X, Y: Integer; Xpr, Ypr: Integer);
begin
  Form1.Canvas.Ellipse(47 * Xpr + X, 40 * Ypr + Y, 57 * Xpr + X, 30 * Ypr + Y);
  // голова
  Form1.Canvas.MoveTo(52 * Xpr + X, 40 * Ypr + Y); // от головы
  Form1.Canvas.LineTo(49 * Xpr + X, 62 * Ypr + Y); // конец тулова
  Form1.Canvas.Polyline([point(51 * Xpr + X, 46 * Ypr + Y), point(45 * Xpr + X,
    49 * Ypr + Y), point(50 * Xpr + X, 52 * Ypr + Y)]); // левая рука
  Form1.Canvas.Polyline([point(51 * Xpr + X, 46 * Ypr + Y), point(56 * Xpr + X,
    50 * Ypr + Y), point(62 * Xpr + X, 47 * Ypr + Y)]); // правая рука
  Form1.Canvas.Polyline([point(49 * Xpr + X, 62 * Ypr + Y), point(48 * Xpr + X,
    70 * Ypr + Y), point(43 * Xpr + X, 73 * Ypr + Y)]); // левая нога
  Form1.Canvas.Polyline([point(49 * Xpr + X, 62 * Ypr + Y), point(57 * Xpr + X,
    69 * Ypr + Y), point(57 * Xpr + X, 74 * Ypr + Y)]); // правая нога
  Form1.Canvas.Polyline([point(66 * Xpr + X, 32 * Ypr + Y), point(41 * Xpr + X,
    63 * Ypr + Y)]); // палка
end;

procedure TMyCanvas._2Run(X, Y: Integer; Xpr, Ypr: Integer);
begin
  Form1.Canvas.Ellipse(47 * Xpr + X, 40 * Ypr + Y, 57 * Xpr + X, 30 * Ypr + Y);
  // голова
  Form1.Canvas.MoveTo(52* Xpr + x, 40* Ypr + Y); // от головы
  Form1.Canvas.LineTo(52 * Xpr+ x, 62* Ypr + Y); // конец тулова
  Form1.Canvas.Polyline([point(52* Xpr + x, 45* Ypr + Y),point(45 * Xpr+ x, 51* Ypr + Y) ,point(50* Xpr + x, 50* Ypr + Y)]); //  левая рука
  Form1.Canvas.Polyline([point(52 * Xpr+ x, 45* Ypr + Y), point(54* Xpr + x, 51* Ypr + Y), point(60* Xpr + x, 46* Ypr + Y)]);  //правая рука
  Form1.Canvas.Polyline([point(52 * Xpr+ x,62* Ypr + Y),point(51* Xpr + x, 67* Ypr + Y), point(46* Xpr + x, 73* Ypr + Y) ]);  //левая нога
  Form1.Canvas.Polyline([point(52 * Xpr+ x, 62* Ypr + Y), point(56 * Xpr+ x, 68* Ypr + Y), point(56* Xpr + x,74* Ypr + Y)]); //правая нога
  Form1.Canvas.Polyline([point(68 * Xpr+ x,33* Ypr + Y), point(40* Xpr + x,59* Ypr + Y)]);  //палка
end;


procedure TMyCanvas._3Run(X, Y: Integer; Xpr, Ypr: Integer);
begin
  Form1.Canvas.Ellipse(47 * Xpr + X, 40 * Ypr + Y, 57 * Xpr + X, 30 * Ypr + Y);// голова
  Form1.Canvas.MoveTo(52* Xpr + X, 40* Ypr + Y); // от головы
  Form1.Canvas.LineTo(51* Xpr + X, 62* Ypr + Y); // конец тулова
  Form1.Canvas.Polyline([point(52* Xpr + X, 45* Ypr + Y),point(45* Xpr + X, 50* Ypr + Y) ,point(50* Xpr + X, 51* Ypr + Y)]); //  левая рука
  Form1.Canvas.Polyline([point(52* Xpr + X, 45* Ypr + Y), point(54* Xpr + X, 50* Ypr + Y), point(59* Xpr + X, 45* Ypr + Y)]);  //правая рука
  Form1.Canvas.Polyline([point(51* Xpr + X,62* Ypr + Y),point(51* Xpr + X, 69* Ypr + Y), point(50* Xpr + X, 74* Ypr + Y) ]);  //правая нога
  Form1.Canvas.Polyline([point(51* Xpr + X, 62* Ypr + Y), point(56* Xpr + X, 69* Ypr + Y), point(48* Xpr + X,70* Ypr + Y)]); //левая нога
  Form1.Canvas.Polyline([point(50* Xpr + X,51* Ypr + Y), point(41* Xpr + X,63* Ypr + Y)]);  //палка
   Form1.Canvas.Polyline([point(50* Xpr + X,51* Ypr + Y), point(66* Xpr + X,32* Ypr + Y)]);  //палка
end;

procedure TMyCanvas.Frame3(X, Y: Integer; Xpr, Ypr: Integer);
begin
  Form1.Canvas.Ellipse(47* Xpr + X, 40* Ypr + Y, 57* Xpr + X, 30* Ypr + Y); // голова
  Form1.Canvas.MoveTo(52* Xpr + X, 40* Ypr + Y); // от головы
  Form1.Canvas.LineTo(52* Xpr + X, 62* Ypr + Y); // конец тулова
  Form1.Canvas.Polyline([point(52* Xpr + X, 46* Ypr + Y),point(47* Xpr + X, 52* Ypr + Y) ,point(50* Xpr + X, 51* Ypr + Y)]); //  левая рука
  Form1.Canvas.Polyline([point(52* Xpr + X, 46* Ypr + Y), point(54* Xpr + X, 50* Ypr + Y), point(59* Xpr + X, 47* Ypr + Y)]);  //правая рука
  Form1.Canvas.Polyline([point(52* Xpr + X,62* Ypr + Y),point(51* Xpr + X, 71* Ypr + Y), point(45* Xpr + X, 70* Ypr + Y) ]);  //левая нога
  Form1.Canvas.Polyline([point(52* Xpr + X, 62* Ypr + Y), point(56* Xpr + X, 69* Ypr + Y), point(55* Xpr + X,75* Ypr + Y)]); //правая нога
  Form1.Canvas.Polyline([point(50* Xpr + X,51* Ypr + Y), point(41* Xpr + X,63* Ypr + Y)]);  //палка
   Form1.Canvas.Polyline([point(50* Xpr + X,51* Ypr + Y), point(66* Xpr + X,32* Ypr + Y)]);  //палка
end;

procedure TMyCanvas._4Run(X, Y: Integer; Xpr, Ypr: Integer);
begin
  Form1.Canvas.Ellipse(47 * Xpr + X, 40 * Ypr + Y, 57 * Xpr + X, 30 * Ypr + Y);// голова
  Form1.Canvas.MoveTo(52* Xpr + X, 40* Ypr + Y); // от головы
  Form1.Canvas.LineTo(52* Xpr + X, 61* Ypr + Y); // конец тулова
  Form1.Canvas.Polyline([point(52* Xpr + X, 45* Ypr + Y),point(47* Xpr + X, 51* Ypr + Y) ,point(51* Xpr + X, 49* Ypr + Y)]); //  левая рука
  Form1.Canvas.Polyline([point(52* Xpr + X, 45* Ypr + Y), point(54* Xpr + X, 50* Ypr + Y), point(57* Xpr + X, 46* Ypr + Y)]);  //правая рука
  Form1.Canvas.Polyline([point(52* Xpr + X, 61* Ypr + Y),point(53* Xpr + X, 70* Ypr + Y), point(50* Xpr + X, 75* Ypr + Y) ]);  //правая нога
  Form1.Canvas.Polyline([point(52* Xpr + X, 61* Ypr + Y), point(57* Xpr + X, 69* Ypr + Y), point(56* Xpr + X,73* Ypr + Y)]); //левая нога
  Form1.Canvas.Polyline([point(51* Xpr + X,49* Ypr + Y), point(41* Xpr + X,63* Ypr + Y)]);  //палка
   Form1.Canvas.Polyline([point(51* Xpr + X,49* Ypr + Y), point(65* Xpr + X,32* Ypr + Y)]);  //палка
end;

// Метод для рисования текущего кадра
procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.Canvas.Ellipse(470, 400, 570, 300); // голова
  Form1.Canvas.MoveTo(520, 400); // от головы
  Form1.Canvas.LineTo(520, 610); // конец тулова
  Form1.Canvas.Polyline([point(520, 450),point(470, 510) ,point(510, 490)]); //  левая рука
  Form1.Canvas.Polyline([point(520, 450), point(540, 500), point(570, 460)]);  //правая рука
  Form1.Canvas.Polyline([point(520, 610),point(530, 700), point(500, 750) ]);  //правая нога
  Form1.Canvas.Polyline([point(520, 610), point(570, 690), point(560,730)]); //левая нога
  Form1.Canvas.Polyline([point(510,490), point(410,630)]);  //палка
   Form1.Canvas.Polyline([point(510,490), point(650,320)]);  //палка
end;

procedure TForm1.DrawFrame;
begin
  MC := TMyCanvas.Create; // используем конструктор родительского класса
  MC.Handle := Canvas.Handle; // назначаем холст окна областью вывода
  Canvas.FillRect(ClientRect); // Очистка экрана

  case FrameIndex of
    1:MC._1Run(100 + X, 100, 10, 10);
    2:MC._2Run(100 + X, 100, 10, 10);
    3:MC._3Run(100 + X, 100, 10, 10);
    4:MC._4Run(100 + X, 100, 10, 10);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FrameIndex := 1; // Начинаем с первого кадра
  Timer1.Enabled := True; // Запускаем таймер
  X := 100;
  Y := 100;
  Timer1.Enabled := True;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  Canvas.Brush.Color := clWhite;
  Color := clWhite;
  Canvas.Pen.Mode := pmNotXor;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  DrawFrame; // Рисуем текущий кадр
  FrameIndex := FrameIndex mod 4 + 1; // Переход к следующему кадру
  X := X + 8;
  if (X >= ClientWidth - 20) then
    Timer1.Enabled := false;
end;

end.
