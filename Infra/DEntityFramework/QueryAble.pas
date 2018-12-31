unit QueryAble;

interface

uses
  strUtils,SysUtils,Variants,EntityConsts, EntityTypes, Atributies, EntityBase,
  EntityFunctions, System.Classes, InterfaceQueryAble, Winapi.Windows;

type
  TFrom = class;

  TQueryAble = class(TInterfacedPersistent, IQueryAble)
  private
    procedure SetEntity(value: TEntityBase);
    function GetEntity: TEntityBase;
    procedure SetSEntity(value: string);
    function GetSEntity: string;
    procedure SetSJoin(value: string);
    function GetSJoin: string;
    procedure SetSWhere(value: string);
    function GetSWhere: string;
    procedure SetSGroupBy(value: string);
    function GetSGroupBy: string;
    procedure SetSOrder(value: string);
    function GetSOrder: string;
    procedure SetSSelect(value: string);
    function GetSSelect: string;
    procedure SetSConcat(value: string);
    function GetSConcat: string;
    procedure SetSUnion(value: string);
    function GetSUnion: string;
    procedure SetSIntersect(value: string);
    function GetSIntersect: string;
    procedure SetSExcept(value: string);
    function gSetSExcept: string;
    procedure SetSCount(value: string);
    function GetSCount: string;
    function GetSExcept: string;
  protected
    oFrom: TFrom;
    FEntity: TEntityBase;
    FSWhere: String;
    FSOrder: string;
    FSSelect: string;
    FSEntity: string;
    FSJoin: string;
    FSGroupBy: string;
    FSUnion: string;
    FSExcept: string;
    FSIntersect: string;
    FSConcat: string;
    FSCount: string;
  public
    function Join(E, _On: string): IQueryAble; overload;
    function Join(E: TEntityBase; _On: TString): IQueryAble; overload;
    function Join(E: TEntityBase): IQueryAble; overload;
    function Join(E: TClass): IQueryAble; overload;
    function JoinLeft(E, _On: string): IQueryAble; overload;
    function JoinLeft(E: TEntityBase; _On: TString): IQueryAble;
      overload;
    function JoinRight(E, _On: string): IQueryAble; overload;
    function JoinRight(E: TEntityBase; _On: TString): IQueryAble;
      overload;
    function Where(condition: string): IQueryAble; overload;
    function Where(condition: TString): IQueryAble; overload;
    function GroupBy(Fields: string): IQueryAble; overload;
    function GroupBy(Fields: array of string): IQueryAble; overload;
    function Order(Fields: string): IQueryAble; overload;
    function Order(Fields: array of string): IQueryAble; overload;
    function OrderDesc(Fields: string): IQueryAble; overload;
    function OrderDesc(Fields: array of string): IQueryAble;overload;
    function Select(Fields: string = ''): IQueryAble; overload;
    function Select(Fields: array of string): IQueryAble; overload;

    function GetQuery(Q: IQueryAble): string;
    property Entity : TEntityBase read GetEntity write SetEntity;
    property SEntity: string read GetSEntity write SetSEntity;
    property SJoin: string read GetSJoin write SetSJoin;
    property SWhere: string read GetSWhere write SetSWhere;
    property SGroupBy: string read GetSGroupBy write SetSGroupBy;
    property SOrder: string read GetSOrder write SetSOrder;
    property SSelect: string read GetSSelect write SetSSelect;
    property SConcat: string read GetSConcat write SetSConcat;
    property SUnion: string read GetSUnion write SetSUnion;
    property SExcept: string read GetSExcept write SetSExcept;
    property SIntersect: string read GetSIntersect write SetSIntersect;
    property SCount: string read GetSCount write SetSCount;
  end;

  TFrom = class(TQueryAble)
  protected
    constructor Create;
    destructor Destroy;
    procedure InitializeString;
  end;

  TJoin = class(TQueryAble);
  TWhere = class(TQueryAble);
  TGroupBy = class(TQueryAble);
  TOrder = class(TQueryAble);

  TSelect = class(TQueryAble)
  private
    FFields:String;
  public
    function TopFirst(i: integer): IQueryAble;
    function Distinct(Field: String = ''): IQueryAble; overload;
    function Distinct(Field: TString): IQueryAble; overload;
    function Union(Q: IQueryAble): IQueryAble;
    function Concat(Q: IQueryAble): IQueryAble;
    function &Except(Q: IQueryAble): IQueryAble;
    function Intersect(Q: IQueryAble): IQueryAble;
    function Count: IQueryAble;
  end;

  Linq = class sealed
  private
    class var oFrom: TFrom;
    class function GetFromSigleton: TFrom;
    class function MontarCaseOf(Expression: string; _When, _then: array of variant): string; static;
  public
    class function From(E: String): TFrom; overload;
    class function From(E: TEntityBase): TFrom; overload;
    class function From(Entities: array of TEntityBase): TFrom; overload;
    class function From(E: TClass): TFrom; overload;
    class function From(E: IQueryAble): TFrom; overload;

    class function Caseof(Expression: TString; _When, _then: array of variant)
      : TString; overload;
    class function Caseof(Expression: TInteger; _When, _then: array of variant)
      : TString; overload;
  end;

