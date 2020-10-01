program Project_Robert;
uses GraphABC, Events, ABCButtons;

const
 BWidth = 200;
 BHeight = 50;
 
var
N_Window, check, dif, n, i  : integer;

{procedure MouseDown(x,y,mb:integer);
begin
  if (mb = 1) and (x < x_rigth) and (y < y_down) then check := 1;//если нажали в 1-ый прямоуголник, то нажали 1-ую кнопку
  if (mb = 1) and ((x < x_rigth) and (y < y_down * 2 + 5)) and ((x > x_left) and (y > y_up )) then check := 2; //если нажали в 2-ый прямоуголник, то нажали 2-ую кнопку
  if (mb = 1) and ((x < x_rigth) and (y < y_down * 3 + 10)) and ((x > x_left) and (y > y_up * 2 )) then check := 3;//если нажали в 3-ый прямоуголник, то нажали 3-ую кнопку
  if (mb = 1) and ((x < x_rigth) and (y < y_down * 4 + 15)) and ((x > x_left) and (y > y_up * 3 )) then check := 4;//если нажали в 4-ый прямоуголник, то нажали 4-ую кнопку
end; }
 
procedure FirstWindow(); // рисует 1-ое окно
begin
  SetWindowSize(480, 600); // параметры окна
  SetWindowLeft(ScreenWidth div 2 - 240);
  SetWindowTop(10);
end; 
  
procedure MainWindow(); // рисует основное окно, с графом
begin
    SetWindowSize(1000, 600); // альфа версия основоного окна
    SetWindowLeft(ScreenWidth div 2 - 500);
    SetWindowTop(10);    
    setpenwidth(1);
    brush.color := clWhite;
    pen.Color := clWhite; 
    rectangle(0, 55, 1000, 505); 
    for var i := 1 to 10 do line(0, i * 50 + 5, 1000, i * 50 + 5, argb(60,60,60,60));  
    for var i := 1 to 20 do line(i * 50 , 55, i * 50, 505, argb(60,60,60,60)); 
      
      
    
end;
 
begin
  
  N_Window := 1; // переменная, обозначающая какое окно открыто
  dif := 1; // переменная, обозначающа выбранную сложность графа
  n := 1; // переменная, обозначающая колличество генераций
  check := 0; // переменная, обозначающая кокую кнопку нажали
  i := 0;
  //onmousedown := MouseDown;
  
  FirstWindow();
  
  var b1 := new ButtonABC(10, 10, BWidth * 2 + 60, BHeight * 2, 'Сгенерировать', clWhite);// основная кнопка
  var b2_1 := new ButtonABC(10,115, BWidth + 25, BHeight * 2, 'Увеличить сложность*', argb(100,255,0,0));//// заготовки под кнопки
  var b3_1 := new ButtonABC(10, 220, BWidth + 25, BHeight * 2, 'Увеличить Колличество *', argb(100,255,0,0));// заготовки под кнопки
  var b2_2 := new ButtonABC(245,115, BWidth + 25, BHeight * 2, 'Уменьшить сложность*', argb(100,0,0,255));//// заготовки под кнопки
  var b3_2 := new ButtonABC(245, 220, BWidth + 25, BHeight * 2, 'Уменьшить Колличество *', argb(100,0,0,255));// заготовки под кнопки
  b1.OnClick := procedure ->
  begin
    mainwindow();
    b1.Text := 'Сгенерировать еще';
    b1.Height := BHeight;
    b1.Width := BWidth - 5;   
    b1.Position := (3,0);
    
    b2_1.Height := BHeight;
    b2_1.Width := BWidth - 5;  
    b2_1.Position := (201, 0);
    
    b3_1.Height := BHeight;
    b3_1.Width := BWidth - 5;  
    b3_1.Position := (597, 0);
    
    b2_2.Height := BHeight;
    b2_2.Width := BWidth - 5;  
    b2_2.Position := (399, 0);
    
    b3_2.Height := BHeight;
    b3_2.Width := BWidth - 5;  
    b3_2.Position := (795, 0);
  end;
  
  b2_1.OnClick := procedure ->
  begin
    read(dif);
  end;
  
  b3_1.OnClick := procedure ->
  begin
    mainwindow();
    b3_1.Text := 'Сгенерировать еще'
  end;
  
end.