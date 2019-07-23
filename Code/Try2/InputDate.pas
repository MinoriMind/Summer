unit InputDate;

interface
uses GlobalTypes;
procedure ReadInputDate(var inputdate: Date);

implementation

procedure ReadInputDate(var inputdate: Date);
var yy, mm, dd:integer;
begin
writeln('Введите год [2016..2017]');
readln(yy);
while (yy < 2016) or (yy > 2017) do begin
  writeln('Введите год [2016..2017]');
  readln(yy);
end;
writeln('Введите месяц [1..12]');
readln(mm);
while (mm < 1) or (mm > 12) do begin
  writeln('Введите месяц [1..12]');
  readln(mm);
end;
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


begin

end.