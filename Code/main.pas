program main;
uses GlobalTypes, FirstFileCheck, SecondFileCheck, ThirdFileCreation,
     InputDate;

var
  staff, catalog, need_to_attestate: text;
  tow: TableOfWorkers;
  toc: TableOfCatalog;
  toq: TableOfReq;
  sCounter_tow, sCounter_toc: byte;
  err1,err2: boolean;
  input_date: Date;
  yy, mm, dd: integer;

  
begin

assign(staff, 'Персонал.txt');
reset(staff);
FileStaffCheck(staff,tow,sCounter_tow,err1);
close(staff);

assign(catalog, 'Каталог.txt');
reset(catalog); 
FileCatalogCheck(catalog,toc,sCounter_toc,err2);
close(catalog);

if (err1 = false) and (err2 = false) then begin
  writeln('Введите год [2016..2017]');
  readln(yy);
  writeln('Введите месяц [1..12]');
  readln(mm);
  AskDay(yy, mm, dd);
  ReadInputDate(input_date, yy, mm, dd);
  PutToArray(tow, toc, input_date, toq, sCounter_tow, sCounter_toc);
  PrintInFile(toq, need_to_attestate);
end;
end.