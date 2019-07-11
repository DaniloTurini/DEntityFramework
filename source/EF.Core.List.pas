unit EF.Core.List;

interface

uses
   EF.Mapping.Base, SysUtils, strUtils, RTTI, EF.Core.Functions, System.Generics.Collections;

type
  TEntityList<T:TEntityBase> = class( TObjectList<T> )
  private
  public
    function List: T;
    constructor Create;
  end;

  TEntityList = class( TEntityList<TEntityBase> )
  public
  end;

implementation


{ TEntityList<T> }

constructor TEntityList<T>.Create;
begin
  inherited Create(true);
  if (count = 0 ) then
     Add( T.Create );
end;

function TEntityList<T>.List: T;
begin
   result:= first;
end;


end.
