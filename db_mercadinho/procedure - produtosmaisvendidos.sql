
-- Tipo define se será os 10 mais vendidos(1) ou os 10 menos vendidos(0)
create procedure dbo.sp_rel_produtos_maisvendidos(@dataini datetime, @datafim datetime, @tipo int) 
as 
begin
	declare @quantidadevendida float, @idproduto int, @descricao varchar(100), @I int = 1
	delete from maismenosvendidos;
	if (@tipo = 1) -- 10 mais vendidos no perido
	begin
		declare cursor_produtos cursor for
			select TOP 10 SUM(i.quantidadevendida) Qtdvendida,
					p.id,
					p.descricao			
				from produto p
			join itemvenda i on i.idproduto = p.id
			join venda v on v.id = i.idvenda
			where v.datavenda between @dataini and @datafim
			group by p.id, p.descricao
			order by 1 	desc
		open cursor_produtos 
			fetch next from cursor_produtos 
			into @quantidadevendida, @idproduto, @descricao
			
			while (@@fetch_status = 0)
			begin
				insert into maismenosvendidos(num_ordem, idproduto,	descricao,quantidadevendida)
					values (@I, @idproduto, @descricao, @quantidadevendida)
				set @I = @I + 1;
				
				fetch next from cursor_produtos 
				into @quantidadevendida, @idproduto, @descricao 
			end
		close cursor_produtos;
		deallocate cursor_produtos
	end
	else -- 10 menos vendidos no perido
	begin
		declare cursor_produtos cursor for
			select TOP 10 SUM(i.quantidadevendida) Qtdvendida,
					p.id,
					p.descricao			
				from produto p
			join itemvenda i on i.idproduto = p.id
			join venda v on v.id = i.idvenda
			where v.datavenda between @dataini and @datafim
			group by p.id, p.descricao
			order by 1 		
		open cursor_produtos 
			fetch next from cursor_produtos 
			into @quantidadevendida, @idproduto, @descricao
			
			while (@@fetch_status = 0)
			begin
				insert into maismenosvendidos(num_ordem, idproduto,	descricao,quantidadevendida)
					values (@I, @idproduto, @descricao, @quantidadevendida)
				set @I = @I + 1;
				
				fetch next from cursor_produtos 
				into @quantidadevendida, @idproduto, @descricao 
			end
		close cursor_produtos;
		deallocate cursor_produtos;
	end
end