type
  Date = record
    day: byte;
    month: byte;
    year: byte;
  end;


type
  worker = record
    secondName: string[15];
    name: char;
    fatherName: char;
    gender: char;
    profession: string[15];
  end;


var
  f: text;
  s: string;
  person: worker;
  sCounter: integer;
  error: boolean;

  
function CheckName (var s:string; field:string):boolean;
begin
if (copy(s, 1, 1) > 'Я') or (copy(s, 1, 1) < 'А')
  then result:=true;

for var i:=2 to length(person.secondName) do
  while copy(s,i,1) <> ' ' do
    if (copy(s,i,1) > 'я') or (copy(s,i,1) < 'а')
    then result:=true;

if result = true then writeln('Ошибка в ', field, ', строка ', sCounter);
delete(s, 1, 17);
end;


function CheckDate (var s:string; field:string):boolean;
 var day, month, year:string;
     dd, mm, yy: integer;
     var err: integer;
begin
 day:=copy(s, 1, 2);
 delete(s, 1, 3);
 month:=copy(s, 1, 2);
 delete(s, 1, 3);
 year:=copy(s, 1, 4);
 delete(s, 1, 5);
 val(day, dd, err);
 //проверка месяца
 val(month, mm, err);
 if (mm <= 0) or (mm > 12) or (err<>0) then begin
  writeln('Ошибка в месяце ', field, ', строка ', sCounter);
  result:=true;
 end;
 //проверка года
 val(year, yy, err);
 if (yy < 0) or (yy > 2019) or (err<>0) then begin
    writeln('Ошибка в году ', field, ', строка ', sCounter);
    result:=true;
 end;
 if err <> 0 then result:=true;
 if result = false then
 begin
  case mm of
   1, 3, 5, 7, 8, 10, 12: 
   if dd > 31 then result:=true;//31 день
   4, 6, 9, 11: 
   if dd > 30 then result:=true;//30 дней
   2:
   if dd > 28 then result:=true;
  end;
 //февраль високосного года
  if (((yy mod 4 = 0) and (yy mod 100 <> 0)) or (yy mod 400 = 0))
  and (error = false) then //если год високостный и нет ошибок
  if (mm = 2) and (dd > 29) then result:=true;
  end;
if result = true then
  writeln ('Ошибка в строке, ', sCounter, ', несоответствие дня и месяца ', field);
end;


begin
  assign(f, 'Input.txt');
  reset(f);
  sCounter:=0;
  if Eof(f) then writeln('В файле ничего нет');
  while not EoF(f) do
  begin
  	readln(f, s);
  	sCounter:=sCounter + 1;
  	//проверка на правильность структуры таблицы
  	if (copy(s,16,1) <> ' ') or (copy(s,19,1) <> ' ') or(copy(s,22,1) <> ' ')
  	or(copy(s,24,1) <> ' ') or (copy(s,40,1) <> ' ') or (copy(s,51,1) <> ' ')
  	then begin
  	writeln('Стрoка ',sCounter ,' задана не табличным видом');
  	error:=true;
  	end
  	else begin
  	if s = '' then writeln('Cтрока ', sCounter, ' пустая') else
  	begin
  	  if CheckName(s, 'фамилии') = true then error:=true;
  	 delete(s, 1, 23);
  	 if CheckDate(s, 'рождения') = true then error:=true;
  	 if CheckDate(s, 'аттестации') = true then error:=true;
  	end;
  end;
  end;
  if error = false then writeln('Нет ошибок');
  close(f);
end.
