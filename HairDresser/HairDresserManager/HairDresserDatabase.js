var localDB = null;

function onInit(){
    try {
        if (!window.openDatabase) {
            updateStatus("Erro: Seu navegador não permite banco de dados.");
        }
        else {
            initDB();
            createTables();
            queryAndUpdateOverview();
        }
    } 
    catch (e) {
        if (e == 2) {
            updateStatus("Erro: Versão de banco de dados inválida.");
        }
        else {
            updateStatus("Erro: Erro desconhecido: " + e + ".");
        }
        return;
    }
}

function initDB(){
    var shortName = 'HairDresserDB';
    var version = '3.0';
    var displayName = 'Hair Dresser Database';
    var maxSize = 65536; // Em bytes
    localDB = window.openDatabase(shortName, version, displayName, maxSize);
}

function onUpdate(){
    var CodCliente = document.itemForm.CodCliente.value;
    var Nome = document.itemForm.Nome.value;
    var Telefone = document.itemForm.Telefone.value;
    if (Nome == "" || Telefone == "") {
        updateStatus("Nome e Telefone são campos obrigatórios!");
    }
    else {
        var query = "update cliente set Nome=?, Telefone=? where CodCliente=?;";
        try {
            localDB.transaction(function(transaction){
                transaction.executeSql(query, [Nome, Telefone, CodCliente], function(transaction, results){
                    if (!results.rowsAffected) {
                        updateStatus("Erro: Update não realizado.");
                    }
                    else {
                        updateForm("", "", "");
                        updateStatus("Alteração realizada");
                        queryAndUpdateOverview();
                    }
                }, errorHandler);
            });
        } 
        catch (e) {
            updateStatus("Erro: Alteração não realizada " + e + ".");
        }
    }
}

function onDelete(){

	if (!confirm('O cliente selecionado sera excluido \n Você confirma?')) {
       return; 
    } 
	
    var CodCliente = document.itemForm.CodCliente.value;   
    var query = "delete from Cliente where CodCliente=?;";
    try {
        localDB.transaction(function(transaction){
        
            transaction.executeSql(query, [CodCliente], function(transaction, results){
                if (!results.rowsAffected) {
                    alert("Erro: Exclusão não realizada.");
                }
                else {
                    updateForm("", "", "");
                    alert("Linha apagada:");
                    queryAndUpdateOverview();
                }
            }, errorHandler);
        });
    } 
    catch (e) {
        updateStatus("Erro: Exclusão não realizada " + e + ".");
    }
    
}

function onCreate(){
    var Nome = document.itemForm.Nome.value;
    var Telefone = document.itemForm.Telefone.value;
    if (Nome == "" || Telefone == "") {
        updateStatus("Erro: Nome e Telefone são campos obrigatórios!");
    }
    else {
        var query = "insert into Cliente (Nome, Telefone) VALUES (?, ?);";
        try {
            localDB.transaction(function(transaction){
                transaction.executeSql(query, [Nome, Telefone], function(transaction, results){
                    if (!results.rowsAffected) {
                        alert("Erro: Inclusão não realizada");
                    }
                    else {
                        updateForm("", "", "");
                        updateStatus("Inclusão realizada");
                        queryAndUpdateOverview();
                    }
                }, errorHandler);
            });
        } 
        catch (e) {
            updateStatus("Erro: INSERT não realizado " + e + ".");
        }
    }
}

function onSelect(htmlLIElement){
	var CodCliente = htmlLIElement.getAttribute("CodCliente");
	
	query = "SELECT * FROM CLIENTE where CodCliente=?;";
    try {
        localDB.transaction(function(transaction){
        
            transaction.executeSql(query, [CodCliente], function(transaction, results){
            
                var row = results.rows.item(0);
                
                updateForm(row['CodCliente'], row['Nome'], row['Telefone']);
                
            }, function(transaction, error){
                updateStatus("Erro: " + error.code + "<br>Mensagem: " + error.message);
            });
        });
    } 
    catch (e) {
        updateStatus("Error: SELECT não realizado " + e + ".");
    }
   
}

