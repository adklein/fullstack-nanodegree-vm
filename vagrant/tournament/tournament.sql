-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE tournament;
DROP TABLE players;
DROP TABLE matches;
DROP VIEW wins;
DROP VIEW losses;
DROP VIEW standings;

CREATE DATABASE tournament;
\c tournament;
CREATE TABLE players 
(
playerID int,
name varchar(255)
);

CREATE TABLE matches
(
    mathchID int,
    winnerID int,
    loserID int
);

CREATE VIEW wins AS
    SELECT p.playerID,
    count(m.winnerID) AS w
    FROM players AS p
    JOIN matches as m
    ON p.playerID = m.winnerID
    GROUP BY p.playerID
    ORDER BY w desc;

CREATE VIEW losses AS
    SELECT p.playerID,
    count(m.loserID) AS l
    FROM players AS p
    JOIN matches as m
    ON p.playerID = m.loserID
    GROUP BY p.playerID
    ORDER BY l desc;

CREATE VIEW standings AS
    SELECT p.playerID,
    wins.w,
    losses.l
    FROM players AS p JOIN wins
        ON p.playerID = wins.playerID JOIN losses
        ON p.playerID = losses.playerID
    GROUP BY p.playerID, wins.w, losses.l
    ORDER BY wins.w desc;



