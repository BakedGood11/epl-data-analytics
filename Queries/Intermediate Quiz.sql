## 1. Consistency Check: Player Goals vs. Team Totals
## Use pl_player_stats, pl_matches, and pl_teams to find all teams where
## the sum of goals scored by players does not match the total goals scored officially (home + away) in matches.



## 2. The “Referee Bias” Hypothesis
## Using pl_matches, pl_referees, and pl_teams, calculate the average goals scored by home teams under each referee.
## Then, rank referees by that average.
## Goal: identify if any referee’s matches statistically lean toward home wins.



## 3. The Fixture Delay Detector
## Compare pl_fixtures.match_date to pl_matches.match_date to find fixtures that were rescheduled.
## Return all fixtures where the difference in days is greater than 0, along with team names and venue.



## 4. The Defensive Efficiency Table
## From pl_player_stats, compute each team’s defensive efficiency score defined as: (defensive_actions) / goals_conceded
## where defensive_actions = tackles + interceptions + blocks + clearances.
## Return the top 5 teams by this metric.


## 5. The “Stadium of Fortune” Query
## Using pl_matches, pl_teams, and pl_venues, find out which venue saw the highest total number of goals this season (home + away combined).
## Bonus: also show the average attendance for that venue.

