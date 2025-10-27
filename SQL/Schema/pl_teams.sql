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