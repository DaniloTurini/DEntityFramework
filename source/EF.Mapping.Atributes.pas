{*******************************************************}
{         Copyright(c) Lindemberg Cortez.               }
{              All rights reserved                      }
{         https://github.com/LinlindembergCz            }
{		Since 01/01/2019                        }
{*******************************************************}
unit EF.Mapping.Atributes;

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


  EntityExpression = class(TCustomAttribute)
  private
    FDisplay: string;
    FExpression: string;
  public
    constructor Create(aDisplay: String; aExpression:string);
    property Display: string read FDisplay;
    property Expression: string read FExpression;
  end;


  EntityItems = class(TCustomAttribute)
  private
    FItems: TStringList;
  public
    constructor Create(aItems: String);
    destructor Destroy; override;
    property Items: TStringList read FItems write FItems;
  end;

  Default = class(TCustomAttribute)
  private
    FName: string;
  public
    constructor Create(aName: string);
    property Name: string read FName;
  end;

  MaxLength = class(TCustomAttribute)
  private
    FValue: integer;
  public
    constructor Create(pMaxLength:integer ); virtual;
    property Value: integer read FValue;
  end;

  Log = class(TCustomAttribute)
  private
    FValue: boolean;
  public
    constructor Create(pValue:boolean ); virtual;
    property Value: boolean read FValue;
  end;

  Valiator = class(TCustomAttribute)
  private
    FMensagem: String;
    procedure AfterValidar(pValido: boolean);
  public
    function Validar(pValue: TValue; pMensagem: string = ''): boolean; virtual;
    constructor Create(pMensagem: String = '');
  end;

  EntityNotSpecialChar = class(TCustomAttribute)
  end;

  //Nao permitir valor nulo
  NotNull = class(Valiator)
  public
    function Validar(pValue: TValue; pMensagem: string = ''): boolean; override;
  end;

  //Verificar o tamanho do valor minimo informado
  LengthMin = class(Valiator)
  private
    FMin: integer;
  public
    constructor Create(pMin: integer; pMensagem: String= ''); reintroduce;
    function Validar( pValue: TValue; pMensagem: string = ''): boolean; override;
  end;

  //Verificar se o valor est� dentro do intervalo
  Range = class(Valiator)
  private
    FMax: integer;
    FMin: integer;
  public
    constructor Create(pMin, pMax: integer; pMensagem: String= ''); reintroduce;
    function Validar(pValue: TValue; pMensagem: string = ''): boolean; override;
  end;

  PItem = ^TItem;

  TItem = record
    Text: string;
    Value: string;
  end;

  Edit = class(TCustomAttribute)
  end;

  Combobox = class(TCustomAttribute)
  end;

  CheckBox = class(TCustomAttribute)
  end;

  Memo = class(TCustomAttribute)
  end;

  DateTimePicker = class(TCustomAttribute)
  end;

  LookupCombobox = class(TCustomAttribute)
  end;

  RadioGroup = class(TCustomAttribute)
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

destructor EntityItems.Destroy;
begin
  FItems.Free;
end;

constructor Default.Create(aName: string);
begin
  FName := aName;
end;

constructor Range.Create(pMin, pMax: integer; pMensagem: String = '');
begin
  inherited Create(pMensagem);
  FMin := pMin;
  FMax := pMax;
end;

constructor Valiator.Create(pMensagem: String = '');
begin
  if pMensagem <> '' then
    FMensagem := pMensagem
  else
    FMensagem := 'Campo requerido!';
end;

function NotNull.Validar(pValue: TValue;pMensagem: string = ''): boolean;
begin
  FMensagem := pMensagem;
  result := pValue.AsString <> '';
  AfterValidar(result);
end;

procedure Valiator.AfterValidar(pValido: boolean);
begin
  if (not pValido) then
    ShowMessage(FMensagem);
end;

function Valiator.Validar(pValue: TValue; pMensagem: string = ''): boolean;
begin
  FMensagem := pMensagem;
  result := true;
  AfterValidar(result);
end;

function Range.Validar(pValue: TValue;pMensagem: string = ''): boolean;
begin
  FMensagem := pMensagem;
  result := true;
  if (pValue.AsInteger < FMin) then
    result := false;
  if (pValue.AsInteger > FMax) then
    result := false;
  AfterValidar(result);
end;

{ EntityMaxLenth }

constructor MaxLength.Create(pMaxLength: integer);
begin
  FValue:= pMaxLength;
end;

{ EntityLog }

constructor Log.Create(pValue: boolean);
begin
  FValue := pValue;
end;

{ EntityExpression }

constructor EntityExpression.Create(aDisplay: String; aExpression:string);
begin
  FDisplay:= aDisplay;
  FExpression := aExpression;
end;

{ EntityValueLengthMin }

function LengthMin.Validar(pValue: TValue;
  pMensagem: string): boolean;
begin
  FMensagem := pMensagem;
  result := true;
  if (pValue.AsString.Length < FMin) then
    result := false;
  AfterValidar(result);
end;

constructor LengthMin.Create(pMin: integer; pMensagem: String);
begin
  inherited Create(pMensagem);
  FMin := pMin;
end;

end.
