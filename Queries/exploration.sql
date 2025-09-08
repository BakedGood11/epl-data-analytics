SELECT
    p.player_name,
    t.team_name,
    SUM(s.Goals) AS total_goals,
    COUNT(DISTINCT s.match_id) AS matches_played,
    r.ref_name AS last_referee,
    v.venue_name AS last_venue
FROM player_match_stats s
JOIN pl_players p
    ON s.player_id = p.player_id
JOIN pl_teams t
    ON s.team_id = t.team_id
JOIN pl_matches m
    ON s.match_id = m.match_id
JOIN pl_referees r
    ON m.ref_id = r.ref_id
JOIN pl_venues v
    ON m.venue_id = v.venue_id
WHERE m.match_date BETWEEN '2024-08-01' AND '2025-05-31'
GROUP BY p.player_name, t.team_name
ORDER BY total_goals DESC
LIMIT 10;

WITH player_season AS (
    SELECT
        s.player_id,
        SUM(s.Goals) AS goals,
        SUM(s.Assists) AS assists,
        SUM(s.Minutes) AS minutes_played
    FROM player_match_stats s
    JOIN pl_matches m ON s.match_id = m.match_id
    WHERE m.match_date BETWEEN '2024-08-01' AND '2025-05-31'
    GROUP BY s.player_id
)
SELECT p.player_name, ps.goals, ps.assists, ps.minutes_played
FROM player_season ps
JOIN pl_players p ON ps.player_id = p.player_id
ORDER BY ps.goals DESC;

WITH team_performance AS (
    SELECT
        team_id,
        match_id,
        SUM(Goals) AS team_goals,
        SUM(Assists) AS team_assists
    FROM player_match_stats
    GROUP BY team_id, match_id
)
SELECT t.team_name, tp.team_goals, tp.team_assists
FROM team_performance tp
JOIN pl_teams t ON tp.team_id = t.team_id;