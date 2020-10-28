unit Button; // работает с кнопками
interface
uses GraphABC, ABCButtons, Describe, Draw, Generate, SaveGraph;

var

b1 := new ButtonABC(10, 10, BWidth * 2 + 70, BHeight * 2, 'Сгенерировать', clWhite); //создаем кнопки
b2_1 := new ButtonABC(10, BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Увеличить сложность', rgb(255, 100, 100));
b3_1 := new ButtonABC(10, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Увеличить Количество', rgb(255, 100, 100));
b2_2 := new ButtonABC(245,BHeight * 2 + 15, BWidth + 30, BHeight * 2, 'Уменьшить сложность', rgb(100, 100, 255));
b3_2 := new ButtonABC(245, BHeight * 4 + 20, BWidth + 30, BHeight * 2, 'Уменьшить Количество', rgb(100, 100, 255));
b4 := new ButtonABC(10, BHeight * 8 , BWidth * 2 + 70, BHeight * 2, 'Помощь', clWhite);
b5 := new ButtonABC(10, BHeight * 10 , BWidth * 2 + 70, BHeight * 2, 'Назад', clWhite);
b6 := new ButtonABC(10, BHeight * 10 , BWidth * 2 + 45, BHeight * 2, 'Показать Путь', clWhite);

procedure b1_OnClick;
procedure b2_1_OnClick;
procedure b3_1_OnClick;
procedure b2_2_OnClick;
procedure b3_2_OnClick;
procedure b4_OnClick;
procedure b5_OnClick;
procedure b6_OnClick;
procedure ButtonPosition1;
procedure ButtonPosition2;
procedure ButtonPosition3;


implementation


  


  procedure b1_OnClick;
  begin
    if N_Window <> 3 then 
    begin
      
      assign(f1, 'Условие.txt');
      reset(f1);
      readln(f1, s);
      close(f1);
      
      for var i := 1 to n do
      begin
     
      
      b5.Visible := False;
      if N_Window <> 2 then
      Prev_N_Window := N_Window;
      N_window := 2;
      MainWindow();
      
      
        
      GenerateGraph();
      //ValWay();
      //SetWay();
      //InterestingWayVal();
      font.Size := 12;
      GenerateRightWay();
      //print('GenerateRightWay();');
      GenerateGraphVal();
      GenerateSecondWay();
      ValWayCheck();
      //print(' GenerateGraphVal();');
      
      DrawGraph();
     // print('DrawGraph();');
      
      WriteWay();
      Textout2();
      ButtonPosition2();
      b4.Visible := True;
     
      
      NextNameFile();
      DrawGraphFile();
      WayFile();
      end;
    end;
  end;


  procedure b2_1_OnClick;// увеличивает сложность, при нажатии
  begin
    if N_Window <> 3 then 
    begin
      if dif < 5 then dif += 1;
      GraphWidth := (6 + dif mod 2); // длинна графа
      GraphHeight := (2 + dif);// высота графа
      if n_window = 1 then Textout1();
      if n_window = 2 then Textout2();
    end;
  end;
  
  
  procedure b3_1_OnClick;  // уменьшает кол-во генераций, при нажатии
  begin
    if N_Window <> 3 then 
    begin
      if n < 10 then n += 1;
      if n_window = 1 then Textout1();
      if n_window = 2 then Textout2();
    end;
  end;
  
  
  procedure b2_2_OnClick;// увеличивает сложность, при нажатии
  begin
    if N_Window <> 3 then 
    begin
      if dif > 1 then dif -= 1;
      GraphWidth := (6 + dif mod 2); // длинна графа
      GraphHeight := (2 + dif);// высота графа
      if n_window = 1 then Textout1();
      if n_window = 2 then Textout2();
    end;
  end;
  
  
  procedure b3_2_OnClick ;// уменьшает кол-во генераций, при нажатии
  begin
    if N_Window <> 3 then 
    begin
      if n > 1 then n -= 1;
      if n_window = 1 then Textout1();
      if n_window = 2 then Textout2();
    end;
  end;  
  
  
  procedure b4_OnClick;
  begin
    if N_Window <> 3 then 
    begin
      if N_Window <> 3 then
      Prev_N_Window := N_Window;
      N_Window := 3;
      HelpWindow();
      b5.Visible := True;
      ButtonPosition3();
    end;
  end;
  
  
  procedure b5_OnClick;
  begin
    if (N_Window <> 1) and (N_Window <> 2) then
    begin
      
     if Prev_N_Window = 1 then
     begin
       Window.Clear();
       FirstWindow();
       Textout1();
       ButtonPosition1();
     end;
     
     if Prev_N_Window = 2 then
     begin
        Window.Clear();
        MainWindow();
        Textout2();
        DrawGraph();
        WriteWay();
        ButtonPosition2();
     end;
     
    end;
  end;
  
  
  procedure b6_OnClick();
  begin
    if b6.Text = 'Показать Путь' then
    begin
      b6.Text := 'Скрыть путь';
      DrawWay();
    end
    else
    begin
      b6.Text := 'Показать Путь';
      CloseWay();
    end;
  end;
  
  
  procedure ButtonPosition1();
  begin
    if N_Window <> 1 then
    Prev_N_Window := N_Window;
    N_Window := 1;
    b1.Visible := True;
    b2_1.Visible := True;
    b3_1.Visible := True;
    b3_2.Visible := True;
    b2_2.Visible := True;
    b4.Visible := True;
    b6.Visible := False;
    
    b1.Text := 'Сгенерировать';
    b1.Height := BHeight * 2;
    b1.Width := BWidth * 2 + 70;
    b1.Position := (10, 10);
    
    b2_1.Height := BHeight * 2;
    b2_1.Width := BWidth + 30;
    b2_1.Position := (10, BHeight * 2 + 15);
    
    b3_1.Height := BHeight * 2;
    b3_1.Width := BWidth + 30;
    b3_1.Position := (10, BHeight * 4 + 20);
    
    b2_2.Height := BHeight * 2;
    b2_2.Width := BWidth + 30;
    b2_2.Position := (245, BHeight * 2 + 15);
    
    b3_2.Height := BHeight * 2;
    b3_2.Width := BWidth + 30;
    b3_2.Position := (245, BHeight * 4 + 20);
    
    b4.Height := BHeight * 2;
    b4.Width := BWidth * 2 + 70;
    b4.Position := (10, BHeight * 8);
    
  end;
  
  
  procedure ButtonPosition2();//меняет параметры кнопок под основное окно
  begin
    if N_Window <> 2 then
    Prev_N_Window := N_Window;
    N_Window := 2;
    b1.Visible := True;
    b2_1.Visible := True;
    b3_1.Visible := True;
    b3_2.Visible := True;
    b2_2.Visible := True;
    b4.Visible := True;
    b5.Visible := False;
    b6.Visible := True;
  
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
    
    b4.Height := BHeight;
    b4.Width := BWidth + 55;
    b4.Position := (BWidth * 2 + 120, BHeight * 13 + 10);
    
    b5.Height := BHeight;
    b5.Width := BWidth + 55;
    b5.Position := (BWidth * 3 + 160, BHeight * 13 + 10);
    
    b6.Height := BHeight;
    b6.Width := BWidth + 45;
    b6.Position := (BWidth * 2 + 125 + b5.Width , BHeight * 13 + 10);
    
  end; //меняет параметры кнопок под основное окно
  

  procedure ButtonPosition3();
  begin
    b1.Visible := False;
    b2_1.Visible := False;
    b3_1.Visible := False;
    b3_2.Visible := False;
    b2_2.Visible := False;
    b4.Visible := False;
    b6.Visible := False;
    
    b5.Height := BHeight;
    b5.Width := BWidth + 55;
    b5.Position := (Window.Width - 3 - b5.Width, Window.Height - 3 - b5.Height);
  end;


end.