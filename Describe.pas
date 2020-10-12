unit Describe; // в нем описаны все переменные
const
   BWidth = 194; // длинна кнопки в основном окне
   BHeight = 50; // высота кнопки в основном окне
   Cell_size = 70; // сторона клеток в основном окне
   r = 25; //радиус вершины
   
type
 ClassVertex = class // класс вершиина
 private
 
 public
  _name : string;
  _val, _MinWayVal : integer;
 end;  

var
  Graph : array of array of ClassVertex; // граф - массив вершин
  Way : array of string; // путь
  f : text := new Text ;
  N_Window, dif, n, GraphWidth, GraphHeight,Prev_N_Window, FileName, FileSession: integer;
end.