unit SecondFileCheck;

interface
  uses GlobalTypes, FirstFileCheck;
  
  procedure FileCatalogCheck (var catalog: text;
                              var toc: TableOfCatalog;
                              var sRightCounter_Staff: byte;
                              var err2: boolean);


implementation


procedure FileCatalogCheck (var catalog: text;
                            var toc: TableOfCatalog;
                            var sRightCounter_Staff: byte;
                            var err2: boolean);
var
  toi: TableOfCatalog;
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


function CheckIndividuality(ssave: string; sCounter: integer; var toi: TableOfCatalog): boolean;
var period: char;
    p: byte;
    err: integer;
    warning: boolean;
begin
period:=ssave[1];
val(period, p, err);
toi[sCounter].period:=p;
delete(ssave, 1, 2);
if pos(' ', ssave) > 1 then
  toi[sCounter].profession:=copy(ssave, 1, pos(' ', ssave) - 1)
else
  toi[sCounter].profession:=copy(ssave, 1, 15);
if sCounter > 1 then
  for var i:=1 to sCounter do
    if (i <> sCounter) and ((toi[i].profession = toi[sCounter].profession) and
    (toi[sCounter].period <> toi[i].period)) then result:=true;
if sCounter > 1 then
  for var i:=1 to sCounter do
    if (i <> sCounter) and ((toi[i].profession = toi[sCounter].profession) and
    (toi[sCounter].period = toi[i].period)) then warning:=true;
if warning = true then writeln('(',sCounter,') ПРЕДУПРЕЖДЕНИЕ: Профессия ',
  toi[sCounter].profession,' повторяется с одинаковым аттестационным периодом');
if result = true then writeln('(',sCounter,') ОШИБКА: Профессия ',
  toi[sCounter].profession,' повторяется с разным аттестационным периодом');
end;


procedure PutToArray(ssave: string; sRightCounter_Staff: integer; var toc: TableOfCatalog);
var period: char;
    p: byte;
    err: integer;
begin
period:=ssave[1];
val(period, p, err);
  toc[sRightCounter_Staff].period:=p;
delete(ssave, 1, 2);
if pos(' ', ssave) > 1 then
  toc[sRightCounter_Staff].profession:=copy(ssave, 1, pos(' ', ssave) - 1)
else
  toc[sRightCounter_Staff].profession:=copy(ssave, 1, 15);
end;


begin
  sCounter:=0;
  sRightCounter_Staff:=0;
  if Eof(catalog) then begin
    writeln('Файл "Каталог" пуст');
    err2:=true
  end
  else begin
    writeln('Каталог..');
    while not EoF(catalog) do
    begin
      error:=false;
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
    	  if CheckIndividuality(ssave, sCounter, toi) = true then error:=true;
    	  if error = false then begin
    	    sRightCounter_Staff:=sRightCounter_Staff + 1;
    	    PutToArray(ssave, sRightCounter_Staff, toc);
    	  end;
      end;
    end;
    if sRightCounter_Staff > maxcorrect then writeln('ПРЕДУПРЕЖДЕНИЕ: файл ',
     '“Каталог” содержит больше 100 правильных строк');
    if sRightCounter_Staff = 0 then begin
      writeln('Файл “Каталог” не содержит правильной информации');
      err2:=true;
    end;
  end;
end;


begin

end.