implementation

uses AutoMapper;

function TQueryAble.GetQuery(Q: IQueryAble): string;
begin
  with Q as TQueryAble do
  begin
    result := Concat(SSelect + SCount, ifthen(Pos('Select', SEntity) > 0,
              fStringReplace(SEntity, 'From ', 'From (') + ')', SEntity),

              SJoin + ifthen((SJoin <> '') and (Pos('(', SSelect) > 0), ')', ''),

              SWhere + ifthen((SWhere <> '') and (SJoin = '') and
              (Pos('(', SSelect) > 0), ')', ''),

              ifthen(SExcept <> '', ifthen(SWhere = '', StrWhere, _And) +

              StrNot + '(' + StrExist + '(' + SExcept + ')' + ')', ''),

              ifthen(SIntersect <> '', ifthen(SWhere = '', StrWhere, _And) + StrExist +
              '(' + SIntersect + ')', ''),

              SGroupBy, SOrder, ifthen(SUnion <> '', StrUnion + SUnion, ''),
              ifthen(SConcat <> '', StrUnionAll + SConcat, ''));
    //oFrom.Free;
  end;
end;

function TQueryAble.GetEntity: TEntityBase;
begin
  result:= FEntity;
end;

function TQueryAble.GetSConcat: string;
begin
 result:= FSConcat;
end;

function TQueryAble.GetSCount: string;
begin
  result:= FSCount;
end;

function TQueryAble.GetSEntity: string;
begin
  result:= FSEntity;
end;

function TQueryAble.GetSExcept: string;
begin
  result:= FSExcept;
end;

function TQueryAble.GetSGroupBy: string;
begin
  result:= FSGroupBy;
end;

function TQueryAble.GetSIntersect: string;
begin
  result:= FSIntersect;
end;

function TQueryAble.GetSJoin: string;
begin
  result:= FSJoin;
end;

function TQueryAble.GetSOrder: string;
begin
  result:= FSOrder;
end;

function TQueryAble.GetSSelect: string;
begin
  result:= FSSelect;
end;

function TQueryAble.GetSUnion: string;
begin
   result:= FSUnion;
end;

function TQueryAble.GetSWhere: string;
begin
   result:= FSWhere;
end;

class function Linq.From(E: String): TFrom;
begin
  oFrom := GetFromSigleton;
  oFrom.SEntity := StrFrom + E;
  result := oFrom;
end;

class function Linq.From(E: TEntityBase): TFrom;
begin
  oFrom := GetFromSigleton;
  oFrom.SEntity := StrFrom + TAutoMapper.GetTableAttribute(E.ClassType);
  oFrom.Entity := E;
  result := oFrom;
end;

class function Linq.From(Entities: array of TEntityBase): TFrom;
var
  E: TEntityBase;
  sFrom: string;
  oFrom : TFrom;
begin
  oFrom := GetFromSigleton;
  for E in Entities do
    sFrom := sFrom + ifthen(sFrom <> '', ',', '') + TAutoMapper.GetTableAttribute
      (E.ClassType);
  oFrom.SEntity := StrFrom + sFrom;
  oFrom.Entity := Entities[0];
  result := oFrom;
end;

class function Linq.From(E: TClass): TFrom;
begin
  oFrom := GetFromSigleton;
  oFrom.SEntity := StrFrom + TAutoMapper.GetTableAttribute(E);
  oFrom.Entity := (E.Create as TEntityBase);
  result := oFrom;
end;

class function Linq.From(E: IQueryAble): TFrom;
begin
  result := oFrom;
end;

class function Linq.GetFromSigleton: TFrom;
begin
  if oFrom = nil  then
     oFrom:= TFrom.Create;
  oFrom.InitializeString;
  result := oFrom;
end;

class function Linq.MontarCaseOf(Expression: string; _When, _then: array of variant): string;
var
  s: string;
  i: integer;
