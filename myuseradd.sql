CREATE USER 'imnewhere'@'localhost' IDENTIFIED BY 'letyourselfin';
GRANT ALL PRIVILEGES ON *.* TO 'imnewhere'@'localhost' WITH GRANT OPTION;
CREATE USER 'imnewhere'@'%' IDENTIFIED BY 'letyourselfin';
GRANT ALL PRIVILEGES ON *.* TO 'imnewhere'@'%' WITH GRANT OPTION;