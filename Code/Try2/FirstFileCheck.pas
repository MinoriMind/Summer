unit FirstFileCheck;

interface
  uses GlobalTypes;
  
  procedure File1Check (var f1: text;
                        var tow: TableOfWorkers);
                 

implementation


procedure File1Check (var f1:text;
                      var tow: TableOfWorkers);
var
  staff: text;
  s,ssave: string;
  sCounter, sRightCounter: integer;
  error: boolean;

  
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


function CheckInitials (var s:string; field:string) :boolean;
var F: string[2];
begin
F:=copy(s, 1, 2);
if (s[1] < 'A') or (s[1] > 'Я') or (s[2] <> '.') then begin
  result:=true;
if s[2] <> '.' then result:=true;
  writeln('(',sCounter,') ОШИБКА: ',field, F, 'должно ',
 'состоять из заглавной буквы русского алфавита и точки');
end;
delete(s, 1, 3); 
end;


function CheckGender (var s:string):boolean;
var F: char;
begin
F:=s[1];
if (F <> 'М') and (F <> 'Ж') then begin
  result:=true;
  writeln('(',sCounter,') ОШИБКА: Пол ', F, ' должен быть буквой М или Ж');
end;
delete(s, 1, 2);
end;


function CheckDate (var s:string; field:string):boolean;
 var day, month, year:string;
     dd, mm, yy: integer;
     var err: integer;
     F: string[10];
begin
F:=copy(s, 1, 10);
if (s[3] <> '/') or (s[6] <> '/') then begin
  result:=true;
  writeln('(',sCounter,') ОШИБКА: День, месяц и год рождения ', F, ' должны быть разделены символом ‘/’');
end
else begin
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
 if field = 'Рождения' then
   if (yy < 1950) or (yy > 2017) or (err<>0) then begin
      writeln('(',sCounter,') ОШИБКА: Год рождения ', F,
      ' должен быть в диапазоне [1950..2017]');
      result:=true; 
   end;
 if field = 'Аттестации' then
   if (yy < 2000) or (yy > 2017) or (err<>0) then begin
      writeln('(',sCounter,') ОШИБКА: Год аттестации ', F,
      ' должен быть в диапазоне [1900..2017]');
      result:=true; 
   end;
 if err <> 0 then result:=true;
  case mm of
   1, 3, 5, 7, 8, 10, 12: //31 день
   if (dd < 1) or (dd > 31) then begin
    result:=true;
    writeln('(',sCounter,') ОШИБКА: День аттестации ', F,
    ' должен быть в диапазоне [01..31]');
   end;
   4, 6, 9, 11: //30 дней
   if (yy mod 4 = 0) and (dd < 1) or (dd > 30) then begin
    result:=true;
    writeln('(',sCounter,') ОШИБКА: День аттестации ', F,
    ' должен быть в диапазоне [01..30]');
   end;
   2:
   begin
     if (yy mod 4 <> 0) and (dd < 1) or (dd > 29) then begin
      result:=true;
      writeln('(',sCounter,') ОШИБКА: День аттестации ', F,
      ' должен быть в диапазоне [01..29]');
     end;
     if (dd < 1) or (dd > 28) then begin
      result:=true;
      writeln('(',sCounter,') ОШИБКА: День аттестации ', F,
      ' должен быть в диапазоне [01..28]');
     end;
   end;
  end;
end;
end;

procedure PutToArray(ssave: string;var tow: TableOfWorkers);
var dd, mm, yy: string;
    day, mon, year: integer;
    err: integer;
begin
  tow[sRightCounter].gender:=ssave[1];
  delete(ssave, 1, 2);
  tow[sRightCounter].profession:=copy(ssave, 1, 15);
  delete(ssave, 1, 16);
  dd:=copy(ssave, 1, 2);
  val(dd, day, err);
  mm:=copy(ssave, 3, 2);
  val(mm, mon, err);
  yy:=copy(ssave, 3, 2);
  val(yy, year, err);
  tow[sRightCounter].birth.day:=day;
  tow[sRightCounter].birth.month:=mon;
  tow[sRightCounter].birth.year:=year;
  delete(ssave, 1, 11);
  dd:=copy(ssave, 1, 2);
  val(dd, day, err);
  mm:=copy(ssave, 3, 2);
  val(mm, mon, err);
  yy:=copy(ssave, 3, 2);
  val(yy, year, err);
  tow[sRightCounter].attestation.day:=day;
  tow[sRightCounter].attestation.month:=mon;
  tow[sRightCounter].attestation.year:=year;
  delete(ssave, 1, 11);
  delete(ssave, 1, 11);
end;


{function DateDifference(minuend, subtrahend: Date): boolean;
var dif: shortint;
begin
if (minuend.month > subtrahend.month) or 
  ((minuend.month = subtrahend.month) and (minuend.day >= subtrahend.day)) then
  dif:=minuend.year - subtrahend.year else
  dif:=minuend.year - subtrahend.year - 1;
if dif <=17 then begin
  writeln('(',sCounter,') ОШИБКА: Разница между датой рождения ',
          minuend, ') и датой аттестации' , subtrahend,' должна быть больше 17');
  result:=true;
end;
end;}


begin
  assign(staff, 'Персонал.txt');
  reset(staff);
  sRightCounter:=0;
  sCounter:=0;
  if Eof(staff) then writeln('Файл "Персонал" пуст') else begin
   writeln('Персонал..');
   while not EoF(staff) do
      begin
      	readln(staff, s);
      	sCounter:=sCounter + 1;
      	ssave:=copy(s, 23 , length(s));
      	//проверка на правильность структуры таблицы
      	if (copy(s,16,1) <> ' ') or (copy(s,19,1) <> ' ') or(copy(s,22,1) <> ' ')
      	or(copy(s,24,1) <> ' ') or (copy(s,40,1) <> ' ') or (copy(s,51,1) <> ' ')
      	then begin
      	writeln('(',sCounter,') ОШИБКА: Стрoка задана не табличным видом. ',
      	'В таблице 16, 19, 22, 24, 40, 51 символы должны являться пробелами');
      	error:=true;
      	end
      	else begin
      	if s = '' then writeln('Cтрока ', sCounter, ' пустая') else
      	begin
      	  if CheckName(s, 'Фамилия') = true then error:=true;
      	  if CheckInitials(s, 'Имя') = true then error:=true;
      	  if CheckInitials(s, 'Отчество') = true then error:=true;
      	  if CheckGender(s) = true then error:=true;
      	  if CheckName(s, 'Профессия') = true then error:=true;
      	  if CheckDate(s, 'Рождения') = true then error:=true;
      	  if CheckDate(s, 'Аттестации') = true then error:=true;
    //  	  if DateDifference(;{что-точто-то}) = true then error:=true;
      	  if error = false then begin
      	    sRightCounter:=sRightCounter + 1;
      	    PutToArray(ssave, tow);
      	  end;
      	end;
      end;
    end;
     if sRightCounter = 0 then
      writeln('Файл “Персонал” не содержит правильной информации');
  end;
    close(staff);
end;

begin

end.