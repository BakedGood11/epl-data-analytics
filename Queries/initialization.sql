#######################################################################
## Creating Raw Player Stats Table as Staging Table and Loading Data ##
#######################################################################
CREATE TABLE pl_player_stats(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Player VARCHAR(50),
    Team VARCHAR(50),
    Number INT,
    Nation VARCHAR(50),
    Position VARCHAR(10),
    Age INT,
    Minutes INT,
    Goals INT,
    Assists INT,
    Penalty_ShotOnGoal INT,
    Penalty_Shots INT,
    Total_Shots INT,
    ShotsOnTarget INT,
    Yellow_Cards INT,
    Red_Cards INT,
    Touches INT,
    Dribbles INT,
    Tackles INT,
    Blocks INT,
    Expected_Goals DECIMAL(5,3),
    Non_Penalty_Expected_Goals DECIMAL(5,3),
    Expected_Assists DECIMAL(5,3),
    Shot_Creating_Actions INT,
    Goal_Creating_Actions INT,
    Passes_Completed INT,
    Passes_Attempted INT,
    Pass_Completion_Percentage DECIMAL(5,2),
    Progressive_Passes INT,
    Carries INT,
    Progressive_Carries INT,
    Dribbles_Attempted INT,
    Succesful_Dribbles INT,
    Date DATE
) COMMENT 'Premiere League Player Stats, 2024-2025 Season';

LOAD DATA LOCAL INFILE '/home/migi/data-science/database.csv'
INTO TABLE pl_player_stats
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(   Player,
    Team,
    Number,
    Nation,
    Position,
    Age,
    Minutes,
    Goals,
    Assists,
    Penalty_ShotOnGoal,
    Penalty_Shots,
    Total_Shots,
    ShotsOnTarget,
    Yellow_Cards,
    Red_Cards,
    Touches,
    Dribbles,
    Tackles,
    Blocks,
    Expected_Goals,
    Non_Penalty_Expected_Goals,
    Expected_Assists,
    Shot_Creating_Actions,
    Goal_Creating_Actions,
    Passes_Completed,
    Passes_Attempted,
    Pass_Completion_Percentage,
    Progressive_Passes,
    Carries,
    Progressive_Carries,
    Dribbles_Attempted,
    Succesful_Dribbles,
    Date);

    
-- To remove the table if needed
DROP TABLE pl_player_stats;

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

#################################################################################
############## Creating the normalized player_match_stats Table #################
#################################################################################

CREATE TABLE player_match_stats (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    match_id INT NOT NULL COMMENT 'Foreign Key to pl_matches(match_id)',
    fixture_id INT NOT NULL,
    venue_id INT NOT NULL,
    ref_id INT NOT NULL,
    player_id INT NOT NULL,
    team_id INT NOT NULL,
    Number INT,
    Position VARCHAR(10),
    Age INT,
    Minutes INT,
    Goals INT,
    Assists INT,
    Penalty_ShotOnGoal INT,
    Penalty_Shots INT,
    Total_Shots INT,
    ShotsOnTarget INT,
    Yellow_Cards INT,
    Red_Cards INT,
    Touches INT,
    Dribbles INT,
    Tackles INT,
    Blocks INT,
    Expected_Goals DECIMAL(5,3),
    Non_Penalty_Expected_Goals DECIMAL(5,3),
    Expected_Assists DECIMAL(5,3),
    Shot_Creating_Actions INT,
    Goal_Creating_Actions INT,
    Passes_Completed INT,
    Passes_Attempted INT,
    Pass_Completion_Percentage DECIMAL(5,2),
    Progressive_Passes INT,
    Carries INT,
    Progressive_Carries INT,
    Dribbles_Attempted INT,
    Succesful_Dribbles INT,
    match_date DATE,
    CONSTRAINT stats_match FOREIGN KEY (match_id) REFERENCES pl_matches(match_id),
    CONSTRAINT stats_fix FOREIGN KEY (fixture_id) REFERENCES pl_fixtures(fixture_id),
    CONSTRAINT stats_venue FOREIGN KEY (venue_id) REFERENCES pl_venues(venue_id),
    CONSTRAINT stats_ref FOREIGN KEY (ref_id) REFERENCES pl_referees(ref_id),
    CONSTRAINT stats_player FOREIGN KEY (player_id) REFERENCES pl_players(player_id),
    CONSTRAINT stats_team FOREIGN KEY (team_id) REFERENCES pl_teams(team_id),
    CONSTRAINT stats_uni UNIQUE (player_id, match_id)
) COMMENT 'Table for Normalized Player Match Stats';


