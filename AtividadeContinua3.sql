use temp

select * from cliente

create table cidade
(
uf char(2),
ddd char(3)
)



-- INSERT TABELA CIDADE (UF E DDD)

insert into cidade values('SP',	11)
insert into cidade values('SP',	12)
insert into cidade values('SP',	13)
insert into cidade values('SP',	14)
insert into cidade values('SP',	15)
insert into cidade values('SP',	16)
insert into cidade values('SP',	17)
insert into cidade values('SP',	18)
insert into cidade values('SP',	19)
insert into cidade values('RJ',	21)
insert into cidade values('RJ',	22)
insert into cidade values('RJ',	24)
insert into cidade values('ES',	27)
insert into cidade values('ES',	28)
insert into cidade values('MG',	31)
insert into cidade values('MG',	32)
insert into cidade values('MG',	33)
insert into cidade values('MG',	34)
insert into cidade values('MG',	35)
insert into cidade values('MG',	37)
insert into cidade values('MG',	38)
insert into cidade values('PR',	41)
insert into cidade values('PR',	42)
insert into cidade values('PR',	43)
insert into cidade values('PR',	44)
insert into cidade values('PR',	45)
insert into cidade values('PR',	46)
insert into cidade values('SC',	47)
insert into cidade values('SC',	48)
insert into cidade values('SC',	49)
insert into cidade values('RS',	51)
insert into cidade values('RS',	53)
insert into cidade values('RS',	54)
insert into cidade values('RS',	55)
insert into cidade values('DF',	61)
insert into cidade values('GO',	62)
insert into cidade values('TO',	63)
insert into cidade values('GO',	64)
insert into cidade values('MT',	65)
insert into cidade values('MT',	66)
insert into cidade values('MS',	67)
insert into cidade values('AC',	68)
insert into cidade values('RO',	69)
insert into cidade values('BA',	71)
insert into cidade values('BA',	73)
insert into cidade values('BA',	74)
insert into cidade values('BA',	75)
insert into cidade values('BA',	77)
insert into cidade values('SE',	79)
insert into cidade values('PE',	81)
insert into cidade values('AL',	82)
insert into cidade values('PB',	83)
insert into cidade values('RN',	84)
insert into cidade values('CE',	85)
insert into cidade values('PI',	86)
insert into cidade values('PE',	87)
insert into cidade values('CE',	88)
insert into cidade values('PI',	89)
insert into cidade values('PA',	91)
insert into cidade values('AM',	92)
insert into cidade values('PA',	93)
insert into cidade values('PA',	94)
insert into cidade values('RR',	95)
insert into cidade values('AP',	96)
insert into cidade values('AM',	97)
insert into cidade values('MA',	98)
insert into cidade values('MA',	99)

select * from cidade
where UF in ('MG', 'BA', 'MT', 'PE', 'MA', 'CE', 'PA', 'AM', 'SP', 'RJ', 'ES', 'PR', 'RS', 'SC')



select	pessoa, telefone 
from	cliente
where	telefone like '13%'

select	id, pessoa
from	cliente
where	pessoa like 'robo%'

select	id, pessoa, telefone
from	cliente
where	pessoa = '0'


select * from cliente

create table erroCliente
(
id int,
data date,
hora time,
pessoa varchar(50),
cpf varchar(50),
telefone varchar(50)
)

-- intem 3
select	* 
into	erroCliente 
from	Cliente 
where	pessoa = '0' or cpf = '0' or telefone = '0'

select * from  erroCliente




-- Cliente formatado

create table clienteFormatado
(
id int,
datahora datetime,
pessoa varchar(50),
cpf varchar(15),
ddd tinyint,
telefone varchar(9),
uf char(2)
)

select	* 
into	clienteFormatado 
from	Cliente 
where	





select * from cliente
select * from clienteFormatado


insert into clienteFormatado
(id, datahora, pessoa, cpf, ddd, telefone) 
select	id,
		cast(concat(convert(varchar, data, 112),' ', left(hora, len(hora)-4)) as datetime) as datahora,
		pessoa,
		LEFT(cpf,3)+'.'+SUBSTRING(cpf,4,3)+'.'+SUBSTRING(cpf,7,3)+'-'+SUBSTRING(cpf,10,2),
		left(telefone,2),
		substring(telefone,3,9)
		
from	Cliente
where	id not in (select id from  erroCliente)



select * from clienteFormatado
select * from cidade

update clienteFormatado
set uf = c.uf
from clienteFormatado f inner join cidade c
on f.ddd = c.ddd