Unit CVect;

interface

Uses crt, Compl;

const p = 3;

Type 
  VectorC = array[1..p] of Complex;

var 
  x, y, t, w: VectorC;
  h: real;

procedure AddCVect(x, y: VectorC; var t: VectorC);
function CScalProd(x, y: VectorC): Complex;
procedure CVectProd(x, y: VectorC; var t: VectorC);
function CMixProd(x, y, t: VectorC): Complex;
function ModulCVect(x: VectorC): real;

procedure OutputCVect(var t: VectorC);
procedure InputCVect(var x: VectorC);
procedure InputCVect2(var x, y: VectorC);
procedure InputCVect3(var x, y, t: VectorC);
procedure Wait;
procedure MenuCVect();

implementation

procedure AddCVect(x, y: VectorC; var t: VectorC);
var 
  i: integer;
begin
  for i := 1 to p do
    Add(x[i], y[i], t[i]);
end;

function CScalProd(x, y: VectorC): Complex;
var 
  i: integer; 
  s, m: Complex;
begin
  One(s);
  for i := 1 to p do
  begin
    Mult(x[i], y[i], m); 
    Add(m, s, s);
  end;
  CScalProd := s;
end;

procedure CVectProd(x, y: VectorC; var t: VectorC);
var 
  a, b: Complex;
begin
  Mult(x[2], y[3], a);
  Mult(x[3], y[2], b);
  Codj(b, b);
  Add(a, b, t[1]);

  Mult(x[1], y[3], a);
  Mult(x[3], y[1], b);
  Codj(b, b);
  Add(a, b, t[2]);

  Mult(x[1], y[2], a);
  Mult(x[2], y[1], b);
  Codj(b, b);
  Add(a, b, t[3]);
end;

function CMixProd(x, y, t: VectorC): Complex;
var 
  w: VectorC;
begin
  CVectProd(x, y, w);
  CMixProd := CScalProd(w, t);
end;

function ModulCVect(x: VectorC): real;
begin
  ModulCVect := sqrt(sqr(x[1].Re) + sqr(x[1].Im) + sqr(x[2].Re) + sqr(x[2].Im) + sqr(x[3].Re) + sqr(x[3].Im));
end;

procedure OutputCVect(var t: VectorC);
var 
  i: integer;
begin
  writeln(' ');
  Writeln('Результат:');
  for i := 1 to p do
  begin
    GoToXY(1, 12);
    writeln(t[i]);
  end;
end;

procedure InputCVect(var x: VectorC);
var 
  i: integer;
begin
  Writeln('Введите элементы вектора (реальная и мнимая части через пробел):');
  for i := 1 to p do
  begin
    Write('Элемент ', i, ': ');
    ReadLn(x[i].Re, x[i].Im);
  end;
end;

procedure InputCVect2(var x, y: VectorC);
var 
  i: integer;
begin
  Writeln('Введите элементы первого вектора (реальная и мнимая части через пробел):');
  for i := 1 to p do
  begin
    Write('Элемент ', i, ': ');
    ReadLn(x[i].Re, x[i].Im);
  end;
  writeln(' ');
  Writeln('Введите элементы второго вектора (реальная и мнимая части через пробел):');
  for i := 1 to p do
  begin
    Write('Элемент ', i, ': ');
    ReadLn(y[i].Re, y[i].Im);
  end;
end;

procedure InputCVect3(var x, y, t: VectorC);
var 
  i: integer;
begin
  Writeln('Введите элементы первого вектора (реальная и мнимая части через пробел):');
  for i := 1 to p do
  begin
    Write('Элемент ', i, ': ');
    ReadLn(x[i].Re, x[i].Im);
  end;
  
  writeln(' ');
  Writeln('Введите элементы второго вектора (реальная и мнимая части через пробел):');
  for i := 1 to p do
  begin
    Write('Элемент ', i, ': ');
    ReadLn(y[i].Re, y[i].Im);
  end;
  
  writeln(' ');
  Writeln('Введите элементы третьего вектора (реальная и мнимая части через пробел):');
  for i := 1 to p do
  begin
    Write('Элемент ', i, ': ');
    ReadLn(t[i].Re, t[i].Im);
  end;
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure MenuCVect();
var 
  Mode: integer;
  Ok: boolean;
  a, b, c: VectorC;
  m: Complex;
  n: real;
begin
  Ok := true;
  while Ok do
  begin
    ClrScr;
    writeln('Укажите режим:');
    writeln('1) Сложение комплексных векторов');
    writeln('2) Скалярное произведение комплексных векторов');
    writeln('3) Векторное произведение комплексных векторов');
    writeln('4) Смешанное произведение комплексных векторов');
    writeln('5) Модуль комплексного вектора');
    writeln('0) Выход');

    GoToXY(1, 9); 
    read(Mode);
    GoToXY(1, 9); 
    ClearLine;

    case Mode of
      1: 
      begin
        ClrScr;
        InputCVect2(x, y);
        AddCVect(x, y, t);
        OutputCVect(t);
        Wait;
      end;
      2:
      begin
        ClrScr;
        InputCVect2(x, y);
        m := CScalProd(x, y);
        GoToXY(1, 10);
        writeln('Результат:');
        write(m);
        Wait;
      end;
      3:
      begin
        ClrScr;
        InputCVect2(x, y);
        CVectProd(x, y, t);
        OutputCVect(t);
        Wait;
      end;
      4:
      begin
        ClrScr;
        InputCVect3(x, y, t);
        m := CMixProd(x, y, t);
        GoToXY(1, 17);
        writeln('Результат:');
        write(m);
        Wait;
      end;
      5:
      begin
        ClrScr;
        InputCVect(x);
        n := ModulCVect(x);
        GoToXY(1, 6);
        writeln('Результат:');
        write(n:0:1);
        Wait;
      end;
      0: 
        Ok := false;
      else
      begin
        GoToXY(30, 21);
        writeln('Ошибка. повтори ввод');
        sleep(1000);
      end;
    end;
  end;
end;

End.