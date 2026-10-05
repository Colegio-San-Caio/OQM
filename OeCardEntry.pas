unit OeCardEntry;

interface

type
  TPunchConfidence = (pcCertain, pcProbable, pcUncertain, pcUnknown);
  TRowSet = set of 0..12;

  { Raw binary punch buffer: 80 columns, each column represented by a 16-bit word }
  TBinaryPunchBuffer = array[1..80] of Word;

  TPunch = record
    Column: 1..80;
    Rows: TRowSet;
    Char: AnsiChar;
    Confidence: TPunchConfidence;
  end;

  TPunchArray = array of TPunch;

  TProvenance = record
    Origin: string;
    DateFrom: string;
    DateTo: string;
    Custodian: string;
  end;

  TCardDimensions = record
    HeightMM: Double;
    WidthMM: Double;
  end;

  TCardEntry = record
    ObjectId: string;
    ObjectType: string;
    Dimensions: TCardDimensions;
    Material: string;
    Color: string;
    CornerCut: string;
    RowCount: Integer;
    ColumnCount: Integer;
    PrintedText: array of string;
    Punches: TPunchArray;
    BinaryBuffer: TBinaryPunchBuffer;
    Provenance: TProvenance;
    Condition: string;
    Notes: array of string;
    Uncertainty: array of string;
  end;

function CardEntryToXml(const Entry: TCardEntry): string;
function XmlToCardEntry(const Xml: string): TCardEntry;
function ValidateCardEntry(const Entry: TCardEntry): Boolean;
function DecodePunch(const Punch: TPunch): AnsiChar;

procedure BufferToCardEntry(const Buffer: TBinaryPunchBuffer; var Entry: TCardEntry);
function CardEntryToBuffer(const Entry: TCardEntry): TBinaryPunchBuffer;

implementation

procedure BufferToCardEntry(const Buffer: TBinaryPunchBuffer; var Entry: TCardEntry);
var
  col: Integer;
  r: Integer;
begin
  Entry.RowCount := 12;
  Entry.ColumnCount := 80;
  SetLength(Entry.Punches, 80);
  
  for col := 1 to 80 do
  begin
    Entry.BinaryBuffer[col] := Buffer[col];
    Entry.Punches[col-1].Column := col;
    Entry.Punches[col-1].Rows := [];
    
    for r := 0 to 12 do
    begin
      if (Buffer[col] and (1 shl r)) <> 0 then
        Include(Entry.Punches[col-1].Rows, r);
    end;
    Entry.Punches[col-1].Confidence := pcCertain;
    Entry.Punches[col-1].Char := #0;
  end;
end;

function CardEntryToBuffer(const Entry: TCardEntry): TBinaryPunchBuffer;
var
  col: Integer;
  r: Integer;
  i: Integer;
begin
  for col := 1 to 80 do
    Result[col] := 0;

  for i := Low(Entry.Punches) to High(Entry.Punches) do
  begin
    col := Entry.Punches[i].Column;
    if (col >= 1) and (col <= 80) then
    begin
      for r := 0 to 12 do
      begin
        if r in Entry.Punches[i].Rows then
          Result[col] := Result[col] or (1 shl r);
      end;
    end;
  end;
end;

function CardEntryToXml(const Entry: TCardEntry): string;
begin
  Result := '<CardEntry id="' + Entry.ObjectId + '"/>';
end;

function XmlToCardEntry(const Xml: string): TCardEntry;
begin
  { Stub implementation }
end;

function ValidateCardEntry(const Entry: TCardEntry): Boolean;
begin
  Result := (Entry.ColumnCount = 80) and (Entry.RowCount = 12);
end;

function DecodePunch(const Punch: TPunch): AnsiChar;
begin
  Result := Punch.Char;
end;

end.
