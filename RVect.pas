Unit RVect;

Interface
uses crt;

const m = 3;

Type 
  Vector = array[1..m] of real;

var 
  x, y, t, w: Vector;
  h: real;

procedure AddVector(x, y: Vector; var t: Vector);
function ScalProd(var x, y: Vector): real;
procedure VectProd(x, y: Vector; var t: Vector);
function MixProd(x, y, t: Vector): real;
function ModuleVect(x: Vector): real;

procedure InputVect1(var x: Vector);
procedure InputVect(var x, y: Vector);
procedure InputThreeVectors(var x, y, t: Vector);
procedure OutputVect(var t: Vector);
procedure Wait;
procedure MenuRVect();

Implementation

procedure AddVector(x, y: Vector; var t: Vector);
var 
  i: integer;
begin
  for i := 1 to m do
    t[i] := x[i] + y[i];
end;

function ScalProd(var x, y: Vector): real;
var 
  h: real;
  i: integer;
begin
  h := 0;
  for i := 1 to m do
    h := h + x[i] * y[i];  // Исправлено: перемножение элементов
  ScalProd := h;
end;

procedure VectProd(x, y: Vector; var t: Vector);
begin
  t[1] := x[2] * y[3] - x[3] * y[2];
  t[2] := x[3] * y[1] - x[1] * y[3];
  t[3] := x[1] * y[2] - x[2] * y[1];
end;

function MixProd(x, y, t: Vector): real;
var 
  w: Vector;
begin
  VectProd(x, y, w);  // Вычисляем векторное произведение
  MixProd := ScalProd(w, t);  // Скалярное произведение с третьим вектором
end;

function ModuleVect(x: Vector): real;
begin
  ModuleVect := sqrt(ScalProd(x, x));  // Модуль вектора - это корень из скалярного произведения вектора с самим собой
end;

procedure InputVect1(var x: Vector);
var 
  i: integer;
begin
  Writeln('Введите элементы вектора:');
  writeln(' ');
  for i := 1 to m do
  begin
    GoToXY(5 * i + 10, 3);
    readln(x[i]);
  end;
end;

procedure InputVect(var x, y: Vector);
var 
  i: integer;
begin
  Writeln('Введите элементы первого вектора вектора:');
  for i := 1 to m do
  begin
    GoToXY(5 * i + 9, 3);
    readln(x[i]);
  end;
  Writeln(' ');
  Writeln('Введите элементы второго вектора вектора:');
  for i := 1 to m do
  begin
    GoToXY(5 * i + 9, 7);
    readln(y[i]);
  end;
end;

procedure InputThreeVectors(var x, y, t: Vector);
var
  i: integer;
begin
  ClrScr;
  Writeln('Введите элементы первого вектора:');
  for i := 1 to m do
  begin
    GoToXY(5 * i + 9, 3);  // Первая строка
    readln(x[i]);
  end;

writeln(' ');
  Writeln('Введите элементы второго вектора:');
  for i := 1 to m do
  begin
    GoToXY(5 * i + 9, 7);  // Вторая строка
    readln(y[i]);
  end;

writeln(' ');
  Writeln('Введите элементы третьего вектора:');
  for i := 1 to m do
  begin
    GoToXY(5 * i + 9, 11);  // Третья строка
    readln(t[i]);
  end;
end;

procedure OutputVect(var t: Vector);
var 
  i: integer;
begin
  Writeln(' ');
  Writeln('Результат:');
  for i := 1 to m do
  begin
    GoToXY(5 * i + 9, 10);
    writeln(t[i]);
  end;
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure MenuRVect();
var 
  Mode: integer;
  Ok: boolean;
  x, y, t, w: Vector;
  h: real;
begin
  Ok := true;
  while Ok do
  begin
    ClrScr;
    writeln('Укажите режим:');
    writeln('1) Сложение векторов');
    writeln('2) Скалярное произведение');
    writeln('3) Векторное произведение');
    writeln('4) Смешанное произведение');
    writeln('5) Модуль вектора');
    writeln('0) Выход');
    
    GoToXY(1, 10); 
    read(Mode);
    GoToXY(1, 10); 
    ClearLine;
    
    case Mode of
      1: 
      begin
          ClrScr;
          InputVect(x, y);
          AddVector(x, y, t);
          OutputVect(t);
          Wait;
      end;
      2:
      begin
        ClrScr;
        InputVect(x, y);
        h := ScalProd(x, y);
        writeln(' ');
        writeln('Результат:');
        write(h);
        Wait;
      end;
      3:
      begin
        ClrScr;
        InputVect(x, y);
        VectProd(x, y, t);
        OutputVect(t);
        Wait;
      end;
      4:
      begin
        ClrScr;
        InputThreeVectors(x, y, t);
        h := MixProd(x, y, t);
        writeln(' ');
        writeln('Результат:');
        write(h);
        Wait;
      end;
      5:
      begin
        ClrScr;
        InputVect1(x);
        h := ModuleVect(x);
        GoToXY(1, 4);
        Writeln(' ');
        Writeln('Результат:');
        write(h:0:1);
        Wait;
      end;
      0: 
        Ok := false;
      else
      begin
        GoToXY(30, 21);
        writeln('Ошибка. повторите ввод');
        sleep(1000);
      end;
    end;
  end;
end;

end.