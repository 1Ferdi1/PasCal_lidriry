Unit Favorites;

interface
uses crt, Compl;
  
procedure FavoritesMenu;

Implementation
procedure FavoritesMenu;
var
  a, b, c: Complex;
  Mode: integer;
begin
  while true do
  begin
    ClrScr;
    writeln('Избранное:');
    writeln('1) Умножение комплексных чисел');
    writeln('0) Назад');
    GoToXY(1, 5); readln(Mode);
    GoToXY(1, 5); ClearLine;
    case Mode of
      1: begin
        ClrScr;
        Input2(a, b);
        Mult(a, b, c);
        Output(c);
        Wait;
      end;
      0: Exit;
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
