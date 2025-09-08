
#########################################################
### Cleaning Team Names in the Fixtures Staging Table ###
#########################################################
UPDATE pl_fixtures_staging
SET home_team = REPLACE(home_team, 'Utd', 'United'),
    away_team = REPLACE(away_team, 'Utd', 'United')
WHERE home_team REGEXP 'Utd'
   OR away_team REGEXP 'Utd';

UPDATE pl_fixtures_staging
SET home_team = REPLACE(home_team, 'Brighton', 'Brighton & Hove Albion'),
    away_team = REPLACE(away_team, 'Brighton', 'Brighton & Hove Albion')
WHERE home_team REGEXP 'Brighton'
   OR away_team REGEXP 'Brighton';

UPDATE pl_fixtures_staging
SET home_team = REPLACE(home_team, 'Wolves', 'Wolverhampton Wanderers'),
    away_team = REPLACE(away_team, 'Wolves', 'Wolverhampton Wanderers')
WHERE home_team REGEXP 'Wolves'
   OR away_team REGEXP 'Wolves';

UPDATE pl_fixtures_staging
SET home_team = REPLACE(home_team, 'West Ham', 'West Ham United'),
    away_team = REPLACE(away_team, 'West Ham', 'West Ham United')
WHERE home_team REGEXP 'West Ham'
   OR away_team REGEXP 'West Ham';

UPDATE pl_fixtures_staging
SET home_team = REPLACE(home_team, 'Tottenham', 'Tottenham Hotspur'),
    away_team = REPLACE(away_team, 'Tottenham', 'Tottenham Hotspur')
WHERE home_team REGEXP 'Tottenham'
   OR away_team REGEXP 'Tottenham';

###################
## Sanity checks ##
###################
SELECT DISTINCT stage.home_team, COUNT(*) AS occurences
FROM pl_fixtures_staging stage
LEFT JOIN pl_teams teams
    ON stage.home_team = teams.team_name
    GROUP BY stage.home_team
ORDER BY home_team
;

SELECT DISTINCT stage.home_team
FROM pl_fixtures_staging stage
LEFT JOIN pl_teams teams
    ON stage.home_team = teams.team_name
WHERE teams.team_id IS NULL;

SELECT DISTINCT 
    teams.team_name   AS master_team_name,
    stage.home_team   AS staging_home_team
FROM pl_fixtures_staging stage
LEFT JOIN pl_teams teams
    ON stage.home_team = teams.team_name
ORDER BY staging_home_team;

SELECT DISTINCT 
    teams.team_name   AS master_team_name,
    stage.away_team   AS staging_away_team
FROM pl_fixtures_staging stage
LEFT JOIN pl_teams teams
    ON stage.away_team = teams.team_name
ORDER BY staging_away_team;


## Cleanup for pl_matches_staging_import Table ##
UPDATE pl_matches_staging
SET Home = REPLACE(Home, 'Brighton', 'Brighton & Hove Albion'),
    Away = REPLACE(Away, 'Brighton', 'Brighton & Hove Albion')
WHERE Home REGEXP 'Brighton'
   OR Away REGEXP 'Brighton';

UPDATE pl_matches_staging
SET Home = REPLACE(Home, 'Tottenham', 'Tottenham Hotspur'),
    Away = REPLACE(Away, 'Tottenham', 'Tottenham Hotspur')
WHERE Home REGEXP 'Tottenham'
   OR Away REGEXP 'Tottenham';

UPDATE pl_matches_staging
SET Home = REPLACE(Home, 'Nott''ham', 'Nottingham'),
    Away = REPLACE(Away, 'Nott''ham', 'Nottingham')
WHERE Home REGEXP 'Nott''ham'
   OR Away REGEXP 'Nott''ham';

UPDATE pl_matches_staging
SET Home = REPLACE(Home, 'Utd', 'United'),
    Away = REPLACE(Away, 'Utd', 'United')
WHERE Home REGEXP 'Utd'
   OR Away REGEXP 'Utd';

UPDATE pl_matches_staging
SET Home = REPLACE(Home, 'Wolves', 'Wolverhampton Wanderers'),
    Away = REPLACE(Away, 'Wolves', 'Wolverhampton Wanderers')
WHERE Home REGEXP 'Wolves'
   OR Away REGEXP 'Wolves';

UPDATE pl_matches_staging
SET Home = REPLACE(Home, 'West Ham', 'West Ham United'),
    Away = REPLACE(Away, 'West Ham', 'West Ham United')
WHERE Home REGEXP 'West Ham'
   OR Away REGEXP 'West Ham';