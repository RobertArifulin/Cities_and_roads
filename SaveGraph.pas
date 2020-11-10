unit SaveGraph;// сохраняет граф 
interface
uses Describe, GraphABC, Generate;

procedure WayFile;
procedure DrawGraphFile;
procedure NextNameFile;
implementation

procedure WayFile(); // сохроняет путь в файле
begin
  assign(f, 'Правильные пути.txt');
  Append(f);
  write(f,'Граф - ' + inttostr(FileName) + '.Первый Путь: ');
  for var i := 0 to length(current_way) - 1 do
  begin
    Write(f, current_way[i] + '  ');
  end;
  writeln(f, '');
  write(f,'Граф - ' + inttostr(FileName) + '.Второй Путь: ');
  if length(second_way) > 0 then
  begin
  for var i := 0 to length(second_way) - 1 do
  begin
    write(f, second_way[i] + '  ');
  end;
  end
  else
    write(f, 'нет');
  writeln(f, '');
  write(f,'Граф - ' + inttostr(FileName) +  '.Стоимость: ');
  write(f, Graph[length(graph) - 1][length(Graph[length(graph) - 1]) - 1]._NewMinWayVal + ' ' + #13 );
  writeln(f, '');
  close(f);
end; // сохроняет путь в файле


procedure DrawGraphFile(); // сохроняет граф в файле
begin

  
  GraphHeight := (2 + dif); // зависимость высоты и ширины от сложности
  GraphWidth := (6 + dif mod 2);
  var p : Picture := new Picture(1000, (GraphHeight + 1 + (2 - GraphHeight div 6)) * Cell_size);
  
  pen.Color := clWhite;
  brush.Color := clWhite;
  p.rectangle(0, 0, 1000, 625);
  
  Font.Size := 15; // настройки шрифта
  pen.Color := clBlack;
  p.TextOut(5 , 2 ,'Граф - ' + inttostr(FileName));
  Font.Size := 12;
  p.TextOut(5 ,30, s);
    
  pen.Color := clWhite;
  brush.Color := clWhite;
  p.rectangle(0, 50, 1000, 625);
  for var i := 1 to 9 do p.line(0, i * Cell_size + 5, 1000, i * Cell_size + 5, argb(60,60,60,60));  // разлиновка окна
  for var i := 1 to 14 do p.line(i * Cell_size , 55, i * Cell_size,635, argb(60,60,60,60));
  
  Font.Size := 12; // настройки шрифта
  Font.Color := rgb(130, 130, 130);
  p.textout(5, Cell_Size + 15, 'Сложность графа: ' + inttostr(dif));// выводим сложность графа, уже сгенерированного
  pen.Color := clBlack;
  
  for var i := 1 to GraphHeight do // перебираем все координаты вершин
    for var j := 1 to GraphWidth  do
      begin
        
        if ((i = 1) and (j = 1)) or ((i = GraphHeight) and (j = GraphWidth)) then
          brush.Color := rgb( 190, 190, 190) // выделяет цветом начало и конец  
        else
          brush.Color := rgb(255, 255, 255); // цвет неособой верщины
          
        p.circle((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + 5, r);// рисуем окружность - вершину
        pen.Color := clBlack;// задаем цвет ребра
       
        if j <> GraphWidth then
        begin
          p.line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 6,((j + 1) + (GraphWidth div 2)) * Cell_size - r , (i + (2 - GraphHeight div 6)) * Cell_size + 6); // рисуем горизонтальные ребра
          p.line((j + (GraphWidth div 2)) * Cell_size + r, (i + (2 - GraphHeight div 6)) * Cell_size + 5,((j + 1) + (GraphWidth div 2)) * Cell_size - r, (i + (2 - GraphHeight div 6)) * Cell_size + 5 ); // толщиной 2 пикселя
        end;
        if i <> GraphHeight then
        begin
          p.line((j + (GraphWidth div 2)) * Cell_size + 1, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size + 1, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );// рисуем вертикальные ребра
          p.line((j + (GraphWidth div 2)) * Cell_size, (i + (2 - GraphHeight div 6)) * Cell_size + r + 5,(j + (GraphWidth div 2)) * Cell_size, ((i + 1) + (2 - GraphHeight div 6)) * Cell_size - r + 5 );// толщиной 2 пикселя
        end;
       
        brush.Color := argb(0,0,0,0); // настраеваем шрифт подписи вершины
        Font.Color := clBlack;
        Font.Size := 14;
       
        if (Graph[i - 1][j - 1]._val div 10 = 0) and ((j <> 1) or (i <> 1)) then 
          p.textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 7, (i + (2 - GraphHeight div 6)) * Cell_size - 6 , inttostr(Graph[i - 1][j - 1]._val) )// записыаем 2-х значное число
        else if (j <> 1) or (i <> 1) then
          p.textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 2, (i + (2 - GraphHeight div 6)) * Cell_size - 6 , inttostr(Graph[i - 1][j - 1]._val) );// записыаем 1 значное число
        if (i = 1) and (j = 1) then
          p.textout((j + (GraphWidth div 2)) * Cell_size - r div 2 - 7, (i + (2 - GraphHeight div 6)) * Cell_size - 6 , 'Start');

         
        //textout((j + (GraphWidth div 2)) * Cell_size - r div 2 + 15, (i + (2 - GraphHeight div 6)) * Cell_size + 5 - r div 2 - 5, inttostr(Graph[i - 1][j - 1]._MinWayVal)); // вывод параметра, для проверки на корректность работы алгоритма
        brush.Color := argb(0,0,0,0);// настраиваем шрифт подписи координат
        Font.Color := clBlack;
        Font.Size := 24;
        p.textout((GraphWidth div 2) * Cell_size - 9, (i + (2 - GraphHeight div 6)) * Cell_size - 13, inttostr(i)); // y координаты
        p.textout((j + (GraphWidth div 2)) * Cell_size - 9, ((2 - GraphHeight div 6)) * Cell_size - 13,  chr(96 + j)); // x координаты
        p.textout((GraphWidth div 2) * Cell_size - 9, (2 - GraphHeight div 6) * Cell_size - 13, '0'); // 0
         
        brush.Color := argb(0,0,0,0); // возвращаем шрифт как был
        Font.Color := clBlack;
        Font.Size := 14;  
        p.Save('Граф - ' + inttostr(FileName) + '.png');
 
      end;
end;  // сохроняет граф в файле



procedure NextNameFile(); // определяет название следующего файла
var
i, j : integer;
f1 : text;
begin
  j := 1;
  i := 1;
  //assign(f1, 'Правильные пути.txt');
  //reset(f1);
  //while not EOF do
    
  while FileExists('Граф - ' + inttostr(i) + '.png') do
  begin
    i += 1;
  end; 
  FileName := i;
end; // определяет название следующего файла
  
  
end.