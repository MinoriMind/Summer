unit ThirdFileCreation;

interface
  uses GlobalTypes, FirstFileCheck, SecondFileCheck;

  procedure PrintInFile(toq: TableOfReq; f: text);
  
  procedure PutToArray(tow: TableOfWorkers; var toc: TableOfCatalog; 
                     input_date: Date;var toq: TableOfReq;
                     sCounter_tow:integer;
                     sCounter_toc:integer);


implementation

procedure PrintInFile(toq: TableOfReq; f: text);
begin
for var i:=0 to 12 do
if (toq[i].male <> 0) or (toq[i].fem <> 0) then
  writeln(toq[i].year, ' год, ',toq[i].month, ' месяц. Количество мужчин: ', toq[i].male,
  ' Количество женщин: ', toq[i].fem);
end;
//будет выводить массива в файл




function Date1less2 (var first: Date;var second: Date): boolean;
//true если 1 дата меньше 2-й
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


procedure PutToArray(tow: TableOfWorkers;var toc: TableOfCatalog; 
                     input_date: Date; var toq: TableOfReq;
                     sCounter_tow: integer;
                     sCounter_toc: integer);
var i, j: byte;
    //timetoattestate: Date; //время когда нужно пройти аттестацию
    minS_tow, minS_toc: shortint;
    dif_timeinmonth: shortint; //индексация массива toq
    input_timeinmonth,tta_timeinmonth: integer; //tta - timetoattestate
begin

if input_date.day > 1 then begin
  input_date.day:=1;
  input_date.month:=input_date.month + 1;
end;

input_timeinmonth:=input_date.year * 12 + input_date.month; //переводит дату в месяц
if sCounter_tow <= maxcorrect then
  minS_tow:=sCounter_tow 
else minS_tow:=maxcorrect;
if sCounter_toc <= maxcorrect then 
  minS_toc:=sCounter_toc 
else minS_toc:=maxcorrect;
for i:=1 to minS_tow do
begin
  for j:=1 to minS_toc do
  //смотреть первую строку 1-го массива, и бегать по второму, если найдено то составляем массив
  begin
    if (tow[i].profession = toc[j].profession) then begin
      //если пришло время аттестаровиться: год аттестации + пероид > указанной даты
      tow[i].time_to_attestate.year:=tow[i].attestation.year + toc[j].period;
      tta_timeinmonth:=tow[i].time_to_attestate.year * 12 + tow[i].attestation.month;
      dif_timeinmonth:=tta_timeinmonth - input_timeinmonth;
      //переводит дату в месяц
      if (dif_timeinmonth >= 0) and (dif_timeinmonth <= 12) then begin
          toq[dif_timeinmonth].year:=tta_timeinmonth div 12;
          toq[dif_timeinmonth].month:=tta_timeinmonth - toq[dif_timeinmonth].year * 12;
          if tow[i].gender = 'М' then 
            toq[dif_timeinmonth].male:=toq[tow[i].attestation.month].male + 1 else
          toq[dif_timeinmonth].fem:=toq[tow[i].attestation.month].fem + 1;
       end;
    end;
  end;
end;
end;

begin

end.