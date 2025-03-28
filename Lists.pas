unit Lists;

interface

uses crt;

type
  TPerson = record
    Name: string;
  end;

  TMenu = record
    Title: string;
    People: array[1..15] of TPerson;
  end;

var
  menus: array[1..3] of TMenu;

procedure InitializeMenus;
procedure ShowMenu;
procedure ShowPeople(menuIndex: Integer);

implementation

procedure InitializeMenus;
begin
  menus[1].Title := 'Вкладка 1';
  for var i := 1 to 15 do
    menus[1].People[i].Name := 'Человек ' + IntToStr(i);

  menus[2].Title := 'Вкладка 2';
  for var i := 1 to 15 do
    menus[2].People[i].Name := 'Человек ' + IntToStr(i + 15);

  menus[3].Title := 'Вкладка 3';
  for var i := 1 to 15 do
    menus[3].People[i].Name := 'Человек ' + IntToStr(i + 30);
end;

procedure ShowMenu;
var
  menuChoice: Integer;
begin
  repeat
    ClrScr;
    writeln('Выберите вкладку:');
    for var i := 1 to 3 do
    begin
      writeln(i, ') ', menus[i].Title);
    end;
    writeln('0) Назад');
    readln(menuChoice);
    
    case menuChoice of
      1..3: 
      begin
        ClrScr;
        ShowPeople(menuChoice);
        writeln('Нажмите Enter для возврата...');
        readln;
      end;
      0: ; // Выход без действий
      else
      begin
        writeln('Неверный выбор. Повторите попытку.');
        sleep(1000);
      end;
    end;
  until menuChoice = 0;
end;

procedure ShowPeople(menuIndex: Integer);
begin
  writeln('Список людей во вкладке ' + menus[menuIndex].Title + ':');
  for var i := 1 to 15 do
    writeln(IntToStr(i) + '. ' + menus[menuIndex].People[i].Name);
end;

end.