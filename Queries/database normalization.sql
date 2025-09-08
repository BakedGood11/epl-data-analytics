#################################################################################
# Creating the Staging table for Premiere League Player Stats, 2024-2025 Season #
#################################################################################
CREATE TABLE player_stats_staging(  
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

###################################################################################
############## Selecting Distinct Players from the Staging Table ##################
###################################################################################
SELECT DISTINCT Player
FROM player_stats_staging
ORDER BY Player;

###################################################################################
## Creating the Teams Table and Inserting Distinct Teams from the Staging Table ##
###################################################################################
CREATE TABLE pl_teams(
    team_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT'Primary Key',
    team_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO pl_teams(team_name)
SELECT DISTINCT Team
FROM player_stats_staging
ORDER BY Team;

SELECT *
FROM pl_teams;

####################################################################################
# Creating the Players Table and Inserting Distinct Players from the Staging Table #
####################################################################################
CREATE TABLE pl_players(
    player_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    player_name VARCHAR(50) NOT NULL,
    nation VARCHAR(50)
);

INSERT INTO pl_players (player_name, nation)
SELECT DISTINCT 
    Player,
    Nation
FROM player_stats_staging
ORDER BY Player;

###################################################
### Checking for Duplicates in pl_players Table ###
###################################################
SELECT player_name, COUNT(*) AS occurences
FROM pl_players
GROUP BY player_name
HAVING COUNT(*) > 1
ORDER BY occurences DESC, player_name;

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

#################################################################################################
## Creating Match Stats Table and Inserting Distinct Match Statistics from the Raw Stats Table ##
#################################################################################################

