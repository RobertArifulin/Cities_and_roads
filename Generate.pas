unit Generate;// генерирует граф 
interface

uses Describe;

procedure GenerateGraph;
procedure ValWay;
procedure SetWay; 
procedure ReadWayCheck;
procedure GenerateRightWay;
procedure CorrectGraphVal;
procedure GenerateGraphVal;
procedure ValWayCheck;
function PossibleAction(GWidth, GHeight :integer ; Path: array of string) : array of string;
function CurrentWayCheck(NewPath, CurrentPath: array of string): boolean;
//function PossibleAction2(GWidth, GHeight :integer ; Path: array of string) : array of string;
implementation


procedure GenerateGraph(); // генерирует граф, с рандомными стоимостями
begin
  
  setlength(Graph, GraphHeight); // Задает длинны Graph (2-х мерного массива вершин), в соответствии с шириной и высотой графа
  for var i := 0 to GraphHeight - 1 do
    setlength(Graph[i], GraphWidth);
    
  for var i := 0 to GraphHeight - 1 do // каждой вершине...
    for var j := 0 to GraphWidth - 1  do
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
begin
  var 
  Flag : boolean;
  begin
   flag := true;
   
   while flag do // повторяем до тех пор, пока все стоимости путей от начальной точки до любой другой не будут минимально возможными
   begin
     Flag := false; // остоновит цикл если ничего не измениться
      for var i := 0 to GraphHeight - 1 do // пробегаемся по всем вершинам
        for var j := 0 to GraphWidth - 1 do
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
  end;
end; // алгорит Дейкстры


procedure SetWay(); // запись кратчайшего пути
var
x, y, prev_x, prev_y, min: integer;
begin
 for var i := 0 to length(way) - 1 do // очищаем массив пути
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
    for var i := GraphHeight - 1 downto 0 do
      for var j := GraphWidth - 1 downto 0  do
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
begin
  var 
  Flag : boolean;
  begin
   flag := true;
   
   for var i := 0 to GraphHeight - 1 do // пробегаемся по всем вершинам
      for var j := 0 to GraphWidth - 1 do
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
      for var i := 0 to GraphHeight - 1 do // пробегаемся по всем вершинам
        for var j := 0 to GraphWidth - 1 do
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
x, y, prev_x, prev_y, min: integer;
begin
 for var i := 0 to length(New_Way) - 1 do // очищаем массив пути
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
  // print(x,' w ',y);
    //этот блок ищет значение минимальной стоимость пути от начала до нее
    
    if y > 0 then // есть ли сосед сверху
    begin
      if (Graph[y - 1][x]._NewMinWayVal < min) and ((y - 1 <> prev_y) or (x <> prev_x))then   
      begin
        min := Graph[y - 1][x]._NewMinWayVal; // min 
        Graph[y][x]._NewMinWayVal := Graph[y][x]._Val + Graph[y - 1][x]._NewMinWayVal;
      end;
    end;
    if x > 0 then // есть ли сосед слева
    begin
      if (Graph[y][x - 1]._NewMinWayVal < min) and ((y <> prev_y) or (x - 1 <> prev_x)) then   
      begin
        min := Graph[y][x - 1]._NewMinWayVal;
        Graph[y][x]._NewMinWayVal := Graph[y][x]._Val + Graph[y][x - 1]._NewMinWayVal;
      end;
    end;
    if y < GraphHeight - 1 then // есть ли сосед снизу
     begin
      if (Graph[y + 1][x]._NewMinWayVal < min) and ((y + 1 <> prev_y) or (x <> prev_x)) then   
      begin
        min := Graph[y + 1][x]._NewMinWayVal;
        Graph[y][x]._NewMinWayVal := Graph[y][x]._Val + Graph[y + 1][x]._NewMinWayVal;
      end;
    end;
    if x < GraphWidth - 1 then // есть ли сосед справа
    begin
      if (Graph[y][x + 1]._NewMinWayVal < min) and ((y <> prev_y) or (x + 1 <> prev_x)) then   
      begin
        min := Graph[y][x + 1]._NewMinWayVal;
        Graph[y][x]._NewMinWayVal := Graph[y][x]._Val + Graph[y][x + 1]._NewMinWayVal;
      end;
    end;  
    
    // этот блок находит соседа с минимальной стоимость пути от начала до него
    for var i := GraphHeight - 1 downto 0 do
      for var j := GraphWidth - 1 downto 0  do
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
      end;
  end;
end; // запись кратчайшего пути для проверки


