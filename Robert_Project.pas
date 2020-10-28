program Project_Robert; //основная программа

uses GraphABC, ABCButtons, Draw, Describe, Button, SaveGraph;
 
begin
  
  
  b5.Visible := False;
  b4.Visible := True;
  b6.Visible := False;
  FileName := 1;
  FileSession := 1;
  N_Window := 1; //  какое окно открыто
  Prev_N_Window := 1;
  dif := 1; //  выбранную сложность графа
  n := 1; //  колличество генераций
  GraphWidth := (6 + dif mod 2); // длинна графа
  GraphHeight := (2 + dif);// высота графа
  
  FirstWindow();
  Textout1();
  
  b1.OnClick := procedure -> // нажатие на кнопку сгенерировать перемещает все кнопки
  begin
    b1_OnClick();
  end;
  
  
  b2_1.OnClick := procedure -> // увеличивает сложность, при нажатии
  begin
    b2_1_OnClick();
  end;
  
  
  b3_1.OnClick := procedure ->// уменьшает кол-во генераций, при нажатии
  begin
    b3_1_OnClick();
  end;
  
  
   b2_2.OnClick := procedure ->// увеличивает сложность, при нажатии
  begin
    b2_2_OnClick();
  end;
  
  
  b3_2.OnClick := procedure ->// уменьшает кол-во генераций, при нажатии
  begin
    b3_2_OnClick();
  end;


  b4.OnClick := procedure ->
  begin
    b4_OnClick();
  end;
  
  b5.OnClick := procedure ->
  begin
    b5_OnClick();
  end;
  
  b6.OnClick := procedure ->
  begin
    b6_OnClick();
  end;
  
end.