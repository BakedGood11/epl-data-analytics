###########################1. Player roll call (Beginner: SELECT basics) #############################
############################### List all players with their team names. ##############################
 
SELECT
    p.player_name AS Player,
    t.team_name AS Team,
    p.nation as Nationality
FROM pl_players p
JOIN pl_player_stats s
    ON p.player_id = s.player_id
JOIN pl_teams t
    ON s.team_id = t.team_id
ORDER BY t.team_name, p.player_name;    


########################### 2. Goal leaderboard (Beginner: ORDER BY, LIMIT) ##########################
############ Find the top 10 players by total goals scored this season. Include their team.###########

SELECT
    p.player_name AS Player,
    t.team_name AS Team,
    ROUND(s.minutes/90,1) AS Matches_Played,
    s.goals AS Goals,
    ROUND(s.goals/s.minutes * 90, 2) AS Goals_per_90
FROM pl_players p
JOIN pl_player_stats s
    ON p.player_id = s.player_id
JOIN pl_teams t
    ON s.team_id = t.team_id
ORDER BY s.goals DESC, p.player_name
LIMIT 10;  

################# 3. Team contribution summary (Beginner–Intermediate: GROUP BY, SUM) ################
######################### For each team, calculate the total goals scored and ########################
############################## total assists contributed by its players. ##############################

SELECT 
    t.team_name AS Team,
    SUM(s.goals) AS Total_Goals,
    SUM(s.assists) AS Total_Assists
FROM pl_player_stats s
JOIN pl_teams t
    ON s.team_id = t.team_id
GROUP BY t.team_name
ORDER BY Total_Goals DESC, t.team_name;

################### 4. Efficiency spotlight (Intermediate: arithmetic, filtering) #####################
#################### Which players have a conversion rate above 20% and at least 30 ###################
#################### shots? Return player, team, goals, shots, and conversion_rate. ###################

SELECT
    p.player_name AS Player,
    t.team_name AS Team,
    s.goals AS Goals,
    s.shots_total AS Shots,
    s.conversion_rate AS StoredConversion,
    ROUND(s.goals/s.shots_total * 100, 2) AS Conversion_Rate
FROM pl_player_stats s
JOIN pl_players p
    ON p.player_id = s.player_id
JOIN pl_teams t
    ON s.team_id = t.team_id
WHERE s.shots_total >= 30
    AND (s.goals/s.shots_total) > 0.20
ORDER BY Conversion_Rate DESC, s.goals DESC, p.player_name;

################### 5. Scheduling detective (Intermediate: JOIN, date comparisons) #####################
########## Find fixtures where the scheduled date (pl_fixtures) didn’t match the actual match date #####
###################### (pl_matches). Return fixture_id, scheduled_date, actual_date. ###################

SELECT
    f.fixture_id AS Fixture_ID,
    m.match_id AS Match_ID,
    f.match_date AS Scheduled_Date,
    m.match_date AS Actual_Date
FROM pl_fixtures f
JOIN pl_matches m
    ON f.fixture_id = m.fixture_id
WHERE f.match_date != m.match_date
ORDER BY f.fixture_id;

####################### 6. Referee workload (Intermediate: COUNT, GROUP BY, JOIN) ######################
######################## Which referee officiated the most matches this season? ########################
################################ Return ref_name and number of matches. ################################

SELECT
    r.ref_name AS Referee,
    COUNT(m.match_id) AS Matches_Officiated
FROM pl_referees r
JOIN pl_matches m
    ON r.ref_id = m.ref_id
GROUP BY r.ref_name
ORDER BY Matches_Officiated DESC, Referee
LIMIT 10;

####### 7. Top scorers per team (Intermediate–Advanced: window functions or correlated subqueries) ######
############## For each team, return the single highest-scoring player and their goal count. ############

WITH RankedPlayers AS (
    SELECT
        p.player_name AS Player,
        t.team_name AS Team,
        s.goals AS Goals,
        ROW_NUMBER() OVER (PARTITION BY t.team_name ORDER BY s.goals DESC, p.player_name) AS rn
    FROM pl_player_stats s
    JOIN pl_players p
        ON p.player_id = s.player_id
    JOIN pl_teams t
        ON s.team_id = t.team_id
)
SELECT
    Player,
    Team,
    Goals
FROM RankedPlayers
WHERE rn = 1
ORDER BY Team;  

