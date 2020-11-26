unit Generate;// генерирует граф 
interface

uses Describe;

procedure GenerateGraph;
procedure ValWay;
procedure SetWay; 
procedure ReadWayCheck;
procedure GenerateRightWay;
procedure GenerateSecondWay;
procedure CorrectGraphVal;
procedure GenerateGraphVal;
procedure ValWayCheck;
procedure FindVertex;
procedure WayFromFile;
function PossibleAction(GWidth, GHeight :integer ; Path: array of string) : array of string;
function CurrentWayCheck(NewPath, CurrentPath: array of string): boolean;
//function PossibleAction2(GWidth, GHeight :integer ; Path: array of string) : array of string;
implementation


procedure GenerateGraph(); // генерирует граф, с рандомными стоимостями
var
i, j: integer;
begin
  
  setlength(Graph, GraphHeight); // Задает длинны Graph (2-х мерного массива вершин), в соответствии с шириной и высотой графа
  for i := 0 to GraphHeight - 1 do
    setlength(Graph[i], GraphWidth);
    
  for i := 0 to GraphHeight - 1 do // каждой вершине...
    for j := 0 to GraphWidth - 1  do
      begin
        Graph[i][j] := ClassVertex.Create;// создаеться класс вершина
        Graph[i][j]._name := chr(j + 97) + '-' + inttostr(i + 1); // присваивается имя ( = координате)
        if (i = 0) and (j = 0)  then
        begin
          Graph[i][j]._val := 0;
          Graph[i][j]._MinWayVal := 0; ;// присваивается мин. стоимость проезда от начала (в начальной вершине, очевидно всегда = 0)
          Graph[i][j]._PrevVal := 0;
          Graph[i][j]._NewMinWayVal := 0;
        end
        else
        begin
          Graph[i][j]._MinWayVal := 10000;// присваивается мин. стоимость проезда от начала 
          Graph[i][j]._val := random(1, 40); // присваивается стоимость проезда
          Graph[i][j]._PrevVal := 0;
          Graph[i][j]._NewMinWayVal := 10000;
        end;
      end; 
end;  // генерирует граф, с рандомными стоимостями}


procedure ValWay(); // алгоритм Дейкстры
  var 
  i, j: integer;
  Flag : boolean;
  begin
   flag := true;
   
   while flag do // повторяем до тех пор, пока все стоимости путей от начальной точки до любой другой не будут минимально возможными
   begin
     Flag := false; // остоновит цикл если ничего не измениться
      for i := 0 to GraphHeight - 1 do // пробегаемся по всем вершинам
        for j := 0 to GraphWidth - 1 do
        begin
            if i > 0 then // есть ли сосед сверху
            begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i - 1][j]._MinWayVal then  // если стоимость проезда от начальной точки до данной больше, 
              begin                                                                           // чем стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i - 1][j]._MinWayVal;      // то меняем на: стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                flag := true;
              end;
            end;
            if j > 0 then  // есть ли сосед слева
             begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i][j - 1]._MinWayVal then   // если стоимость проезда от начальной точки до данной больше, 
              begin                                                                            // чем стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i][j - 1]._MinWayVal;       // то меняем на: стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                flag := true;
              end;
            end;
            if i < GraphHeight - 1 then  // есть ли сосед снизу
             begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i + 1][j]._MinWayVal then   // аналогично
              begin
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i + 1][j]._MinWayVal;
                flag := true;
              end;
            end;
            if j < GraphWidth - 1 then  // есть ли сосед справа
            begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i][j + 1]._MinWayVal then   // аналогично
              begin
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i][j + 1]._MinWayVal;
                flag := true;
              end;
            end;
       end;
    end;
end; // алгорит Дейкстры


procedure SetWay(); // запись кратчайшего пути
var
x, y, prev_x, prev_y, min, i, j: integer;
begin
 for i := 0 to length(way) - 1 do // очищаем массив пути
   way[i] := '';
 setlength(way, 0);
 
 prev_x := GraphWidth - 1; // запоминаем координаты предыдущей вершины
 prev_y := GraphHeight - 1;
 x := GraphWidth - 1;// запоминаем координаты нынешний вершины
 y := GraphHeight - 1;
 
 min := 10000; // изночально стоимасть минимального пути "бесконечность"
 
 setlength(way, length(way) + 1); // первый элемент way - конечная точка (в way путь храниться задом на перед)
 way[0] := Graph[GraphHeight - 1][GraphWidth - 1]._name; 
 while (y <> 0) or (x <> 0) do // проходим по всем соседям, находим соседа с минимальной стоимость пути от начала до него
  begin
    
    //этот блок ищет значение минимальной стоимость пути от начала до него
    if y > 0 then // есть ли сосед сверху
    begin
      if (Graph[y - 1][x]._MinWayVal < min) and ((y - 1 <> prev_y) or (x <> prev_x))then   
      begin
        min := Graph[y - 1][x]._MinWayVal; // min 
        Graph[y - 1][x]._MinWayVal := Graph[y][x]._Val + Graph[y - 1][x]._MinWayVal;
      end;
    end;
    if x > 0 then // есть ли сосед слева
    begin
      if (Graph[y][x - 1]._MinWayVal < min) and ((y <> prev_y) or (x - 1 <> prev_x)) then   
      begin
        min := Graph[y][x - 1]._MinWayVal;
        Graph[y][x - 1]._MinWayVal := Graph[y][x]._Val + Graph[y][x - 1]._MinWayVal;
      end;
    end;
    if y < GraphHeight - 1 then // есть ли сосед снизу
     begin
      if (Graph[y + 1][x]._MinWayVal < min) and ((y + 1 <> prev_y) or (x <> prev_x)) then   
      begin
        min := Graph[y + 1][x]._MinWayVal;
        Graph[y + 1][x]._MinWayVal := Graph[y][x]._Val + Graph[y + 1][x]._MinWayVal;
      end;
    end;
    if x < GraphWidth - 1 then // есть ли сосед справа
    begin
      if (Graph[y][x + 1]._MinWayVal < min) and ((y <> prev_y) or (x + 1 <> prev_x)) then   
      begin
        min := Graph[y][x + 1]._MinWayVal;
        Graph[y][x + 1]._MinWayVal := Graph[y][x]._Val + Graph[y][x + 1]._MinWayVal;
      end;
    end;  
    
    // этот блок находит соседа с минимальной стоимость пути от начала до него
    for i := GraphHeight - 1 downto 0 do
      for j := GraphWidth - 1 downto 0  do
      begin
        if (Graph[i][j]._MinWayVal = min) and ((((i = y + 1) or (i = y - 1)) and (j = x)) or (((j = x + 1) or (j = x - 1)) and (i = y))) then // проверки на сосед ли это и минимальна ли стоимость
        begin 
          prev_x := x; // запоминаем координаты предыдущей вершины
          prev_y := y;
          x := j; // запоминаем координаты новой, подходящей нам вершины
          y := i;
          setlength(way, length(way) + 1);
          way[length(way) - 1] := Graph[i][j]._name; // добовляем ее имя в путь
        end;
      end;
  end;
