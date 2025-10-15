# About
This project is an exercise in data cleanup, normalization, and analysis. It uses 3 datasets focused on the 2024-2025 season of the English Premiere League; one dataset to supply official fixtures, another for row-level player statistics per match, and lastly one for overall match statistics and information.

Data sources:
1. EPL Player Match Data: https://www.kaggle.com/datasets/aesika/english-premier-league-player-stats-2425
(1 row per player, aggregated statistics for the 2024-2025 season)
2. EPL Fixture Data: https://www.kaggle.com/datasets/secretglory/epl-fixtures-list-2024-2025
(Official match schedule as published)
3. EPL Match Data: Scraped from https://fbref.com/en/comps/9/2024-2025/schedule/2024-2025-Premier-League-Scores-and-Fixtures
(Aggregated match statistics, per team, for the entire season)

## Schema
pl_players: player_id (Primary Key), player_name, nation
pl_teams: team_id (Primary Key), team_name
pl_matches: match_id (Primary Key), fixture_id (Foreign Key), match_date, Wk, Day, Time, home_team_id, away_team_id, home_score, away_score, home_xG, away_xG, venue_id (Foreign Key), Attendance, ref_id

## Cleanup
Cleanup was mostly about making sure naming conventions were parallel across all tables (Manchester United vs Manchester Utd)

## Normalizing Data
In order to maximize efficiency when querying for analysis, I split the data from the raw sets into six (6) tables; pl_players, pl_teams, pl_referees, pl_venues, pl_matches, and pl_player_stats. Each table has its own unique Primary Key and references Foreign Keys from the others where applicable, with the goal achieving at least 3rd Normal Form.

## Quiz
Included in this repo is a self-imposed quiz I drafted with the help of ChatGPT. 