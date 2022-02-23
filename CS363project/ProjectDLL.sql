DROP DATABASE IF EXISTS `cs363teamproject`;
CREATE DATABASE IF NOT EXISTS `cs363teamproject`;
use `cs363teamproject`;

DROP TABLE IF EXISTS `UserAccounts`;

CREATE TABLE `UserAccounts` (
	name VARCHAR(40),
	screen_name VARCHAR(40),
	following INT,
	followers INT,
	-- category ENUM("senate_group", "presidential_candidate", "reporter", "Senator", "General", "null", ""),
    -- House_representative is listed in the .csv but not in the pdf?
    category ENUM("senate_group", "presidential_candidate", "reporter", "Senator", "General", "null", "", "House_representative"),
	sub_category ENUM("GOP", "Democrat", "na", "null", ""),
	state VARCHAR(40),
	location VARCHAR(120),

	PRIMARY KEY (screen_name)
);

DROP TABLE IF EXISTS `Tweets`;
CREATE TABLE `Tweets` (
	id double,
	tweet_text VARCHAR(280),
	retweet_count INT,
	created_at DATE,
	tweeted_by VARCHAR(80) NOT NULL,

	PRIMARY KEY (id),
	FOREIGN KEY (tweeted_by) REFERENCES UserAccounts(screen_name)
); 

DROP TABLE IF EXISTS `URLs`;
CREATE TABLE `URLs` (
	-- urls are automatically shortened to 23 characters, so the 280 limit does not apply here
	address VARCHAR(560),

	PRIMARY KEY (address)
);

DROP TABLE IF EXISTS `Hashtags`;
CREATE TABLE `Hashtags` (
	name VARCHAR(280),

	PRIMARY KEY (name)
);

DROP TABLE IF EXISTS `HasURLs`;
CREATE TABLE `HasURLs` (
	id double,
	address VARCHAR(560),
	PRIMARY KEY (id, address),

	FOREIGN KEY (id) REFERENCES Tweets(id),
	FOREIGN KEY (address) REFERENCES URLs(address)
);

CREATE TRIGGER HasURLSTrigger AFTER DELETE ON HasURLs
FOR EACH ROW DELETE
	from URLs u
	where not exists (
		select name from HasURLs
		where HasURLS.address = URLs.address
	);


DROP TABLE IF EXISTS `HasHashtag`;
CREATE TABLE `HasHashtag` (
	id double,
	name VARCHAR(280),

	PRIMARY KEY (id, name),
	FOREIGN KEY (id) REFERENCES Tweets(id),
	FOREIGN KEY (name) REFERENCES Hashtags(name)
);

CREATE TRIGGER HasHashtagTrigger AFTER DELETE ON HasHashtag
FOR EACH ROW DELETE
	from Hashtags h
	where not exists (
		select name from HasHashTag
		where HasHashTag.name = Hashtags.name
	);

DROP TABLE IF EXISTS `Mention`;
CREATE TABLE `Mention` (
	id double,
	screen_name VARCHAR(80),

	PRIMARY KEY (id, screen_name),
	FOREIGN KEY (id) REFERENCES Tweets(id),
	FOREIGN KEY (screen_name) REFERENCES UserAccounts(screen_name)
);

Drop trigger if exists createHashTagTrigger;
CREATE TRIGGER createHashTagTrigger BEFORE INSERT ON HasHashtag
FOR EACH ROW insert
	into Hashtags
    select New.name
	where not exists (
		select name from Hashtags 
		where Hashtags.name = New.name
	);

    
Drop trigger if exists createURLsTrigger;
CREATE TRIGGER createURLsTrigger BEFORE INSERT ON HasURLs
FOR EACH ROW INSERT
	into Urls
    select New.address
	where not exists (
		select address from Urls 
		where Urls.address = New.address
	);
