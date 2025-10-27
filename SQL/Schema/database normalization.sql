
###################################################################################
######### Instering Data into the Staging Table from the Original Table ###########
###################################################################################
INSERT INTO player_stats_staging
SELECT * FROM pl_player_stats;


###################################################################################
############### Querying the Staging Table to Verify Data Insertion ###############
###################################################################################
SELECT *
FROM player_stats_staging
ORDER BY Team, Player;

###################################################################################
############## Selecting Distinct Teams from the Staging Table ####################
###################################################################################
SELECT DISTINCT Team 
FROM player_stats_staging
ORDER BY Team;



########################################################################################
## Creating Match IDs Table and Inserting Distinct Match Dates from the Staging Table ##
########################################################################################
CREATE TABLE pl_matches(
    match_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    match_date DATE NOT NULL,
    team_1_id INT NOT NULL,
    team_2_id INT NOT NULL,
    FOREIGN KEY (team_1_id) REFERENCES pl_teams(team_id),
    FOREIGN KEY (team_2_id) REFERENCES pl_teams(team_id),
    CONSTRAINT unique_match UNIQUE (match_date, team_1_id, team_2_id)
)

SELECT match_date, team_1

DROP TABLE pl_matches;


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
