
CREATE FUNCTION lucroproduto (@nome VARCHAR(45))
RETURNS REAL
AS
BEGIN
	
	DECLARE @lucro REAL  
	SELECT @lucro =  (precotabela - precocusto)
	FROM estoque
	WHERE nome = @nome
	RETURN @lucro

END
GO