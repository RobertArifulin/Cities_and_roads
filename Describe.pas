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
  _name : string;
  _val, _MinWayVal, _PrevVal : integer;
 end;  

var
 // new com 2
  Graph : array of array of ClassVertex; // граф - массив вершин
  Way, Interesting_Way, Current_Way : array of string; // путь
  f : text := new Text ;
  N_Window, dif, n, GraphWidth, GraphHeight,Prev_N_Window, FileName, FileSession: integer;
  // new com current_new_branch
end.