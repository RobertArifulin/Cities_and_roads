program Project_Robert;
uses GraphABC, Events, ABCButtons;

const
 BWidth = 194; // длинна кнопки в основном окне
 BHeight = 50; // высота кнопки в основном окне
 Cell_size = 70; // сторона клеток в основном окне
 r = 25; //радиус вершины

type
 ClassVertex = class
 private
 public
 _name : string;
  _val, _MinWayVal : integer;
 end;
 
var
Graph : array of array of ClassVertex;
Way : array of string;
N_Window, dif, n, GraphWidth, GraphHeight  : integer;
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
        Graph[i][j]._val := random(1, 40); // присваивается стоимость проезда
        if ((i = 0) and (j = 0))  then
        Graph[i][j]._MinWayVal := 0 // присваивается мин. стоимость проезда от начала (в начальной вершине, очевидно всегда = 0)
        else
        Graph[i][j]._MinWayVal := 10000;// присваивается мин. стоимость проезда от начала 
    end;
end;  // генерирует граф, с рандомными стоимостями

procedure DrawGraph(); // рисует граф, подписывает вершины
begin
  GraphHeight := (2 + dif); // зависимость высоты и ширины от сложности
  GraphWidth := (6 + dif mod 2);
  pen.Color := clBlack;
  for var i := 1 to GraphHeight do
    for var j := 1 to GraphWidth  do
      begin
       if ((i = 1) and (j = 1)) or ((i = GraphHeight) and (j = GraphWidth)) then
        brush.Color := argb(130, 0, 170, 0) // отрисовка графа, с именем вершины и ее стоимость       
       else
        brush.Color := argb(130, 0, 0, 150); // отрисовка графа, с именем вершины и ее стоимостью
      
       circle((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + 5, r);
       pen.Color := clBlack;
       if j <> GraphWidth then
       begin
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 6,((j + 1) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 6);
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 5,((j + 1) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 5 );
       end;
       if i <> GraphHeight then
       begin
        line((j + (GraphWidth div 2)) * Cell_size + 1, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 1, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );
        line((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );
       end;
       brush.Color := argb(0,0,0,0);
       Font.Color := clBlack;
       Font.Size := 14;
       
       textout((j + (GraphWidth div 2)) * Cell_size - r div 2 - 3, (i + (2 - GraphHeight div 6)) * Cell_size + 5 - r div 2 - 5, inttostr(Graph[i - 1][j - 1]._val) );
       //textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 15, (i + (2 - GraphHeight div 6)) * Cell_size + 5 - r div 2 - 5, inttostr(Graph[i - 1][j - 1]._MinWayVal));
       textout((j + (GraphWidth div 2)) * Cell_size - 15, (i + (2 - GraphHeight div 6)) * Cell_size + 5 , Graph[i - 1][j - 1]._name);
      end;
end;// рисует граф, подписывает вершины

procedure RightWay();
begin
  var 
  Flag : boolean;
  begin
   flag := true;
   while flag do
   begin
     Flag := false;
      for var i := 0 to GraphHeight - 1 do
        for var j := 0 to GraphWidth - 1 do
        begin
            if i > 0 then
            begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i - 1][j]._MinWayVal then   
              begin
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i - 1][j]._MinWayVal;
                flag := true;
              end;
            end;
            if j > 0 then
             begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i][j - 1]._MinWayVal then   
              begin
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i][j - 1]._MinWayVal;
                flag := true;
              end;
            end;
            if i < GraphHeight - 1 then
             begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i + 1][j]._MinWayVal then   
              begin
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i + 1][j]._MinWayVal;
                flag := true;
              end;
            end;
            if j < GraphWidth - 1 then
            begin
              if Graph[i][j]._MinWayVal > Graph[i][j]._Val + Graph[i][j + 1]._MinWayVal then   
              begin
                Graph[i][j]._MinWayVal := Graph[i][j]._Val + Graph[i][j + 1]._MinWayVal;
                flag := true;
              end;
            end;
       end;
    end;
  end;
end;

