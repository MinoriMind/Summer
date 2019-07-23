unit ThirdFileCreation;

interface
  uses GlobalTypes, FirstFileCheck, SecondFileCheck;

  procedure PrintInFile (toq: TableOfReq);


implementation
procedure PrintInFile (toq: TableOfReq);
var i: byte;
begin
while (i <= maxcorrect) and (toq[i].month <> 0) do begin 
  write(toq[i].month);
  write(toq[i].male);
  write(toq[i].fem);
  i:=i + 1;
end;
end;
//будет выводить массива в файл

function Date1less2 (var first, second: Date): boolean;
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


procedure PutToArray(tow: TableOfWorkers; toc: TableOfCatalog; 
                     input_date: Date; sRightCounter: integer);
var toq: TableOfReq;
    i, j: byte;
    attestate, dateint: Date;
    day, month: string;
    foundperiod: boolean;
begin
i:=0;
while (i <= 12) and (tow[i].gender <> '') do
begin
  foundperiod:=false;
  j:=0;
  while (j < maxcorrect) and (foundperiod = false) do
  begin
    if (tow[i].profession = toc[j].profession) then begin
      foundperiod:=true;
      //если пришло время аттестаровиться: год аттестации + пероид > указанной даты
      attestate.year:=tow[i].attestation.year + toc[j].period;
      if Date1less2(attestate, dateint) = true then begin
          toq[i].month:=tow[i].attestation.month;
          if tow[i].gender = 'М' then toq[i].male:=toq[i].male + 1 else
          toq[i].fem:=toq[i].fem + 1;
       end;
       j:=j + 1; 
    end;
  end;
end;
i:=i + 1;
end;

begin

end.