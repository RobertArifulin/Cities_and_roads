﻿program Project_Robert;

uses GraphABC, ABCButtons, Draw, Describe, Button, SaveGraph;
 
begin
  FileName := 1;
  FileSession := 1;
  N_Window := 1; //  какое окно открыто
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

end.