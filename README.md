# About
This English Premier League data analytics repository is a project aimed at helping me learn more about SQL and R. The R analytics section was done in conjunction with the Google Data Analytics Professional Certificate program on Coursera. This involves:
- an exercise in data cleanup, normalization, and analysis with SQL. 
- exploratory analysis in R (via MariaDB connector to homelab server)

Both analyses make use of 3 datasets focused on the 2024-2025 season of the English Premiere League; one dataset to supply official fixtures, another for row-level player statistics per match, and lastly one for overall match statistics and information. The data is then supported with statistics and data from the 2023-2024 season of the Premier League. 

## Environment:
1. Homelab Server: Debian 13 running a Dockerized MariaDB instance (data storage and normalization).
2. Client Machine: CachyOS (Arch Linux) with VSCode (SQL + R extensions) and RStudio for analytical workflow and visualization.
3. Software Stack: R 4.4, tidyverse ecosystem, RMariaDB connector, Git + GitHub version control.
4. Visualizations: Tableau Public and Metabase.

### R packages used:
- DBI
- RMariaDB
- ggplot2
- dplyr
- dbplyr
- tinytex
- tidyr
- knitr

### Data sources:
1. EPL Player Match Data: https://www.kaggle.com/datasets/aesika/english-premier-league-player-stats-2425 
(1 row per player, aggregated statistics for the 2024-2025 season)
2. EPL Fixture Data: https://www.kaggle.com/datasets/secretglory/epl-fixtures-list-2024-2025 
(Official match schedule as published)
3. EPL Match Data: Scraped from https://fbref.com/en/comps/9/2024-2025/schedule/2024-2025-Premier-League-Scores-and-Fixtures 
(Aggregated match statistics, per team, for the entire season)
4. Arsenal Squad Data from 2023-2024: https://fbref.com/en/squads/18bb7c10/2024-2025/matchlogs/c9/schedule/Arsenal-Scores-and-Fixtures-Premier-League
(Previous season summary stats for context review)
5. EPL Season Table, 2024-2025: https://fbref.com/en/comps/9/2024-2025/2024-2025-Premier-League-Stats
(League table from 2024 for conte
6. EPL Season Table, 2023-2024: https://fbref.com/en/comps/9/2023-2024/2023-2024-Premier-League-Stats
(League table for context review)

## Project Layout

### SQL Phase
Goal: To build and explore the database foundation. 
- Loaded local CSVs and created a reproducible schema for the data to live in.
- Cleaned, Normalized, and Explored the data in the database.
- Produced key joins for Match, Player, and Fixture data. 

### Analyzing A(R)senal [R]
Goal: We explore Arsenal's season metrics using R. This section is intended to present statistical analyses and visualizations, using some of R's many packages. 
- Connected and queried the MariaDB server using RMariaDB connectors for RStudio.
- Explored and created visualizations in R.
- Generated visuals for the narrative of the exploration.



![schema_diagram](epl-schema-diagram.png)