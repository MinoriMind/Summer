unit SecondFileCheck;

interface
  uses GlobalTypes;
  
  procedure File2Check (var f2: text;
                        var toc: TableOfCatalog);


implementation


procedure File2Check (var f2:text;
                      var toc: TableOfCatalog);
var
  catalog: text;
  s,ssave: string;
  sCounter: integer;
  error: boolean;
  
  
function CheckPeriod (var s:string):boolean;
var F: char;
begin
F:=s[1];
if (F < '1') or (F > '3') then begin
  result:=true;
  writeln('(',sCounter,') ОШИБКА: Аттестационный период ', F, ' должен быть ',
  'натуральным числом в диапазоне [1..3]');
end;
delete(s, 1, 2);
end;


function CheckName (var s:string; field:string):boolean;
var F: string[15];
begin
F:=copy(s, 1, 15);
if (copy(s, 1, 1) > 'Я') or (copy(s, 1, 1) < 'А')
  then result:=true;
for var i:=2 to (pos(' ',s) - 1) do begin
  if (copy(s, i, 1) > 'я') or (copy(s, i, 1) < 'а') then result:=true;
end;
if result = false then 
  for var i:=pos(' ', s) to 15 do begin
    if copy(s, i, 1) <> (' ') then result:=true;
  end;
if result = true then writeln('(',sCounter,') ОШИБКА: ',field,' ', F,' должна ',
 'начинаться с заглавной буквы, за которой следуют маленькие ',
 'буквы русского алфавита');
delete(s, 1, 16);
end;


procedure PutToArray(ssave: string);
begin
end;


begin
  assign(catalog, 'Каталог.txt');
  reset(catalog);
  sCounter:=0;
  if Eof(catalog) then writeln('Файл "Каталог" пуст') else begin
    writeln('Каталог..');
    while not EoF(catalog) do
    begin
    	readln(catalog, s);
    	sCounter:=sCounter + 1;
    	ssave:=copy(s, 1 , length(s));
    	//проверка на правильность структуры таблицы
    	if (copy(s,2,1) <> ' ') then begin
    	writeln('(',sCounter,') ОШИБКА: Второй символ должен быть пробелом');
    	error:=true;
    	end
    	else begin
    	if s = '' then writeln('Cтрока ', sCounter, ' пустая') else
    	begin
    	  if CheckPeriod(s) = true then error:=true;
    	  if CheckName(s, 'Профессия') = true then error:=true;
    	  if error = false then PutToArray(ssave);
    	end;
    end;
    end;
    end;
    close(catalog);
end;


begin

end.