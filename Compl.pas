Unit Compl;
Interface
uses crt;
Type Complex = record
  Re, Im: real;
end;

var u,v,w,z: Complex; var q: real;

procedure Add(u,v: Complex; var w: Complex);
procedure Mult(u,v: Complex; var w: Complex);
procedure Inv(z: Complex; var w: Complex);
procedure Divz(u,v: Complex; var w: Complex);
procedure Codj(z: Complex; var w: Complex);
procedure Prod(a: real; z: Complex; var w: Complex);
procedure Zero(var z: Complex);
procedure One(var z: Complex);
function Module(z: Complex): real;
procedure ExpC(z: Complex; var w: Complex);
procedure CosC(z: Complex; var w: Complex);
procedure SinC(z: Complex; var w: Complex);

procedure Input(var z: Complex);
procedure Input2(var u, v: Complex);
procedure Output(var w: Complex);
procedure Wait;
procedure MenuCompl();

Implementation

procedure Add(u,v: Complex; var w: Complex);
Begin
  w.Re := u.Re + v.Re;
  w.Im := u.Im + v.Im;
end;

procedure Mult(u,v: Complex; var w: Complex);
begin
  w.Re := u.Re * v.Re - u.Im * v.Im;
  w.Im := u.Re * v.Im + u.Im * v.Re;
end;

procedure Inv(z: Complex; var w: Complex);
var
  q: real;
begin
  q := z.Re * z.Re + z.Im * z.Im;
  
  if q = 0 then
  begin
    writeln('Ошибка: инверсия не определена для нуля.');
    w.Re := 0;
    w.Im := 0;
    Exit;
  end;

  w.Re := z.Re / q;  
  w.Im := -z.Im / q;      
end;


procedure Divz(u, v: Complex; var w: Complex);
var
  z: Complex;
begin
  if (v.Re = 0) and (v.Im = 0) then
  begin
    writeln('Ошибка: деление на ноль.');
    w.Re := 0; 
    w.Im := 0;
    Exit; 
  end;
  Inv(v, z); 
  Mult(u, z, w); 
end;

procedure Codj(z: Complex; var w: Complex);
begin
  w.Re := z.Re;
  w.Im := -z.Im; // исправлено: мнимая часть меняет знак
end;

procedure Prod(a: real; z: Complex; var w: Complex);
begin
  w.Re := a * z.Re;
  w.Im := a * z.Im;
end;

procedure Zero(var z: Complex);
begin
  z.Re := 0;  
  z.Im := 0;
end;

procedure One(var z: Complex);
begin
  z.Re := 1;  
  z.Im := 0; // исправлено: единица комплексного числа имеет мнимую часть 0
end;

function Module(z: Complex): real;
begin
  Module := sqrt(sqr(z.Re) + sqr(z.Im));
end;

procedure ExpC(z: Complex; var w: Complex);
const eps = 0.01;
var k: integer; p, s: Complex;
begin
  k := 0;
  One(p); One(s);
  while Module(p) >= eps do
  begin
    k := k + 1;
    Mult(p, z, p); // произведение с z
    Prod(1 / k, p, p); // деление на k
    Add(s, p, s); // сложение с результатом
  end;
  w := s; // результат сохраняется в w
end;

procedure CosC(z: Complex; var w: Complex);
const
  eps = 0.001;
var
  k: integer;
  z2, p, s: Complex;
begin
  k := 0; 
  s.Re := 1; // Инициализация s = 1
  s.Im := 0; // Инициализация s = 0i
  p.Re := 1; // Инициализация p = z^0 = 1
  p.Im := 0; // Инициализация p = z^0 = 0i

  Mult(z, z, z2); // z^2

  repeat
    k := k + 1; // Увеличиваем k на 1
    Mult(p, z2, p); // p *= z^2 (умножаем на z^2)
    Prod(-1 / (2 * k * (2 * k - 1)), p, p); // фактор (-1 / (2k(2k-1)))
    Add(s, p, s); // добавляем результат в s
  until Module(p) < eps; // продолжаем до тех пор, пока модуль p меньше eps

  w := s; // результат сохраняется в w
end;

procedure SinC(z: Complex; var w: Complex);
const
  eps = 0.001;
var
  k: integer;
  z2, p, s: Complex;
