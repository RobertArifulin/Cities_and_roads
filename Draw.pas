unit Draw; // рисует основное окно
interface

uses GraphABC, Describe;

procedure FirstWindow;
procedure MainWindow;
procedure Textout1;
procedure Textout2;
procedure DrawGraph;
procedure WriteWay;
procedure HelpWindow; // рисует окно помощи 
procedure DrawWay;
procedure CloseWay;


implementation


procedure MainWindow;// все плохо sdadada
begin
  SetWindowSize(1000, 800); // параметры окна
  SetWindowLeft(ScreenWidth div 2 - 500);
  SetWindowTop(10);
  setpenwidth(1);
  brush.color := clWhite;
  pen.Color := clWhite; 
  rectangle(0, 55, 1000, 636); // очищает часть окна
  line(0, 730, 1000, 730, rgb(0, 0, 0));
  for var i := 1 to 9 do line(0, i * Cell_size + 5, 1000, i * Cell_size + 5, argb(60,60,60,60));  // разлиновка окна
  for var i := 1 to 14 do line(i * Cell_size , 55, i * Cell_size,635, argb(60,60,60,60));  
end;


procedure FirstWindow(); // рисует 1-ое окно
begin
  SetWindowSize(480, 600); // параметры окна
  SetWindowLeft(ScreenWidth div 2 - 240);
  SetWindowTop(10);
end; // рисует 1-ое окно


procedure HelpWindow(); // рисует окно помощи (не сделано)
var
p1, p2 : Picture;
begin
  p1 := Picture.Create('1.png');
  p1.Load('1.png');
  p2 := Picture.Create('2.png');
  p2.Load('2.png');
  Window.Clear();
  SetWindowSize(1000, 800); // параметры окна
  SetWindowLeft(ScreenWidth div 2 - 500);
  SetWindowTop(10);
  p1.Draw(10,0);
  p2.Draw(320,0);
end; // рисует окно помощи 


procedure Textout1(); // выводит сложность и кол-во генераций в начадьном окне
begin
  brush.Color := clWhite;
  Font.Size := 15;
  textout(10, BHeight * 6 + 25, 'Сложность сейчас: ' + inttostr(dif) + '     (1-min, 5-max)    '); 
  textout(10, BHeight * 7, 'Кол-во генераций: ' + inttostr(n) + '     (1-min, 10-max)    '); 
end; // выводит сложность и кол-во генераций в начальном окне


procedure Textout2(); // выводит кол-во генераций, сложность и путь в основном окне
begin
  Font.Size := 15;
  Font.Color := clBlack;
  brush.color := clWhite;
  textout(10, BHeight * 13 + 10, 'Сложность следующего графа: ' + inttostr(dif) + '     (1-min, 5-max)    '); 
  textout(10, BHeight * 13 + 35, 'Кол-во генераций: ' + inttostr(n) + '     (1-min, 10-max)    ');
  font.Size := 12;
   textout(10, BHeight * 11 + 55, s);
end; // выводит кол-во генераций, сложность и путь в основном окне


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

        
       //textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 20, (i + (2 - GraphHeight div 6)) * Cell_size + 5 - r div 2 - 10, inttostr(Graph[i - 1][j - 1]._NewMinWayVal)); // вывод параметра, для проверки работы алгоритма
       brush.Color := argb(0,0,0,0);// настраиваем шрифт подписи координат
       Font.Color := clBlack;
       Font.Size := 24;
       textout((GraphWidth div 2) * Cell_size - 9, (i + (2 - GraphHeight div 6)) * Cell_size - 13, i); // y координаты
       textout((j + (GraphWidth div 2)) * Cell_size - 9, ((2 - GraphHeight div 6)) * Cell_size - 13, chr(96 + j)); // x координаты
         
         brush.Color := argb(0,0,0,0); // возвращаем шрифт как был
         Font.Color := clBlack;
         Font.Size := 14;
      end;
end; // рисует граф, подписывает вершины


procedure WriteWay(); // вывод пути в основном окне
begin
  brush.color := clWhite;
  pen.Color := clWhite; 
  rectangle(0, 735, 1000, 800); // очищает часть окнo
  textout(5, BHeight * 15 - 15, 'Путь: ');  
  textout(70 + 40 * 17, BHeight * 16 - 35,'Стоимость проезда: ');
  pen.Color := clBlack; 
  Font.Color := clRed;
  for var i := 0 to length(current_way) - 1 do
  begin
    if 100 + 40 * i > Window.Width then
      textout(70 + 40 * (i - 21), BHeight * 16 - 35, current_way[i])
    else 
      textout(70 + 40 * i, BHeight * 15 - 15, current_way[i])
  end; 
    textout(260 + 40 * 17, BHeight * 16 - 35, Graph[length(graph) - 1][length(Graph[length(graph) - 1]) - 1]._NewMinWayVal);
  Font.Color := clBlack;
 end; // вывод пути в основном окне


