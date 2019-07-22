unit GlobalTypes;

interface
  const max_cor_lines = 100;
  
    
type
  Date = record
    day: shortint;
    month: shortint;
    year: smallint;
  end;
  
  worker = record
    secondName: string[15];
    name: char;
    fatherName: char;
    gender: char;
    profession: string[15];
    birth: Date;
    certification: Date;
  end;
  
  catalog = record
    period: byte;
    profession: string[15];
  end;
  
  req_pass = record
    time: byte;
    numman: byte;
    numweman: byte;
  end;
  


implementation


begin


end.