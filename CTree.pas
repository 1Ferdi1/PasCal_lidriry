Unit CTree;

Interface

uses crt;

const
  MaxNodes = 10; // Максимальное количество узлов

type
  TNode = record
    ch: char;
    left, right: byte;
  end;

  TTree = array[1..MaxNodes] of TNode;

procedure InputTree(var ATree: TTree; var ASize: byte; var ARoot: byte);
procedure PrintTree(const ATree: TTree; ASize: byte);
procedure PreOrderTraversal(const ATree: TTree; AStart: byte);
procedure PostOrderTraversal(const ATree: TTree; AStart: byte);
procedure LevelOrderTraversal(const ATree: TTree; ASize: byte);
procedure MenuCTree;

Implementation

procedure InputTree(var ATree: TTree; var ASize: byte; var ARoot: byte);
var
  i: byte;
begin
  repeat
    Write('Введите количество узлов (1-', MaxNodes, '): ');
    Readln(ASize);
  until (ASize > 0) and (ASize <= MaxNodes);
  
  for i := 1 to ASize do
  begin
    Writeln('Узел ', i, ':');
    Write('  Символ: ');
    Readln(ATree[i].ch);
    repeat
      Write('  Левый потомок (0 если нет): ');
      Readln(ATree[i].left);
    until (ATree[i].left = 0) or ((ATree[i].left >= 1) and (ATree[i].left <= ASize));
    repeat
      Write('  Правый потомок (0 если нет): ');
      Readln(ATree[i].right);
    until (ATree[i].right = 0) or ((ATree[i].right >= 1) and (ATree[i].right <= ASize));
  end;
  
  repeat
    Write('Введите индекс корневого узла (1-', ASize, '): ');
    Readln(ARoot);
  until (ARoot >= 1) and (ARoot <= ASize);
end;

procedure PrintTree(const ATree: TTree; ASize: byte);
var
  i: byte;
begin
  ClrScr;
  Writeln('Текущее дерево:');
  for i := 1 to ASize do
    with ATree[i] do
      Writeln('Узел ', i, ': ', ch, ' (Л:', left, ' П:', right, ')');
  Writeln;
end;

procedure PreOrderTraversal(const ATree: TTree; AStart: byte);
begin
  if AStart <> 0 then
  begin
    Write(ATree[AStart].ch, ' ');
    PreOrderTraversal(ATree, ATree[AStart].left);
    PreOrderTraversal(ATree, ATree[AStart].right);
  end;
end;

procedure PostOrderTraversal(const ATree: TTree; AStart: byte);
begin
  if AStart <> 0 then
  begin
    PostOrderTraversal(ATree, ATree[AStart].left);
    PostOrderTraversal(ATree, ATree[AStart].right);
    Write(ATree[AStart].ch, ' ');
  end;
end;

procedure LevelOrderTraversal(const ATree: TTree; ASize: byte);
var
  level, i, current: byte;
  queue: array[1..MaxNodes] of byte;
  front, rear: byte;
begin
  if ASize = 0 then Exit;
  
  front := 1;
  rear := 1;
  queue[rear] := 1; // Корень всегда первый
  inc(rear);
  
  while front <> rear do
  begin
    current := queue[front];
    inc(front);
    
    Write(ATree[current].ch, ' ');
    
    if ATree[current].left <> 0 then
    begin
      queue[rear] := ATree[current].left;
      inc(rear);
    end;
    if ATree[current].right <> 0 then
    begin
      queue[rear] := ATree[current].right;
      inc(rear);
    end;
  end;
end;

procedure MenuCTree;
var
  tree: TTree;
  size, root: byte;
  choice: char;
  exitMenu: boolean;
begin
  size := 0;
  root := 0;
  exitMenu := False;
  
  repeat
    ClrScr;
    Writeln('Меню работы с деревом:');
    Writeln('1. Ввести новое дерево');
    Writeln('2. Показать дерево');
    Writeln('3. Прямой обход (Root-Left-Right)');
    Writeln('4. Обратный обход (Left-Right-Root)');
    Writeln('5. Обход в ширину (по уровням)');
    Writeln('0. Выход');
    Writeln;
    Write('Выберите действие: ');
    Readln(choice);
    
    case choice of
      '1': begin
        InputTree(tree, size, root);
        PrintTree(tree, size);
      end;
      '2': begin
        if size = 0 then
          Writeln('Дерево не введено!')
        else
          PrintTree(tree, size);
        Readkey;
      end;
      '3': begin
        if size = 0 then
          Writeln('Дерево не введено!')
        else
        begin
          Writeln('Прямой обход:');
          PreOrderTraversal(tree, root);
        end;
        Readkey;
      end;
      '4': begin
        if size = 0 then
          Writeln('Дерево не введено!')
        else
        begin
          Writeln('Обратный обход:');
          PostOrderTraversal(tree, root);
        end;
        Readkey;
      end;
      '5': begin
        if size = 0 then
          Writeln('Дерево не введено!')
        else
        begin
          Writeln('Обход в ширину:');
          LevelOrderTraversal(tree, size);
        end;
        Readkey;
      end;
      '0': exitMenu := True;
      else
      begin
        Writeln('Неверный выбор!');
        Delay(1000);
      end;
    end;
  until exitMenu;
end;

end.