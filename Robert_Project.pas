program Project_Robert;
uses GraphABC, Events;
var
N_Window, check, dif, n, b  : integer;
endofgame : boolean;
procedure MouseDown(x,y,mb:integer);
begin
  if (mb = 1) and (x < 470) and (y < 100) then check := 1;
  if (mb = 1) and ((x < 470) and (y < 205)) and ((x > 10) and (y > 105)) then check := 2;
  if (mb = 1) and ((x < 470) and (y < 305)) and ((x > 10) and (y > 210)) then check := 3;
  if (mb = 1) and ((x < 470) and (y < 415)) and ((x > 10) and (y > 315)) then check := 4;
end; 
 
procedure FirstWindow();
begin
  SetWindowSize(480, 600); // (1366, 705)
    SetWindowLeft(ScreenWidth div 2 - 240);
    SetWindowTop(10);
    setpenwidth(2);
    rectangle(10, 5, 470 , 100);
    setfontsize(20);
    textout(20, 25, 'Задать сложность графа от 1 до 5');
    textout(20, 65,'Сейчас:');
    textout(140, 65, inttostr(dif));
    rectangle(10, 105, 470 , 205);
    textout(20, 130, 'Задать колличетво генераций');
    textout(20, 170,'Сейчас:');
    textout(140, 170, inttostr(n));
    setFontcolor(color.Red);
    setfontsize(30);
    rectangle(10, 210, 470 , 305);
    textout(20, 235, 'Сгенерировать');
    setFontcolor(color.black);
    rectangle(10, 315, 470 , 415);
    textout(20, 340, 'Помощь'); //2
    setfontsize(20);
end; 
 
begin
  N_Window := 1;
  dif := 1;
  n := 1;
  endofgame := false;
  onmousedown := MouseDown;
  check := 0;
  
  FirstWindow();
  
    while N_Window = 1 do
    begin 
      if check = 1 then 
      begin
        read(dif);
        check := 0;
        textout(140, 65, inttostr(dif));
      end;
      if check = 2 then
      begin
        read(n);
        check := 0;
        textout(140, 170, inttostr(n));
      end;
      if check = 3 then N_Window := 2;
      if check = 4 then N_Window := 3;
    end;
    
    check := 0;
    SetWindowSize(1000, 600); // (1366, 705)
    Window.clear();
    SetWindowLeft(ScreenWidth div 2 - 500);
    SetWindowTop(10);    
    setpenwidth(2);
    rectangle(0, 0, 200, 100);
    while N_Window = 2  do
end.