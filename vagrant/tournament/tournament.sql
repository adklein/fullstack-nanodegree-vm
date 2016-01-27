-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP VIEW IF EXISTS standings;
DROP VIEW IF EXISTS wins;
DROP VIEW IF EXISTS losses;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS players;
DROP DATABASE IF EXISTS tournament;





CREATE DATABASE tournament;
\c tournament;
CREATE TABLE players 
(
    playerID serial PRIMARY KEY,
    name varchar(255)
);

CREATE TABLE matches
(
    mathchID serial PRIMARY KEY,
    winnerID int,
    loserID int
);

CREATE VIEW wins AS
    SELECT p.playerID,
    count(m.winnerID) AS w
    FROM players AS p
    LEFT JOIN matches as m
    ON p.playerID = m.winnerID
    GROUP BY p.playerID
    ORDER BY w desc;

CREATE VIEW losses AS
    SELECT p.playerID,
    count(m.loserID) AS l
    FROM players AS p
    LEFT JOIN matches as m
    ON p.playerID = m.loserID
    GROUP BY p.playerID
    ORDER BY l desc;

CREATE VIEW standings AS
    SELECT p.playerID,
    p.name,
    wins.w,
    losses.l + wins.w AS mCount
    FROM players AS p LEFT JOIN wins
        ON p.playerID = wins.playerID LEFT JOIN losses
        ON p.playerID = losses.playerID
    GROUP BY p.playerID, wins.w, mCount
    ORDER BY wins.w desc;