end; // запись кратчайшего пути


procedure ValWayCheck(); // алгоритм Дейкстры для проверки
var
Flag : boolean;
i, j: integer;
begin

  begin
   flag := true;
   
   for i := 0 to GraphHeight - 1 do // пробегаемся по всем вершинам
      for j := 0 to GraphWidth - 1 do
      begin
        if (i = 0) and (j = 0)  then
         Graph[i][j]._NewMinWayVal := 0
        else
          Graph[i][j]._NewMinWayVal := 10000;
        end;
   
   
   while flag do // повторяем до тех пор, пока все стоимости путей от начальной точки до любой другой не будут минимально возможными
   begin
     //print('d');
     
     Flag := false; // остоновит цикл если ничего не измениться
      for i := 0 to GraphHeight - 1 do // пробегаемся по всем вершинам
        for j := 0 to GraphWidth - 1 do
        begin
        //print(Graph[i][j]._NewMinWayVal);
            if i > 0 then // есть ли сосед сверху
            begin
              if Graph[i][j]._NewMinWayVal > Graph[i][j]._Val + Graph[i - 1][j]._NewMinWayVal then  // если стоимость проезда от начальной точки до данной больше, 
              begin                                                                           // чем стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                Graph[i][j]._NewMinWayVal := Graph[i][j]._Val + Graph[i - 1][j]._NewMinWayVal;      // то меняем на: стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                flag := true;
              end;
            end;
            if j > 0 then  // есть ли сосед слева
             begin
              if Graph[i][j]._NewMinWayVal > Graph[i][j]._Val + Graph[i][j - 1]._NewMinWayVal then   // если стоимость проезда от начальной точки до данной больше, 
              begin                                                                            // чем стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                Graph[i][j]._NewMinWayVal := Graph[i][j]._Val + Graph[i][j - 1]._NewMinWayVal;       // то меняем на: стоимость проезда через нее + стоимость проезда от начальной точки до соседа
                flag := true;
              end;
            end;
            if i < GraphHeight - 1 then  // есть ли сосед снизу
             begin
              if Graph[i][j]._NewMinWayVal > Graph[i][j]._Val + Graph[i + 1][j]._NewMinWayVal then   // аналогично
              begin
                Graph[i][j]._NewMinWayVal := Graph[i][j]._Val + Graph[i + 1][j]._NewMinWayVal;
                flag := true;
              end;
            end;
            if j < GraphWidth - 1 then  // есть ли сосед справа
            begin
              if Graph[i][j]._NewMinWayVal > Graph[i][j]._Val + Graph[i][j + 1]._NewMinWayVal then   // аналогично
              begin
                Graph[i][j]._NewMinWayVal := Graph[i][j]._Val + Graph[i][j + 1]._NewMinWayVal;
                flag := true;
              end;
            end;
       end;
    end;
  end;
end; // алгорит Дейкстры для проверки


