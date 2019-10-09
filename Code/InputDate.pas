unit InputDate;

interface
uses GlobalTypes;
procedure ReadInputDate(var input_date: Date; yy, mm, dd:integer);
procedure AskDay(yy, mm, dd: integer);

implementation
procedure AskDay(yy, mm, dd: integer);
begin
case mm of
   1, 3, 5, 7, 8, 10, 12: //31 день
   begin
     writeln('Введите день [1..31]');
     readln(dd);
     while (dd < 1) or (dd > 31) do begin
      writeln('Введите день [1..31]');
      readln(dd);
     end;
   end;
   4, 6, 9, 11: //30 дней
   begin
     writeln('Введите день [1..30]');
     readln(dd);
     while (dd < 1) or (dd > 30) do begin
      writeln('Введите день [1..30]');
      readln(dd);
    end;
   end;
   2:
   begin
     if yy mod 4 = 0 then begin
       writeln('Введите день [1..29]');
       readln(dd);
       while (dd < 1) or (dd > 29) do begin
        writeln('Введите день [1..30]');
        readln(dd);
       end;
     end else begin
       writeln('Введите день [1..28]');
       readln(dd);
       while (dd < 1) or (dd > 29) do begin
        writeln('Введите день [1..28]');
        readln(dd);
       end;
     end;
  end;
end;

end;


procedure ReadInputDate(var input_date: Date; yy, mm, dd:integer);
begin
while (yy < 2016) or (yy > 2017) do begin
  writeln('Введите год [2016..2017]');
  readln(yy);
end;
while (mm < 1) or (mm > 12) do begin
  writeln('Введите месяц [1..12]');
  readln(mm);
end;
input_date.day:=dd;
input_date.month:=mm;
input_date.year:=yy;
end;


begin

end.