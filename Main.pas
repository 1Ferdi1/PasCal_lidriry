program ComplexMathTool;
uses 
  crt, Compl, CMatr, RVect, CVect, Favorites, CStack;

var 
  Mode: integer;
  ok: boolean;
  
begin
  ok := true;
  while ok do
  begin
    ClrScr;
    writeln('Укажите режим работы:');
    writeln('1) Комплексные числа');
    writeln('2) Комплексные матрицы');
    writeln('3) Вещественные векторы');
    writeln('4) Комплексные векторы');
    writeln('5) Избранное');
    writeln('6) Работа со стеками');  // Новый пункт меню
    writeln('0) Выход');
    
    GoToXY(1, 10); readln(Mode);  // Измененное положение курсора
    GoToXY(1, 10); ClearLine;
    
    case Mode of
      1: MenuCompl;
      2: MenuCMatr;
      3: MenuRVect;
      4: MenuCVect;
      5: FavoritesMenu;
      6: MenuCStack;  // Вызов меню стеков
      0: ok := false;
      else
      begin
        GoToXY(30, 21);
        writeln('Ошибка. Повторите ввод');
        sleep(1000);
      end;
    end;
  end;
end.