unit FirstFileCheck;

interface
  uses GlobalTypes;
  
  procedure FileStaffCheck (var staff: text;
                        var tow: TableOfWorkers;var sRightCounter_Staff: byte;
                        var err1: boolean);
  function CheckName (var s:string; field:string; sCounter: integer):boolean;

implementation

function CheckName (var s:string; field:string; sCounter: integer):boolean;
var F: string[15];
begin
F:=copy(s, 1, 15);
if (copy(s, 1, 1) > 'Я') or (copy(s, 1, 1) < 'А')
  then result:=true;
for var i:=2 to (pos(' ',s) - 1) do begin
  if (copy(s, i, 1) > 'я') or (copy(s, i, 1) < 'а') then result:=true;
end;
if result = true then writeln('(',sCounter,') ОШИБКА: ',field,' ', F,' должна ',
 'начинаться с заглавной буквы, за которой следуют маленькие ',
 'буквы русского алфавита');
delete(s, 1, 16);
end;

  procedure FileStaffCheck (var staff: text;
                        var tow: TableOfWorkers;var sRightCounter_Staff: byte;
                        var err1: boolean);
var
  s,ssave: string;
  sCounter: integer;
  error: boolean;

  
function Date1less2 (var first, second: Date):boolean;
//true если 1-я дата меньше 2-й
begin
if first.year > second.year then result:=false;
if first.year < second.year then result:=true;
if first.year = second.year then begin
  if first.month > second.month then result:=false;
  if first.month < second.month then result:=true;
  if first.month = second.month then begin
    if first.day > second.day then result:=false;
    if first.day < second.day then result:=true;
    if first.day = second.day then result:=false;
  end;
end;
end;


function CheckInitials (var s:string; field:string):boolean;
var F: string[2];
begin
F:=copy(s, 1, 2);
if (s[1] < 'А') or (s[1] > 'Я') then begin
  result:=true;