function PossibleAction(GWidth, GHeight :integer ; Path: array of string) : array of string;
var
CurrentPoint : String;
x, y: integer;
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
    for var i := 1 to length(path) - 1 do
    begin
       if strtoint(path[i][3]) - strtoint(path[i - 1][3]) = -1 then flag_up := true;
       if ord(path[i][1]) - ord(path[i - 1][1]) = 1 then flag_left := true;
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
      for var i := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[i][1]) - x - 96) + abs(strtoint(path[i][3]) - (y - 1)) <= 1 then flag := true;              
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
      for var i := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[i][1]) - x - 96) + abs(strtoint(path[i][3]) - (y + 1)) <= 1 then flag := true;              
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
      for var i := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[i][1]) - 96 - (x - 1)) + abs(strtoint(path[i][3]) - y) <= 1 then flag := true;              
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
      for var i := 0 to length(path) - 2 do // каждой вершине пути
      begin
        if abs(ord(path[i][1]) - 96 - (x + 1)) + abs(strtoint(path[i][3]) - y) <= 1 then flag := true;              
      end;
      
      if not flag then
      begin 
        setlength(res, length(res) + 1);
        res[length(res) - 1] := 'right';
      end;
    end;
    
  end;
  
  if length(path) = 1 then
  begin
    
  end;
  
  result := res;
end;


procedure GenerateRightWay();
var
NextAction : integer;
ar : array of string;
begin
  
  for var i := 0 to length(Current_Way) - 1 do Current_Way[i] := '';
  setlength(Current_Way, 0);
  
  setlength(Current_Way, 1);
  Current_Way[0] := 'a-1';
  
  GoLeft := 0;
  GoUp := 0;
  
  while Current_Way[length(Current_Way) - 1] <> (chr(96 + GraphWidth) + '-' + inttostr(GraphHeight)) do
  begin
    NextAction := 0;
    
    NextAction := random(length(PossibleAction(GraphWidth, GraphHeight, Current_Way)));
    //println('                                                                                                                                                                      '  , (PossibleAction(GraphWidth, GraphHeight, Current_Way)), NextAction);
    //println('                                                                                                                                                                   '  , Current_way);
   ar := PossibleAction(GraphWidth, GraphHeight, Current_Way);
   if (PossibleAction(GraphWidth, GraphHeight, Current_Way))[NextAction] = 'down' then
    begin
      setlength(Current_Way, length(Current_Way) + 1);
      Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1])) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]) + 1);
      continue;
    end;
    if ((PossibleAction(GraphWidth, GraphHeight, Current_Way))[NextAction] = 'up') and (GoUp < GraphHeight div 2) then
    begin
      GoUp += 1;
      setlength(Current_Way, length(Current_Way) + 1);
      Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1])) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]) - 1);
      continue;
    end;
    if ((PossibleAction(GraphWidth, GraphHeight, Current_Way))[NextAction] = 'left') and (GoLeft < GraphWidth div 2) then
    begin
      GoLeft += 1;
      setlength(Current_Way, length(Current_Way) + 1);
      Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1]) - 1) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]));
      continue;
    end;
    if (PossibleAction(GraphWidth, GraphHeight, Current_Way))[NextAction] = 'right' then
    begin
      setlength(Current_Way, length(Current_Way) + 1);
      Current_Way[length(Current_Way) - 1] := chr(ord(Current_Way[length(Current_Way) - 2][1]) + 1) + '-' + inttostr(strtoint(Current_Way[length(Current_Way) - 2][3]));
      continue;
    end;
    
  end;
  
end;


function CurrentWayCheck(NewPath, CurrentPath: array of string): boolean ;
var
flag : boolean;
check : integer;
begin
  flag := true;
  reverse(NewPath);
  
  if length(NewPath) = length(CurrentPath) then
  begin
    for var i := 0 to length(NewPath) - 1 do
      if NewPath[i] <> CurrentPath[i] then flag := false;
    if flag then result := true
    else result := false;   
  end
  else result := false;
  
end;


procedure CorrectGraphVal();
var
flag1, leftinway, upinway, downinway, rightinway :boolean; left, up, down, right :integer;
begin
    for var i := 0 to GraphHeight - 1 do // каждой вершине...
      for var j := 0 to GraphWidth - 1  do
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
        for var h := 0 to length(Current_Way) - 1 do
          if Graph[i][j]._Name = Current_Way[h] then 
          begin
            flag1 := true;
            
            if h = 0 then
            begin
              if Current_Way[h + 1][1] = 'a' then downinway := true 
              else  rightinway := true;
            end
            else if h = length(Current_Way) - 1 then
            begin
              if Current_Way[h - 1][1] = chr(96 + GraphWidth) then upinway := true 
              else  leftinway := true;
            end
            else
            begin
              if ord(Current_Way[h][1]) - ord(Current_Way[h - 1][1]) = 1 then leftinway := true
              else if ord(Current_Way[h][1]) - ord(Current_Way[h - 1][1]) = -1 then rightinway :=true
              else if strtoint(Current_Way[h][3]) - strtoint(Current_Way[h - 1][3]) = 1 then upinway := true
              else downinway := true; 
              
              if ord(Current_Way[h][1]) - ord(Current_Way[h + 1][1]) = 1 then leftinway := true
              else if ord(Current_Way[h][1]) - ord(Current_Way[h + 1][1]) = -1 then rightinway :=true
              else if strtoint(Current_Way[h][3]) - strtoint(Current_Way[h + 1][3]) = 1 then upinway := true
              else downinway := true; 
            end;
            
            break;
          end;
        if not flag1 then continue;
        
        
        if i > 0 then up := Graph[i - 1][j]._NewMinWayVal;
        if i < GraphHeight - 1 then down := Graph[i + 1][j]._NewMinWayVal; 
        if j > 0 then left := Graph[i][j - 1]._NewMinWayVal;
        if j < GraphWidth - 1 then right := Graph[i][j + 1]._NewMinWayVal;
        
        if (up = left) then
        begin
          if upinway then Graph[i][j - 1]._Val += 1
          else Graph[i - 1][j]._Val += 1;
        end
        else if (up = down) then
        begin
          if upinway then Graph[i + 1][j]._Val += 1
          else Graph[i - 1][j]._Val += 1;
        end
        else if (up = right) then
        begin
          if upinway then Graph[i][j + 1]._Val += 1
          else Graph[i - 1][j]._Val += 1;
        end
        else if(right = left) then
        begin
          if rightinway then Graph[i][j - 1]._Val += 1
          else Graph[i][j + 1]._Val += 1;
        end
        else if(right = down) then
        begin
          if rightinway then Graph[i + 1][j]._Val += 1
          else  Graph[i][j + 1]._Val += 1;
        end
        else if(down = left) then
        begin
          if downinway then Graph[i][j - 1]._Val += 1
          else  Graph[i + 1][j]._Val += 1
        end;
        
    end;
end;


procedure GenerateGraphVal(); // задает стоимости графа
var
active_top:string;
flag : boolean;
NotAction, x, y, randval: integer;
begin
  
  setlength(Graph, GraphHeight); // Задает длинны Graph (2-х мерного массива вершин), в соответствии с шириной и высотой графа
  for var i := 0 to GraphHeight - 1 do
    setlength(Graph[i], GraphWidth);
   
  for var i := 0 to GraphHeight - 1 do // каждой вершине...
    for var j := 0 to GraphWidth - 1  do
      begin
        flag := false;
        for var h := 0 to length(Current_Way) - 1 do
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
    for var h := 0 to length(Current_way) - 1 do
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
  
  
for var k := 0 to 15 do
begin
  
    for var i := 0 to length(current_way) - 1 do
    begin
      Graph[strtoint(current_way[i][3]) - 1][ord(current_way[i][1]) - 97]._Val += 1;
      ValWayCheck();
      ReadWayCheck();
      if not CurrentWayCheck(New_Way, Current_Way) then
      begin
        NotAction += 1;
        Graph[strtoint(current_way[i][3]) - 1][ord(current_way[i][1]) - 97]._val -= 1;
      end 
      else NotAction := 0;
    end;
  end;
  
  active_top := '';  

  for var k := 0 to 15 do
   begin
    for var i := 0 to GraphHeight - 1 do // каждой вершине...
      for var j := 0 to GraphWidth - 1  do
      begin
       flag := False;
       if pos(chr(97 + j) + '-' + inttostr(i + 1), active_top) <> 0 then continue;
       randval := 1;
      for var h := 0 to length(Current_way) - 1 do
        if Graph[i][j]._Name = Current_way[h] then 
        begin
          flag := true;
          break;
        end;
      
      //if k = 0 then
     // println(active_top);
      
      if not flag and (Graph[i][j]._val > 2) then
      begin
        Graph[i][j]._val -= randval;
        ValWayCheck();
        ReadWayCheck();
        if not CurrentWayCheck(New_Way, Current_Way) then
        begin
          NotAction += 1;
          Graph[i][j]._val += randval;
          active_top += chr(97 + j) + '-' + inttostr(i+1);
        end
        else NotAction := 0;
      //  print('notflag');
      end;
     //print(NotAction ,'-', Graph[i][j]._val);
    // println(New_Way);
    end;
    end;
    
    Graph[GraphHeight - 1][GraphWidth - 1]._val := random(8, 50) ;
    ValWayCheck();
  
   
end;// задает стоимости графа


end.