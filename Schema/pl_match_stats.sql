#################################################################################
# Creating the Staging table for Premiere League Player Stats, 2024-2025 Season #
#################################################################################
CREATE TABLE pl_stats_staging(  
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
) COMMENT 'Staging table for Premiere League Player Stats, 2024-2025 Season';




#################################################################################
############## Creating the normalized player_match_stats Table #################
#################################################################################

CREATE TABLE pl_match_stats (
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


INSERT INTO pl_match_stats (
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

DROP TABLE pl_match_stats_staging;
