program main;
uses GlobalTypes, FirstFileCheck, SecondFileCheck, ThirdFileCreation,
     InputDate;

var
  staff, catalog: text;
  s,ssave: string;
  tow: TableOfWorkers;
  toc: TableOfCatalog;
  toq: TableOfReq;
  sCounter: integer;
  error: boolean;
  input_date: Date;

  
begin
ReadInputDate(input_date);
File1Check(staff,tow);
File2Check(catalog,toc);
PutToArray(tow, toc, input_date);
//PrintInFile(toq);
writeln(toq[1].month);
end.