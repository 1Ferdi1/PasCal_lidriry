Unit CQueue;

Interface

uses crt;

type
  Node = record
    Next: ^Node;
    inf: integer;
  end;

  Queue = record
    Top: ^Node;
  end;

procedure Add(var q: Queue; val: integer);
procedure DeleteLast(var q: Queue);
procedure ViewQueue(q: Queue);
procedure InputQueue(var q: Queue);
procedure OutputQueue(q: Queue);
procedure Wait;
procedure MenuCQueue();

Implementation

procedure Add(var q: Queue; val: integer);
var
  p, temp: ^Node;
begin
  New(p);
  p^.inf := val;
  p^.Next := Nil;
  if q.Top = Nil then
    q.Top := p
  else
  begin
    temp := q.Top;
    while temp^.Next <> Nil do
      temp := temp^.Next;
    temp^.Next := p;
  end;
end;

procedure DeleteLast(var q: Queue);
var
  temp, prev: ^Node;
begin
  if q.Top = Nil then
    raise new Exception('Очередь пуста');
  if q.Top^.Next = Nil then
  begin
    Dispose(q.Top);
    q.Top := Nil;
    Exit;
  end;
  temp := q.Top;
  prev := Nil;
  while temp^.Next <> Nil do
  begin
    prev := temp;
    temp := temp^.Next;
  end;
  Dispose(temp);
  prev^.Next := Nil;
end;

procedure ViewQueue(q: Queue);
var
  p: ^Node;
begin
  p := q.Top;
  if p = Nil then
  begin
    writeln('Очередь пуста');
    exit;
  end;
  writeln('Элементы очереди:');
  while p <> Nil do
  begin
    writeln('  ', p^.inf);
    p := p^.Next;
  end;
end;

procedure InputQueue(var q: Queue);
var
  val, count, i: integer;
begin
  write('Введите количество элементов: ');
  readln(count);
  for i := 1 to count do
  begin
    write('Введите элемент ', i, ': ');
    readln(val);
    Add(q, val);
  end;
end;

procedure OutputQueue(q: Queue);
begin
  ClrScr;
  ViewQueue(q);
  readln;
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure MenuCQueue();
var
  Mode, count: integer;
  Ok: boolean;
  q: Queue;
begin
  Ok := true;
  while Ok do
  begin
    q.Top := Nil;
    
    ClrScr;
    writeln('Меню работы с очередью:');
    writeln('1) Ввод и вывод очереди');
    writeln('2) Удаление элементов');
    writeln('0) Выход');
    
    GoToXY(1, 6); read(Mode);
    GoToXY(1, 6); ClearLine;
    
    case Mode of
      1: begin
        ClrScr;
        writeln('Ввод очереди:');
        InputQueue(q);
        writeln('Результат:');
        OutputQueue(q);
      end;
      
      2: begin
        ClrScr;
        writeln('Ввод очереди:');
        InputQueue(q);
        write('Введите количество элементов для удаления: ');
        readln(count);
        try
          for var i := 1 to count do
            DeleteLast(q);
          writeln('Результат:');
          OutputQueue(q);
        except
          on E: Exception do
          begin
            writeln(E.Message);
            Wait;
          end;
        end;
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