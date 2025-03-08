unit c;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ExtDlgs;

type
  TArr = array [1 .. 4, 1 .. 2, 1 .. 2] of integer;

  TForm1 = class(TForm)
    Button1: TButton;
    Timer1: TTimer;
    Button2: TButton;
    Timer2: TTimer;
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
    procedure DrawCharacter(X, Y, Xpr, Ypr, LeftArm1X, LeftArm1Y, LeftArm2X,
      LeftArm2Y, RightArm1X, RightArm1Y, RightArm2X, RightArm2Y, LeftLeg1X,
      LeftLeg1Y, LeftLeg2X, LeftLeg2Y, RightLeg1X, RightLeg1Y, RightLeg2X,
      RightLeg2Y: integer);
  end;

var
  Form1: TForm1;
  X, Y: integer;
  MC: TMyCanvas;

implementation

{$R *.dfm}

procedure TMyCanvas.DrawCharacter(X, Y, Xpr, Ypr, LeftArm1X, LeftArm1Y,
  LeftArm2X, LeftArm2Y, RightArm1X, RightArm1Y, RightArm2X, RightArm2Y,
  LeftLeg1X, LeftLeg1Y, LeftLeg2X, LeftLeg2Y, RightLeg1X, RightLeg1Y,
  RightLeg2X, RightLeg2Y: integer);
begin
  // ������
  Form1.Canvas.Ellipse(47 * Xpr + X, 40 * Ypr + Y, 57 * Xpr + X, 30 * Ypr + Y);

  // ��������
  Form1.Canvas.MoveTo(52 * Xpr + X, 40 * Ypr + Y);
  Form1.Canvas.LineTo(52 * Xpr + X, 62 * Ypr + Y); // ����� ������

  // ����� ����
  Form1.Canvas.Polyline([Point(52 * Xpr + X, 45 * Ypr + Y),
    Point(LeftArm1X * Xpr + X, LeftArm1Y * Ypr + Y), Point(LeftArm2X * Xpr + X,
    LeftArm2Y * Ypr + Y)]);

  // ������ ����
  Form1.Canvas.Polyline([Point(52 * Xpr + X, 45 * Ypr + Y),
    Point(RightArm1X * Xpr + X, RightArm1Y * Ypr + Y),
    Point(RightArm2X * Xpr + X, RightArm2Y * Ypr + Y)]);

  // ����� ����
  Form1.Canvas.Polyline([Point(52 * Xpr + X, 62 * Ypr + Y),
    Point(LeftLeg1X * Xpr + X, LeftLeg1Y * Ypr + Y), Point(LeftLeg2X * Xpr + X,
    LeftLeg2Y * Ypr + Y)]);

  // ������ ����
  Form1.Canvas.Polyline([Point(52 * Xpr + X, 62 * Ypr + Y),
    Point(RightLeg1X * Xpr + X, RightLeg1Y * Ypr + Y),
    Point(RightLeg2X * Xpr + X, RightLeg2Y * Ypr + Y)]);
end;

procedure TForm1.DrawBackground;
var
  BitMap: TBitmap;
begin
  BitMap := TBitmap.Create;
  try
    BitMap.LoadFromFile('Images\fon.bmp'); // ������� ���� � ����������� ����
    Canvas.Draw(XImage, YImage, BitMap); // ������ ���
  finally
    BitMap.Free;
  end;
end;

procedure TForm1.DrawCharacter;
begin
  case FrameIndex of
    1: MC.DrawCharacter(100 + X, 100, 10, 10, 45, 49, 50, 52, 56, 50, 62, 47, 48,
        70, 43, 73, 57, 69, 57, 74);
    2: MC.DrawCharacter(100 + X, 100, 10, 10, 45, 51, 50, 50, 54, 51, 60, 46, 51,
        67, 46, 73, 56, 68, 56, 74);
    3: MC.DrawCharacter(100 + X, 100, 10, 10, 45, 50, 50, 51, 54, 50, 59, 45, 51,
        69, 50, 74, 56, 69, 48, 70);
    4: MC.DrawCharacter(100 + X, 100, 10, 10, 47, 51, 51, 49, 54, 50, 57, 46, 53,
        70, 50, 75, 57, 69, 56, 73);
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
  Form1.Canvas.Ellipse(470, 400, 570, 300); // ������
  Form1.Canvas.MoveTo(520, 400); // �� ������
  Form1.Canvas.LineTo(520, 610); // ����� ������
  Form1.Canvas.Polyline([Point(520, 450), Point(480, 500), Point(470, 460)]);
  // ����� ����
  Form1.Canvas.Polyline([Point(520, 450), Point(540, 500), Point(570, 460)]);
  // ������ ����
  Form1.Canvas.Polyline([Point(520, 610), Point(530, 700), Point(500, 750)]);
  // ������ ����
  Form1.Canvas.Polyline([Point(520, 610), Point(570, 690), Point(560, 730)]);
  // ����� ����
  Form1.Canvas.Polyline([Point(510, 490), Point(410, 630)]); // �����
  Form1.Canvas.Polyline([Point(510, 490), Point(650, 320)]); // �����
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  XImage := 0; // ������������� ������� ����
  YImage := 0; // ������������� ������� ����
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
  FrameIndex := FrameIndex mod 4 + 1; // ������� � ���������� �����
  X := X + 1;
  if (X >= ClientWidth - 20) then
    Timer1.Enabled := false;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  DrawFrame; // ������ ������� ����
  // ��������� ������� ����
  XImage := XImage - 1; // ������� ��� �����
end;

end.

// ������
