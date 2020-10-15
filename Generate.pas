unit Generate;// генерирует граф 
interface

uses Describe;

procedure GenerateGraph;
procedure ValWay;
procedure SetWay; 

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
        end
        else
        begin
          Graph[i][j]._MinWayVal := 10000;// присваивается мин. стоимость проезда от начала 
          Graph[i][j]._val := random(1, 40); // присваивается стоимость проезда
        end;
    end; 
end;  // генерирует граф, с рандомными стоимостями


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
        Graph[y][x]._MinWayVal := Graph[y][x]._Val + Graph[y - 1][x]._MinWayVal;
      end;
    end;
    if x > 0 then // есть ли сосед слева
    begin
      if (Graph[y][x - 1]._MinWayVal < min) and ((y <> prev_y) or (x - 1 <> prev_x)) then   
      begin
        min := Graph[y][x - 1]._MinWayVal;
        Graph[y][x]._MinWayVal := Graph[y][x]._Val + Graph[y][x - 1]._MinWayVal;
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


end.