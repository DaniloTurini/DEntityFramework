unit FactoryController;

interface

uses
  Forms,  Sysutils, FactoryEntity, InterfaceController, System.Classes, RTTI, Dialogs;

type
  TFactoryController = class
  private
    class function GetControllerClassName(E: TEnumEntities): string; static;
  public
    class function GetController(E: TEnumEntities ): IControllerBase;Virtual;
  end;

implementation

{ TFactoryEntity }

uses
InterfaceService, FactoryService, ControllerBase, AutoMapper;

class function TFactoryController.GetControllerClassName( E: TEnumEntities):string;
begin
  case E of
     tpCliente   : result:= 'ControllerCliente.TControllerCliente';
     tpFornecedor: result:= 'ControllerFornecedor.TControllerFornecedor';
     tpFabricante: result:= 'ControllerFabricante.TControllerFabricante';
         tpAluno : result:= 'ControllerAluno.TControllerAluno';
//tpEntity: result:= ControllerEntity.TControllerEntity;
  else
    begin
      showmessage('Verificar declara��o "initialization RegisterClass" requerido do Controller !');
      abort;
    end;
  end;
end;

class function TFactoryController.GetController( E: TEnumEntities ): IControllerBase;
var
  Controller     : IControllerBase;
  Instance      : TObject;
begin
  Instance := TAutoMapper.GetInstance( GetControllerClassName( E ) );
  if Instance <> nil then
  begin
    Controller :=  TControllerBase( Instance ).create( TFactoryService.GetService(E) );
    result:= Controller;
  end;
end;

end.
