unit EntityAtributies;

interface

uses
   sysUtils, RTTI, Classes, Dialogs;

type
  PParamAtributies = ^TParamAtributies;

  TParamAtributies = record
    Name: string;
    Tipo: String;
    IsNull: boolean;
    PrimaryKey: boolean;
    DefaultValue: variant;
    AutoInc: boolean;
  end;

  EntityTable = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(aName: String);
    property Name: string read FName;
  end;

  EntityField = class(TCustomAttribute)
  private
    FName: String;
    FIsNull: boolean;
    FPrimaryKey: boolean;
    FTipo: string;
    FDefaultValue: variant;
    FAutoInc: boolean;
    procedure SetDefaultValue(const Value: variant);
    procedure SetAutoInc(const Value: boolean);
  public
    constructor Create(aName: String; aTipo: string=''; aIsNull: boolean=true;
      aPrimaryKey: boolean = false; aAutoInc: boolean = false); overload;
    property Name: String read FName;
    property Tipo: string read FTipo;
    property IsNull: boolean read FIsNull;
    property PrimaryKey: boolean read FPrimaryKey;
    property DefaultValue: variant read FDefaultValue;
    property AutoInc: boolean read FAutoInc write SetAutoInc;
  end;

  EntityRef = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(aName: String);
    property Name: string read FName;
  end;

  EntityItems = class(TCustomAttribute)
  private
    FItems: TStringList;
  public
    constructor Create(aItems: String);
    property Items: TStringList read FItems;
  end;

  EntityDefault = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(aName: string);
    property Name: string read FName;
  end;

  EntityMaxLength = class(TCustomAttribute)
  private
    FValue: integer;
  public
    constructor Create(pMaxLength:integer ); virtual;
    property Value: integer read FValue;
  end;

  EntityLog = class(TCustomAttribute)
  private
    FValue: boolean;
  public
    constructor Create(pValue:boolean ); virtual;
    property Value: boolean read FValue;
  end;

  EntityValidation = class(TCustomAttribute)
  private
    FMensagem: String;
    procedure AfterValidar(pValido: boolean);
  public
    function Validar(pValue: TValue): boolean; virtual;
    constructor Create(pMensagem: String = '');
  end;

  EntityNotSpecialChar = class(TCustomAttribute)
  end;

  EntityNotNull = class(EntityValidation)
  public
    function Validar(pValue: TValue): boolean; override;
  end;

  EntityRangeValues = class(EntityValidation)
  private
    FMax: integer;
    FMin: integer;
  public
    constructor Create(pMin, pMax: integer; pMensagem: String); reintroduce;
    function Validar(pValue: TValue): boolean; override;
  end;

  PItem = ^TItem;

  TItem = record
    Text: string;
    Value: string;
  end;

implementation


{ EntityTable }
constructor EntityTable.Create(aName: String);
begin
  FName := aName;
end;

{ EntityField }

constructor EntityField.Create(aName: String; aTipo: string =''; aIsNull: boolean=true;
  aPrimaryKey: boolean = false; aAutoInc: boolean = false);
begin
  FName := aName;
  FTipo := aTipo;
  FIsNull := aIsNull;
  FPrimaryKey := aPrimaryKey;
  FAutoInc := aAutoInc;
end;

procedure EntityField.SetAutoInc(const Value: boolean);
begin
  FAutoInc := Value;
end;

procedure EntityField.SetDefaultValue(const Value: variant);
begin
  FDefaultValue := Value;
end;

{ EntityRef }
constructor EntityRef.Create(aName: String);
begin
  FName := aName;
end;

{ EntityItems }
constructor EntityItems.Create(aItems: String);
begin
  FItems := TStringList.Create;
  FItems.delimiter := ';';
  FItems.DelimitedText := aItems;
end;

constructor EntityDefault.Create(aName: string);
begin
  FName := aName;
end;

constructor EntityRangeValues.Create(pMin, pMax: integer; pMensagem: String);
begin
  inherited Create(pMensagem);
  FMin := pMin;
  FMax := pMax;
end;

constructor EntityValidation.Create(pMensagem: String = '');
begin
  if pMensagem <> '' then
    FMensagem := pMensagem
  else
    FMensagem := 'Campo requerido!';
end;

function EntityNotNull.Validar(pValue: TValue): boolean;
begin
  result := pValue.AsString <> '';
  AfterValidar(result);
end;

procedure EntityValidation.AfterValidar(pValido: boolean);
begin
  if (not pValido) then
    ShowMessage(FMensagem);
end;

function EntityValidation.Validar(pValue: TValue): boolean;
begin
  result := true;
  AfterValidar(result);
end;

function EntityRangeValues.Validar(pValue: TValue): boolean;
begin
  result := true;
  if (pValue.AsInteger < FMin) then
    result := false;
  if (pValue.AsInteger > FMax) then
    result := false;
  AfterValidar(result);
end;

{ EntityMaxLenth }

constructor EntityMaxLength.Create(pMaxLength: integer);
begin
  FValue:= pMaxLength;
end;

{ EntityLog }

constructor EntityLog.Create(pValue: boolean);
begin
  FValue := pValue;
end;

end.