INSERT INTO player_match_stats (
            match_id, fixture_id, venue_id, ref_id, player_id, team_id, Number, Position, Age, Minutes, Goals, 
            Assists, Penalty_ShotOnGoal, Penalty_Shots, Total_Shots, ShotsOnTarget, Yellow_Cards, Red_Cards, Touches, Dribbles,
            Tackles, Blocks, Expected_Goals, Non_Penalty_Expected_Goals, Expected_Assists, Shot_Creating_Actions, Goal_Creating_Actions,
            Passes_Completed, Passes_Attempted, Pass_Completion_Percentage, Progressive_Passes, Carries, Progressive_Carries, Dribbles_Attempted,
            Succesful_Dribbles, match_date
)
SELECT
    m.match_id,
    m.fixture_id,
    m.venue_id,
    m.ref_id,
    r.player_id,
    r.team_id,
    r.Number,
    r.Position,
    r.Age,
    r.Minutes,
    r.Goals,
    r.Assists,
    r.Penalty_ShotOnGoal,
    r.Penalty_Shots,
    r.Total_Shots,
    r.ShotsOnTarget,
    r.Yellow_Cards,
    r.Red_Cards,
    r.Touches,
    r.Dribbles,
    r.Tackles,
    r.Blocks,
    r.Expected_Goals,
    r.Non_Penalty_Expected_Goals,
    r.Expected_Assists,
    r.Shot_Creating_Actions,
    r.Goal_Creating_Actions,
    r.Passes_Completed,
    r.Passes_Attempted,
    r.Pass_Completion_Percentage,
    r.Progressive_Passes,
    r.Carries,
    r.Progressive_Carries,
    r.Dribbles_Attempted,
    r.Succesful_Dribbles,
    r.Date
FROM raw_player_stats r
JOIN pl_matches m
    ON m.match_date = r.Date
    AND (r.team_id = m.home_team_id 
    OR r.team_id = m.away_team_id);



## Adding indexes to improve join performance
CREATE INDEX idx_player_name ON pl_players(player_name);
CREATE INDEX idx_team_name ON pl_teams(team_name);
CREATE INDEX idx_venue_id ON pl_venues(venue_id);
CREATE INDEX idx_ref_id ON pl_referees(ref_id);
CREATE INDEX idx_fixture_id ON pl_fixtures(fixture_id);
CREATE INDEX idx_match_date ON pl_matches(match_date);

DROP TABLE player_match_stats_staging;


#######################################################################
################### Creating a Table for pl_venues ####################
#######################################################################
CREATE TABLE pl_venues (
    venue_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT 'Primary key for pl_venues',
    venue_name VARCHAR(150)
) COMMENT 'Venue Table for the Premiere League'

INSERT INTO pl_venues (venue_name)
SELECT DISTINCT Venue
FROM pl_fixtures
ORDER BY Venue;

DROP TABLE pl_venues;

###################################################################################
######### Adjusting Other Tables to Use IDs From Created Reference Tables #########
###################################################################################
ALTER TABLE pl_fixtures
ADD COLUMN venue_id INT;

UPDATE pl_fixtures f
JOIN pl_venues v
  ON f.Venue = v.venue_name
SET f.venue_id = v.venue_id;

ALTER TABLE pl_fixtures
    ADD CONSTRAINT fix_venue
    FOREIGN KEY (venue_id) REFERENCES pl_venues(venue_id);


## Creating a Referee Table ###
CREATE TABLE pl_referees (
    ref_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT 'Primary key for Referee Table',
    referee_name VARCHAR(100)
)COMMENT 'Referee Table for the Premiere League'

INSERT INTO pl_referees (referee_name)
SELECT Referee
FROM pl_matches
GROUP BY Referee
ORDER BY Referee;


ALTER TABLE pl_matches
ADD COLUMN ref_id INT;

UPDATE pl_matches m
JOIN pl_referees r
    ON m.Referee = r.ref_name
SET m.ref_id = r.ref_id;

SELECT
    r.Player,
    r.Team,
    t.team_id
FROM raw_player_stats r
JOIN pl_teams t
    ON t.team_name = r.Team;

ALTER TABLE raw_player_stats
ADD COLUMN team_id INT AFTER Team;

UPDATE raw_player_stats r
JOIN pl_teams t
    ON t.team_name = r.Team
SET r.team_id = t.team_id;


ALTER TABLE raw_player_stats
ADD COLUMN player_id INT AFTER Player;

UPDATE raw_player_stats r
JOIN pl_players p
    ON p.player_name = r.Player
SET r.player_id = p.player_id;