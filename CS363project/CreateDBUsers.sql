CREATE USER IF NOT EXISTS
	'cs363@%1'@'localhost'
	IDENTIFIED BY 'buffalo';

GRANT SELECT, DROP, CREATE, INSERT, DELETE
	ON twitterdb.* 
	TO 'cs363@%1'@'localhost';
	
flush privileges;