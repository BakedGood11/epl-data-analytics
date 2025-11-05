# GEMINI.md

## Project Overview

This project is a data analysis of the English Premier League (EPL) 2024-2025 season. It uses SQL for data cleaning, normalization, and database management, and R for statistical analysis and visualization. The project also uses PowerBI for creating interactive dashboards.

The main goal of the project is to analyze the performance of Arsenal FC, but it also includes a broader analysis of the entire league.

**Key Technologies:**

*   **R:** For statistical analysis and visualization (`tidyverse` ecosystem).
*   **SQL (MariaDB):** For data storage, cleaning, and normalization.
*   **PowerBI:** For creating interactive dashboards.

**Architecture:**

The project follows a standard data analysis workflow:

1.  **Data Acquisition:** Data is sourced from Kaggle and scraped from FBRef.
2.  **Data Storage and Cleaning:** The raw data is loaded into a MariaDB database, where it is cleaned and normalized using SQL scripts.
3.  **Analysis:** The cleaned data is analyzed using R and SQL.
4.  **Visualization:** The results are visualized using R (`ggplot2`) and PowerBI.

## Building and Running

### Database Setup

1.  **Prerequisites:** A running MariaDB instance is required.
2.  **Schema and Data Loading:** The database can be set up by executing the `projects/SQL-analysis/Schema/initialization.sql` script. This script creates the necessary tables, loads the data from the CSV files, and normalizes the data.

    **Note:** The `LOAD DATA LOCAL INFILE` commands in the script have hardcoded paths to the CSV files. You will need to modify these paths to match the location of the data on your local machine.

### R Analysis

1.  **Prerequisites:** R and RStudio should be installed. The required R packages are listed in the `Arsenal_stats_24-25.Rmd` file.
2.  **Running the Analysis:** The R analysis can be run by opening the `projects/a(r)senal-analysis/Arsenal_stats_24-25.Rmd` file in RStudio and executing the code chunks. The Rmd file connects to the MariaDB database, so make sure the database is running and the connection details in the Rmd file are correct.

### PowerBI Dashboards

The project uses PowerBI for visualizations. The PowerBI files are not included in the repository. To view the dashboards, you would need to get the `.pbix` files from the project owner.

## Development Conventions

### SQL

*   SQL keywords are written in uppercase.
*   Staging tables are used for loading and cleaning raw data before inserting it into the final normalized tables.
*   The schema is designed to be in at least 3rd Normal Form.
*   Comments are used to explain the purpose of the SQL scripts.

### R

*   The project uses the `tidyverse` ecosystem for data manipulation and visualization.
*   The R code is well-commented and organized into logical chunks in the R Markdown file.
*   The R Markdown file is used to create a reproducible report that combines code, output, and narrative.
