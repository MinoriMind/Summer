unit GlobalTypes;


interface
  const maxcorrect = 100;

type
  Date = record
    day: shortint;
    month: shortint;
    year: smallint;
  end;

  worker = record
    gender: char;
    profession: string[15];
    birth: Date;
    attestation: Date;
    time_to_attestate: Date;
  end;

  catalog = record
    period: byte;
    profession: string[15];
  end;

  req_to_attestate = record
    month: byte;
    year: integer;
    male: byte;
    fem: byte;
  end;
  
  
  
  
  TableOfWorkers = array [1..maxcorrect] of worker;
  TableOfCatalog = array [1..maxcorrect] of catalog;
  TableOfReq = array [0..12] of req_to_attestate;
  
  
implementation  

begin

end.
