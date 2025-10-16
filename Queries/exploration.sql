SELECT 
    p.player_name AS Player,
    s.position AS Position,
    s.minutes AS Minutes,
    t.team_name AS Team,
    s.goals AS Goals,
    s.assists AS Assists,
    ROUND(s.Goals/s.Minutes * 90, 2) AS Goals_per_90
FROM pl_player_stats s
JOIN pl_players p
    ON s.player_id = p.player_id
JOIN pl_teams t
    ON s.team_id = t.team_id
WHERE t.team_name = 'Arsenal';

SELECT home_team_id, away_team_id, match_date, COUNT(*) 
FROM pl_matches
GROUP BY home_team_id, away_team_id, match_date
HAVING COUNT(*) > 1;

SELECT
    t.team_name,
    COUNT(*)
FROM pl_matches m
JOIN pl_teams t
    ON t.team_id IN (m.home_team_id, m.away_team_id)
GROUP BY t.team_name;

WITH referee_totals AS (
    SELECT
        r.ref_name AS Referee,
        COUNT(*) AS Matches_Officiated
    FROM pl_matches m
    JOIN pl_referees r
        ON m.ref_id = r.ref_id
    GROUP BY r.ref_name
)
SELECT
    Referee,
    Matches_Officiated,
    SUM(Matches_Officiated) OVER(ORDER BY Matches_Officiated, Referee) AS Running_Total
FROM referee_totals
ORDER BY Matches_Officiated, Referee;

SELECT 
    m.match_id,
    r.ref_id,
    CASE
        WHEN th.team_id = m.home_team_id THEN th.team_name
        ELSE 0 END,
    CASE
        WHEN ta.team_id = m.away_team_id THEN ta.team_name
        ELSE 0 END
FROM pl_matches m
JOIN pl_referees r
    ON m.ref_id = r.ref_id
JOIN pl_teams th
    ON th.team_id = m.home_team_id
JOIN pl_teams ta
    ON ta.team_id = m.away_team_id
WHERE m.ref_id = 18
;