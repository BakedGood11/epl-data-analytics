##################################################################################
####################### Create Fixtures staging table ############################
##################################################################################
CREATE TABLE pl_fixtures_staging (
    match_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    week INT NOT NULL,
    match_date DATE,
    match_day VARCHAR(20) NOT NULL,
    match_time TIME,
    home_team VARCHAR(50),
    away_team VARCHAR(50),
    venue VARCHAR(150)
)

LOAD DATA LOCAL INFILE '/home/migi/Documents/pl-fixtures/epl-fixtures-2025.csv'
INTO TABLE pl_fixtures_staging
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(week, match_date, match_day, match_time, home_team, away_team, venue);

DROP TABLE pl_fixtures_staging;


##############################################################################
##################### Creating Normalized Fixtures Table #####################
##############################################################################
CREATE TABLE pl_fixtures (
    match_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    week INT NOT NULL,
    match_date DATE,
    match_day VARCHAR(20) NOT NULL,
    match_time TIME,
    home_team_id INT,
    away_team_id INT,
    venue VARCHAR(150)
)

ALTER TABLE pl_fixtures
  RENAME COLUMN match_id TO fixture_id;


INSERT INTO pl_fixtures (week, match_date, match_day, match_time, home_team_id, away_team_id, venue)
SELECT
    stage.week,
    stage.match_date,
    stage.match_day,
    stage.match_time,
    home_team.team_id AS home_team_id,
    away_team.team_id AS away_team_id,
    stage.venue
FROM pl_fixtures_staging stage
JOIN pl_teams home_team 
    ON stage.home_team = home_team.team_name
JOIN pl_teams away_team 
    ON stage.away_team = away_team.team_name
;

SELECT *
FROM pl_fixtures
ORDER BY week;

DROP TABLE pl_fixtures;
