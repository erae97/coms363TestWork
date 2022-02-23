use `cs363teamproject`;

Load Data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataCSV/user.csv'
into table UserAccounts
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(screen_name, name, sub_category, category, state, followers, following);

Load Data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataCSV/tweets.csv'
into table Tweets
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id,tweet_text,retweet_count,@col4,created_at,tweeted_by);

Load Data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataCSV/tagged.csv'
into table HasHashtag
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, name);

Load Data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataCSV/mentioned.csv'
into table Mention
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, screen_name);

Load Data infile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dataCSV/urlused.csv'
into table HasURLs
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id, address);
