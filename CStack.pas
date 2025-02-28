Unit CStack;

Interface

uses crt;

type
  Node = record
    Next: ^Node;
    inf: integer;
  end;

  Stack = record
    Top: ^Node;
  end;

procedure Add(var s: Stack; val: integer);
procedure DeleteLast(var s: Stack);
procedure MergeStacks(var s1, s2: Stack);
procedure ViewStack(s: Stack);
procedure ReverseStack(var s: Stack);
procedure InputStack(var s: Stack);
procedure InputStack2(var s1, s2: Stack);
procedure OutputStack(s: Stack);
procedure Wait;
procedure MenuCStack();

Implementation

procedure Add(var s: Stack; val: integer);
var
  p: ^Node;
begin
  New(p);
  p^.inf := val;
  p^.Next := s.Top;
  s.Top := p;
end;

procedure DeleteLast(var s: Stack);
var
  temp: ^Node;
begin
  if s.Top <> Nil then
  begin
    temp := s.Top;
    s.Top := s.Top^.Next;
    Dispose(temp);
  end
  else
    raise new Exception('Стек пуст');
end;

procedure MergeStacks(var s1, s2: Stack);
var
  temp: ^Node;
begin
  if s2.Top <> Nil then
  begin
    temp := s2.Top;
    while temp^.Next <> Nil do
      temp := temp^.Next;
    temp^.Next := s1.Top;
    s1.Top := s2.Top;
    s2.Top := Nil;
  end;
end;

procedure ViewStack(s: Stack);
var
  p: ^Node;
begin
  p := s.Top;
  if p = Nil then
  begin
    writeln('Стек пуст');
    exit;
  end;
  writeln('Элементы стека:');
  while p <> Nil do
  begin
    writeln('  ', p^.inf);
    p := p^.Next;
  end;
end;

procedure ReverseStack(var s: Stack);
var
  reversed, temp: ^Node;
begin
  reversed := Nil;
  while s.Top <> Nil do
  begin
    temp := s.Top;
    s.Top := s.Top^.Next;
    temp^.Next := reversed;
    reversed := temp;
  end;
  s.Top := reversed;
end;

procedure InputStack(var s: Stack);
var
  val, count, i: integer;
begin
  write('Введите количество элементов: ');
  readln(count);
  for i := 1 to count do
  begin
    write('Введите элемент ', i, ': ');
    readln(val);
    Add(s, val);
  end;
end;

procedure InputStack2(var s1, s2: Stack);
begin
  writeln('Ввод первого стека:');
  InputStack(s1);
  writeln('Ввод второго стека:');
  InputStack(s2);
end;

procedure OutputStack(s: Stack);
begin
  ClrScr;
  ViewStack(s);
  readln;
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure MenuCStack();
var
  Mode, count: integer;
  Ok: boolean;
  s, s1, s2: Stack;
begin
  Ok := true;
  while Ok do
  begin
    // Сброс стеков перед каждой операцией
    s.Top := Nil;
    s1.Top := Nil;
    s2.Top := Nil;
    
    ClrScr;
    writeln('Меню работы со стеками:');
    writeln('1) Ввод и вывод стека');
    writeln('2) Ввод двух стеков и объединение');
    writeln('3) Удаление элементов из стека');
    writeln('4) Переворачивание стека');
    writeln('0) Выход');
    
    GoToXY(1, 8); read(Mode);
    GoToXY(1, 8); ClearLine;
    
    case Mode of
      1: begin
        ClrScr;
        writeln('Ввод стека:');
        InputStack(s);
        writeln('Результат:');
        OutputStack(s);
      end;
      
      2: begin
        ClrScr;
        InputStack2(s1, s2);
        MergeStacks(s1, s2);
        writeln('Результат объединения:');
        OutputStack(s1);
      end;
      
      3: begin
        ClrScr;
        writeln('Ввод стека:');
        InputStack(s);
        write('Введите количество элементов для удаления: ');
        readln(count);
        try
          for var i := 1 to count do
            DeleteLast(s);
          writeln('Результат:');
          OutputStack(s);
        except
          on E: Exception do
          begin
            writeln(E.Message);
            Wait;
          end;
        end;
      end;
      
      4: begin
        ClrScr;
        writeln('Ввод стека:');
        InputStack(s);
        ReverseStack(s);
        writeln('Результат переворота:');
        OutputStack(s);
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