begin
  k := 0; 
  s.Re := z.Re; // Инициализация s = z (первый член ряда)
  s.Im := z.Im; // Инициализация s = z (первый член ряда)
  p.Re := z.Re; // Инициализация p = z (первый член ряда)
  p.Im := z.Im; // Инициализация p = z (первый член ряда)

  Mult(z, z, z2); // z^2

  repeat
    k := k + 1; // Увеличиваем k на 1
    Mult(p, z2, p); // p *= z^2 (умножаем на z^2)
    Prod(-1 / ((2 * k) * (2 * k + 1)), p, p); // фактор (-1 / (2k(2k+1)))
    Add(s, p, s); // добавляем результат в s
  until Module(p) < eps; // продолжаем до тех пор, пока модуль p меньше eps

  w := s; // результат сохраняется в w
end;


procedure Input(var z: Complex);
begin
  writeln('Введите действительную часть комплексного числа:');
  readln(z.Re);
  writeln(' ');
  writeln('Введите мнимую часть комплексного числа:');
  read(z.Im);
end;

procedure Input2(var u, v: Complex);
begin
  writeln('Введите действительную и мнимую части первого комплексного числа:');
  readln(u.Re); 
  read(u.Im);
  writeln(' ');
  writeln('Введите действительную и мнимую части второго комплексного числа:');
  readln(v.Re); 
  read(v.Im);
end;

procedure Output(var w: Complex);
begin
  writeln(' ');
  writeln('Результат:');
  write(w.Re:0:1);
  if w.Im >= 0 then
    write(' + ', w.Im:0:1, 'i') // выводим знак мнимой части
  else
    write(' ', w.Im:0:1, 'i'); // для отрицательной части уже будет минус
  writeln;
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure MenuCompl();
Var Mode: integer; Ok: boolean;
var a, b, c: Complex;
var m: real;
begin
  Ok := true;
  while Ok do
  begin
    ClrScr;
    writeln('Укажите режим работы:');
    writeln('1) Сложение комплексных чисел');
    writeln('2) Умножение комплексных чисел');
    writeln('3) Инверсия комплексных чисел');
    writeln('4) Деление комплексных чисел');
    writeln('5) Инверсия знаков');
    writeln('6) Умножение комплексного числа на вещественное');
    writeln('7) Модуль комплексного числа');
    writeln('8) Экспонента комплексноо числа');
    writeln('9) Косинус комплексного числа');
    writeln('10) Синус комплексного числа');
    writeln('11) Единичное комплексное число');
    writeln('12) Нулевое комплексное число');
    writeln('0) Выход');
    
    GoToXY(1, 16); 
    read(Mode);
    GoToXY(1, 16); 
    ClearLine;
    
    case Mode of
      1:
      begin
        ClrScr;
        Input2(u, v);
        Add(u, v, w);
        Output(w);
        Wait;
      end;
      2:
      begin
        ClrScr;
        Input2(u, v);
        Mult(u, v, w);
        Output(w);
        Wait;
      end;
      3:
      begin
        ClrScr;
        Input(z);
        Inv(z, w);
        Output(w);
        Wait;
      end;
      4:
      begin
        ClrScr;
        Input2(u, v);
        Divz(u, v, w);
        Output(w);
        Wait;
      end;
      5:
      begin
        ClrScr;
        Input(z);
        Codj(z, w);
        Output(w);
        Wait;
      end;
      6:
      begin
        ClrScr;
        writeln('Введите вещественное число:');
        readln(q);
        Input(z);
        Prod(q, z, w);
        Output(w);
        Wait;
      end;
      7:
      begin
        ClrScr;
        Input(z);
        m := Module(z);
        writeln('Модуль комплексного числа: ', m:0:2);
        Wait;
      end;
      8:
      begin
        ClrScr;
        Input(z);
        ExpC(z, w);
        Output(w);
        Wait;
      end;
      9:
      begin
        ClrScr;
        Input(z);
        CosC(z, w);
        Output(w);
        Wait;
      end;
      10:
      begin
        ClrScr;
        Input(z);
        SinC(z, w);
        Output(w);
        Wait;
      end;
      11:
      begin
        ClrScr;
        One(w);
        Output(w);
        Wait;
      end;
      12:
      begin
        ClrScr;
        Zero(w);
        Output(w);
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