procedure ReadWayCheck(); // запись кратчайшего пути для проверки
var
x, y, prev_x, prev_y, min, i, j: integer;
next : string;
begin
 for i := 0 to length(New_Way) - 1 do // очищаем массив пути
   New_Way[i] := '';
 setlength(New_Way, 0);
 
 prev_x := GraphWidth - 1; // запоминаем координаты предыдущей вершины
 prev_y := GraphHeight - 1;
 x := GraphWidth - 1;// запоминаем координаты нынешний вершины
 y := GraphHeight - 1;
 
 min := 1000000; // изначально стоимасть минимального пути "бесконечность"
 
 setlength(New_Way, length(New_Way) + 1); // первый элемент way - конечная точка (в way путь храниться задом на перед)
 New_Way[0] := Graph[GraphHeight - 1][GraphWidth - 1]._name; 
 
 while (y <> 0) or (x <> 0) do // проходим по всем соседям, находим соседа с минимальной стоимость пути от начала до него
 begin
   min := 1000000;
   next := '';
  // print(x,' w ',y);
    //этот блок ищет значение минимальной стоимость пути от начала до нее
    
    if y > 0 then // есть ли сосед сверху
    begin
      if (Graph[y - 1][x]._NewMinWayVal < min) and ((y - 1 <> prev_y) or (x <> prev_x))then   
      begin
        min := Graph[y - 1][x]._NewMinWayVal; // min
        next := 'up';
      end;
    end;
    if x > 0 then // есть ли сосед слева
    begin
      if (Graph[y][x - 1]._NewMinWayVal < min) and ((y <> prev_y) or (x - 1 <> prev_x)) then   
      begin
        min := Graph[y][x - 1]._NewMinWayVal;
        next := 'left';
      end;
    end;
    if y < GraphHeight - 1 then // есть ли сосед снизу
     begin
      if (Graph[y + 1][x]._NewMinWayVal < min) and ((y + 1 <> prev_y) or (x <> prev_x)) then   
      begin
        min := Graph[y + 1][x]._NewMinWayVal;
        next := 'down';
      end;
    end;
    if x < GraphWidth - 1 then // есть ли сосед справа
    begin
      if (Graph[y][x + 1]._NewMinWayVal < min) and ((y <> prev_y) or (x + 1 <> prev_x)) then   
      begin
        min := Graph[y][x + 1]._NewMinWayVal;
        next := 'right';
      end;
    end;  
    
    if next = 'up' then
    begin
      setlength(New_Way, length(New_Way) + 1);
      New_Way[length(New_Way) - 1] := Graph[y - 1][x]._name; // добовляем ее имя в путь
      prev_x := x; // запоминаем координаты предыдущей вершины
      prev_y := y;
      x := x; // запоминаем координаты новой, подходящей нам вершины
      y := y - 1;
    end;
    if next = 'left' then
    begin
      setlength(New_Way, length(New_Way) + 1);
      New_Way[length(New_Way) - 1] := Graph[y][x - 1]._name; // добовляем ее имя в путь
      prev_x := x; // запоминаем координаты предыдущей вершины
      prev_y := y;
      x := x - 1; // запоминаем координаты новой, подходящей нам вершины
      y := y;
    end;
    if next = 'down' then
    begin
      setlength(New_Way, length(New_Way) + 1);
      New_Way[length(New_Way) - 1] := Graph[y + 1][x]._name; // добовляем ее имя в путь
      prev_x := x; // запоминаем координаты предыдущей вершины
      prev_y := y;
      x := x; // запоминаем координаты новой, подходящей нам вершины
      y := y + 1;
    end;
    if next = 'right' then
    begin
      setlength(New_Way, length(New_Way) + 1);
      New_Way[length(New_Way) - 1] := Graph[y][x + 1]._name; // добовляем ее имя в путь
      prev_x := x; // запоминаем координаты предыдущей вершины
      prev_y := y;
      x := x + 1; // запоминаем координаты новой, подходящей нам вершины
      y := y;
    end;
    
    // этот блок находит соседа с минимальной стоимость пути от начала до него
 {  for i := GraphHeight - 1 downto 0 do
      for j := GraphWidth - 1 downto 0  do
      begin
        if (Graph[i][j]._NewMinWayVal = min) and ((((i = y + 1) or (i = y - 1)) and (j = x)) or (((j = x + 1) or (j = x - 1)) and (i = y))) then // проверки на сосед ли это и минимальна ли стоимость
        begin 
          prev_x := x; // запоминаем координаты предыдущей вершины
          prev_y := y;
          x := j; // запоминаем координаты новой, подходящей нам вершины
          y := i;
          setlength(New_Way, length(New_Way) + 1);
          New_Way[length(New_Way) - 1] := Graph[i][j]._name; // добовляем ее имя в путь
        end;
      end;}
      
  end;
end; // запись кратчайшего пути для проверки


function PossibleAction(GWidth, GHeight :integer ; Path: array of string) : array of string;
var
CurrentPoint : String;
x, y, t: integer;
flag, flag_up, flag_left : boolean;
res : array of string;
begin
  CurrentPoint := Path[length(path) - 1] ; // имя последней точки пути
  
  x := ord(CurrentPoint[1]) - 96; // координаты последней точки пути
  y := strtoint(CurrentPoint[3]);
  
  setlength(res, 0);
  
  flag_up := false;
  flag_left := false;
  
  if length(path) > 1 then
    for t := 1 to length(path) - 1 do
    begin
       if strtoint(path[t][3]) - strtoint(path[t - 1][3]) = -1 then flag_up := true;
       if ord(path[t][1]) - ord(path[t - 1][1]) = 1 then flag_left := true;
    end;
  
  if length(path) = 1 then
  begin
    setlength(res, 2);
    res[0] := 'down';
    res[1] := 'right';
  end
  else
  begin
    
    if y > 1 then
    begin
      flag := false; 
      if length(path) > 1 then
      for t := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[t][1]) - x - 96) + abs(strtoint(path[t][3]) - (y - 1)) <= 1 then flag := true;              
      end;
      
      if not flag and (x > 2) and (x < GWidth - 1) then
      begin
       if not flag_up and (x >= GWidth div 2) then 
       begin
         setlength(res, 1);
         res[length(res) - 1] := 'up';
         result := res;
         exit;
       end
       else
       begin
         setlength(res, length(res) + 1);
         res[length(res) - 1] := 'up';
       end;
      end;
    end;
    
    
    if y < GHeight then
    begin
      flag := false;
      
      if length(path) > 1 then
      for t := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[t][1]) - x - 96) + abs(strtoint(path[t][3]) - (y + 1)) <= 1 then flag := true;              
      end;
      
      if not flag then  
      begin
        setlength(res, length(res) + 1);
        res[length(res) - 1] := 'down';
     end;
    end;
    
    
    if x > 1 then
    begin
      flag := false;
      for t := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[t][1]) - 96 - (x - 1)) + abs(strtoint(path[t][3]) - y) <= 1 then flag := true;              
      end;
      if not flag and (y > 2) and (y < GHeight - 1) then
      begin
        if not flag_left and (y >= GHeight div 2) then 
        begin
          setlength(res, 1);
          res[length(res) - 1] := 'left';
          result := res;
          exit;
        end
       else
       begin
         setlength(res, length(res) + 1);
         res[length(res) - 1] := 'left';
       end;
      end;
    end;
    
    
    if x < GWidth then
    begin
      flag := false;
      
      if length(path) > 1 then
      for t := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[t][1]) - 96 - (x + 1)) + abs(strtoint(path[t][3]) - y) <= 1 then flag := true;              
      end;
      
      if not flag then
      begin 
        setlength(res, length(res) + 1);
        res[length(res) - 1] := 'right';
      end;
    end;
  end;

  result := res;
