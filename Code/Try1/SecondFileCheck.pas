unit SecondFileCheck;


uses GlobalTypes, FirstFileCheck;


interface
  uses GlobalTypes;
  procedure CheckingFile2();


implementation
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


function CheckPeriod (var s:string; field:string):boolean;
begin
if 








end;











procedure CheckingFile();
begin
 assign(f, 'Input.txt');
  reset(f);
  sCounter:=0;
  if Eof(f) then writeln('Файл "Персонал" пуст');
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
//  if error = false then writeln('Нет ошибок');
  close(f);
end;

begin
 CheckingFile();
end.