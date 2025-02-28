Unit CMatr;

Interface

uses crt; 
uses Compl;

const n = 2;

Type Matrix = array [1..n, 1..n] of Complex;
var a, b, c: Matrix; var p: Complex; i, j: integer;

procedure AddMatrix(a, b: Matrix; var c: Matrix);
procedure MultMatrix(a, b: Matrix; var c: Matrix);
procedure ProdRMatrix(c: real; a: Matrix; var b: Matrix);
procedure ProdCMatrix(a: Matrix; c: Complex; var b: Matrix);
procedure ZeroMatrix(var a: Matrix);
procedure OneMatrix(var a: Matrix);
function NormMatrix(a: Matrix): real;
procedure ExpM(a: Matrix; var c: Matrix);

procedure InputMatrix(var a: Matrix);
procedure InputMatrix2(var a, b: Matrix);
procedure OutputMatrix(c: Matrix);
procedure Wait;
procedure MenuCMatr();

Implementation

procedure AddMatrix(a, b: Matrix; var c: Matrix);
var i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      Add(a[i, j], b[i, j], c[i, j]);
end;

procedure MultMatrix(a, b: Matrix; var c: Matrix);
var 
  i, j, k: integer; 
  p, s: Complex;
begin
  // Инициализируем результирующую матрицу нулями
  ZeroMatrix(c);

  for i := 1 to n do
    for j := 1 to n do
    begin
      Zero(s); // Обнуляем сумму для элемента c[i,j]
      for k := 1 to n do
      begin
        // Умножаем a[i,k] на b[k,j]
        Mult(a[i, k], b[k, j], p); 
        // Добавляем результат к сумме s
        Add(s, p, s); 
      end;
      c[i, j] := s; // Присваиваем сумму элементу c[i,j]
    end;
end;


procedure ProdRMatrix(c: real; a: Matrix; var b: Matrix);
var i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      Prod(c, a[i, j], b[i, j]);
end;

procedure ProdCMatrix(a: Matrix; c: Complex; var b: Matrix);
var i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      Mult(c, a[i, j], b[i, j]);
end;

procedure ZeroMatrix(var a: Matrix);
var i, j: integer;
begin
  for i := 1 to n do
    for j := 1 to n do
      Zero(a[i, j]);
end;

procedure OneMatrix(var a: Matrix);
var i, j: integer;
begin
  ZeroMatrix(a);
  for i := 1 to n do
    a[i, i].Re := 1; 
end;

function NormMatrix(a: Matrix): real;
var i, j: integer; z, s: real;
begin
  z := 0;
  for i := 1 to n do
  begin
    s := 0;
    for j := 1 to n do
      s := s + Module(a[i, j]);
    if s > z then
      z := s;
  end;
  NormMatrix := z;
end;

procedure ExpM(a: Matrix; var c: Matrix);
const eps = 0.001;
var k: integer; p, s: Matrix;
begin
  k := 0;
  OneMatrix(p);  
  OneMatrix(s);  

  while NormMatrix(p) >= eps do
  begin
    k := k + 1;
    MultMatrix(p, a, p); 
    ProdRMatrix(1 / k, p, p); 
    AddMatrix(s, p, s);  
  end;
  c := s;  
end;

procedure InputMatrix(var a: Matrix);
var
  i, j: integer;
  u: Complex;
begin
  ClrScr; // Очистка экрана для удобства ввода
  Writeln('Введите элементы матрицы (действительная и мнимая части):');
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      GoToXY(10 * j, i + 2); // Позиция для элемента [i, j]
      Write('> '); // Указатель ввода
      Read(u.Re); // Считываем действительную часть
      GoToXY(10 * j + 5, i + 2); // Перемещаем курсор для ввода мнимой части
      Read(u.Im); // Считываем мнимую часть
      a[i, j] := u; // Сохраняем в матрицу
    end;
  end;
end;


procedure InputMatrix2(var a, b: Matrix);
var
  i, j: integer;
  u: Complex;
begin
  ClrScr;

  Writeln('Введите элементы первой матрицы (действительная и мнимая части):');
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      GoToXY(10 * j, i + 2);
      Write('> ');
      Read(u.Re);
      GoToXY(10 * j + 5, i + 2);
      Read(u.Im);
      a[i, j] := u;
    end;
  end;


  Writeln(' ');
  Writeln('Введите элементы второй матрицы (действительная и мнимая части):');
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      GoToXY(10 * j, i + 7); 
      Write('> ');
      Read(u.Re);
      GoToXY(10 * j + 5, i + 7);
      Read(u.Im);
      b[i, j] := u;
    end;
  end;
end;


procedure OutputMatrix(c: Matrix);
var
  i, j: integer;
  w: Complex;
begin
  Writeln(' ');
  Writeln('Результат:');
  for i := 1 to n do
  begin
    for j := 1 to n do
    begin
      w := c[i, j];
      write(w.Re:0:2, ' + ', w.Im:0:2, 'i    ');  
    end;
    writeln;
  end;
  readln;
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure MenuCMatr();
var Mode: integer; Ok: boolean;
    a, b, c: Matrix;
    m: real;
    Com: Complex;
begin
  Ok := true;
  while Ok do
  begin
    ClrScr;
    writeln('Укажите режим работы:');
    writeln('1) Сложение матриц');
    writeln('2) Умножение матриц');
    writeln('3) Умножение матрицы на вещественное число');
    writeln('4) Умножение матрицы на комплексное число');
    writeln('5) Вычисление нормы матрицы');
    writeln('6) Экспонента матрицы');
    writeln('7) Заполнить матрицу нулями');
    writeln('8) Заполнить единичную матрицу');
    writeln('0) Выход');
    
    GoToXY(1, 12); read(Mode);
    GoToXY(1, 12); ClearLine;
    
    case Mode of
      1:
      begin
        ClrScr;
        InputMatrix2(a, b);
        AddMatrix(a, b, c);
        OutputMatrix(c);
        Wait;
      end;
      2:
      begin
        ClrScr;
        InputMatrix2(a, b);
        MultMatrix(a, b, c);
        OutputMatrix(c);
        Wait;
      end;
      3:
      begin
        ClrScr;
        InputMatrix(a);
        writeln(' ');
        writeln('Введите вещественный скаляр для умножения матрицы: ');
        read(m);
        ProdRMatrix(m, a, c);
        writeln(' ');
        OutputMatrix(c);
        Wait;
      end;
      4:
      begin
        ClrScr;
        InputMatrix(a);
        Input(Com);
        ProdCMatrix(a, Com, b);
        OutputMatrix(b);
        Wait;
      end;
      5:
      begin
        ClrScr;
        InputMatrix(a);
        m := NormMatrix(a);
        write(m);
        Wait;
      end;
      6:
      begin
        ClrScr;
        InputMatrix(a);
        ExpM(a, c);
        OutputMatrix(c);
        Wait;
      end;
      7:
      begin
        ClrScr;
        ZeroMatrix(a);
        OutputMatrix(a);
        Wait;
      end;
      8:
      begin
        ClrScr;
        OneMatrix(a);
        OutputMatrix(a);
        Wait;
      end;
      0: Ok := false;
      else
      begin
        GoToXY(30, 21);
        writeln('Ошибка. Повторите ввод');
        sleep(1000);
      end;
    end;
  end;
end;

end.