end;


procedure GenerateRightWay();
var
InterestingWay, flag: boolean;
NextAction, i, maxlen, len, j: integer;
action: string;
begin
  
  
  InterestingWay := False;
  
  while not InterestingWay do
  begin
    i := 0;
    j := 0;
    
    setlength(Current_Way, 1);
    Current_Way[0] := 'a-1';
    
    GoLeft := 0;
    GoUp := 0;
  
    while Current_Way[length(Current_Way) - 1] <> (chr(96 + GraphWidth) + '-' + inttostr(GraphHeight)) do
    begin
      NextAction := 0;
      
      NextAction := random(length(PossibleAction(GraphWidth, GraphHeight, Current_Way)));
      try
        action := PossibleAction(GraphWidth, GraphHeight, Current_Way)[NextAction];
      except
        Current_Way := Current_Way[1: length(current_way) - 1];
      end;
      //println('                                                                                                                                                                      '  , (PossibleAction(GraphWidth, GraphHeight, Current_Way)), NextAction);
      //println('                                                                                                                                                                   '  , Current_way);
     if action = 'down' then
      begin
        setlength(Current_Way, length(Current_Way) + 1);
        Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1])) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]) + 1);
        continue;
      end;
      if action = 'up' then
      begin
        GoUp += 1;
        setlength(Current_Way, length(Current_Way) + 1);
        Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1])) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]) - 1);
        continue;
      end;
      if action = 'left' then
      begin
        GoLeft += 1;
        setlength(Current_Way, length(Current_Way) + 1);
        Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1]) - 1) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]));
        continue;
      end;
      if action = 'right' then
      begin
        setlength(Current_Way, length(Current_Way) + 1);
        Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1]) + 1) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]));
        continue;
      end;
    end;
    
    len := 1;
    maxlen := 0;
    i := 0;
    
    while i < length(Current_Way) - 1 do
    begin
      j := i;
      len := 1;
      
      while (j < length(Current_Way) - 1) and (Current_way[j][1] = Current_way[j + 1][1]) do
      begin
        len += 1;
        if j < length(Current_Way) - 1 then j += 1
        else break;
      end;

      if maxlen < len then maxlen := len;
      
      j := i;
      len := 1;

      while (j < length(Current_Way) - 1) and (Current_way[j][3] = Current_way[j + 1][3]) do
      begin
        len += 1;
        if j < length(Current_Way) - 1 then j += 1
        else break;
      end;
      
      if maxlen < len then maxlen := len;

      i += maxlen - 1;  
      if i >= length(Current_Way) - 1 then break;
    end;
    
    for i := 0 to length(Current_Way) - 1 do
    begin
      if i > 0 then
      begin
        if ((strtoint(Current_way[i][3]) - strtoint(Current_way[i - 1][3]) = -1) or (ord(Current_way[i][1]) - Ord(Current_way[i - 1][1]) = -1)) and (maxlen <= (GraphWidth div 2) + 1) and (Current_way[0] = 'a-1')then
        begin
          InterestingWay := True;
          break
        end;
      end;
    end;
    
    if InterestingWay then break;
  end;
  
end;


procedure WayFromFile();
var
f1: text; 
i, j: integer;
s: string;
VariantWay: array of string;
begin
  WayError := False;
  assign(f1, 'Setting\Way.txt');
  reset(f1);
  
  for i := 0 to length(Current_Way) - 1 do Current_Way[i] := '';
  setlength(Current_Way, 0);
  setlength(VariantWay, 0);
  
  i := 0;
  while not eof(f1) do
  begin
    if i = dif then
    begin
      readln(f1, s);
      s := s[5:];
      VariantWay := s.Split(';');  
      if VariantWay[length(VariantWay) - 1] = '' then
        setlength(VariantWay, length(VariantWay) - 1);
      Current_Way := VariantWay[random(0, length(VariantWay) - 1)].Split(' ');
      
      if (Current_Way[0] <> 'a-1') or (Current_Way[length(Current_Way) - 1] <> Graph[GraphHeight - 1][GraphWidth - 1]._Name) then 
      begin
        WayError := True;
        break;
      end;
      break;
    end;
    readln(f1, s);
    i += 1;
  end;
  
  close(f1);
end;


