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

DROP TABLE IF EXISTS Cliente; 

CREATE TABLE Cliente (
CodCliente INTEGER PRIMARY KEY AUTOINCREMENT ,
Nome VARCHAR(50) NOT NULL ,
Telefone VARCHAR(15) NOT NULL ,
CaminhoImagem VARCHAR(45) NULL) ;

DROP TABLE IF EXISTS Servico; 

CREATE TABLE Servico(
CodServico INTEGER PRIMARY KEY AUTOINCREMENT ,
Nome VARCHAR(50) NOT NULL ,
Descricao VARCHAR(100) NULL ,
CaminhoImagem VARCHAR(45) NULL ,
Preco DOUBLE NOT NULL ,
Desconto DOUBLE NULL);

DROP TABLE IF EXISTS Profissional; 

CREATE TABLE Profissional (
CodProfissional INTEGER PRIMARY KEY AUTOINCREMENT ,
Nome VARCHAR(50) NOT NULL ,
CaminhoImagem VARCHAR(45) NULL);

DROP TABLE IF EXISTS Agenda; 

CREATE TABLE Agenda (
CodServico INT ,
CodProfissional INT NOT NULL ,
CodCliente INT NOT NULL,
DataHora DATETIME NOT NULL,
FOREIGN KEY(CodCliente) REFERENCES CLIENTE(CodCliente),
FOREIGN KEY(CodProfissional) REFERENCES PROFISSIONAL(CodProfissional),
FOREIGN KEY(CodServico) REFERENCES SERVICO(CodServico));

DROP TABLE IF EXISTS ServicoProfissional; 

CREATE TABLE ServicoProfissional (
  CodServico INTEGER NOT NULL ,
  CodProfissional INTEGER NOT NULL ,
  CONSTRAINT IdxServicoProfissional
  FOREIGN KEY (CodServico) REFERENCES servico (CodServico),
  FOREIGN KEY (CodProfissional)  REFERENCES profissional (CodProfissional));
