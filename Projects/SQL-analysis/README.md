# SQL Analysis for EPL Data

This project contains all the SQL scripts used for data cleaning, normalization, and exploration of the English Premier League dataset. The scripts are designed to be run on a MariaDB database.

## Directory Structure

- **Schema**: Contains the SQL scripts for creating the database schema, including tables and relationships.
- **Queries**: Contains SQL scripts for data cleanup, exploration, and ad-hoc analysis.

## Schema

The `Schema` directory includes the following files to set up the database:

- `initialization.sql`: The main script to create the database, tables, and load data from CSV files. **Note:** You must edit the file paths in this script to match the location of your CSV files.
- `database normalization.sql`: Contains the final normalized schema definition.
- `pl_fixtures.sql`: Script to create the `pl_fixtures` table.
- `pl_matches.sql`: Script to create the `pl_matches` table.
- `pl_player_stats.sql`: Script to create the `pl_player_stats` table.
- `pl_players.sql`: Script to create the `pl_players` table.
- `pl_referees.sql`: Script to create the `pl_referees` table.
- `pl_teams.sql`: Script to create the `pl_teams` table.
- `pl_venues.sql`: Script to create the `pl_venues` table.

## Queries

The `Queries` directory contains scripts for working with the data:

- `cleanup.sql`: Scripts for cleaning and standardizing data, such as team names and referee names.
- `exploration.sql`: Queries for league-wide analysis, including joins, CTEs, and CASE statements.
- `Intermediate Quiz.sql` & `quiz.sql`: SQL quizzes and exercises for practice.
- `scratchpad.sql`: A scratchpad for writing and testing ad-hoc queries.

## How to Use

1.  **Database Setup**:
    - Ensure a running MariaDB instance is available.
    - Execute the `projects/SQL-analysis/Schema/initialization.sql` script to create the database, tables, and load the data. Update the CSV file paths within the script as required for your environment.
2.  **Data Analysis**:
    - Utilize the scripts in the `Queries` directory for data cleaning, exploration, and analysis.