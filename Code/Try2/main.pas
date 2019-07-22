program main;
uses GlobalTypes, FirstFileCheck, SecondFileCheck, ThirdFileCreation;

var
  staff, catalog: text;
  s,ssave: string;
  tow: TableOfWorkers;
  toc: TableOfCatalog;
  toq: TableOfReq;
  sCounter: integer;
  error: boolean;

  
begin
File1Check(staff,tow);
File2Check(catalog,toc);
end.