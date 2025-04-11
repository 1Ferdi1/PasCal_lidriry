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
  ClrScr;
  ok := true;
  Writeln('Дайте файлу имя: '); 
  Readln(FileName);
  Assign(StudentFile, FileName);
  Rewrite(StudentFile);
  
  with FlowStudent do
  while ok do
  begin
    ClrScr;
    GoToXY(1, 1);  Write('Фамилия: ');
    Readln(Name);
    GoToXY(1, 3);  Write('Оценки: ');
    Readln(Mark);
    Write(StudentFile, FlowStudent);

    GoToXY(1, 10); Write('Продолжить ввод? (y/n): ');
    Readln(ch);
    ok := (UpCase(ch) = 'Y');
  end;
  Close(StudentFile);
end;

procedure ViewFile;
var 
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
  y: integer;
begin
  ClrScr;
  y := 3;
  Write('Введите имя файла: ');
  Readln(FileName);
  Assign(StudentFile, FileName);
  Reset(StudentFile);
  
  ClrScr;
  Writeln('=== Содержимое файла ===');
  while not Eof(StudentFile) do
  begin
    Read(StudentFile, FlowStudent);
    GoToXY(5, y); Write(FlowStudent.Name);
    GoToXY(20, y); Writeln(FlowStudent.Mark);
    Inc(y);
  end;
  Close(StudentFile);
  Write('Нажмите любую клавишу...');
  ReadKey;
end;

procedure AddFile;
var 
  FileName: string[12];
  StudentFile: file of Student;
  FlowStudent: Student;
  ch: char;
begin
  ClrScr;
  Write('Введите имя файла: ');
  Readln(FileName);
  Assign(StudentFile, FileName);
  Reset(StudentFile);
  Seek(StudentFile, FileSize(StudentFile));
  
  repeat
    ClrScr;
    GoToXY(1, 1);  Write('Фамилия: ');
    Readln(FlowStudent.Name);
    GoToXY(1, 3);  Write('Оценки: ');
    Readln(FlowStudent.Mark);
    Write(StudentFile, FlowStudent);

    GoToXY(1, 10); Write('Добавить еще? (y/n): ');
    Readln(ch);
    ch := UpCase(ch);
  until ch = 'N'; // Фиксированный выход при 'N'

  Close(StudentFile);
end;

procedure StudentMenu;
var
  mode: integer;
begin
  repeat
    ClrScr;
    Writeln('[1] Создать файл');
    Writeln('[2] Просмотреть файл');
    Writeln('[3] Добавить записи');
    Writeln('[0] Выход');
    GoToXY(1, 10); Write('Ваш выбор: ');
    Readln(mode);
    
    case mode of
      1: MakeFile;
      2: ViewFile;
      3: AddFile;
    end;
  until mode = 0;
end;

end.