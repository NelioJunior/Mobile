/*
      Notas: NO SQLITE Se eu quero usar o Auto Increment em um campo chave primaria, eu tenho que escrever
             INTEGER sem abreviar, se eu utilizar INT d� erro na cria��o da tabela (vai intender...)

                                                                                      N�lio J�nior/Junho 2015          
            
            --Sem a seguinte comando a integridade referencial SIMPLESMENTE n�o funciona: 
            PRAGMA foreign_keys = ON;

            -- Verifica a vers�o do seu SQLite                                                                           
               select sqlite_version(); 

*/
PRAGMA foreign_keys = ON;

select * from artist;

insert into artist(artistname) values('Dean Martin');
insert into artist(artistname) values('Frank Sinatra');
insert into artist(artistname) values('Frank Sinatra');


select * from track; 

insert into track(trackid, trackname,trackartist) values (11,'Thats Amore ',1) ;
insert into track(trackid, trackname,trackartist) values (12,'Christmas Blues ',1) ;
insert into track(trackid, trackname,trackartist) values (13,'My Ways ',2) ;

INSERT INTO track VALUES(14, 'Mr. Bojangles', 3);   