begin
  s := '(case ' + Expression;
  for i := 0 to length(_When) - 1 do
  begin
    s := s + fCaseof(_When[i], _then[i]);
  end;
  s := s + ' end)';
  result:= s;
end;

class function Linq.Caseof(Expression: TString;
  _When, _then: array of variant): TString;
begin
  result.SetAs( MontarCaseOf( Expression.&As,_When , _then) );
end;

class function Linq.Caseof(Expression: TInteger;
  _When, _then: array of variant): TString;
begin
  result.SetAs( MontarCaseOf( Expression.&As,_When , _then) );
end;

{ TFrom }

constructor TFrom.Create;
begin

end;

destructor TFrom.Destroy;
begin

end;

procedure TFrom.InitializeString;
begin
    FSWhere:= '';
    FSOrder:= '';
    FSSelect:= '';
    FSEntity:= '';
    FSJoin:= '';
    FSGroupBy:= '';
    FSUnion:= '';
    FSExcept:= '';
    FSIntersect:= '';
    FSConcat:= '';
    FSCount:= '';
end;

{ TCustomLinqQueryAble }

function TQueryAble.Join(E, _On: string): IQueryAble;
begin
  self.SJoin := self.SJoin + StrInnerJoin + E + StrOn + _On;
  result := self;
end;

function TQueryAble.Join(E: TEntityBase; _On: TString): IQueryAble;
begin
  self.SJoin := self.SJoin + StrInnerJoin + TAutoMapper.GetTableAttribute
    (E.ClassType) + StrOn + _On.Value;
  result := self;
end;

function TQueryAble.Join(E: TEntityBase): IQueryAble;
begin
  self.SJoin := self.SJoin + StrInnerJoin + TAutoMapper.GetTableAttribute
    (E.ClassType) + StrOn + TAutoMapper.GetReferenceAtribute(self.Entity, E);
  result := self;
end;

function TQueryAble.Join(E: TClass): IQueryAble;
begin
  self.SJoin := self.SJoin + StrInnerJoin + TAutoMapper.GetTableAttribute
    (E) + StrOn + TAutoMapper.GetReferenceAtribute(self.Entity, E);
  result := self;
end;

function TQueryAble.JoinLeft(E, _On: string): IQueryAble;
begin
  self.SJoin := self.SJoin + StrLeftJoin + E + StrOn + _On;
  result := self;
end;

function TQueryAble.JoinLeft(E: TEntityBase; _On: TString): IQueryAble;
begin
  self.SJoin := self.SJoin + StrLeftJoin + TAutoMapper.GetTableAttribute
    (E.ClassType) + StrOn + _On.Value;
  result := self;
end;

function TQueryAble.JoinRight(E, _On: string): IQueryAble;
begin
  self.SJoin := self.SJoin + StrRightJoin + E + StrOn + _On;
  result := self;
end;

function TQueryAble.JoinRight(E: TEntityBase; _On: TString): IQueryAble;
begin
  self.SJoin := self.SJoin + StrRightJoin + TAutoMapper.GetTableAttribute
    (E.ClassType) + StrOn + _On.Value;
  result := self;
end;

function TQueryAble.Where(condition: string): IQueryAble;
begin
  self.SWhere := StrWhere + condition;
  result := self;
end;

function TQueryAble.Where(condition: TString): IQueryAble;
begin
  self.SWhere := Concat(StrWhere, condition);
  result := self;
end;

function TQueryAble.GroupBy(Fields: string): IQueryAble;
begin
  self.SGroupBy := Concat(StrGroupBy, Fields);
  result := self;
end;

function TQueryAble.GroupBy(Fields: array of string): IQueryAble;
var
  values: string;
  Value: string;
begin
  for Value in Fields do
  begin
    values := values + ifthen(values <> '', ', ', '') + Value;
  end;
  self.SGroupBy := Concat(StrGroupBy, values);
  result := self;
end;

function TQueryAble.gSetSExcept: string;
begin

end;

function TQueryAble.Order(Fields: string): IQueryAble;
begin
  self.SOrder := Concat(StrOrderBy, Fields);
  result := self;
end;

function TQueryAble.Order(Fields: array of string): IQueryAble;
var
  values: string;
  Value: string;
begin
  for Value in Fields do
  begin
    values := values + ifthen(values <> '', ', ', '') + Value;
  end;
  self.SOrder := StrOrderBy + values;
  result := self;
end;

function TQueryAble.OrderDesc(Fields: string): IQueryAble;
begin
  self.SOrder := Concat(StrOrderBy, Fields, StrDesc);
  result := self;
end;

function TQueryAble.OrderDesc(Fields: array of string): IQueryAble;
var
  values: string;
  Value: string;
