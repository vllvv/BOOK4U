CREATE DATABASE BBS;

USE BBS;
CREATE TABLE USER (
	userID VARCHAR(20),
	userPassword VARCHAR(20),
	userName VARCHAR(20),
	userEmail VARCHAR(50),
	userPoint INT,
	userRole VARCHAR(20),
	PRIMARY KEY (userID)
);
CREATE TABLE BBS (
	bbsID INT,
	bbsTitle VARCHAR(50),
	userID VARCHAR(20),
	bbsDate DATETIME,
	bbsContent VARCHAR(2048),
	bbsAvailable INT,
	fileName VARCHAR(200),
	fileRealName VARCHAR(200),
	PRIMARY KEY (bbsID)
);
CREATE TABLE LODGING (
	id INT AUTO_INCREMENT,
	title VARCHAR(50),
	price INT,
	location VARCHAR(100),
	reserv BOOLEAN,
	img VARCHAR(100),
	description VARCHAR(100),
	PRIMARY KEY (id)
);
CREATE TABLE RESERV(
	userID VARCHAR(20),
	id INT,
	price INT,
	checkin VARCHAR(20),
	checkout VARCHAR(20),
	reservID VARCHAR(20),
	title VARCHAR(20),
	FOREIGN KEY (userID) REFERENCES USER(userID),
	FOREIGN KEY (id) REFERENCES LODGING(id)
);
INSERT INTO USER(userID, userPassword, userName, userEmail, userPoint, userRole)
	values("admin", "admin", "admin", "admin@admin.com", 10000000, "Admin");
INSERT INTO LODGING(title, price, location, reserv, img, description)
	values("신라호텔", 500000,"서울", true, "http://api.book4u.net/SSRF/images/sin","상세설명");
INSERT INTO LODGING(title, price, location, reserv, img, description)
	values("시그니엘 호텔", 700000,"서울", true, "http://api.book4u.net/SSRF/images/sig","상세설명");
INSERT INTO LODGING(title, price, location, reserv, img, description)
	values("파크하얏트호텔", 600000,"서울", true, "http://api.book4u.net/SSRF/images/pk","상세설명");
INSERT INTO LODGING(title, price, location, reserv, img, description)
	values("반얀트리호텔", 560000,"서울", true, "http://api.book4u.net/SSRF/images/ban","상세설명");
INSERT INTO LODGING(title, price, location, reserv, img, description)
	values("워커힐호텔", 750000,"서울", true, "http://api.book4u.net/SSRF/images/wh","상세설명");
INSERT INTO LODGING(title, price, location, reserv, img, description)
	values("파라다이스호텔", 820000,"인천", true, "http://api.book4u.net/SSRF/images/ph","상세설명");
INSERT INTO LODGING(title, price, location, reserv, img, description)
	values("콘래드호텔", 890000,"서울", true, "http://api.book4u.net/SSRF/images/ch","상세설명");