procedure SetWay();
var
x, y, prev_x, prev_y, min: integer;
begin
 for var i := 0 to length(way) - 1 do // очищаем массив пути
   way[i] := '';
 setlength(way, 0);
 
 prev_x := GraphWidth - 1;
 prev_y := GraphHeight - 1;
 x := GraphWidth - 1;
 y := GraphHeight - 1;
 min := 10000;
 setlength(way, length(way) + 1);
 way[0] := Graph[GraphHeight - 1][GraphWidth - 1]._name;
 while (y <> 0) or (x <> 0) do
  begin
    if y > 0 then
    begin
      if (Graph[y - 1][x]._MinWayVal < min) and ((y - 1 <> prev_y) or (x <> prev_x))then   
      begin
        min := Graph[y - 1][x]._MinWayVal; // min 
        Graph[y][x]._MinWayVal := Graph[y][x]._Val + Graph[y - 1][x]._MinWayVal;
      end;
    end;
    if x > 0 then
    begin
      if (Graph[y][x - 1]._MinWayVal < min) and ((y <> prev_y) or (x - 1 <> prev_x)) then   
      begin
        min := Graph[y][x - 1]._MinWayVal;
        Graph[y][x]._MinWayVal := Graph[y][x]._Val + Graph[y][x - 1]._MinWayVal;
      end;
    end;
    if y < GraphHeight - 1 then
     begin
      if (Graph[y + 1][x]._MinWayVal < min) and ((y + 1 <> prev_y) or (x <> prev_x)) then   
      begin
        min := Graph[y + 1][x]._MinWayVal;
        Graph[y + 1][x]._MinWayVal := Graph[y][x]._Val + Graph[y + 1][x]._MinWayVal;
      end;
    end;
    if x < GraphWidth - 1 then
    begin
      if (Graph[y][x + 1]._MinWayVal < min) and ((y <> prev_y) or (x + 1 <> prev_x)) then   
      begin
        min := Graph[y][x + 1]._MinWayVal;
        Graph[y][x + 1]._MinWayVal := Graph[y][x]._Val + Graph[y][x + 1]._MinWayVal;
      end;
    end;  
    
    for var i := GraphHeight - 1 downto 0 do
      for var j := GraphWidth - 1 downto 0  do
      begin
        if (Graph[i][j]._MinWayVal = min) and ((((i = y + 1) or (i = y - 1)) and (j = x)) or (((j = x + 1) or (j = x - 1)) and (i = y))) and ((i <> prev_y) or (j <> prev_x)) then
        begin
          prev_x := x;
          prev_y := y;
          x := j;
          y := i;
          setlength(way, length(way) + 1);
          way[length(way) - 1] := Graph[i][j]._name;
        end;
      end;
  end;
 setlength(way, length(way) + 1);
 way[length(way) - 1] := Graph[0][0]._name;
end;
  
procedure MainWindow(); // рисует основное окно
begin
    SetWindowSize(1000, 800); // параметры окна
    SetWindowLeft(ScreenWidth div 2 - 500);
    SetWindowTop(10);    
    setpenwidth(1);
    brush.color := clWhite;
    pen.Color := clWhite; 
    rectangle(0, 55, 1000, 800); // очищает часть окна
    for var i := 1 to 9 do line(0, i * Cell_size + 5, 1000, i * Cell_size + 5, argb(60,60,60,60));  // разлиновка окна
    for var i := 1 to 14 do line(i * Cell_size , 55, i * Cell_size,635, argb(60,60,60,60));    
end; // рисует основное окно

procedure Textout1(); // выводит сложность и кол-во генераций в начадьном окне
begin
  brush.Color := clWhite;
  Font.Size := 15;
  textout(10, BHeight * 6 + 25, 'Сложность сейчас: ' + inttostr(dif) + '     (1-min, 5-max)    '); 
  textout(10, BHeight * 6 + 50, 'Кол-во генераций: ' + inttostr(n) + '     (1-min, 10-max)    '); 
end; // выводит сложность

procedure Textout2(); // выводит кол-во генераций, сложность и путь
begin
  Font.Size := 15;
  Font.Color := clBlack;
  brush.color := clWhite;
  textout(10, BHeight * 12 + 40, 'Сложность сейчас: ' + inttostr(dif) + '     (1-min, 5-max)    '); 
  textout(10, BHeight * 12 + 65, 'Кол-во генераций: ' + inttostr(n) + '     (1-min, 10-max)    ');
end; // выводит кол-во генераций, сложность и путь

procedure WriteWay();
begin
  brush.color := clWhite;
  pen.Color := clWhite; 
  rectangle(0, 715, 1000, 800); // очищает часть окнo
  textout(10, BHeight * 13 + 65, 'Путь: ');  
  pen.Color := clBlack; 
  Font.Color := clRed;
  for var i := 1 to length(way) - 1 do
  begin
    textout(20 + 50 * i, BHeight * 13 + 65, way[length(way) - 1 - i]); 
  end; 
  Font.Color := clBlack;
 end;
 
procedure HelpWindow(); // рисует окно помощи
begin
  
end; // рисует окно помощи 
 
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
    RightWay();
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