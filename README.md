# About
This project is an exercise in data cleanup, normalization, and analysis. It uses 3 datasets focused on the 2024-2025 season of the English Premiere League; one dataset to supply official fixtures, another for row-level player statistics per match, and lastly one for overall match statistics and information.

Data sources were as follows:
1. EPL Player Match Data: https://www.kaggle.com/datasets/eduardopalmieri/premier-league-player-stats-season-2425
2. EPL Fixture Data: https://www.kaggle.com/datasets/secretglory/epl-fixtures-list-2024-2025
3. EPL Match Data: Scraped from https://fbref.com/en/comps/9/2024-2025/schedule/2024-2025-Premier-League-Scores-and-Fixtures

## Cleanup
Cleanup was mostly about making sure naming conventions were parallel across all tables (Manchester United vs Manchester Utd)

## Normalizing Data
In order to maximize efficiency when querying for analysis, I split the data from the raw sets into six (6) tables; pl_players, pl_teams, pl_referees, pl_venues, pl_matches, and player_match_stats. Each table has its own unique Primary Key and references Foreign Keys from the others where applicable, with the goal achieving at least 3rd Normal Form.

## Quiz
Included in this repo is a self-imposed quiz I drafted with the help of ChatGPT. 