if s[2] <> '.' then result:=true;
if result = true then writeln('(',sCounter,') ОШИБКА: ',field, F, 'должно ',
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
     Fd, Fm: string[2];
     Fy: string[4];
begin
F:=copy(s, 1, 10);
Fd:=copy(s, 1, 2);
Fm:=copy(s, 4, 2);
Fy:=copy(s, 7, 4);
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
  writeln('(',sCounter,') ОШИБКА: Месяц ', field ,
  Fm, ' должен быть в диапазоне [1..12]');
  result:=true;
 end;
 //проверка года
 val(year, yy, err);
 if field = 'рождения' then
   if (yy < 1950) or (yy > 2017) or (err<>0) then begin
      writeln('(',sCounter,') ОШИБКА: Год рождения ', Fy,
      ' должен быть в диапазоне [1950..2017]');
      result:=true; 
   end;
 if field = 'аттестации' then
   if (yy < 2000) or (yy > 2017) or (err<>0) then begin
      writeln('(',sCounter,') ОШИБКА: Год аттестации ', Fy,
      ' должен быть в диапазоне [1900..2017]');
      result:=true; 
   end;
 if err <> 0 then result:=true;
  case mm of
   1, 3, 5, 7, 8, 10, 12: //31 день
   if (dd < 1) or (dd > 31) then begin
    result:=true;
    writeln('(',sCounter,') ОШИБКА: День ', field ,' ', Fd,
    ' должен быть в диапазоне [01..31]');
   end;
   4, 6, 9, 11: //30 дней
   if (yy mod 4 = 0) and (dd < 1) or (dd > 30) then begin
    result:=true;
    writeln('(',sCounter,') ОШИБКА: День ', field ,' ', Fd,
    ' должен быть в диапазоне [01..30]');
   end;
   2:
   begin
     if (yy mod 4 <> 0) and (dd < 1) or (dd > 29) then begin
      result:=true;
      writeln('(',sCounter,') ОШИБКА: День ', field ,' ', Fd,
      ' должен быть в диапазоне [01..29]');
     end;
     if (dd < 1) or (dd > 28) then begin
      result:=true;
      writeln('(',sCounter,') ОШИБКА: День ', field ,' ', Fd,
      ' должен быть в диапазоне [01..28]');
     end;
   end;
  end;
if (result = false) and ((F[3] <> '/') or (F[6] <> '/')) then begin
  result:=true;
  writeln('(',sCounter,') ОШИБКА: День, месяц и год ', field , ' ',
  F, ' должны быть разделены символом ‘/’');
end;
end;


procedure PutToArray(ssave: string; var tow: TableOfWorkers;
                     sRightCounter: integer);
var dd, mm, yy: string;
    day, mon, year: integer;
    err: integer;
begin
if (sRightCounter < 100) then begin
  tow[sRightCounter].gender:=ssave[1];
  delete(ssave, 1, 2);
  tow[sRightCounter].profession:=copy(ssave, 1, pos(' ', ssave) - 1);
  delete(ssave, 1, 16);
  dd:=copy(ssave, 1, 2);
  val(dd, day, err);
  mm:=copy(ssave, 4, 2);
  val(mm, mon, err);
  yy:=copy(ssave, 7, 4);
  val(yy, year, err);
  tow[sRightCounter].birth.day:=day;
  tow[sRightCounter].birth.month:=mon;
  tow[sRightCounter].birth.year:=year;
  delete(ssave, 1, 11);
  dd:=copy(ssave, 1, 2);
  val(dd, day, err);
  mm:=copy(ssave, 4, 2);
  val(mm, mon, err);
  yy:=copy(ssave, 7, 4);
  val(yy, year, err);
  tow[sRightCounter].attestation.day:=day;
  tow[sRightCounter].attestation.month:=mon;
  tow[sRightCounter].attestation.year:=year;
  delete(ssave, 1, 11);
end;
end;


function DateDifference(minuend, subtrahend: Date): boolean;
var dif: shortint;
begin
if Date1less2(subtrahend, minuend) then begin
  if (minuend.month > subtrahend.month) or 
    ((minuend.month = subtrahend.month) and (minuend.day >= subtrahend.day)) then
    dif:=minuend.year - subtrahend.year else
    dif:=minuend.year - subtrahend.year - 1;
  if dif <=17 then begin
    writeln('(',sCounter,') ОШИБКА: Разница между датой рождения ',
            minuend, ' и датой аттестации' , subtrahend,' должна быть больше 17');
    result:=true;
end;
end;
end;


function TakeDate(ssave: string): boolean;
var attestation, birth: string[10];
    atd, atm, brd, brm: string[2]; //день, месяц аттестации, рождения
    aty, bry: string[4]; //год
    atDate, brDate: Date;
    err: integer;
begin
birth:=copy(ssave, 19, 10);
attestation:=copy(ssave, 30, 10);
brd:=copy(birth, 1, 2);
brm:=copy(birth, 4, 2);
bry:=copy(birth, 7, 4);
val(brd, brDate.day, err);
val(brm, brDate.month, err);
val(bry, brDate.year, err);
atd:=copy(attestation, 1, 2);
atm:=copy(attestation, 4, 2);
aty:=copy(attestation, 7, 4);
val(atd, atDate.day, err);
val(atm, atDate.month, err);
val(aty, atDate.year, err);
if DateDifference(atDate, brDate) = true then result:=true;
end;


begin
  sRightCounter_Staff:=0;
  sCounter:=0;
  if Eof(staff) then begin
    writeln('Файл "Персонал" пуст');
    err1:=error;
  end
  else begin
   writeln('Персонал..');
   while not EoF(staff) do
      begin
        error:=false;
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
      	  if CheckName(s, 'Фамилия', sCounter) = true then error:=true;
      	  if CheckInitials(s, 'Имя') = true then error:=true;
      	  if CheckInitials(s, 'Отчество') = true then error:=true;
      	  if CheckGender(s) = true then error:=true;
      	  if CheckName(s, 'Профессия', sCounter) = true then error:=true;
      	  if CheckDate(s, 'рождения') = true then error:=true;
      	  if CheckDate(s, 'аттестации') = true then error:=true;
          if error = false then 
            if TakeDate(ssave) = true then error:=true;
      	  if error = false then begin
      	    sRightCounter_Staff:=sRightCounter_Staff + 1;
      	    PutToArray(ssave, tow, sRightCounter_Staff);
      	  end;
      	end;
      end;
    end;
     if sRightCounter_Staff > maxcorrect then writeln('ПРЕДУПРЕЖДЕНИЕ: файл ',
     '“Персонал” содержит больше 100 правильных строк');
     if sRightCounter_Staff = 0 then begin
      writeln('Файл “Персонал” не содержит правильной информации');
      err1:=true;
     end;
  end;
end;

begin

end.