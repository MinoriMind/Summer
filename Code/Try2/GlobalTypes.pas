unit GlobalTypes;


interface
  const maxcorrect = 100;

type
  Date = record
    day: byte;
    month: byte;
    year: byte;
  end;

  worker = record
    gender: char;
    profession: string[15];
    birth: Date;
    attestation: Date;
  end;

  catalog = record
    period: byte;
    profession: string[15];
  end;

  req_to_attestate = record
    month: byte;
    male: byte;
    fem: byte;
  end;
  
  
  TableOfWorkers = array [0..maxcorrect - 1] of worker;
  TableOfCatalog = array [0..maxcorrect - 1] of catalog;
  TableOfReq = array [0..maxcorrect - 1] of req_to_attestate;
  
  
  
implementation  

begin

end.
