
CREATE procedure dbo.sp_gerarcontareceber(@idvenda int)
as
begin
	declare @quantidadeparcelas int, @I int = 1
	declare @valorvenda float, @valorconta float
	
	select @quantidadeparcelas = ISNULL(f.quantidadeparcelas,0)
	from venda v
	join formapagamento f on v.idformapagamento = f.id
	where v.id = @idvenda;
	
	if @quantidadeparcelas = 0 set @quantidadeparcelas = 1;
	set @valorvenda = dbo.calcula_total_venda (@idvenda);
	set @valorconta = @valorvenda/@quantidadeparcelas
	
	while @I <= @quantidadeparcelas
	begin
		insert into contasreceber(idvenda, valor, situacao)values(@idvenda,@valorconta, 0)
		set @I = @I +1;
	end;

end
