
--1. Crie um tabela que envolva algum tipo de cadastro (compra, cliente, venda, produto,
--funcionário, fornecedor, ...). A tabela deve ter uma PK (autonumerada), coluna de texto, data,
--número e valor monetário e nenhuma coluna deve aceitar NULLs.

--CRIANDO TABELA
create table [2100545].Cadastro
(
idCompra tinyint identity(1,1) not null,
nomeCliente varchar(50) not null,
venda decimal(10,2) not null,
produto varchar(50) not null,
ativo bit,
data date not null,
CONSTRAINT PK_tbCompra_idCompra PRIMARY KEY CLUSTERED (idCompra)
)

--2. Crie uma procedure que realize ações de DML que queiramos (INSERT, DELETE, UPDATE), assim
--como os valores necessários para esta ação.

--CRIANDO PROCEDURE
create or alter procedure [2100545].valoresNecessarios
(@nomeCliente varchar(50), @venda decimal(10,2), @produto varchar(50) = '', 
@ativo bit = 1, @data date, @acao varchar(10))
as
begin
if @acao = 'insert'
	insert into[2100545].Cadastro (nomeCliente, venda, produto, ativo, data)
	values (@nomeCliente, @venda, @produto, @ativo, @data)

if @acao = 'update'
	update Cadastro 
	set venda = @venda
	where nomeCliente = @nomeCliente

if @acao = 'delete'
	delete from Cadastro
	where nomeCliente = @nomeCliente
	
end

exec [2100545].valoresNecessarios @nomeCliente = 'Zezinho', @venda = 100.20, 
@produto = 'Pão', @ativo = 1, @data = '2022-05-24', @acao = 'insert'

exec [2100545].valoresNecessarios @nomeCliente = 'Zezinho', @venda = 200.20, @data = '2022-05-24', @acao = 'update'

exec [2100545].valoresNecessarios @nomeCliente = 'Zezinho', @venda = 200.20, @data = '2022-05-24', @acao = 'delete'

select * from [2100545].Cadastro
--3. Crie uma tabela de auditoria que irá armazenar os valores do cadastro antes de serem
--removidos por uma ação de DELETE ou UPDATE (esta ação também deve ser registrada na
--auditoria, assim como o momento que ocorreu, com precisão de milissegundos). A tabela de
--auditoria será alimentada através de triggers que mapeiam estas ações

--Crianda tabela auditoria
create table [2100545].auditoria
(
idCompra tinyint not null,
nomeCliente varchar(50) not null,
venda decimal(10,2) not null,
produto varchar(50) not null,
ativo bit,
data date not null,
acao varchar(10),
dataModificacao datetime constraint dfAuditoriaModificacao default getdate()
)

drop table [2100545].auditoria

--criando trigger update
Create or alter trigger TR_auditoria
on [2100545].Cadastro
after update as
begin
	insert into [2100545].auditoria (idCompra, nomeCliente, venda, produto, ativo, data, acao)
	select idCompra, nomeCliente, venda, produto, ativo, data,  'update' from deleted

end


--criando trigger delete
Create or alter trigger TR_auditoria_delete
on [2100545].Cadastro
after delete as
begin
	insert into [2100545].auditoria (idCompra, nomeCliente, venda, produto, ativo, data, acao)
	select idCompra, nomeCliente, venda, produto, ativo, data,  'delete' from deleted

end

--criando trigger insert
Create trigger TR_auditoria_insert
on [2100545].Cadastro
after delete as
begin
	insert into [2100545].auditoria (idCompra, nomeCliente, venda, produto, ativo, data, acao)
	select idCompra, nomeCliente, venda, produto, ativo, data,  'insert' from deleted

end


update [2100545].Cadastro
set  nomeCliente = 'Zezinho', venda = 200.20, data = '2022-05-24'
where idCompra = 2

select * from [2100545].auditoria


--4. Utilize os objetos criados para gerar um bloco de inserção, update e deleção, de forma que a
--tabela inicial fique VAZIA e a tabela de auditoria registre tudo o que foi realizado. Mostre que a
--tabela de auditoria foi corretamente preenchida.

--inserindo registro
exec [2100545].valoresNecessarios @nomeCliente = 'Zezinho', @venda = 100.20, 
@produto = 'Pão', @ativo = 1, @data = '2022-05-24', @acao = 'insert'

--update de teste trigger
exec [2100545].valoresNecessarios @nomeCliente = 'Zezinho', @venda = 200.20, @data = '2022-05-24', @acao = 'update'

--delete de teste trigger
exec [2100545].valoresNecessarios @nomeCliente = 'Zezinho', @venda = 200.20, @data = '2022-05-24', @acao = 'delete'

--OBS1: O script (.sql ) deve ser anexado por apenas um integrante, contendo no cabeçalho os
--nomes completos e RA de todos os participantes.
--OBS2: Todos os objetos e blocos de testes devem conter comentários, documentando tudo que
--está sendo realizado e ocorrendo.
