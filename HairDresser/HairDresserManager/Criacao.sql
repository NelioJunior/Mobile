/*

     Carga das tabelas do sistema Hairdresser 

      Notas: NO SQLITE Se eu quero usar o Auto Increment em um campo chave primaria, eu tenho que escrever
             INTEGER sem abreviar, se eu utilizar INT dá erro na criação da tabela (vai intender...)

                                                                                      Nélio Júnior/Junho 2015          
            
            --Sem a seguinte comando a integridade referencial SIMPLESMENTE não funciona: 
            PRAGMA foreign_keys = ON;
            
            -- Verifica a versão do seu SQLite                                                                           
               select sqlite_version(); 

           -- O Banco de dados SQLite do Chrime (WebSQL)  fisicamente fica localiado em:
            \Users\_username_\AppData\Local\Google\Chrome\User Data\Default\databases (\file__0 )                                                                                      
*/

PRAGMA foreign_keys = ON;
CREATE TABLE if not exists Cliente (CodCliente INTEGER PRIMARY KEY AUTOINCREMENT , Nome VARCHAR(50) NOT NULL , Telefone VARCHAR(15) NOT NULL , CaminhoImagem VARCHAR(45) NULL) ;
CREATE TABLE if not exists Servico(CodServico INTEGER PRIMARY KEY AUTOINCREMENT ,Nome VARCHAR(50) NOT NULL ,Descricao VARCHAR(100) NULL ,CaminhoImagem VARCHAR(45) NULL ,Preco DOUBLE NOT NULL ,Desconto DOUBLE NULL);
CREATE TABLE if not exists Profissional (CodProfissional INTEGER PRIMARY KEY AUTOINCREMENT ,Nome VARCHAR(50) NOT NULL ,CaminhoImagem VARCHAR(45) NULL);
CREATE TABLE Agenda (CodServico INT ,CodProfissional INT NOT NULL ,CodCliente INT NOT NULL,DataHora DATETIME NOT NULL,FOREIGN KEY(CodCliente) REFERENCES CLIENTE(CodCliente),FOREIGN KEY(CodProfissional) REFERENCES PROFISSIONAL(CodProfissional),FOREIGN KEY(CodServico) REFERENCES SERVICO(CodServico));
CREATE TABLE ServicoProfissional (CodServico INTEGER NOT NULL ,  CodProfissional INTEGER NOT NULL ,  CONSTRAINT IdxServicoProfissional  FOREIGN KEY (CodServico) REFERENCES servico (CodServico),  FOREIGN KEY (CodProfissional)  REFERENCES profissional (CodProfissional));