####################### 8. Team reliance index (Advanced: aggregation + division) #######################
############### For each team, calculate what percentage of total team goals came from their ############
############################### top scorer. Sort teams by this dependency %. ############################

WITH RankedPlayers AS (
    SELECT
        p.player_name AS Player,
        t.team_name AS Team,
        s.goals AS Goals,
        ROW_NUMBER() OVER (PARTITION BY t.team_name ORDER BY s.goals DESC, p.player_name) AS rn
    FROM pl_player_stats s
    JOIN pl_players p
        ON p.player_id = s.player_id
    JOIN pl_teams t
        ON s.team_id = t.team_id
)
SELECT
    Player,
    Team,
    Goals
FROM RankedPlayers
WHERE rn = 1
ORDER BY Team;  

######################## 9. Venue bias analysis (Advanced: joins + aggregation) #########################
############### Which venue saw the highest average goals per match (sum of both teams’ #################
################################### goals / matches played there)? ######################################

SELECT v.venue_name AS Venue,
       COUNT(m.match_id) AS Matches_Played,
       SUM(m.home_score + m.away_score) AS Total_Goals,
       ROUND(SUM(m.home_score + m.away_score) / COUNT(m.match_id), 2) AS Avg_Goals_Per_Match
FROM pl_venues v
JOIN pl_matches m
    ON v.venue_id = m.venue_id
GROUP BY v.venue_name
ORDER BY Avg_Goals_Per_Match DESC
LIMIT 10;

SELECT DISTINCT t.team_name, 
       v.venue_name
FROM pl_teams t
JOIN pl_matches m
    ON t.team_id = m.home_team_id
JOIN pl_venues v
    ON m.venue_id = v.venue_id
WHERE v.venue_name = 'Gtech Community Stadium'
;

################ 10. Balance of power (Challenger: multi-table join, advanced aggregation) ##############
############### For each team, compare goals scored by its players (from pl_player_stats) vs ############
#################### total goals conceded in matches. Return a goal difference figure. ##################

# CASE-statement to pivot home/away scores
SELECT
    t.team_name,
    SUM(CASE WHEN t.team_id = m.home_team_id THEN m.home_score
             WHEN t.team_id = m.away_team_id THEN m.away_score
             ELSE 0 END) AS GoalsFor,
    SUM(CASE WHEN t.team_id = m.home_team_id THEN m.away_score
             WHEN t.team_id = m.away_team_id THEN m.home_score
             ELSE 0 END) AS GoalsAgainst,
    SUM(CASE WHEN t.team_id = m.home_team_id THEN m.home_score - m.away_score
             WHEN t.team_id = m.away_team_id THEN m.away_score - m.home_score
             ELSE 0 END) AS GoalDifference
FROM pl_teams t
JOIN pl_matches m
    ON t.team_id IN (m.home_team_id, m.away_team_id)
GROUP BY t.team_name
ORDER BY GoalDifference DESC, t.team_name;


# CTE-based approach
WITH player_goals AS (
    SELECT
        t.team_id,
        t.team_name,
        SUM(s.goals) AS GoalsFor
    FROM pl_player_stats s
    JOIN pl_teams t
        ON s.team_id = t.team_id
    GROUP BY team_name
),
official_score AS (
    SELECT
        t.team_id,
        t.team_name,
        SUM(CASE WHEN t.team_id = m.home_team_id THEN m.home_score
                 WHEN t.team_id = m.away_team_id THEN m.away_score
                 ELSE 0 END) AS GF,
        SUM(CASE WHEN t.team_id = m.home_team_id THEN m.away_score
                 WHEN t.team_id = m.away_team_id THEN m.home_score
                 ELSE 0 END) AS GA
    FROM pl_teams t
    JOIN pl_matches m
        ON t.team_id IN (m.home_team_id, m.away_team_id)
    GROUP BY t.team_name
)
SELECT
    t.team_name,
    pg.GoalsFor AS Player_Goals,
    os.GF AS Official_Goals_For,
    os.GA AS Official_Goals_Against,
    (os.GF - os.GA) AS Goal_Difference
FROM pl_teams t
JOIN player_goals pg
    ON t.team_id = pg.team_id
JOIN official_score os
    ON t.team_id = os.team_id
ORDER BY Goal_Difference DESC, t.team_name;



