#########################################################################################################################################
####################################### 1. Guided: Who scored the most goals in a single match? #########################################
#########################################################################################################################################
# Skills: Filtering, grouping, simple aggregate (SUM/MAX), JOIN basics.
# Step 1: Which table holds goals at the player-match level?
# Step 2: How do you group results so that multiple rows of the same player in one match collapse into one?
# Step 3: Once you’ve got totals, how do you order and limit to find the peak performance?




#########################################################################################################################################
######################################## 2. Which referee gives the most yellow cards per match? ########################################
#########################################################################################################################################
# Skills: Aggregates, COUNT, joining dimension (referees) to fact (player_match_stats).




#########################################################################################################################################
########################## 3. Which team has the widest squad rotation (most distinct players used in a season)? ########################
#########################################################################################################################################
# Skills: COUNT DISTINCT, grouping by team, understanding “unique player appearances.”




#########################################################################################################################################
######################################## 4. What’s the average age of goal scorers per team? ############################################
#########################################################################################################################################
# Skills: Aggregates, conditional WHERE filters, numeric functions, JOIN player attributes to match stats.





#########################################################################################################################################
#################################### 5. Who are the most efficient forwards (goals per shot ratio)? #####################################
#########################################################################################################################################
# Skills: Ratio metrics, division inside aggregates, handling divide-by-zero cases.





#########################################################################################################################################
##################################### 6. Which venues have the highest average goals per match? #########################################
#########################################################################################################################################
# Skills: Multi-table JOINs (fixtures + player stats), grouping by categorical dimensions, aggregating at the venue level.



#########################################################################################################################################
########################### 7. Can you reconstruct the full league table? (Points, goals for/against, GD, W/D/L) ########################
#########################################################################################################################################
# Skills: Complex aggregation, CASE WHEN logic, home/away symmetry, multiple joins. This is a “build a fact table from raw data” challenge.




#########################################################################################################################################
############################ 8. Which players are “super-subs” (most goals scored when coming off the bench)? ###########################
#########################################################################################################################################
# Skills: Using conditional aggregates (CASE WHEN inside SUM), filtering based on position/minutes played, interpreting substitution data if available.



#########################################################################################################################################
###################### 9. Correlation check: Does xG (expected goals) actually predict real goals across teams? #########################
#########################################################################################################################################
# Skills: Joining expected vs actual datasets, computing correlation metrics (SQL-level correlation if supported, or preparing clean extract for Python), exploratory statistics.


#########################################################################################################################################
################ 10. Rolling window analysis: Which players had the hottest streaks (most goals in any 5-match window)? #################
#########################################################################################################################################
# Skills: Window functions (SUM OVER with ROWS BETWEEN), partitioning by player, advanced time-series SQL.