procedure FindVertex();
var
flag1, leftinway, upinway, downinway, rightinway :boolean; 
left, up, down, right, h , i, j:integer;
begin
    setlength(SecondWayVertex, 0);
  
    for i := 0 to GraphHeight - 1 do // каждой вершине...
      for j := 0 to GraphWidth - 1  do
      begin
        left := -1;
        up := -2;
        down := -3;
        right := -4;
        flag1 := false;
        leftinway := false;
        upinway := false;
        downinway := false;
        rightinway := false;
        for h := length(Current_Way) - 1 downto 0 do
          if Graph[i][j]._Name = Current_Way[h] then 
          begin
            
            flag1 := true;
        
            if Current_Way.IndexOf(chr(ord(Current_Way[h][1]) - 1) + '-' + current_way[h][3]) <> -1 then leftinway := true;
            if Current_Way.IndexOf(chr(ord(Current_Way[h][1]) + 1) + '-' + current_way[h][3]) <> -1 then rightinway := true;
            if Current_Way.IndexOf(chr(ord(Current_Way[h][1])) + '-' + inttostr(strtoint(current_way[h][3]) - 1)) <> -1 then upinway := true;
            if Current_Way.IndexOf(chr(ord(Current_Way[h][1])) + '-' + inttostr(strtoint(current_way[h][3]) + 1)) <> -1 then downinway := true;
            break;
          end;
          
        if not flag1 then continue;
        
        if i > 0 then up := Graph[i - 1][j]._NewMinWayVal;
        if i < GraphHeight - 1 then down := Graph[i + 1][j]._NewMinWayVal; 
        if j > 0 then left := Graph[i][j - 1]._NewMinWayVal;
        if j < GraphWidth - 1 then right := Graph[i][j + 1]._NewMinWayVal;
        
        //and (Current_Way.IndexOf() < h)  
        if (up = left) then
        begin
          if upinway and not leftinway and (Current_Way.IndexOf(Graph[i - 1][j]._Name) < h) then 
            begin
              setlength(SecondWayVertex, length(SecondWayVertex) + 1);
              SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i][j - 1]._Name;
            end
          else if leftinway and not upinway and (Current_Way.IndexOf(Graph[i][j - 1]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i - 1][j]._Name;
          end;
        end
        else if (up = down) then
        begin
          if upinway and not downinway and (Current_Way.IndexOf(Graph[i - 1][j]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i + 1][j]._Name;
          end
          else if downinway and not upinway and (Current_Way.IndexOf(Graph[i + 1][j]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i - 1][j]._Name;
          end
        end
        else if (up = right) then
        begin
          if upinway and not rightinway and (Current_Way.IndexOf(Graph[i - 1][j]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i][j + 1]._Name;
          end
          else if not upinway and rightinway and (Current_Way.IndexOf(Graph[i][j + 1]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i - 1][j]._Name;
          end
        end
        else if(right = left) then
        begin
          if rightinway and not leftinway and (Current_Way.IndexOf(Graph[i][j + 1]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i][j - 1]._Name;
          end
          else if not rightinway and leftinway and (Current_Way.IndexOf(Graph[i][j - 1]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i][j + 1]._Name;
          end
        end
        else if(right = down) then
        begin
          if rightinway and not downinway and (Current_Way.IndexOf(Graph[i][j + 1]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i + 1][j]._Name;
          end
          else if not rightinway and downinway and (Current_Way.IndexOf(Graph[i + 1][j]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i][j + 1]._Name;
          end
        end
        else if(down = left) then
        begin
          if downinway and not leftinway and (Current_Way.IndexOf(Graph[i + 1][j]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i][j - 1]._Name;
          end
          else if not downinway and leftinway and (Current_Way.IndexOf(Graph[i][j - 1]._Name) < h) then 
          begin
            setlength(SecondWayVertex, length(SecondWayVertex) + 1);
            SecondWayVertex[length(SecondWayVertex) - 1] := Graph[i + 1][j]._Name;
          end
        end;
      end;
      if length(SecondWayVertex) = 0 then
        SecondVertex := False
      else
        SecondVertex := True;
end;


procedure GenerateSecondWay();
var
x, y, prev_x, prev_y, min, i, j: integer;
Vertex, next, Close: string;
begin
  
  while true do
  begin
  Vertex := SecondWayVertex[random(length(SecondWayVertex))];
  
  //ОТЛАДКA
  //Vertex := 'b-2';
  //ОТЛАДКА
  
  x := ord(Vertex[1]) - 96; // координаты последней точки пути
  y := strtoint(Vertex[3]);
  if ((x > 1) and (x < GraphWidth)) or ((y > 1) and (y < GraphWidth)) then break;
  end;
  close := '';
  
  for i := 0 to length(Current_Way) - 1 do
  begin
    if (y = strtoint(current_way[i][3])) and (abs(x - (ord(current_way[i][1]) - 96)) = 1) then
    begin
      close := current_way[i];
    end;
    if (x = ord(current_way[i][1]) - 96) and (abs(y - strtoint(current_way[i][3])) = 1) then
    begin
      close := current_way[i];
    end;
  end;
  Second_Way := current_way[current_way.FindIndex(s -> s = close):length(current_way)];
  reverse(second_way);
  setlength(Second_Way, length(Second_Way) + 1);
  Second_Way[length(Second_Way) - 1] := Vertex;
  
  
  prev_x := x - 1; // запоминаем координаты предыдущей вершины
  prev_y := y - 1;
  x := x - 1;// запоминаем координаты нынешний вершины
  y := y - 1;
  //Current_Way.IndexOf(chr(x + 97) + '-' + inttostr(y + 1)) = -1
  
 
 while Current_Way.IndexOf(chr(x + 97) + '-' + inttostr(y + 1)) = -1 do // проходим по всем соседям, находим соседа с минимальной стоимость пути от начала до него
 begin
  min := 1000000;
   next := '';
  // print(x,' w ',y);
    //этот блок ищет значение минимальной стоимость пути от начала до нее
    
    if y > 0 then // есть ли сосед сверху
    begin
      if (Graph[y - 1][x]._NewMinWayVal < min) and ((y - 1 <> prev_y) or (x <> prev_x))then   
      begin
        min := Graph[y - 1][x]._NewMinWayVal; // min
        next := 'up';
      end;
    end;
    if x > 0 then // есть ли сосед слева
    begin
      if (Graph[y][x - 1]._NewMinWayVal < min) and ((y <> prev_y) or (x - 1 <> prev_x)) then   
      begin
        min := Graph[y][x - 1]._NewMinWayVal;
        next := 'left';
      end;
    end;
    if y < GraphHeight - 1 then // есть ли сосед снизу
     begin
      if (Graph[y + 1][x]._NewMinWayVal < min) and ((y + 1 <> prev_y) or (x <> prev_x)) then   
      begin
        min := Graph[y + 1][x]._NewMinWayVal;
        next := 'down';
      end;
    end;
    if x < GraphWidth - 1 then // есть ли сосед справа
    begin
      if (Graph[y][x + 1]._NewMinWayVal < min) and ((y <> prev_y) or (x + 1 <> prev_x)) then   
      begin
        min := Graph[y][x + 1]._NewMinWayVal;
        next := 'right';
      end;
    end;  
 
    
    // этот блок находит соседа с минимальной стоимость пути от начала до него
    for i := GraphHeight - 1 downto 0 do
      for j := GraphWidth - 1 downto 0  do
      begin
        if (Graph[i][j]._NewMinWayVal = min) and ((((i = y + 1) or (i = y - 1)) and (j = x)) or (((j = x + 1) or (j = x - 1)) and (i = y))) then // проверки на сосед ли это и минимальна ли стоимость
        begin 
          prev_x := x; // запоминаем координаты предыдущей вершины
          prev_y := y;
          x := j; // запоминаем координаты новой, подходящей нам вершины
          y := i;
          setlength(Second_Way, length(Second_Way) + 1);
          Second_Way[length(Second_Way) - 1] := Graph[i][j]._name; // добовляем ее имя в путь
        end;
      end;
  end;
  for i := (Current_Way.IndexOf(Second_Way[length(Second_Way) - 1]) - 1) downto 0 do
  begin
    setlength(Second_Way, length(Second_Way) + 1);
    Second_Way[length(Second_Way) - 1] := Current_Way[i];
  end;
  reverse(Second_Way);
  close := '';
end;


function CurrentWayCheck(NewPath, CurrentPath: array of string): boolean ;
var
i: integer;
flag : boolean;
begin
  flag := true;
  reverse(NewPath);
  if length(NewPath) = length(CurrentPath) then
  begin
    for i := 0 to length(NewPath) - 1 do
      if NewPath[i] <> CurrentPath[i] then flag := false;
    if flag then result := true
    else result := false;   
  end
  else result := false;
  
end;


procedure CorrectGraphVal();
var
flag1, flag2, leftinway, upinway, downinway, rightinway, action, flag:boolean; 
left, up, down, right, i, j, h, n, NotAction, randval :integer;
active_top, check: string;
begin
  
//ОТЛАДКА
{
Graph[0][1]._val := 10;
Graph[0][2]._val := 20;
Graph[1][0]._val := 10;
Graph[1][1]._Val := 20;
ValWayCheck();
}
//ОТЛАДКА


for i := 0 to GraphHeight - 1 do // каждой вершине...
  for j := 0 to GraphWidth - 1  do
  begin
    ValWayCheck();
    left := -1;
    up := -2;
    down := -3;
    right := -4;
    
    flag1 := false;
    flag2 := false;
    leftinway := false;
    upinway := false;
    downinway := false;
    rightinway := false;
    
    for h := 0 to length(Current_Way) - 1 do
    if Graph[i][j]._Name = Current_Way[h] then 
    begin
      flag1 := true;
      
      if (h > 0) then
      begin
        if ord(Current_Way[h][1]) - ord(Current_Way[h - 1][1]) = 1 then leftinway := True;
        if ord(Current_Way[h][1]) - ord(Current_Way[h - 1][1]) = -1 then rightinway := True;
        if strtoint(Current_Way[h][3]) - strtoint(Current_Way[h - 1][3]) = 1 then upinway := True;
        if strtoint(Current_Way[h][3]) - strtoint(Current_Way[h - 1][3]) = -1 then downinway := True;
      end;
    
    
      if Second_Way.IndexOf(Current_way[h]) = -1 then
      begin    
        if i > 0 then 
        begin
          for n := 0 to length(Second_Way) - 1 do
          if Graph[i - 1][j]._Name = Second_Way[n] then 
          begin
            upinway := True;{
            if (n > 0) then
            begin
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = -1 then downinway := True;
            end;}
            break;
          end;
        end;
    
        if i < GraphHeight - 1 then 
        begin
          for n := 0 to length(Second_Way) - 1 do
          if Graph[i + 1][j]._Name = Second_Way[n] then 
          begin
            downinway := True;{
            if (n > 0) then
            begin
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = -1 then downinway := True;
            end;}
            break;
          end;
        end;
    
        if j > 0 then 
        begin
          for n := 0 to length(Second_Way) - 1 do
          if Graph[i][j - 1]._Name = Second_Way[n] then 
          begin
            leftinway := True;{
            if (n > 0) then
            begin
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = -1 then downinway := True;
            end;}
            break;
          end;
        end;
    
    
        if j < GraphWidth - 1 then
        begin
          for n := 0 to length(Second_Way) - 1 do
          if Graph[i][j + 1]._Name = Second_Way[n] then 
          begin
            rightinway := True;{
            if (n > 0) then
            begin
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Second_Way[n][1]) - ord(Second_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Second_Way[n][3]) - strtoint(Second_Way[n - 1][3]) = -1 then downinway := True;
            end;}
            break;
          end;
        end;
      end;
      break;
     end;
    
    
    setlength(SecondWayVertex, 0);
    
    
    for h := 0 to length(Second_Way) - 1 do
    if Graph[i][j]._Name = Second_Way[h] then 
    begin
      flag2 := true;
      
      if (h > 0) then
      begin
        if ord(Second_Way[h][1]) - ord(Second_Way[h - 1][1]) = 1 then leftinway := True;
        if ord(Second_Way[h][1]) - ord(Second_Way[h - 1][1]) = -1 then rightinway := True;
        if strtoint(Second_Way[h][3]) - strtoint(Second_Way[h - 1][3]) = 1 then upinway := True;
        if strtoint(Second_Way[h][3]) - strtoint(Second_Way[h - 1][3]) = -1 then downinway := True;
      end;
      
      if Current_Way.IndexOf(Second_Way[h]) = -1 then
      begin
        if i > 0 then 
        begin
          for n := 0 to length(Current_Way) - 1 do
          if Graph[i - 1][j]._Name = Current_Way[n] then 
          begin
            upinway := True;
            {if (n > 0) then
            begin
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = -1 then downinway := True;
            end;  }
            break;
          end;
        end;
        
        if i < GraphHeight - 1 then 
        begin
          for n := 0 to length(Current_Way) - 1 do
          if Graph[i + 1][j]._Name = Current_Way[n] then 
          begin
            downinway := True;
           { if (n > 0) then
            begin
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = -1 then downinway := True;
            end;  }
            break;
          end;
        end;
        
        if j > 0 then 
        begin
          for n := 0 to length(Current_Way) - 1 do
          if Graph[i][j - 1]._Name = Current_Way[n] then 
          begin
            leftinway := True;
            {if (n > 0) then
            begin
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = -1 then downinway := True;
            end;  }
            break;
          end;
        end;
        
        if j < GraphWidth - 1 then 
        begin
          for n := 0 to length(Current_Way) - 1 do
          if Graph[i][j + 1]._Name = Current_Way[n] then 
          begin
            rightinway := True;
            {
            if (n > 0) then
            begin
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = 1 then leftinway := True;
              if ord(Current_Way[n][1]) - ord(Current_Way[n - 1][1]) = -1 then rightinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = 1 then upinway := True;
              if strtoint(Current_Way[n][3]) - strtoint(Current_Way[n - 1][3]) = -1 then downinway := True;
            end;  }
            break;
          end;
        end;
      end;
    
      break;
     end;
    
    
    
    if not flag1 and not flag2 then continue;
    
    
    
    if i > 0 then up := Graph[i - 1][j]._NewMinWayVal;
    if i < GraphHeight - 1 then down := Graph[i + 1][j]._NewMinWayVal; 
    if j > 0 then left := Graph[i][j - 1]._NewMinWayVal;
    if j < GraphWidth - 1 then right := Graph[i][j + 1]._NewMinWayVal;
    n := Graph[0][2]._val;
    
    
    if (j > 0) and upinway and not leftinway and (left <= up) and (Current_Way.IndexOf(Graph[i][j - 1]._Name) = -1) and (Second_Way.IndexOf(Graph[i][j - 1]._Name) = -1) then Graph[i][j - 1]._Val += up - left + 1;
    
    if (i > 0) and leftinway and not upinway and (left >= up) and (Current_Way.IndexOf(Graph[i - 1][j]._Name) = -1) and (Second_Way.IndexOf(Graph[i - 1][j]._Name) = -1) then Graph[i - 1][j]._Val += left - up + 1;
    
    if (i < GraphHeight - 1) and upinway and not downinway and (down <= up) and (Current_Way.IndexOf(Graph[i + 1][j]._Name) = -1) and (Second_Way.IndexOf(Graph[i + 1][j]._Name) = -1) then Graph[i + 1][j]._Val += up - down + 1;
    
    if (i > 0) and downinway and not upinway and (down >= up) and (Current_Way.IndexOf(Graph[i - 1][j]._Name) = -1) and (Second_Way.IndexOf(Graph[i - 1][j]._Name) = -1) then Graph[i - 1][j]._Val += down - up + 1;
    
    if (j < GraphWidth - 1) and upinway and not rightinway and (right <= up) and (Current_Way.IndexOf(Graph[i][j + 1]._Name) = -1) and (Second_Way.IndexOf(Graph[i][j + 1]._Name) = -1) then Graph[i][j + 1]._Val += up - right + 1;
    
    if (i > 0) and not upinway and rightinway and (right >= up) and (Current_Way.IndexOf(Graph[i - 1][j]._Name) = -1) and (Second_Way.IndexOf(Graph[i - 1][j]._Name) = -1) then Graph[i - 1][j]._Val += right - up + 1;
    
    if (j > 0) and rightinway and not leftinway and (left <= right) and (Current_Way.IndexOf(Graph[i][j - 1]._Name) = -1) and (Second_Way.IndexOf(Graph[i][j - 1]._Name) = -1) then Graph[i][j - 1]._Val += right - left + 1;
    
    if (j < GraphWidth - 1) and not rightinway and leftinway and (left >= right) and (Current_Way.IndexOf(Graph[i][j + 1]._Name) = -1) and (Second_Way.IndexOf(Graph[i][j + 1]._Name) = -1) then Graph[i][j + 1]._Val += left - right + 1;
    
    if (i < GraphHeight - 1) and rightinway and not downinway and (down <= right) and (Current_Way.IndexOf(Graph[i + 1][j]._Name) = -1) and (Second_Way.IndexOf(Graph[i + 1][j]._Name) = -1) then Graph[i + 1][j]._Val += right - down + 1;
    
    if (j < GraphWidth - 1) and not rightinway and downinway and (down >= right) and (Current_Way.IndexOf(Graph[i][j + 1]._Name) = -1) and (Second_Way.IndexOf(Graph[i][j + 1]._Name) = -1) then Graph[i][j + 1]._Val += down - right + 1;
    
    if (j > 0) and downinway and not leftinway and (left <= down) and (Current_Way.IndexOf(Graph[i][j - 1]._Name) = -1) and (Second_Way.IndexOf(Graph[i][j - 1]._Name) = -1) then Graph[i][j - 1]._Val += down - left + 1;
    
    if (i < GraphHeight - 1) and not downinway and leftinway and (left >= down) and (Current_Way.IndexOf(Graph[i + 1][j]._Name) = -1) and (Second_Way.IndexOf(Graph[i + 1][j]._Name) = -1) then Graph[i + 1][j]._Val += left - down + 1;
     
    n := Graph[0][2]._val;
    ValWayCheck();
    if i > 0 then up := Graph[i - 1][j]._NewMinWayVal;
    if i < GraphHeight - 1 then down := Graph[i + 1][j]._NewMinWayVal; // нужно проверять только перекрестки
    if j > 0 then left := Graph[i][j - 1]._NewMinWayVal;
    if j < GraphWidth - 1 then right := Graph[i][j + 1]._NewMinWayVal;
    
    n := 0;
  end;
{
active_top := '';  
NotAction := 0;
action := True;

while action do  
begin
action := False;
for i := 0 to GraphHeight - 1 do // каждой вершине...
  for j := 0 to GraphWidth - 1  do
  begin
    flag := False;
    check := chr(97 + j) + '-' + inttostr(i + 1);
    if pos(check, active_top) <> 0 then continue;
    NotAction += 1;
    randval := 1;
    for h := 0 to length(Current_way) - 1 do
    if Graph[i][j]._Name = Current_way[h] then 
    begin
      flag := true;
      break;
    end;
    
    if flag then continue;
    //if k = 0 then
    // println(active_top);
    
    
    if not flag and (Graph[i][j]._val > 2) then
    begin
      Graph[i][j]._val -= randval;
      ValWayCheck();
      ReadWayCheck();
      if not CurrentWayCheck(New_Way, Current_Way) then
      begin
        Graph[i][j]._val += randval;
        active_top += check;
      end
      else action := True;
      //  print('notflag');
    end;
      //print(NotAction ,'-', Graph[i][j]._val);
      // println(New_Way);
  end;
  NotAction := NotAction + 0
end;}
end;


procedure GenerateGraphVal(); // задает стоимости графа
var
active_top, check:string;
flag, action : boolean;
NotAction, n , x, y, randval, i, j, h: integer;
begin
  
  setlength(Graph, GraphHeight); // Задает длинны Graph (2-х мерного массива вершин), в соответствии с шириной и высотой графа
  for i := 0 to GraphHeight - 1 do
    setlength(Graph[i], GraphWidth);
   
  for i := 0 to GraphHeight - 1 do // каждой вершине...
    for j := 0 to GraphWidth - 1  do
      begin
        flag := false;
        for h := 0 to length(Current_Way) - 1 do
          if Graph[i][j]._name = Current_way[h] then 
          begin
            flag := true;
            break;
          end;
        if flag then
          Graph[i][j]._val := 1
        else
          Graph[i][j]._val := 41;
      end;
  
 NotAction := 0;
 active_top := '';  
     
  while NotAction < GraphWidth * GraphHeight * 4  do
  begin
    
    flag := false;
    x := random(GraphWidth);
    y := random(GraphHeight);
    randval := random(1, 3);
   // print(s);
   // print(active_top.FindIndex(active_top, t -> t = s));
    //if active_top.FindIndex(active_top, t -> t = s) = -1 then continue;
    //print(', ', NotAction, '-', Graph[y][x]._val, '(', x, ',', y, ')');
    for h := 0 to length(Current_way) - 1 do
      if Graph[y][x]._Name = Current_way[h] then 
      begin
        flag := true;
        break;
      end;
    
    if flag then
    begin
      Graph[y][x]._val += randval;
      ValWayCheck();
      ReadWayCheck();
      if not CurrentWayCheck(New_Way, Current_Way) then
      begin
        NotAction += 1;
        Graph[y][x]._val -= randval;
      end
      else NotAction := 0;
    end
    
    else if Graph[y][x]._val > 5 then
    begin
      Graph[y][x]._val -= randval;
      ValWayCheck();
      ReadWayCheck();
      if not CurrentWayCheck(New_Way, Current_Way) then
      begin
        NotAction += 1;
        Graph[y][x]._val += randval;
      end
      else NotAction := 0;
    end;
   //print(NotAction ,'-', Graph[y][x]._val);
  end;
  
  Graph[GraphHeight - 1][GraphWidth - 1]._val := random(8, 50) ;
  ValWayCheck();
  
  //writeln('1');
  
  NotAction := 0;
  action := True;
  {
//for k := 0 to 15 do
while action and (NotAction < 50 * length(current_way)) do
begin
  action := False;
  NotAction += 1;
  for i := 0 to length(current_way) - 1 do
  begin
    Graph[strtoint(current_way[i][3]) - 1][ord(current_way[i][1]) - 97]._Val += 1;
    ValWayCheck();
    ReadWayCheck();
    if not CurrentWayCheck(New_Way, Current_Way) then
    begin
      Graph[strtoint(current_way[i][3]) - 1][ord(current_way[i][1]) - 97]._val -= 1;
    end 
    else action := True;
  end;
end;}
  
  active_top := '';  
  n := 0; 
  NotAction := 0;
  action := True;

while action do  
begin
action := False;
for i := 0 to GraphHeight - 1 do // каждой вершине...
  for j := 0 to GraphWidth - 1  do
  begin
    flag := False;
    check := chr(97 + j) + '-' + inttostr(i + 1);
    if pos(check, active_top) <> 0 then continue;
    NotAction += 1;
    randval := 1;
    for h := 0 to length(Current_way) - 1 do
    if Graph[i][j]._Name = Current_way[h] then 
    begin
      flag := true;
      break;
    end;
    
    if flag then continue;
    //if k = 0 then
    // println(active_top);
    
    
    if not flag and (Graph[i][j]._val > 2) then
    begin
      Graph[i][j]._val -= randval;
      ValWayCheck();
      ReadWayCheck();
      if not CurrentWayCheck(New_Way, Current_Way) then
      begin
        Graph[i][j]._val += randval;
        active_top += check;
      end
      else action := True;
      //  print('notflag');
    end;
      //print(NotAction ,'-', Graph[i][j]._val);
      // println(New_Way);
  end;
  NotAction := NotAction + 0
end;
    
    Graph[GraphHeight - 1][GraphWidth - 1]._val := random(8, 50) ;
    ValWayCheck();   
end;// задает стоимости графа


end.