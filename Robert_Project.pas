program Project_Robert;
uses GraphABC, Events, ABCButtons;

const
 BWidth = 194; // длинна кнопки в основном окне
 BHeight = 50; // высота кнопки в основном окне
 
var
N_Window, check, dif, n, i  : integer;
b1 := new ButtonABC(10, 10, BWidth * 2 + 70, BHeight * 2, 'Сгенерировать', clWhite);
b2_1 := new ButtonABC(10, BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Увеличить сложность*', rgb(255, 100, 100));
b3_1 := new ButtonABC(10, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Увеличить Колличество *', rgb(255, 100, 100));
b2_2 := new ButtonABC(245,BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Уменьшить сложность*', rgb(100, 100, 255));
b3_2 := new ButtonABC(245, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Уменьшить Колличество *', rgb(100, 100, 255));

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
  
procedure GenerateGraph();
begin
  
end;

procedure DrawGraph();
begin
   brush.Color := argb(100, 0, 0, 150);
   pen.Color := clBlack;
  for var i := 1 to 8 do
    for var j := 2 to 9 do
      begin
       circle(j * 65, i * 65 + 5, 15);
      end;
end;
  
procedure MainWindow(); // рисует основное окно
begin
    SetWindowSize(1000, 600); // альфа версия основоного окна
    SetWindowLeft(ScreenWidth div 2 - 500);
    SetWindowTop(10);    
    setpenwidth(1);
    brush.color := clWhite;
    pen.Color := clWhite; 
    rectangle(0, 55, 1000, 505); 
    for var i := 1 to 7 do line(0, i * 65 + 5, 1000, i * 65 + 5, argb(60,60,60,60));  
    for var i := 1 to 20 do line(i * 65 , 55, i * 65, 505, argb(60,60,60,60));    
end; // рисует основное окно

procedure Textout1(); // выводит сложность
begin
  brush.Color := clWhite;
  Font.Size := 15;
  textout(10, BHeight * 6 + 25, 'Сложность сейчас: ' + inttostr(dif) + '     (1-min, 5-max)    '); 
  textout(10, BHeight * 6 + 50, 'Кол-во генераций: ' + inttostr(n) + '     (1-min, 10-max)    '); 
end; // выводит сложность

procedure Textout2(); // выводит кол-во генераций
begin
  
end; // выводит кол-во генераций

procedure HelpWindow(); // рисует окно помощи
begin
  
end; // рисует окно помощи
 
begin
  N_Window := 1; // переменная, обозначающая какое окно открыто
  dif := 1; // переменная, обозначающа выбранную сложность графа
  n := 1; // переменная, обозначающая колличество генераций
  check := 0; // переменная, обозначающая кокую кнопку нажали
  i := 0;
  
  FirstWindow();
  Textout1();
  
  b1.OnClick := procedure -> // нажатие на кнопку сгенерировать перемещает все кнопки
  begin
    mainwindow();
    DrawGraph();
    ButtonPosition1();
  end;
  
  b2_1.OnClick := procedure -> // увеличивает сложность, при нажатии
  begin
    if dif < 5 then dif += 1;
    Textout1()
  end;
  
  b3_1.OnClick := procedure ->// уменьшает кол-во генераций, при нажатии
  begin
    if n < 10 then n += 1;
    Textout1();
  end;
  
   b2_2.OnClick := procedure ->// увеличивает сложность, при нажатии
  begin
    if dif > 1 then dif -= 1;
    Textout1();
  end;
  
  b3_2.OnClick := procedure ->// уменьшает кол-во генераций, при нажатии
  begin
    if n > 1 then n -= 1;
    Textout1();
  end;
  
end.