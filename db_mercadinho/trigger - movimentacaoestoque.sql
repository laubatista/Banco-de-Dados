use db_mercadinho
GO 

CREATE TRIGGER movimentacaodoestoque
   ON  venda
   FOR	INSERT
AS 
BEGIN  
      DECLARE
	  @idproduto int,
	  @quantidadevendida int 
	  
	  select @idproduto = idproduto, @quantidadevendida = quantidadevendida from inserted

	  update estoque set quantidade = quantidade - @quantidadevendida
	    where idproduto = @idproduto	  
	      
  END