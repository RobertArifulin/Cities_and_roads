unit Describe;// здесь описаны все переменные, типы и константы
const
   BWidth = 194; // длинна кнопки в основном окне
   BHeight = 50; // высота кнопки в основном окне
   Cell_size = 70; // сторона клеток в основном окне
   r = 25; //радиус вершины
   // new com master
type
 ClassVertex = class // класс вершиина
 private
 
 public
  _Name : string;
  _Val, _MinWayVal, _PrevVal, _NewMinWayVal : integer;
 end;  

var
 // new com 2
  Graph : array of array of ClassVertex; // граф - массив вершин
  Way,  New_Way, Current_Way, Second_way, SecondWayVertex : array of string; // путь
  f : text := new Text ;
  f1 : text;
  s : string;
  ManyWays : boolean;
  N_Window, dif, n, GraphWidth, GraphHeight,Prev_N_Window, FileName, FileSession, GoLeft, GoUp: integer;
  // new com current_new_branch
end.