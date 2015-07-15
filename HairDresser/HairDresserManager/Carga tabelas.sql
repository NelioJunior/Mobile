-- Carga das tabelas do sistema Hairdresser 
--                                           Nelio Júnior - Junho/2015
delete from cliente; 
insert into cliente(nome, telefone, CaminhoImagem) values('Josie and the Pussycats', '+55 11 9998 5645', 'Não definido') ;
insert into cliente(nome, telefone, CaminhoImagem) values('Penelope Charmosa', '+55 21 9934 2323', 'Não definido') ;
insert into cliente(nome, telefone, CaminhoImagem) values('Monica dentuça', '+55 11 87799 1122', 'Não definido') ;
insert into cliente(nome, telefone, CaminhoImagem) values('Lindinha', '+55 31 6777655', 'Não definido') ;
insert into cliente(nome, telefone, CaminhoImagem) values('Florzinha', '+55 21 9221 1331', 'Não definido') ;

-- select * from cliente;

delete from servico;
insert into servico(Nome,Preco) values('Corte infantil feminino', 30.00);
insert into servico(Nome,Preco) values('Corte infantil masculino', 25.00);
insert into servico(Nome,Preco) values('Corte feminino', 70.00); 
insert into servico(Nome,Preco) values('Corte masculino', 30.00);
insert into servico(Nome,Preco) values('Pedicure', 30.00);

-- SELECT * FROM SERVICO; 

delete from profissional; 
insert into profissional(nome) values('Zé Colmeia');
insert into profissional(nome)  values('Ursinho Ted');
insert into profissional(nome)  values('Catatau');
insert into profissional(nome)  values('Ursinho Carinhoso');
insert into profissional(nome)  values('Urso Fonzie');

-- Select * from profissional ;

delete from ServicoProfissional;
insert into ServicoProfissional(CodServico, CodProfissional) values(1,5) ;

PRAGMA foreign_keys = ON;
-- select * from ServicoProfissional;  
delete from agenda;
insert into agenda(CodServico, CodProfissional, CodCliente, DataHora)  values(3, 2, 1 , "2015-07-12 14:30");
insert into agenda(CodServico, CodProfissional, CodCliente, DataHora)  values(3, 4, 1 , "2015-07-12 14:30");
insert into agenda(CodServico, CodProfissional, CodCliente, DataHora)  values(3, 4, 1 , "2015AASSS-17-12 14:30");

select * from agenda;
select * from cliente;
select * from servico;
select * from profissional;
select * from ServicoProfissional;
