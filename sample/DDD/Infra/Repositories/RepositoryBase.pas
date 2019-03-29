unit RepositoryBase;

interface

uses
 Classes, Repository, Entities, InterfaceRepositoryCliente, InterfaceRepository,
 DB, Context, EF.Engine.DataContext, EF.Mapping.Base;

type
   {$M+}
   TRepositoryBase<T:TEntitybase> = Class(TInterfacedPersistent, IRepositoryBase<T>)
   private
     FRefCount: integer;
   protected
     _RepositoryBase: IRepository<T>;
   public
     Constructor Create(dbContext:Context.TContext);virtual;

     procedure RefreshDataSet; virtual;
     function  LoadDataSet(iId:Integer; Fields: string = ''): TDataSet;virtual;
     function  Load(iId: Integer = 0): T;virtual;
     procedure Delete;virtual;
     procedure AddOrUpdate( State: TEntityState);virtual;
     procedure Commit;virtual;
     function Context: Context.TContext;virtual;


    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
   End;
   {$M-}

implementation

uses Winapi.Windows;

procedure TRepositoryBase<T>.AddOrUpdate(State: TEntityState);
begin
 _RepositoryBase.AddOrUpdate(State);
end;

procedure TRepositoryBase<T>.Commit;
begin
 _RepositoryBase.Commit;
end;

procedure TRepositoryBase<T>.Delete;
begin
  _RepositoryBase.Delete;
end;

function TRepositoryBase<T>.Context: Context.TContext;
begin
  result:= _RepositoryBase.Context;
end;

constructor TRepositoryBase<T>.Create(dbContext: Context.TContext);
begin
   inherited Create;
end;

function TRepositoryBase<T>.LoadDataSet(iId: Integer; Fields: string = ''): TDataSet;
begin
  result := _RepositoryBase.LoadDataSet(iId, Fields)
end;

function TRepositoryBase<T>.Load(iId: Integer): T;
begin
 result := _RepositoryBase.Load(iId)
end;

procedure TRepositoryBase<T>.RefreshDataSet;
begin
 _RepositoryBase.RefreshDataSet;
end;

function TRepositoryBase<T>._AddRef: Integer;
begin
  Result := inherited _AddRef;
  InterlockedIncrement(FRefCount);
end;

function TRepositoryBase<T>._Release: Integer;
begin
  Result := inherited _Release;
  InterlockedDecrement(FRefCount);
  if FRefCount <=0 then
    Free;
end;

end.
