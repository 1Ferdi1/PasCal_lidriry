program ComplexMathTool;
uses
  crt, Compl, CMatr, RVect, CVect, Favorites,
  CStack, СQueue, Lists, StudentFiles;

var
  Mode: integer;
  ok: boolean;
  
begin
  ok := true;
  InitializeMenus;
  while ok do
  begin
    ClrScr;
    writeln('Укажите режим работы:');
    writeln('1) Комплексные числа');
    writeln('2) Комплексные матрицы');
    writeln('3) Вещественные векторы');
    writeln('4) Комплексные векторы');
    writeln('5) Избранное');
    writeln('6) Работа со стеками');
    writeln('7) Работа с очередями');
    writeln('8) Списки');
    writeln('9) Файлы студентов');
    writeln('0) Выход');
    
    GoToXY(1, 15); readln(Mode);
    GoToXY(1, 15); ClearLine;
    
    case Mode of
      1: MenuCompl;
      2: MenuCMatr;
      3: MenuRVect;
      4: MenuCVect;
      5: FavoritesMenu;
      6: MenuCStack;
      7: MenuCQueue;
      8: ShowMenu;
      9: StudentMenu;
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