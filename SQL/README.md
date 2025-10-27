## Schema [SQL]
** See below for visual diagram **
pl_players: player_id (Primary Key), player_name, nation
pl_teams: team_id (Primary Key), team_name
pl_matches: match_id (Primary Key), fixture_id (Foreign Key), match_date, Wk, Day, Time, home_team_id, away_team_id, home_score, away_score, home_xG, away_xG, venue_id (Foreign Key), Attendance, ref_id

## Cleanup [SQL]
Cleanup was mostly about making sure naming conventions were parallel across all tables (Manchester United vs Manchester Utd). There are instances of a wrong entry in the referee column of the pl_matches table. I've corrected what I can but given the level of data and the purpose of this project I've chosen not to do a full replacement until later on. 

## Normalizing Data [SQL]
In order to maximize efficiency when querying for analysis, I split the data from the raw sets into six (6) tables; pl_players, pl_teams, pl_referees, pl_venues, pl_matches, and pl_player_stats. Each table has its own unique Primary Key and references Foreign Keys from the others where applicable, with the goal achieving at least 3rd Normal Form.

## General Exploration [SQL]
The SQL exploration portion is dedicated to league-wide analysis. Found in this section are queries involving mupltiple joins, CTEs, and CASE statements. 