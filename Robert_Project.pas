program Project_Robert;
uses GraphABC, Events, ABCButtons;

const
 BWidth = 194; // длинна кнопки в основном окне
 BHeight = 50; // высота кнопки в основном окне
 Cell_size = 70; // сторона клеток в основном окне
 r = 25; //радиус вершины


type
 ClassVertex = class // класс вершиина
 private
 public
  _name : string;
  _val, _MinWayVal : integer;
 end;
 
 
var
Graph : array of array of ClassVertex; // граф - массив вершин
Way : array of string; // путь
N_Window, dif, n, GraphWidth, GraphHeight, Prev_N_Window  : integer;
b1 := new ButtonABC(10, 10, BWidth * 2 + 70, BHeight * 2, 'Сгенерировать', clWhite); //создаем кнопки
b2_1 := new ButtonABC(10, BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Увеличить сложность', rgb(255, 100, 100));
b3_1 := new ButtonABC(10, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Увеличить Колличество', rgb(255, 100, 100));
b2_2 := new ButtonABC(245,BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Уменьшить сложность', rgb(100, 100, 255));
b3_2 := new ButtonABC(245, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Уменьшить Колличество', rgb(100, 100, 255));


procedure ButtonPosition1();//меняет параметры кнопок под основное окно
begin
    b1.Text := 'Сгенерировать еще'; // меняет параметры  1-ой кнопки под основное окно
    b1.Height := BHeight;
    b1.Width := BWidth;   
    b1.Position := (3,0);
    
    b2_1.Height := BHeight;// меняет параметры  2-ой кнопки под основное окно
    b2_1.Width := BWidth;  
    b2_1.Position := (BWidth + 10, 0);
    
    b3_1.Height := BHeight;// меняет параметры  3-ой кнопки под основное окно
    b3_1.Width := BWidth;  
    b3_1.Position := (BWidth * 3 + 20, 0);
    
    b2_2.Height := BHeight;// меняет параметры  4-ой кнопки под основное окно
    b2_2.Width := BWidth;  
    b2_2.Position := (BWidth * 2 + 15, 0);
    
    b3_2.Height := BHeight;// меняет параметры  5-ой кнопки под основное окно
    b3_2.Width := BWidth;  
    b3_2.Position := (BWidth * 4 + 25, 0);
end; //меняет параметры кнопок под основное окно

 
procedure FirstWindow(); // рисует 1-ое окно
begin
  SetWindowSize(480, 600); // параметры окна
  SetWindowLeft(ScreenWidth div 2 - 240);
  SetWindowTop(10);
end; // рисует 1-ое окно
 
 
procedure GenerateGraph(); // генерирует граф, с рандомными стоимостями
begin
  
  setlength(Graph, GraphHeight); // Задает длинны Graph (2-х мерного массива вершин), в соответствии с шириной и высотой графа
  for var i := 0 to GraphHeight - 1 do
    setlength(Graph[i], GraphWidth);
    
  for var i := 0 to GraphHeight - 1 do // каждой вершине...
    for var j := 0 to GraphWidth - 1  do
      begin
        Graph[i][j] := ClassVertex.Create;// создаеться класс вершина
        Graph[i][j]._name := inttostr(j + 1) + '-' + inttostr(i + 1); // присваивается имя ( = координате)
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


procedure DrawGraph(); // рисует граф, подписывает вершины
begin
  GraphHeight := (2 + dif); // зависимость высоты и ширины от сложности
  GraphWidth := (6 + dif mod 2);
  
  Font.Size := 12; // настройки шрифта
  Font.Color := rgb(130, 130, 130);
  textout(5, Cell_Size + 15, 'Сложность графа: ' + inttostr(dif));// выводим сложность графа, уже сгенерированного
  pen.Color := clBlack;
  
  for var i := 1 to GraphHeight do // перебираем все координаты вершин
    for var j := 1 to GraphWidth  do
      begin
        
        if ((i = 1) and (j = 1)) or ((i = GraphHeight) and (j = GraphWidth)) then
          brush.Color := argb(130, 0, 170, 0) // выделяет цветом начало и конец  
        else
          brush.Color := argb(130, 0, 0, 150); // цвет неособой верщины
      
       circle((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + 5, r);// рисуем окружность - вершину
       pen.Color := clBlack;// задаем цвет ребра
       
       if j <> GraphWidth then
       begin
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 6,((j + 1) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 6); // рисуем горизонтальные ребра
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 5,((j + 1) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 5 ); // толщиной 2 пикселя
       end;
       if i <> GraphHeight then
       begin
        line((j + (GraphWidth div 2)) * Cell_size + 1, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 1, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );// рисуем вертикальные ребра
        line((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );// толщиной 2 пикселя
       end;
       
       brush.Color := argb(0,0,0,0); // настраеваем шрифт подписи вершины
       Font.Color := clBlack;
       Font.Size := 14;
       
       if (Graph[i - 1][j - 1]._val div 10 = 0) and ((j <> 1) or (i <> 1)) then 
         textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 7, (i + (2 - GraphHeight div 6)) * Cell_size - 6 , inttostr(Graph[i - 1][j - 1]._val) )// записыаем 2-х значное число
       else if (j <> 1) or (i <> 1) then
         textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 2, (i + (2 - GraphHeight div 6)) * Cell_size - 6 , inttostr(Graph[i - 1][j - 1]._val) );// записыаем 1 значное число
       if (i = 1) and (j = 1) then
         textout((j + (GraphWidth div 2)) * Cell_size - r div 2 - 7, (i + (2 - GraphHeight div 6)) * Cell_size - 6 , 'Start');

         
       //textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 15, (i + (2 - GraphHeight div 6)) * Cell_size + 5 - r div 2 - 5, inttostr(Graph[i - 1][j - 1]._MinWayVal)); // вывод параметра, для проверки на корректность работы алгоритма
       brush.Color := argb(0,0,0,0);// настраиваем шрифт подписи координат
       Font.Color := clBlack;
       Font.Size := 24;
       textout((GraphWidth div 2) * Cell_size - 9, (i + (2 - GraphHeight div 6)) * Cell_size - 13, i); // y координаты
       textout((j + (GraphWidth div 2)) * Cell_size - 9, ((2 - GraphHeight div 6)) * Cell_size - 13, j); // x координаты
       textout((GraphWidth div 2) * Cell_size - 9, (2 - GraphHeight div 6) * Cell_size - 13, 0); // 0
         
         brush.Color := argb(0,0,0,0); // возвращаем шрифт как был
         Font.Color := clBlack;
         Font.Size := 14;
      end;
end; // рисует граф, подписывает вершины


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
 
 
procedure Textout1(); // выводит сложность и кол-во генераций в начадьном окне
begin
  brush.Color := clWhite;
  Font.Size := 15;
  textout(10, BHeight * 6 + 25, 'Сложность сейчас: ' + inttostr(dif) + '     (1-min, 5-max)    '); 
  textout(10, BHeight * 6 + 50, 'Кол-во генераций: ' + inttostr(n) + '     (1-min, 10-max)    '); 
end; // выводит сложность и кол-во генераций в начальном окне


procedure Textout2(); // выводит кол-во генераций, сложность и путь в основном окне
begin
  Font.Size := 15;
  Font.Color := clBlack;
  brush.color := clWhite;
  textout(10, BHeight * 13 + 10, 'Сложность следующего графа: ' + inttostr(dif) + '     (1-min, 5-max)    '); 
  textout(10, BHeight * 13 + 35, 'Кол-во генераций: ' + inttostr(n) + '     (1-min, 10-max)    ');
end; // выводит кол-во генераций, сложность и путь в основном окне


procedure WriteWay(); // вывод пути в основном окне
begin
  brush.color := clWhite;
  pen.Color := clWhite; 
  rectangle(0, 750, 1000, 800); // очищает часть окнo
  textout(10, BHeight * 15, 'Путь: ');  
  textout(70 + 40 * length(way), BHeight * 15,'Стоимость проезда: ');  
  pen.Color := clBlack; 
  Font.Color := clRed;
  for var i := 0 to length(way) - 1 do
  begin
    textout(70 + 40 * i, BHeight * 15, way[length(way) - 1 - i]); 
  end; 
    textout(260 + 40 * length(way), BHeight * 15, Graph[length(graph) - 1][length(Graph[length(graph) - 1]) - 1]._MinWayVal); 
  Font.Color := clBlack;
 end; // вывод пути в основном окне
 
 
procedure HelpWindow(); // рисует окно помощи (не сделано)
begin
  
end; // рисует окно помощи (не сделано)


procedure MainWindow(); // рисует основное окно
begin
    SetWindowSize(1000, 800); // параметры окна
    SetWindowLeft(ScreenWidth div 2 - 500);
    SetWindowTop(10);    
    setpenwidth(1);
    brush.color := clWhite;
    pen.Color := clWhite; 
    rectangle(0, 55, 1000, 800); // очищает часть окна
    line(0, 730, 1000, 730, rgb(0, 0, 0));
    for var i := 1 to 9 do line(0, i * Cell_size + 5, 1000, i * Cell_size + 5, argb(60,60,60,60));  // разлиновка окна
    for var i := 1 to 14 do line(i * Cell_size , 55, i * Cell_size,635, argb(60,60,60,60)); 
    
end; // рисует основное окно


begin
  N_Window := 1; //  какое окно открыто
  dif := 1; //  выбранную сложность графа
  n := 1; //  колличество генераций
  GraphWidth := (6 + dif mod 2); // длинна графа
  GraphHeight := (2 + dif);// высота графа
  
  FirstWindow();
  Textout1();
  
  b1.OnClick := procedure -> // нажатие на кнопку сгенерировать перемещает все кнопки
  begin
    N_window := 2;
    mainwindow();
    
    GenerateGraph();
    ValWay();
    SetWay();
    DrawGraph();
    
    WriteWay();
    ButtonPosition1();
    Textout2();
  end;
  
  b2_1.OnClick := procedure -> // увеличивает сложность, при нажатии
  begin
    if dif < 5 then dif += 1;
    GraphWidth := (6 + dif mod 2); // длинна графа
    GraphHeight := (2 + dif);// высота графа
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;
  
  b3_1.OnClick := procedure ->// уменьшает кол-во генераций, при нажатии
  begin
    if n < 10 then n += 1;
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;
  
   b2_2.OnClick := procedure ->// увеличивает сложность, при нажатии
  begin
    if dif > 1 then dif -= 1;
    GraphWidth := (6 + dif mod 2); // длинна графа
    GraphHeight := (2 + dif);// высота графа
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;
  
  b3_2.OnClick := procedure ->// уменьшает кол-во генераций, при нажатии
  begin
    if n > 1 then n -= 1;
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;

end.