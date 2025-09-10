#####################################################################################
### Creating Staging Table for pl_matches Table to Host All Match Specific Data #####
#####################################################################################
CREATE TABLE pl_matches_staging (
    Wk FLOAT,
    Day VARCHAR(10),
    Date DATE,
    Time TIME,
    Home VARCHAR(50),
    xG DECIMAL(4,2),
    Score VARCHAR(5),      
    xG_away DECIMAL(4,2),
    Away VARCHAR(50),
    Attendance INT,
    Venue VARCHAR(150),
    Referee VARCHAR(100),
    Match_Report TEXT,
    Notes TEXT
);

LOAD DATA LOCAL INFILE '/home/migi/Documents/data-science-learning/sql-practice/prem-league-player-stats/fbref_premier_league_2024_2025.csv'
INTO TABLE pl_matches_staging
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
;


DROP TABLE pl_matches_staging;

##################################################################################
### Creating Normalized Table for pl_matches to Host All Match Specific Data #####
##################################################################################
CREATE TABLE pl_matches (
    match_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fixture_id INT NOT NULL,
    match_date DATE,
    Wk FLOAT,
    Day VARCHAR(10),
    Time TIME,
    home_team_id VARCHAR(50),
    away_team_id VARCHAR(50),
    home_score INT,
    away_score INT,    
    xG DECIMAL(4,2),
    xG_away DECIMAL(4,2),
    venue_id INT,
    Attendance INT,
    Referee VARCHAR(100)
);
INSERT INTO pl_matches (
    fixture_id, match_date, Wk, Day, Time, home_team_id, away_team_id,
    home_score, away_score, xG, xG_away, venue_id, Attendance, Referee
)
SELECT
    f.fixture_id AS fixture_id,
    i.Date AS match_date,
    i.Wk AS Wk,
    i.Day AS Day,
    i.Time AS Time,
    home_team.team_id AS home_team_id,
    away_team.team_id AS away_team_id,
    CAST(SUBSTRING_INDEX(i.Score, '–', 1) AS UNSIGNED) AS home_score,
    CAST(SUBSTRING_INDEX(i.Score, '–', -1) AS UNSIGNED) AS away_score,
    i.xG AS xG,
    i.xG_away AS xG_away,
    v.venue_id AS venue_id,
    i.Attendance AS Attendance,
    i.Referee AS Referee
FROM z_pl_matches_staging i
JOIN pl_teams home_team
    ON i.Home = home_team.team_name
JOIN pl_teams away_team
    ON i.Away = away_team.team_name
JOIN pl_fixtures f
    ON f.home_team_id = home_team.team_id
    AND f.away_team_id = away_team.team_id
JOIN pl_venues v
    ON v.venue_name = i.Venue;

DROP TABLE pl_matches;