function queryAndUpdateOverview(){
	//Remove as linhas existentes para inserção das novas
    var dataRows = document.getElementById("itemData").getElementsByClassName("data");
	
    while (dataRows.length > 0) {
        row = dataRows[0];
        document.getElementById("itemData").removeChild(row);
    };
    
    var query = "SELECT * FROM CLIENTE;";
    try {  			
        	localDB.transaction(function(transaction){
            transaction.executeSql(query, [], function(transaction, results){

			for (var i = 0; i < results.rows.length; i++) {                
                    var row = results.rows.item(i);
                    var li = document.createElement("li");
					li.setAttribute("CodCliente", row['CodCliente']);
                    li.setAttribute("class", "data");
                    li.setAttribute("onclick", "onSelect(this)");
                    var liText = document.createTextNode(row['Nome']);
                    li.appendChild(liText);
                    
                    document.getElementById("itemData").appendChild(li);
                }
            }, function(transaction, error){
                       updateStatus("Erro: " + error.code + "<br>Mensagem: " + error.message);
            });
        });
    } 
    catch (e) {
        updateStatus("Error: SELECT não realizado " + e + ".");
    }
}

errorHandler = function(transaction, error){
    updateStatus("Erro: " + error.message);
    return true;
}

nullDataHandler = function(transaction, results){
}

function updateForm(CodCliente, Nome, Telefone){
    document.itemForm.CodCliente.value = CodCliente;
    document.itemForm.Nome.value = Nome;
    document.itemForm.Telefone.value = Telefone;
}

function updateStatus(status){
    document.getElementById('status').innerHTML = status;
}

function createTables(){

		var script  = "PRAGMA foreign_keys = ON;$";  
		    script += "CREATE TABLE if not exists Cliente (CodCliente INTEGER PRIMARY KEY AUTOINCREMENT ,Nome VARCHAR(50) NOT NULL ,Telefone VARCHAR(15) NOT NULL ,CaminhoImagem VARCHAR(45) NULL) ;$"; 
            script += "CREATE TABLE if not exists Servico(CodServico INTEGER PRIMARY KEY AUTOINCREMENT ,Nome VARCHAR(50) NOT NULL ,Descricao VARCHAR(100) NULL ,CaminhoImagem VARCHAR(45) NULL ,Preco DOUBLE NOT NULL ,Desconto DOUBLE NULL);$";
            script += "CREATE TABLE if not exists Profissional (CodProfissional INTEGER PRIMARY KEY AUTOINCREMENT ,Nome VARCHAR(50) NOT NULL ,CaminhoImagem VARCHAR(45) NULL);$";
            script += "CREATE TABLE if not exists Agenda (CodServico INT ,CodProfissional INT NOT NULL ,CodCliente INT NOT NULL,DataHora DATETIME NOT NULL,FOREIGN KEY(CodCliente) REFERENCES CLIENTE(CodCliente),FOREIGN KEY(CodProfissional) REFERENCES PROFISSIONAL(CodProfissional),FOREIGN KEY(CodServico) REFERENCES SERVICO(CodServico));$";  
			script += "CREATE TABLE if not exists ServicoProfissional (CodServico INTEGER NOT NULL ,  CodProfissional INTEGER NOT NULL ,  CONSTRAINT IdxServicoProfissional  FOREIGN KEY (CodServico) REFERENCES servico (CodServico),  FOREIGN KEY (CodProfissional)  REFERENCES profissional (CodProfissional));$";  
			
			try {
                var queries = script.split("$");
				
				for( var i = 0; i < queries.length; i++ ) {					
				    criar(queries[i]);
            	 }   
				updateStatus("Criacao das tabelas OK");
            }
        catch (e) {
               updateStatus("Erro: Criacao das tabelas: " + e + ".");
               return;
		}	   
 }

 function criar(queries){
	localDB.transaction(function(transaction){
         transaction.executeSql(queries,[], nullDataHandler, errorHandler);  
        });
 }
 




