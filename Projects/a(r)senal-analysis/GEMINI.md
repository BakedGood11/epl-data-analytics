# Project: a(r)senal-analysis

## Project Overview

This project is a data analysis of Arsenal Football Club's performance in the 2024-2025 English Premier League season. The analysis is conducted using R and R Markdown, with data sourced from a MariaDB database. The primary goal is to understand why Arsenal, despite a strong defense, failed to win the league, focusing on their attacking inefficiencies.

The final output is a PDF report generated from the `Arsenal_stats_24-25.Rmd` file.

## Building and Running

This is an R project and is best managed using RStudio.

1.  **Prerequisites:**
    *   R and RStudio installed.
    *   Access to the MariaDB database with the relevant data. The RMD file loads connection details from a `~/.Renviron` file. Ensure this file is present and contains the correct credentials:
        ```
        MARIADB_HOST=<your_host>
        MARIADB_PORT=<your_port>
        MARIADB_USER=<your_user>
        MARIADB_PWD=<your_password>
        MARIADB_PL_DB=<your_database_name>
        ```
    *   The following R packages installed: `DBI`, `RMariaDB`, `ggplot2`, `dplyr`, `dbplyr`, `tinytex`, `tidyr`, `knitr`, `zoo`.

2.  **Running the Analysis:**
    *   Open the `a(r)senal-analysis.Rproj` file in RStudio.
    *   Open the `Arsenal_stats_24-25.Rmd` file.
    *   Click the "Knit" button in RStudio to generate the PDF report.

## Development Conventions

*   **Data Source:** The project relies on a MariaDB database as the single source of truth for data. The tables used are `pl_matches`, `pl_teams`, `pl_players`, `afc_23_24`, `pl_table_24`, `pl_table_23_24`, and `pl_player_stats`.
*   **Coding Style:** The R code largely follows the `tidyverse` style, utilizing packages like `dplyr` for data manipulation and `ggplot2` for visualizations.
*   **Analysis Structure:** The analysis is presented in a narrative format within the R Markdown file, with code chunks used to perform calculations and generate plots. The final output is a well-structured PDF document.
*   **File Naming:** Files are named descriptively, indicating their content and the season under analysis.
