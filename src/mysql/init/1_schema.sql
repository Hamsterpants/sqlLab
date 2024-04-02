-- Create the database
DROP DATABASE IF EXISTS game_db;

CREATE DATABASE IF NOT EXISTS game_db DEFAULT CHARACTER SET UTF8MB4;
USE game_db;

DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Maps;
DROP TABLE IF EXISTS HiScores;

CREATE TABLE Users (
  ID BIGINT PRIMARY KEY,
  FirstName VARCHAR(20) NOT NULL,
  LastName VARCHAR(20),
  InGameName VARCHAR(20) NOT NULL UNIQUE,
  Email VARCHAR(255) NOT NULL UNIQUE,
  PasswordSalt CHAR(36),
  PasswordHash VARCHAR(80),
  CreatedDate DATETIME,
  LastOnline DATETIME,
  IsActive BIT
);

CREATE TABLE Maps (
  ID BIGINT PRIMARY KEY,
  Name VARCHAR(20) NOT NULL UNIQUE,
  CreatedDate DATETIME,
  LastModified DATETIME,
  IsActive BIT
);

CREATE TABLE HiScores (
  ID BIGINT PRIMARY KEY,
  Map BIGINT,
  User BIGINT,
  Time TIME NOT NULL,
  FOREIGN KEY (Map) REFERENCES Maps(ID),
  FOREIGN KEY (User) REFERENCES Users(ID)
);