begin
  for Value in Fields do
  begin
    values := values + ifthen(values <> '', ', ', '') + Value;
  end;
  self.SOrder := StrOrderBy + values + StrDesc;
  result := self;
end;

function TQueryAble.Select(Fields: string = ''): IQueryAble;
var
  _Atribs:string;
begin
  _Atribs:= TAutoMapper.GetAttributies(FEntity, true);
  if Pos('Select', Fields) > 0 then
    Fields := '(' + Fields + ')';

  self.SSelect := StrSelect + ifthen( self.SSelect <> '' ,
                                    ifthen( Fields  <> '', Fields,
                                          ifthen( _Atribs <> '', _Atribs,'*')) + ' From (' + self.SSelect ,
                                                ifthen( Fields  <> '', Fields,
                                                      ifthen(_Atribs  <> '', _Atribs,'*')));
  TSelect(self).FFields := Fields;
  result := TSelect(self);
end;

function TQueryAble.Select(Fields: array of string): IQueryAble;
var
  _Fields: string;
  Field: string;
  _Atribs:string;
begin
  _Fields := '';
  _Atribs:= TAutoMapper.GetAttributies(FEntity, true);
  for Field in Fields do
  begin
    _Fields := _Fields + ifthen(_Fields <> '', ', ', '') + Field;
  end;
  TSelect(self).FFields:= _Fields;
  self.SSelect := StrSelect + ifthen(_Fields <> '', _Fields,ifthen(_Atribs <> '',_Atribs,'*' ) );
  result := TSelect(self);
end;

procedure TQueryAble.SetEntity(value: TEntityBase);
begin
  FEntity := Value;
end;

procedure TQueryAble.SetSConcat(value: string);
begin
   FSConcat:= Value;
end;

procedure TQueryAble.SetSCount(value: string);
begin
   FSCount:= Value;
end;

procedure TQueryAble.SetSEntity(value: string);
begin
   FSEntity:= Value;
end;

procedure TQueryAble.SetSExcept(value: string);
begin
   FSExcept:= Value;
end;

procedure TQueryAble.SetSGroupBy(value: string);
begin
   FSGroupBy:= Value;
end;

procedure TQueryAble.SetSIntersect(value: string);
begin
  FSIntersect:= Value;
end;

procedure TQueryAble.SetSJoin(value: string);
begin
   FSJoin:= Value;
end;

procedure TQueryAble.SetSOrder(value: string);
begin
  FSOrder:= Value;
end;

procedure TQueryAble.SetSSelect(value: string);
begin
  FSSelect:= Value;
end;

procedure TQueryAble.SetSUnion(value: string);
begin
  FSUnion:= Value;
end;

procedure TQueryAble.SetSWhere(value: string);
begin
  FSWhere:= Value;
end;

{ TSelect }

function TSelect.&Except(Q: IQueryAble): IQueryAble;
begin
  SExcept := GetQuery(Q);
  result := self;
end;

function TSelect.Intersect(Q: IQueryAble): IQueryAble;
begin
  SIntersect := GetQuery(Q);
  result := self;
end;

function TSelect.Concat(Q: IQueryAble): IQueryAble;
begin
  SConcat := GetQuery(Q);
  result := self;
end;

function TSelect.Count: IQueryAble;
begin
  SSelect := trim(fStringReplace(SSelect, '*', ''));
  if FFields <> '' then
     SSelect := fStringReplace(SSelect,
                            StrSelect,
                            StrSelect +
                            StrCount + '(*)' +
                            ifthen(SSelect <> 'Select', ', ', ''))
  else
     SSelect := StrSelect + StrCount + '(*)';
  result := self;
end;

function TSelect.Distinct(Field: TString): IQueryAble;
begin
  SSelect := fStringReplace(SSelect, StrSelect, StrSelect + StrDistinct +
    ifthen(assigned(@Field), '(' + Field.&As + '),', '') + ' ');
  result := self;
end;

function TSelect.Distinct(Field: String): IQueryAble;
begin
  SSelect := fStringReplace(SSelect, StrSelect, StrSelect + StrDistinct +
    ifthen(Field <> '', '(' + Field + '),', '') + ' ');
  result := self;
end;

function TSelect.TopFirst(i: integer): IQueryAble;
begin
  SSelect := fStringReplace(SSelect, StrSelect, StrSelect + StrTop + inttostr(i)
    + ' ');
end;

function TSelect.Union(Q: IQueryAble): IQueryAble;
begin
  SUnion := GetQuery(Q);
  result := self;
end;



end.