procedure DrawWay();
var
flag : boolean;
begin
  flag := false;
  for var i := 1 to GraphHeight do // перебираем все координаты вершин
    for var j := 1 to GraphWidth  do 
    begin
       
      flag := false;
      if (i > 1) then
      begin
        for var h := 0 to length(Current_Way) - 1 do
          if (Graph[i - 1][j - 1]._Name = Current_Way[h]) then
          begin
            if (h > 0) and (Graph[i - 2][j- 1]._Name = Current_Way[h - 1]) then
            begin
              flag := true;
              break;
            end;
            if (h < length(Current_Way) - 1) and (Graph[i - 2][j- 1]._Name = Current_Way[h + 1]) then
            begin
              flag := true;
              break;
            end;
          end;
        if (i <> GraphHeight) and flag then
        begin
          line((j + (GraphWidth div 2)) * Cell_size + 2, (i - 1 + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 2, ((i) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed );// рисуем вертикальные ребра
          line((j + (GraphWidth div 2)) * Cell_size - 1, (i  - 1 + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size - 1, ((i) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed);// толщиной 2 пикселя
          line((j + (GraphWidth div 2)) * Cell_size + 1, (i - 1 + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 1, ((i) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed );// рисуем вертикальные ребра
          line((j + (GraphWidth div 2)) * Cell_size, (i  - 1 + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size, ((i) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed);// толщиной 2 пикселя
        end;
      end;
      
      flag := false;
      if (i < GraphHeight)  then
      begin
        for var h := 0 to length(Current_Way) - 1 do
          if (Graph[i - 1][j - 1]._Name = Current_Way[h]) then
          begin
            if (h > 0) and (Graph[i][j - 1]._Name = Current_Way[h - 1]) then
            begin
              flag := true;
              break;
            end;
            if (h < length(Current_Way) - 1) and (Graph[i][j - 1]._Name = Current_Way[h + 1]) then
            begin
              flag := true;
              break;
            end;
          end;
        if (i <> GraphHeight) and flag then
        begin
          line((j + (GraphWidth div 2)) * Cell_size + 2, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 2, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed );// рисуем вертикальные ребра
          line((j + (GraphWidth div 2)) * Cell_size - 1, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size - 1, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed);// толщиной 2 пикселя
          line((j + (GraphWidth div 2)) * Cell_size + 1, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 1, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed );// рисуем вертикальные ребра
          line((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clRed);// толщиной 2 пикселя
        end;
      end;
      
      flag := false;
      if (j > 1) then
      begin
        for var h := 0 to length(Current_Way) - 1 do
          if (Graph[i - 1][j - 1]._Name = Current_Way[h])then
          begin
            if (h > 0) and (Graph[i - 1][j - 2]._Name = Current_Way[h - 1]) then
            begin
              flag := true;
              break;
            end;
            if (h < length(Current_Way) - 1) and (Graph[i - 1][j - 2]._Name = Current_Way[h + 1]) then
            begin
              flag := true;
              break;
            end;
          end;
        if (j <= GraphWidth) and flag then
        begin
          line((j - 1 + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 7,((j) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 7, clRed); // рисуем горизонтальные ребра
          line((j - 1 + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 4,((j) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 4, clRed); // толщиной 2 пикселя
          line((j - 1 + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 6,((j) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 6, clRed); // рисуем горизонтальные ребра
          line((j - 1 + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 5,((j) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 5, clRed); // толщиной 2 пикселя
        end;
      end;
      
      flag := false;
      if (j < GraphHeight)  then
        begin
        for var h := 0 to length(Current_Way) - 1 do
          if (Graph[i - 1][j - 1]._Name = Current_Way[h]) then
          begin
            if (h > 0) and (Graph[i - 1][j]._Name = Current_Way[h - 1]) then
            begin
              flag := true;
              break;
            end;
            if (h < length(Current_Way) - 1) and (Graph[i - 1][j]._Name = Current_Way[h + 1]) then
            begin
              flag := true;
              break;
            end;
          end;
          if (j <= GraphWidth) and flag then
          begin
            line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 4,((j + 1) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 4, clRed); // рисуем горизонтальные ребра
            line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 5,((j + 1) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 5, clRed); // толщиной 2 пикселя
            line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 6,((j + 1) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 6, clRed); // рисуем горизонтальные ребра
            line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 7,((j + 1) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 7, clRed); // толщиной 2 пикселя
          end;
        end;  
    end;
    
end;


procedure CloseWay();
begin
 for var i := 1 to GraphHeight do // перебираем все координаты вершин
    for var j := 1 to GraphWidth  do
    begin
      if j <> GraphWidth then
       begin
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 7,((j + 1) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 7, clWhite); // рисуем горизонтальные ребра
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 4,((j + 1) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 4, clWhite ); // толщиной 2 пикселя
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 6,((j + 1) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 6); // рисуем горизонтальные ребра
        line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 5,((j + 1) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 5 ); // толщиной 2 пикселя
       end;
       if i <> GraphHeight then
       begin
        line((j + (GraphWidth div 2)) * Cell_size + 2, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 2, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clWhite );// рисуем вертикальные ребра
        line((j + (GraphWidth div 2)) * Cell_size - 1, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size - 1, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5, clWhite );// толщиной 2 пикселя
        line((j + (GraphWidth div 2)) * Cell_size + 1, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 1, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );// рисуем вертикальные ребра
        line((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );// толщиной 2 пикселя
       end;
    end;
end;


end.