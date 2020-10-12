unit Button; // работает с кнопками
interface
uses GraphABC, ABCButtons, Describe, Draw, Generate, SaveGraph;

var

b1 := new ButtonABC(10, 10, BWidth * 2 + 70, BHeight * 2, 'Сгенерировать', clWhite); //создаем кнопки
b2_1 := new ButtonABC(10, BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Увеличить сложность', rgb(255, 100, 100));
b3_1 := new ButtonABC(10, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Увеличить Колличество', rgb(255, 100, 100));
b2_2 := new ButtonABC(245,BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Уменьшить сложность', rgb(100, 100, 255));
b3_2 := new ButtonABC(245, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Уменьшить Колличество', rgb(100, 100, 255));

procedure b1_OnClick;
procedure b2_1_OnClick;
procedure b3_1_OnClick;
procedure b2_2_OnClick;
procedure b3_2_OnClick;
procedure ButtonPosition1;

implementation


  procedure b1_OnClick;
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
    
    NextNameFile();
    DrawGraphFile();
    WayFile();
  end;


  procedure b2_1_OnClick;// увеличивает сложность, при нажатии
  begin
    if dif < 5 then dif += 1;
    GraphWidth := (6 + dif mod 2); // длинна графа
    GraphHeight := (2 + dif);// высота графа
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;
  
  
  procedure b3_1_OnClick;  // уменьшает кол-во генераций, при нажатии
  begin
    if n < 10 then n += 1;
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;
  
  
  procedure b2_2_OnClick;// увеличивает сложность, при нажатии
  begin
    if dif > 1 then dif -= 1;
    GraphWidth := (6 + dif mod 2); // длинна графа
    GraphHeight := (2 + dif);// высота графа
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;
  
  
  procedure b3_2_OnClick ;// уменьшает кол-во генераций, при нажатии
  begin
    if n > 1 then n -= 1;
    if n_window = 1 then Textout1();
    if n_window = 2 then Textout2();
  end;  
  
  
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
  

end.