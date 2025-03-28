unit StudentFiles;
interface
uses crt;

procedure StudentMenu;

implementation

type
  Student = record
    Name: string[10];
    Mark: string[3];
  end;

procedure MakeFile;
var 
  ch: char;
  ok: boolean;
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
begin
  ok := true;
  Writeln('Дайте файлу имя'); 
  Readln(FileName);
  Assign(StudentFile, FileName);
  Rewrite(StudentFile);
  
  with FlowStudent do
    while ok do
    begin
      GoToXY(30,10); Writeln('Будите еще вводить?y|n');
      GoToXY(30,11); Readln(ch);
      GoToXY(30,11); ClearLine;
      
      if ch = 'n' then
      begin
        ok := false; 
        Close(StudentFile);
      end
      else
      begin
        GoToXY(30,20); Writeln('Введите фамилию студента');
        GoToXY(30,21); Readln(Name);
        GoToXY(30,21); ClearLine;
        GoToXY(30,22); Writeln('введите его оценки');
        GoToXY(30,23); Readln(Mark);
        GoToXY(30,23); ClearLine;
        Write(StudentFile, FlowStudent);
      end;
    end;
end;

procedure ViewFile;
var 
  k: integer;
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
begin
  k := 3;
  Writeln('Введите имя файла'); 
  Readln(FileName);
  Assign(StudentFile, FileName);
  Reset(StudentFile);
  
  with FlowStudent do
    while not Eof(StudentFile) do
    begin
      k := k + 1;
      Read(StudentFile, FlowStudent);
      GoToXY(1,k); Writeln(Name);
      GoToXY(11,k); Writeln(Mark);
    end;
  Close(StudentFile);
end;

procedure AddFile;
var 
  ch: char;
  ok: boolean;
  FileName, NewName: string[12];
  StudentFile, NewFile: file of Student;
  FlowStudent: Student;   
begin
  ok := true;
  Writeln('Введите имя файла'); 
  Readln(FileName);
  Assign(StudentFile, FileName); 
  Reset(StudentFile);
  
  NewName := 'aaaa';
  Assign(NewFile, NewName); 
  Rewrite(NewFile);
  
  while not Eof(StudentFile) do
  begin
    Read(StudentFile, FlowStudent);
    Write(NewFile, FlowStudent);
  end;
  
  with FlowStudent do
    while ok do
    begin
      GoToXY(30,10); Writeln('Будите еще вводить?y|n');
      GoToXY(30,11); Readln(ch);
      GoToXY(30,11); ClearLine;
      
      if ch = 'n' then
      begin
        ok := false;
        Close(NewFile);
      end
      else
      begin
        GoToXY(30,20); Writeln('Введите фамилию студента');
        GoToXY(30,21); Readln(Name);
        GoToXY(30,21); ClearLine;
        GoToXY(30,22); Writeln('введите его оценки');
        GoToXY(30,23); Readln(Mark);
        GoToXY(30,23); ClearLine;
        Write(NewFile, FlowStudent);
      end;
    end;
  
  Close(StudentFile); 
  Erase(StudentFile);
  Rename(NewFile, FileName);
end;

procedure StudentMenu;
var
  mode: integer;
  ok: boolean;
begin
  ok := true;
  while ok do
  begin
    ClrScr;
    writeln('Режим работы со студентами:');
    writeln('1) Создать новый файл');
    writeln('2) Просмотреть файл');
    writeln('3) Добавить записи');
    writeln('0) Назад');
    
    GoToXY(1, 12); readln(mode);
    GoToXY(1, 12); ClearLine;
    
    case mode of
      1: MakeFile;
      2: ViewFile;
      3: AddFile;
      0: ok := false;
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