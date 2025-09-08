SELECT *
FROM pl_player_stats
LIMIT 10000;

SELECT Player, Team, Number, Age, Goals, Assists
FROM pl_player_stats
WHERE Team = 'Arsenal'
;

SELECT Nation, COUNT(DISTINCT Player) AS player_count
FROM pl_player_stats
GROUP BY Nation
ORDER BY player_count DESC
;
 
SELECT SUM(Goals) AS total_goals
FROM pl_player_stats
;

SELECT SUM(`Total_Shots`) AS total_shots
FROM pl_player_stats
;


SELECT Player, Expected_Goals
FROM pl_player_stats
ORDER BY Expected_Goals DESC
;

SELECT *
FROM pl_player_stats
WHERE Player = 'Erling Haaland'
;

SELECT Player, Team, Goals, Date 
FROM pl_player_stats
ORDER BY Player;

SELECT COUNT(DISTINCT Date) AS match_days
FROM pl_player_stats
;

WITH team_pairs AS (
    SELECT Date, Team
    FROM pl_player_stats
    GROUP BY Date, Team
)
SELECT COUNT(*) / 2 AS total_matches
FROM team_pairs;

SELECT *
FROM pl_player_stats
WHERE Player = 'Luke McNally';

SELECT Team, `Date`, SUM(Goals) AS total_goals
FROM player_stats_staging
WHERE DATE = '2024-08-16'
GROUP BY Team
ORDER BY Team
;

SELECT *
FROM pl_fixtures
WHERE home_team REGEXP 'Utd'
   OR away_team REGEXP 'Utd'
ORDER BY week;


-- Home team players
SELECT 
    m.match_id,
    m.fixture_id,
    m.match_date,
    r.Player,
    m.Home AS team_side,
    m.Away AS opponent,
    m.home_score,
    m.away_score,
    m.Venue
FROM pl_matches AS m
JOIN raw_player_stats AS r
    ON r.Team = m.Home
    AND r.Date = m.match_date 
UNION ALL
SELECT 
    m.match_id,
    m.fixture_id,
    m.match_date,
    r.Player,
    m.Away AS team_side,
    m.Home AS opponent,
    m.home_score,
    m.away_score,
    m.Venue
FROM pl_matches AS m
JOIN raw_player_stats AS r
    ON r.Team = m.Away
    AND r.Date =m.match_date
ORDER BY match_date, match_id, team_side;


SELECT
FROM pl_matches;

SELECT 
    
