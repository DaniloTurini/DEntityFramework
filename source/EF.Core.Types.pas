{*******************************************************}
{         Copyright(c) Lindemberg Cortez.               }
{              All rights reserved                      }
{         https://github.com/LinlindembergCz            }
{		Since 01/01/2019                        }
{*******************************************************}
unit EF.Core.Types;

interface

uses
   SysUtils, strUtils, RTTI, EF.Core.Functions;

type
  TString = record
  private
    FValue: string;
    FAs: string;
    FInContext: boolean;
    FColumn: string;
    procedure SetInContext(const Value: boolean);
    procedure SetColumn(const Value: string);
  public
    procedure SetAs(const Value: string);
    procedure SetValue(const Value: string);
    class operator Equal(const a: TString; const b: TString): TString; overload;
    class operator Equal(const a: TString; b: string): TString; overload;
    class operator NotEqual(const a: TString; const b: TString): TString; overload;
    class operator NotEqual(const a: TString; b: string): TString; overload;
    class operator LogicalAnd(a: TString; b: TString): TString; overload;
    class operator LogicalAnd(a: TString; b: string): TString; overload;
    class operator LogicalOr(a: TString; b: TString): TString; overload;
    class operator LogicalOr(a: TString; b: string): TString; overload;
    class operator In (a: TString; b: array of string): TString;
    class operator Implicit(const a: string): TString; overload;
    class operator Implicit(const a: TString): string; overload;
    class operator Add(const a: TString; const b: TString): TString; overload;
    class operator Add(const a: TString; b: string): TString; overload;

    property Value: string read FValue write SetValue;
    property Column: string read FColumn write SetColumn;
    property InContext: boolean read FInContext write SetInContext;
    function &As(_as: string = ''): string;
  end;

  TStringHelp = record helper for TString
  public
    function SubString(i, p: integer): string;
    function Like(const a: string): TString;
    function CharIndex(Ch: string): string;
    function Left(i: integer): string;
    function Len(&As: string = ''): TString;
    function Lower: string;
    function Ltrim: string;
    function Reverse: string;
    function Right(i: integer): string;
    function Rtrim: string;
    function Upper: string;
  end;

  TFloat = record
  private
    FValue: Real;
    FAs: string;
    FColumn: string;
    procedure SetColumn(const Value: string);
  public
    procedure SetAs(const Value: string);
    procedure SetValue(const Value: Real);
    class operator Equal(const a: TFloat; const b: TFloat): TString; overload;
    class operator Equal(const a: TFloat; b: Real): TString; overload;
    class operator NotEqual(const a: TFloat; const b: TFloat): TString;overload;
    class operator NotEqual(const a: TFloat; b: Real): TString; overload;
    class operator LogicalAnd(a: TFloat; b: TFloat): TString; overload;
    class operator LogicalAnd(a: TFloat; b: Real): TString; overload;
    class operator LogicalOr(a: TFloat; b: TFloat): TString; overload;
    class operator LogicalOr(a: TFloat; b: Real): TString; overload;
    class operator GreaterThan(a: TFloat; b: TFloat): TString; overload;
    class operator GreaterThan(a: TFloat; b: Real): TString; overload;
    class operator LessThan(a: TFloat; b: TFloat): TString; overload;
    class operator LessThan(a: TFloat; b: Real): TString; overload;
    class operator GreaterThanOrEqual(a: TFloat; b: TFloat): TString; overload;
    class operator GreaterThanOrEqual(a: TFloat; b: Real): TString; overload;
    class operator LessThanOrEqual(a: TFloat; b: TFloat): TString; overload;
    class operator LessThanOrEqual(a: TFloat; b: Real): TString; overload;
    class operator Implicit(const a: Real): TFloat; overload;
    class operator Implicit(const a: TFloat): Real; overload;
    class operator Implicit(const a: TFloat): string; overload;
    class operator Add(const a, b: TFloat): TString; overload;
    class operator Add(const a: TFloat; b: Real): TString; overload;
    class operator Divide(const a, b: TFloat): TString; overload;
    class operator Divide(const a: TFloat; b: Real): TString; overload;
    class operator Multiply(const a, b: TFloat): TString; overload;
    class operator Multiply(const a: TFloat; b: Real): TString; overload;
    class operator Subtract(const a, b: TFloat): TString; overload;
    class operator Subtract(const a: TFloat; b: Real): TString; overload;
    property Value: Real read FValue write SetValue;
    function &As(_as: string = ''): string;
    property Column: string read FColumn write SetColumn;
  end;

  TFloatHelp = record helper for TFloat
    function Max(&As: string = ''): string;
    function Min(&As: string = ''): string;
    function Sum(&As: string = ''): string;
    function AVG(&As: string = ''): string;
    function Round(decimal: integer): string;
  end;

  TDate = record
  private
    FValue: TDatetime;
    FAs: string;
    FColumn: string;
    procedure SetColumn(const Value: string);
  public
    procedure SetAs(const Value: string);
    procedure SetValue(const Value: TDatetime);
    class operator Equal(const a: TDate; const b: TDate)
      : TString; overload;
    class operator Equal(const a: TDate; b: TDatetime)
      : TString; overload;
    class operator NotEqual(const a: TDate; const b: TDate)
      : TString; overload;
    class operator NotEqual(const a: TDate; b: TDatetime)
      : TString; overload;
    class operator LogicalAnd(a: TDate; b: TDate)
      : TString; overload;
    class operator LogicalAnd(a: TDate; b: TDatetime)
      : TString; overload;
    class operator LogicalOr(a: TDate; b: TDate)
      : TString; overload;
    class operator LogicalOr(a: TDate; b: TDatetime)
      : TString; overload;
    class operator GreaterThan(a: TDate; b: TDate)
      : TString; overload;
    class operator GreaterThan(a: TDate; b: TDatetime)
      : TString; overload;
    class operator LessThan(a: TDate; b: TDate)
      : TString; overload;
    class operator LessThan(a: TDate; b: TDatetime): TString;
      overload;
    class operator GreaterThanOrEqual(a: TDate; b: TDate)
      : TString; overload;
    class operator GreaterThanOrEqual(a: TDate; b: TDatetime)
      : TString; overload;
    class operator LessThanOrEqual(a: TDate; b: TDate)
      : TString; overload;
    class operator LessThanOrEqual(a: TDate; b: TDatetime)
      : TString; overload;
    class operator Implicit(const a: TDatetime): TDate; overload;
    class operator Implicit(const a: TDate): TDatetime; overload;
    class operator Implicit(const a: TDate): string; overload;

    class operator Add(const a, b: TDate): TString; overload;
    class operator Add(const a: TDate; b: TDatetime)
      : TString; overload;
    class operator Subtract(const a, b: TDate): TString; overload;
    class operator Subtract(const a: TDate; b: TDatetime): TString; overload;

    property Value: TDatetime read FValue write SetValue;
    function &As(_as: string = ''): string;
    property Column: string read FColumn write SetColumn;
  end;

  TInteger = record
  private
    FValue: integer;
    FAs: string;
    FColumn: string;
    procedure SetColumn(const Value: string);
  public
    procedure SetAs(const Value: string);
    procedure SetValue(const Value: integer);
    class operator Equal(const a: TInteger; const b: TInteger)
      : TString; overload;
    class operator Equal(const a: TInteger; b: integer): TString; overload;

    class operator NotEqual(const a: TInteger; const b: TInteger)
      : TString; overload;
    class operator NotEqual(const a: TInteger; b: integer): TString; overload;
    class operator LogicalAnd(a: TInteger; b: TInteger): TString; overload;
    class operator LogicalAnd(a: TInteger; b: integer): TString; overload;
    class operator LogicalOr(a: TInteger; b: TInteger): TString; overload;
    class operator LogicalOr(a: TInteger; b: integer): TString; overload;
    class operator GreaterThan(a: TInteger; b: TInteger): TString; overload;
    class operator GreaterThan(a: TInteger; b: integer): TString; overload;
    class operator LessThan(a: TInteger; b: TInteger): TString; overload;
    class operator LessThan(a: TInteger; b: integer): TString; overload;
    class operator In (a: TInteger; b: array of integer): TString;
    class operator GreaterThanOrEqual(a: TInteger; b: TInteger): TString; overload;
    class operator GreaterThanOrEqual(a: TInteger; b: integer): TString; overload;
    class operator LessThanOrEqual(a: TInteger; b: TInteger): TString; overload;
    class operator LessThanOrEqual(a: TInteger; b: integer): TString; overload;
    class operator Implicit(const a: integer): TInteger; overload;
    class operator Implicit(const a: TInteger): integer; overload;
    class operator Implicit(const a: TInteger): string; overload;
    class operator Add(const a: TInteger; const b: TInteger): TString; overload;
    class operator Add(const a: TInteger; b: integer): TString; overload;
    class operator Subtract(const a: TInteger; const b: TInteger)
      : TString; overload;
    class operator Subtract(const a: TInteger; b: integer): TString; overload;
    class operator Divide(const a: TInteger; const b: TInteger)
      : TString; overload;
    class operator Divide(const a: TInteger; b: integer): TString; overload;
    class operator Multiply(const a: TInteger; const b: TInteger)
      : TString; overload;
    class operator Multiply(const a: TInteger; b: integer): TString; overload;
    property Value: integer read FValue write SetValue;
    function &As(_as: string = ''): string;
    property Column: string read FColumn write SetColumn;
  end;

  TIntegerHelp = record helper for TInteger
    function Max(&As: string = ''): string;
    function Min(&As: string = ''): string;
    function Sum(&As: string = ''): string;
    function AVG(&As: string = ''): string;
  end;

  TBoolean = record
  private
    FAs: string;
    FValue: boolean;
    FColumn: string;
    procedure SetValue(const Value: boolean);
    procedure SetColumn(const Value: string);
  public
    procedure SetAs(const Value: string);
    class operator Equal(const a: TBoolean; const b: TBoolean)
      : TString; overload;
    class operator Equal(const a: TBoolean; b: boolean): TString; overload;
    class operator NotEqual(const a: TBoolean; const b: TBoolean)
      : TString; overload;
    class operator NotEqual(const a: TBoolean; b: boolean): TString; overload;
    class operator LogicalAnd(a: TBoolean; b: TBoolean): TString; overload;
    class operator LogicalAnd(a: TBoolean; b: boolean): TString; overload;
    class operator LogicalOr(a: TBoolean; b: TBoolean): TString; overload;
    class operator LogicalOr(a: TBoolean; b: boolean): TString; overload;
    class operator GreaterThan(a: TBoolean; b: TBoolean): TString; overload;
    class operator GreaterThan(a: TBoolean; b: boolean): TString; overload;
    class operator LessThan(a: TBoolean; b: TBoolean): TString; overload;
    class operator LessThan(a: TBoolean; b: boolean): TString; overload;
    class operator GreaterThanOrEqual(a: TBoolean; b: TBoolean)
      : TString; overload;
    class operator GreaterThanOrEqual(a: TBoolean; b: boolean)
      : TString; overload;
    class operator LessThanOrEqual(a: TBoolean; b: TBoolean): TString; overload;
    class operator LessThanOrEqual(a: TBoolean; b: boolean): TString; overload;
    class operator Implicit(const a: boolean): TBoolean; overload;
    class operator Implicit(const a: TBoolean): boolean; overload;
    class operator Implicit(const a: TBoolean): string; overload;

    property Value: boolean read FValue write SetValue;
    function &As(_as: string = ''): string;
    property Column: string read FColumn write SetColumn;
  end;



implementation

uses EF.Core.Consts;

resourcestring
  MaskFloat = '0.00;';

class operator TString.Equal(const a, b: TString): TString;
begin
  result := fEqual(a.FAs, b.FAs);
end;

class operator TString.Equal(const a: TString; b: string): TString;
begin
  if a.FAs <> '' then
    result := fEqual(a.FAs, quotedstr(b))
  else
    result := fEqual(a.Value, quotedstr(b));
end;

class operator TString.Implicit(const a: string): TString;
begin
  result.Value := a;
end;

class operator TString.Implicit(const a: TString): string;
begin
  if a.FInContext then
    result := a.FAs
  else
    result := a.FValue;
end;

class operator TString.In(a: TString; b: array of string): TString;
var
  values: string;
  Value: string;
begin
  inherited;
  for Value in b do
  begin
    values := values + ifthen(values <> '', ',', '') +
      ifthen(Pos('Select', Value) > 0, Value, quotedstr(Value));
  end;
  result := a.FAs + _In + '(' + values + ')';
end;

class operator TString.Add(const a, b: TString): TString;
begin
  result := fAdd(a.FAs, b.FAs);
end;

function TString.&As(_as: string = ''): string;
begin
  result := fGetAs(FAs, _as);
end;

class operator TString.Add(const a: TString; b: string): TString;
begin
  result := fAdd(a.FAs, quotedstr(b));
end;

class operator TString.NotEqual(const a, b: TString): TString;
begin
  result := fNotEqual(a.FAs, b.FAs);
end;

class operator TString.NotEqual(const a: TString; b: string): TString;
begin
  result := fNotEqual(a.FAs, quotedstr(b));
end;

class operator TString.LogicalAnd(a, b: TString): TString;
begin
  result := fLogicalAnd(a.Value, b.Value);
end;

class operator TString.LogicalAnd(a: TString; b: string): TString;
begin
  result := fLogicalAnd(a.Value, quotedstr(b));
end;

class operator TString.LogicalOr(a, b: TString): TString;
begin
  result := fLogicalOr(a.Value, b.Value);
end;

class operator TString.LogicalOr(a: TString; b: string): TString;
begin
  result := fLogicalOr(a.Value, quotedstr(b));
end;

procedure TString.SetAs(const Value: string);
begin
  FAs := Value;
end;

procedure TString.SetColumn(const Value: string);
begin
  FColumn := Value;
end;

procedure TString.SetInContext(const Value: boolean);
begin
  FInContext := Value;
end;

procedure TString.SetValue(const Value: string);
begin
  FValue := Value;
end;

{ TStringHelp }

function TStringHelp.Lower: string;
begin
  result := 'LOWER(' + FAs + ') as ' + copy(FAs, Pos('.', FAs) + 1,
    length(FAs));
end;

function TStringHelp.Ltrim: string;
begin
  result := 'LTRIM(' + FAs + ') as ' + copy(FAs, Pos('.', FAs) + 1,
    length(FAs));
end;

function TStringHelp.Reverse: string;
begin
  result := 'REVERSE(' + FAs + ') as ' + copy(FAs, Pos('.', FAs) + 1,
    length(FAs));
end;

function TStringHelp.Right(i: integer): string;
begin
  result := 'RIGHT(' + FAs + ',' + inttostr(i) + ') as ' +
    copy(FAs, Pos('.', FAs) + 1, length(FAs));
end;

function TStringHelp.Rtrim: string;
begin
  result := 'RTRIM(' + FAs + ') as ' + copy(FAs, Pos('.', FAs) + 1,
    length(FAs));
end;

function TStringHelp.SubString(i, p: integer): string;
begin
  result := 'SUBSTRING(' + FAs + ',' + inttostr(i) + ',' + inttostr(p) + ') as '
    + copy(FAs, Pos('.', FAs) + 1, length(FAs));
end;

function TStringHelp.CharIndex(Ch: string): string;
begin
  result := 'CHARINDEX(' + quotedstr(Ch) + ',' + FAs + ') as ' +
    copy(FAs, Pos('.', FAs) + 1, length(FAs));
end;

function TStringHelp.Left(i: integer): string;
begin
  result := 'LEFT(' + FAs + ',' + inttostr(i) + ') as ' +
    copy(FAs, Pos('.', FAs) + 1, length(FAs));
end;

function TStringHelp.Len(&As: string = ''): TString;
begin
  if &As <> '' then
    result := 'LEN(' + FAs + ') as ' + &As
  else
    result.Value := 'LEN(' + FAs + ')';

end;

function TStringHelp.Upper: string;
begin
  result := 'UPPER(' + FAs + ') as ' + copy(FAs, Pos('.', FAs) + 1,
    length(FAs));
end;

function TStringHelp.Like(const a: string): TString;
begin
  result.Value := FAs + ' LIKE(' + quotedstr(a) + ')';
end;

class operator TFloat.Equal(const a, b: TFloat): TString;
begin
  result := fEqual(a.FAs, b.FAs);
end;

class operator TFloat.Equal(const a: TFloat; b: Real): TString;
begin
  result := fEqual(a.FAs, FormatFloat(MaskFloat, b).Replace('.', '')
    .Replace(',', '.'));
end;

class operator TFloat.GreaterThan(a, b: TFloat): TString;
begin
  result := fGreaterThan(a.FAs, b.FAs);
end;

class operator TFloat.GreaterThan(a: TFloat; b: Real): TString;
begin
  result := fGreaterThan(a.FAs, FormatFloat(MaskFloat, b).Replace('.', '')
    .Replace(',', '.'));
end;

class operator TFloat.GreaterThanOrEqual(a, b: TFloat): TString;
begin
  result := fGreaterThanOrEqual(a.FAs, b.FAs);
end;

class operator TFloat.GreaterThanOrEqual(a: TFloat; b: Real): TString;
begin
  result := fGreaterThanOrEqual(a.FAs, FormatFloat(MaskFloat, b).Replace('.', '')
    .Replace(',', '.'));
end;

class operator TFloat.LogicalAnd(a, b: TFloat): TString;
begin
  result := fLogicalAnd(floattostr(a.Value), floattostr(b.Value));
end;

class operator TFloat.LogicalAnd(a: TFloat; b: Real): TString;
begin
  result := fLogicalAnd(floattostr(a.Value), floattostr(b));
end;

class operator TFloat.LessThan(a, b: TFloat): TString;
begin
  result := fLessThan(a.FAs, b.FAs);
end;

class operator TFloat.LessThan(a: TFloat; b: Real): TString;
begin
  result := fLessThan(a.FAs, FormatFloat(MaskFloat, b).Replace('.', '')
    .Replace(',', '.'));
end;

class operator TFloat.LessThanOrEqual(a, b: TFloat): TString;
begin
  result := fLessThanOrEqual(a.FAs, b.FAs);
end;

class operator TFloat.LessThanOrEqual(a: TFloat; b: Real): TString;
begin
  result := fLessThanOrEqual(a.FAs, FormatFloat(MaskFloat, b).Replace('.', '')
    .Replace(',', '.'));
end;

class operator TFloat.LogicalOr(a, b: TFloat): TString;
begin
  result := fLogicalOr(floattostr(a.Value), floattostr(b.Value));
end;

class operator TFloat.LogicalOr(a: TFloat; b: Real): TString;
begin
  result := fLogicalOr(floattostr(a.Value), floattostr(b));
end;

class operator TFloat.NotEqual(const a, b: TFloat): TString;
begin
  result := fNotEqual(a.FAs, b.FAs);
end;

class operator TFloat.NotEqual(const a: TFloat; b: Real): TString;
begin
  result := fNotEqual(a.FAs, FormatFloat(MaskFloat, b).Replace('.', '')
    .Replace(',', '.'));
end;

class operator TFloat.Implicit(const a: Real): TFloat;
begin
  result.FValue := a;
end;

class operator TFloat.Implicit(const a: TFloat): Real;
begin
  result := a.FValue;
end;

class operator TFloat.Implicit(const a: TFloat): string;
begin
  result := a.FAs;
end;

procedure TFloat.SetAs(const Value: string);
begin
  FAs := Value;
end;

procedure TFloat.SetColumn(const Value: string);
begin
  FColumn := Value;
end;

procedure TFloat.SetValue(const Value: Real);
begin
  FValue := Value;
end;

class operator TFloat.Add(const a, b: TFloat): TString;
var
  s: string;
begin
  s := fAdd(a.FAs, b.FAs);
  result.SetAs(s);
  result := s;
end;

function TFloat.&As(_as: string = ''): string;
begin
  result := fGetAs(FAs, _as);
end;

class operator TFloat.Add(const a: TFloat; b: Real): TString;
begin
  result := fAdd(a.FAs, floattostr(b));
end;

class operator TFloat.Subtract(const a, b: TFloat): TString;
begin
  result := fSubtract(a.FAs, b.FAs);
end;

class operator TFloat.Subtract(const a: TFloat; b: Real): TString;
begin
  result := fSubtract(a.FAs, floattostr(b));
end;

class operator TFloat.Divide(const a, b: TFloat): TString;
begin
  result := fDivide(a.FAs, b.FAs);
end;

class operator TFloat.Divide(const a: TFloat; b: Real): TString;
begin
  result := fDivide(a.FAs, floattostr(b));
end;

class operator TFloat.Multiply(const a, b: TFloat): TString;
begin
  result := fMultiply(a.FAs, b.FAs);
end;

class operator TFloat.Multiply(const a: TFloat; b: Real): TString;
begin
  result := fMultiply(a.FAs, floattostr(b));
end;

{ TFloatHelp }

function TFloatHelp.Max(&As: string = ''): String;
begin
  result := FMax(FAs, &As);
end;

function TFloatHelp.AVG(&As: string = ''): string;
begin
  result := fAVG(FAs, &As);
end;

function TFloatHelp.Sum(&As: string = ''): string;
begin
  result := fSum(FAs, &As);
end;

function TFloatHelp.Min(&As: string = ''): string;
begin
  result := FMin(FAs, &As);
end;

function TFloatHelp.Round(decimal: integer): string;
begin
  result := 'Round(' + FAs + ',' + inttostr(decimal) + ') as ' +
    copy(FAs, Pos('.', FAs) + 1, length(FAs));
end;

class operator TDate.Equal(const a, b: TDate): TString;
begin
  result := fEqual(a.FAs, b.FAs);
end;

class operator TDate.Equal(const a: TDate;
  b: TDatetime): TString;
begin
  result := fEqual(a.FAs, datetimetostr(b));
end;

class operator TDate.GreaterThan(a, b: TDate): TString;
begin
  result := fGreaterThan(a.FAs, b.FAs);
end;

class operator TDate.GreaterThan(a: TDate;
  b: TDatetime): TString;
begin
  result := fGreaterThan(a.FAs, datetimetostr(b));
end;

class operator TDate.GreaterThanOrEqual(a,
  b: TDate): TString;
begin
  result := fGreaterThanOrEqual(a.FAs, b.FAs);
end;

class operator TDate.GreaterThanOrEqual(a: TDate;
  b: TDatetime): TString;
begin
  result := fGreaterThanOrEqual(a.FAs, datetimetostr(b));
end;

class operator TDate.LogicalAnd(a, b: TDate): TString;
begin
  result := fLogicalAnd(datetostr(a.Value), datetostr(b.Value));
end;

class operator TDate.LogicalAnd(a: TDate;
  b: TDatetime): TString;
begin
  result := fLogicalAnd(datetostr(a.Value), datetimetostr(b));
end;

class operator TDate.LessThan(a, b: TDate): TString;
begin
  result := fLessThan(a.FAs, b.FAs);
end;

class operator TDate.LessThan(a: TDate;
  b: TDatetime): TString;
begin
  result := fLessThan(a.FAs, datetimetostr(b));
end;

class operator TDate.LessThanOrEqual(a, b: TDate): TString;
begin
  result := fLessThanOrEqual(a.FAs, b.FAs);
end;

class operator TDate.LessThanOrEqual(a: TDate;
  b: TDatetime): TString;
begin
  result := fLessThanOrEqual(a.FAs, datetimetostr(b));
end;

class operator TDate.LogicalOr(a, b: TDate): TString;
begin
  result := fLogicalOr(datetostr(a.Value), datetostr(b.Value));
end;

class operator TDate.LogicalOr(a: TDate;
  b: TDatetime): TString;
begin
  result := fLogicalOr(datetostr(a.Value), floattostr(b));
end;

class operator TDate.NotEqual(const a, b: TDate): TString;
begin
  result := fNotEqual(a.FAs, b.FAs);
end;

class operator TDate.NotEqual(const a: TDate;
  b: TDatetime): TString;
begin
  result := fNotEqual(a.FAs, datetostr(b));
end;

class operator TDate.Implicit(const a: TDatetime): TDate;
begin
  result.FValue := a;
end;

class operator TDate.Implicit(const a: TDate): TDatetime;
begin
  result := a.FValue;
end;

class operator TDate.Implicit(const a: TDate): string;
begin
  result := a.FAs;
end;

procedure TDate.SetAs(const Value: string);
begin
  FAs := Value;
end;

procedure TDate.SetColumn(const Value: string);
begin
  FColumn := Value;
end;

procedure TDate.SetValue(const Value: TDatetime);
begin
  FValue := Value;
end;

class operator TDate.Add(const a, b: TDate): TString;
begin
  result := fAdd(a.FAs, b.FAs);
end;

function TDate.&As(_as: string = ''): string;
begin
  result := fGetAs(FAs, _as);
end;

class operator TDate.Add(const a: TDate;
  b: TDatetime): TString;
begin
  result := fAdd(a.FAs, datetimetostr(b));
end;

class operator TDate.Subtract(const a, b: TDate): TString;
begin
  result := fSubtract(a.FAs, b.FAs);
end;

class operator TDate.Subtract(const a: TDate;
  b: TDatetime): TString;
begin
  result := fSubtract(a.FAs, datetimetostr(b));
end;

class operator TInteger.Equal(const a, b: TInteger): TString;
begin
  result := fEqual(a.FAs, b.FAs);
end;

class operator TInteger.Equal(const a: TInteger; b: integer): TString;
begin
  result := fEqual(a.FAs, inttostr(b));
end;

class operator TInteger.Add(const a, b: TInteger): TString;
begin
  result := fAdd(a.FAs, b.FAs);
end;

function TInteger.&As(_as: string = ''): string;
begin
  result := fGetAs(FAs, _as);
end;

class operator TInteger.Add(const a: TInteger; b: integer): TString;
begin
  result := fAdd(a.FAs, inttostr(b));
end;

class operator TInteger.Subtract(const a, b: TInteger): TString;
begin
  result := fSubtract(a.FAs, b.FAs);
end;

class operator TInteger.Subtract(const a: TInteger; b: integer): TString;
begin
  result := fSubtract(a.FAs, inttostr(b));
end;

class operator TInteger.Divide(const a, b: TInteger): TString;
begin
  result := fDivide(a.FAs, b.FAs);
end;

class operator TInteger.Divide(const a: TInteger; b: integer): TString;
begin
  result := fDivide(a.FAs, inttostr(b));
end;

class operator TInteger.Multiply(const a, b: TInteger): TString;
begin
  result := fMultiply(a.FAs, b.FAs);
end;

class operator TInteger.Multiply(const a: TInteger; b: integer): TString;
begin
  result := fMultiply(a.FAs, inttostr(b));
end;

class operator TInteger.GreaterThan(a, b: TInteger): TString;
begin
  result := fGreaterThan(a.FAs, b.FAs);
end;

class operator TInteger.GreaterThan(a: TInteger; b: integer): TString;
begin
  result := fGreaterThan(a.FAs, inttostr(b));
end;

class operator TInteger.GreaterThanOrEqual(a, b: TInteger): TString;
begin
  result := fGreaterThanOrEqual(a.FAs, b.FAs);
end;

class operator TInteger.GreaterThanOrEqual(a: TInteger; b: integer): TString;
begin
  result := fGreaterThanOrEqual(a.FAs, inttostr(b));
end;

class operator TInteger.NotEqual(const a, b: TInteger): TString;
begin
  result := fNotEqual(a.FAs, b.FAs);
end;

class operator TInteger.NotEqual(const a: TInteger; b: integer): TString;
begin
  result := fNotEqual(a.FAs, inttostr(b));
end;

class operator TInteger.LogicalAnd(a, b: TInteger): TString;
begin
  result := fLogicalAnd(floattostr(a.Value), floattostr(b.Value));
end;

class operator TInteger.LessThan(a, b: TInteger): TString;
begin
  result := fLessThan(a.FAs, b.FAs);
end;

class operator TInteger.LessThan(a: TInteger; b: integer): TString;
begin
  result := fLessThan(a.FAs, inttostr(b));
end;

class operator TInteger.LessThanOrEqual(a, b: TInteger): TString;
begin
  result := fLessThanOrEqual(a.FAs, b.FAs);
end;

class operator TInteger.LessThanOrEqual(a: TInteger; b: integer): TString;
begin
  result := fLessThanOrEqual(a.FAs, inttostr(b));
end;

class operator TInteger.LogicalAnd(a: TInteger; b: integer): TString;
begin
  result := fLogicalAnd(floattostr(a.Value), inttostr(b));
end;

class operator TInteger.LogicalOr(a, b: TInteger): TString;
begin
  result := fLogicalOr(floattostr(a.Value), floattostr(b.Value));
end;

class operator TInteger.LogicalOr(a: TInteger; b: integer): TString;
begin
  result := fLogicalOr(floattostr(a.Value), inttostr(b));
end;

class operator TInteger.Implicit(const a: integer): TInteger;
begin
  result.FValue := a;
end;

class operator TInteger.Implicit(const a: TInteger): integer;
begin
  result := a.FValue;
end;

class operator TInteger.Implicit(const a: TInteger): string;
begin
  result := a.FAs;
end;

class operator TInteger.In(a: TInteger; b: array of integer): TString;
var
  values: string;
  Value: integer;
begin
  inherited;
  for Value in b do
  begin
    values := values + ifthen(values <> '', ',', '') + inttostr(Value);
  end;
  result := a.FAs + _In + '(' + values + ')';
end;

procedure TInteger.SetAs(const Value: string);
begin
  FAs := Value;
end;

procedure TInteger.SetColumn(const Value: string);
begin
  FColumn := Value;
end;

procedure TInteger.SetValue(const Value: integer);
begin
  FValue := Value;
end;

{ TIntegerHelp }

function TIntegerHelp.Max(&As: string = ''): string;
begin
  result := FMax(FAs, &As);
end;

function TIntegerHelp.AVG(&As: string = ''): string;
begin
  result := fAVG(FAs, &As);
end;

function TIntegerHelp.Sum(&As: string = ''): string;
begin
  result := fSum(FAs, &As);
end;

function TIntegerHelp.Min(&As: string = ''): string;
begin
  result := FMin(FAs, &As);
end;

function TBoolean.&As(_as: string): string;
begin

end;

class operator TBoolean.Equal(const a: TBoolean; const b: TBoolean): TString;
begin

end;

class operator TBoolean.Equal(const a: TBoolean; b: boolean): TString;
begin

end;

class operator TBoolean.GreaterThan(a: TBoolean; b: TBoolean): TString;
begin

end;

class operator TBoolean.GreaterThan(a: TBoolean; b: boolean): TString;
begin

end;

class operator TBoolean.GreaterThanOrEqual(a: TBoolean; b: TBoolean): TString;
begin

end;

class operator TBoolean.GreaterThanOrEqual(a: TBoolean; b: boolean): TString;
begin

end;

class operator TBoolean.Implicit(const a: TBoolean): string;
begin

end;

class operator TBoolean.Implicit(const a: TBoolean): boolean;
begin

end;

class operator TBoolean.Implicit(const a: boolean): TBoolean;
begin

end;

class operator TBoolean.LessThan(a: TBoolean; b: TBoolean): TString;
begin

end;

class operator TBoolean.LessThan(a: TBoolean; b: boolean): TString;
begin

end;

class operator TBoolean.LessThanOrEqual(a: TBoolean; b: TBoolean): TString;
begin

end;

class operator TBoolean.LessThanOrEqual(a: TBoolean; b: boolean): TString;
begin

end;

class operator TBoolean.LogicalAnd(a: TBoolean; b: boolean): TString;
begin

end;

class operator TBoolean.LogicalAnd(a: TBoolean; b: TBoolean): TString;
begin

end;

class operator TBoolean.LogicalOr(a: TBoolean; b: TBoolean): TString;
begin

end;

class operator TBoolean.LogicalOr(a: TBoolean; b: boolean): TString;
begin

end;

class operator TBoolean.NotEqual(const a: TBoolean; const b: TBoolean): TString;
begin

end;

class operator TBoolean.NotEqual(const a: TBoolean; b: boolean): TString;
begin

end;

procedure TBoolean.SetAs(const Value: string);
begin

end;

procedure TBoolean.SetColumn(const Value: string);
begin
  FColumn := Value;
end;

procedure TBoolean.SetValue(const Value: boolean);
begin
  FValue := Value;
end;

end.
