
-- 1. Crie uma função X que receba um parâmetro referente ao número do veículo e outro referente ao Ano de Venda. 
-- A função deve retornar o número de vendas referentes ao veículo no dado ano.

select * from veiculo
select * from vendasAnuais
SELECT * FROM ano
select * from Vendas2013 where idVeiculo = 47



create or alter function [2100545].funcX(@idveiculo tinyint, @ano int)
returns tinyint
as
begin
	declare @nvendas tinyint
	select @nvendas = case @ano
						when 2013 then (select count(*) from Vendas2013 where idVeiculo = @idVeiculo)
						when 2014 then (select count(*) from Vendas2014 where idVeiculo = @idVeiculo)
						when 2015 then (select count(*) from Vendas2015 where idVeiculo = @idVeiculo)
						end

	return @nvendas
end

select [2100545].funcX(47, 2013) as compras



-- 2. Crie uma função Y que receba um parâmetro referente ao número do cliente e retorne
-- todas as compras feitas por este cliente, trazendo as informações abaixo:

create or alter function [2100545].funcY(@idCliente tinyint)
returns table
as
return
(
	select 
	D.idCliente, 
	C.nome, 
	C.sexo, 
	C.dtNascimento, 
	D.dataVenda, 
	D.idVeiculo, V.descricao as Veiculo, M.descricao as Modelo, F.Nome as Fabricante 
	
	from (
	select * from Vendas2013
	union all
	select * from Vendas2014
	union all 
	select * from Vendas2015
	) as D 
	inner join Cliente		as C on D.idCliente = C.idCliente
	inner join Veiculo		as V on D.idVeiculo = V.idVeiculo
	inner join Modelo		as M on V.idModelo = M.idModelo
	inner join Fabricante	as F on V.idFabricante = F.idFabricante
	where C.idcliente = @idCliente
)

select * from [2100545].funcY(2)

-- 3. Crie uma função Z que receba um parâmetro referente ao número do cliente. 
-- A função deve retornar todo o conteúdo da função Y e mais 3 colunas com o nome TotalVendasVeiculo2013, TotalVendasVeiculo2014, TotalVendasVeiculo2015. 
-- Estas colunas devem ser preenchidas com as quantidades de compras que o determinado cliente fez nos respectivos anos. 
-- Alguns requisitos devem ser seguidos na função Z:


create or alter function [2100545].funcZ(@idCliente int)
returns @var_table table (idCliente int, nome varchar, sexo bit, dtNascimeto date, dataVenda date, Veiculo varchar, Fabricante varchar, idVeiculo tinyint, 
	TotalVendasVeiculos2013  tinyint,
	TotalVendasVeiculos2014  tinyint,
	TotalVendasVeiculos2015  tinyint,
	id smallint identity(1,1)


)
as
begin
	insert @var_table (idCliente, nome, dtNascimento, dataVenda, idVeiculo, Veiculo, Modelo, Fabricante)
	select idCliente, nome, sexo, dtNascimento, dataVenda, idVeiculo, Veiculo, Modelo, Fabricante from [2100203].funcY(@idCliente)
	
	while exists (select * from var_table where TotalVendasVeiculos2013 is null or TotalVendasVeiculos2014 is null or TotalVendasVeiculos2015 is null)
	begin
	update @var_table set TotalVendasVeiculos2013 = [2100545].X(idVeiculo, 2013),
						  TotalVendasVeiculos2014 = [2100545].X(idVeiculo, 2014),
						  TotalVendasVeiculos2015 = [2100545].X(idVeiculo, 2015)

	
	end
end

