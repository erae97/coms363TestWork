-- use `cs363teamproject`;

CREATE TABLE `appusers`(
	name VARCHAR(40),
	hashPwd VARCHAR(100),
	privilege ENUM('all','readonly'),
	
	PRIMARY KEY (name)
);

INSERT INTO `appusers`
	VALUES('user1',SHA('pwd1'),'all');
	
INSERT INTO `appusers`
	VALUES('user2',SHA('pwd2'),'readonly');