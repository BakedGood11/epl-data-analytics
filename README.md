# A(r)senal Analysis – English Premier League Data Analytics

This project investigates the relationship between expected performance metrics (xG, xGA) and actual outcomes in the 2024–2025 Premier League season. Focusing on Arsenal FC, it demonstrates end-to-end data analytics (SQL-based data cleaning and R-powered regression and visualization) built on a reproducible Dockerized homelab pipeline.
---
## About
This repository explores the 2024-2025 English Premier League season using SQL, R, and a Docker-based homelab setup. The goal is to strengthen my skills in data management, analytics, and visualization while producing reproducible workflows.

The project involves:
- Cleaning, normalizing, and aggregating datasets using SQL on a MariaDB instance.
- Performing exploratory and statistical analysis in R, connected directly to the database.
- Visualizing team and player-level metrics using RMarkdown and interactive dashboards.

The analysis focuses on Arsenal FC and is supplemented with data from the 2023-2024 season for context.

---
## Results Summary
Key findings from the analysis include:
- Found a strong positive correlation (r = 0.92) between Expected Goals (xG) and Goals For (GF).

- Observed a decline in Arsenal’s xG (−21%) compared to the previous season.

- Identified midfield dependency for goal contribution (48% cumulative share).
---

## Folder Structure

### data
Contains all datasets used in the project.
- `cleaned_manual`: Manually cleaned CSV files.
- `cleaned_sql`: CSV files cleaned through SQL queries.

### docs
Project documentation including schema diagrams and reference materials.

### notebooks
Reserved for Jupyter notebooks. Currently empty.

### projects
Main analysis projects:
- **A(r)senal Analysis – EPL 2024-2025 Season**
  Conducted statistical and regression analysis to understand Arsenal's performance, expected goals (xG), goal efficiency, and player contributions. Produced RMarkdown reports with dynamic visualizations and tables.

- **SQL & Database Management – A(r)senal Analysis**
  Designed and managed a MariaDB database to store multi-source Premier League data. Wrote SQL queries for data cleaning, normalization, and aggregation. Integrated the database with a Docker-based homelab setup for reproducible workflows and automated data pipelines.

### visuals
Folder for storing generated plots, charts, and visualizations. Currently empty.

---

## Environment

- **Homelab Server**: Debian 13 running Dockerized MariaDB for data storage and normalization.
- **Client Machine**: CachyOS (Arch Linux) with VSCode (SQL and R extensions) and RStudio for analysis and visualization.
- **Software Stack**: R 4.4, tidyverse ecosystem, RMariaDB connector, Git with GitHub version control.
- **Visualization Tools**: Tableau Public and Metabase.

---

## R Packages Used

- DBI
- RMariaDB
- ggplot2
- dplyr
- dbplyr
- tidyverse
- tidyr
- knitr
- kableExtra
- zoo
- ggrepel
- ggpmisc
- broom
- ggcorrplot
- tinytex

---

## Data Sources

1. **EPL Player Match Data (2024-2025)**  
   [Kaggle Dataset](https://www.kaggle.com/datasets/aesika/english-premier-league-player-stats-2425)  

2. **EPL Fixture Data (2024-2025)**  
   [Kaggle Dataset](https://www.kaggle.com/datasets/secretglory/epl-fixtures-list-2024-2025)  

3. **EPL Match Data (2024-2025)**  
   [FBRef](https://fbref.com/en/comps/9/2024-2025/schedule/2024-2025-Premier-League-Scores-and-Fixtures)  

4. **Arsenal Squad Data (2023-2024)**  
   [FBRef](https://fbref.com/en/squads/18bb7c10/2024-2025/matchlogs/c9/schedule/Arsenal-Scores-and-Fixtures-Premier-League)  

5. **EPL Season Table (2024-2025)**  
   [FBRef](https://fbref.com/en/comps/9/2024-2025/2024-2025-Premier-League-Stats)  

6. **EPL Season Table (2023-2024)**  
   [FBRef](https://fbref.com/en/comps/9/2023-2024/2023-2024-Premier-League-Stats)  

---

## Technical Skills Highlighted

- SQL: Data cleaning, normalization, aggregation, and complex joins.
- R: Statistical analysis, regression, correlation, and visualization.
- Homelab Management: Docker-based MariaDB server, reproducible workflows, and client-server integration.
- Data Visualization: RMarkdown, ggplot2, Tableau, and Metabase.
- Data Pipeline Design: Combining SQL queries and R analytics for reproducible, automated analysis.

---

![Schema Diagram](docs/epl-schema-diagram.png)
*Schema illustrating how match, player, and fixture datasets are relationally modeled in the MariaDB database, enabling multi-season joins and aggregated analytics.*