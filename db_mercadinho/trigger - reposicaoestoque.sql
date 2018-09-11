use db_mercadinho
GO 

CREATE TRIGGER reposicaoestoque
   ON  dbo.itemcompra
   FOR	INSERT
AS 
BEGIN  
      DECLARE
	  @idproduto int,
	  @quantidadecompra float
	  
	  select @idproduto = idprodutoestoque,  @quantidadecompra = qtn_itemcompra  from inserted

	  update dbo.estoque set quantidade = quantidade + @quantidadecompra 
	    where idproduto = @idproduto	  	      
END
GO
