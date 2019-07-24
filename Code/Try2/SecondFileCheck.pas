unit SecondFileCheck;

interface
  uses GlobalTypes, FirstFileCheck;
  
  procedure File2Check (var f2: text;
                        var toc: TableOfCatalog);


implementation


procedure File2Check (var f2:text;
                      var toc: TableOfCatalog);
var
  catalog: text;
  s,ssave: string;
  sCounter, sRightCounter: integer;
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




procedure PutToArray(ssave: string; sRightCounter: integer);
var period: char;
    p: byte;
    err: integer;
begin
period:=ssave[1];
val(period, p, err);
  toc[sRightCounter].period:=p;
if pos(' ', ssave) > 3 then
  toc[sRightCounter].profession:=copy(ssave, 3, pos(' ', ssave) - 1)
else
  toc[sRightCounter].profession:=copy(ssave, 3, 15);
end;


begin
  assign(catalog, 'Каталог.txt');
  reset(catalog);
  sCounter:=0;
  sRightCounter:=0;
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
    	  if CheckPeriod(s) = true then error:=true;
    	  if CheckName(s, 'Профессия', sCounter) = true then error:=true;
    	  if error = false then begin
    	    sRightCounter:=sRightCounter + 1;
    	    PutToArray(ssave, sRightCounter);
    	  end;
      end;
    end;
    if sRightCounter = 0 then
      writeln('Файл “Каталог” не содержит правильной информации');
  end;
  close(catalog);
end;


begin

end.