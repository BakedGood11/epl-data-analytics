#################################################################################
# Creating the Staging table for Premiere League Player Stats, 2024-2025 Season #
#################################################################################
CREATE TABLE pl_player_stats_staging(  
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    Player VARCHAR(50),
    Team VARCHAR(50),
    nation VARCHAR(50),
    position VARCHAR(10),
    appearances INT,
    minutes INT,
    goals INT,
    assists INT,
    shots_total INT,
    shots_on_target INT,
    conversion_rate DECIMAL(5,2),
    big_chances_missed INT,
    hit_woodwork INT,
    offsides INT,
    touches INT,
    passes INT,
    passes_completed INT,
    pass_completion_rate DECIMAL(5,2),
    crosses INT,
    cross_completed INT,
    cross_completion_rate DECIMAL(5,2),
    final_third_passes INT,
    final_third_passes_completed INT,
    final_third_pass_completion_rate DECIMAL(5,2),
    through_balls INT,
    carries INT,
    progressive_carries INT,
    carries_ended_with_goal INT,
    carries_ended_with_assist INT,
    carries_ended_with_shot INT,
    carries_ended_with_chance INT,
    posessions_won INT,
    posessions_lost INT,
    clean_sheets INT,
    clearances INT,
    interceptions INT,
    blocks INT,
    tackles INT,
    ground_duels INT,
    ground_duels_won INT,
    ground_duel_win_rate DECIMAL(5,2),
    aerial_duels INT,
    aerial_duels_won INT,
    aerial_duel_win_rate DECIMAL(5,2),
    goals_conceded INT,
    xGoT_conceded DECIMAL(5,2),
    own_goals INT,
    fouls INT,
    yellow_cards INT,
    red_cards INT,
    saves INT,
    save_percentage DECIMAL(5,2),
    penalties_saved INT,
    clearances_off_line INT,
    punches INT,
    high_claims INT,
    goals_prevented INT
) COMMENT 'Staging table for Premiere League Player Stats, 2024-2025 Season';

LOAD DATA LOCAL INFILE '/home/migi/Documents/Premiere-League-SQL-Analysis/CSVs/epl_player_stats_24_25.csv'
INTO TABLE pl_player_stats_staging
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Player, Team, nation, position, appearances, minutes, goals, assists, shots_total, 
shots_on_target, conversion_rate, big_chances_missed, hit_woodwork, offsides, 
touches, passes, passes_completed, pass_completion_rate, crosses, cross_completed, 
cross_completion_rate, final_third_passes, final_third_passes_completed, final_third_pass_completion_rate, 
through_balls, carries, progressive_carries, carries_ended_with_goal, carries_ended_with_assist, 
carries_ended_with_shot, carries_ended_with_chance, posessions_won, posessions_lost, clean_sheets, 
clearances, interceptions, blocks, tackles, ground_duels, ground_duels_won, ground_duel_win_rate, 
aerial_duels, aerial_duels_won, aerial_duel_win_rate, goals_conceded, xGoT_conceded, own_goals, fouls, 
yellow_cards, red_cards, saves, save_percentage, penalties_saved, clearances_off_line, punches, high_claims, goals_prevented); 


#################################################################################
############## Creating the normalized player_match_stats Table #################
#################################################################################

CREATE TABLE pl_player_stats (  
    stat_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT 'Primary Key',
    player_id INT,
    team_id INT,
    nation VARCHAR(50),
    position VARCHAR(10),
    appearances INT,
    minutes INT,
    goals INT,
    assists INT,
    shots_total INT,
    shots_on_target INT,
    conversion_rate DECIMAL(5,2),
    big_chances_missed INT,
    hit_woodwork INT,
    offsides INT,
    touches INT,
    passes INT,
    passes_completed INT,
    pass_completion_rate DECIMAL(5,2),
    crosses INT,
    cross_completed INT,
    cross_completion_rate DECIMAL(5,2),
    final_third_passes INT,
    final_third_passes_completed INT,
    final_third_pass_completion_rate DECIMAL(5,2),
    through_balls INT,
    carries INT,
    progressive_carries INT,
    carries_ended_with_goal INT,
    carries_ended_with_assist INT,
    carries_ended_with_shot INT,
    carries_ended_with_chance INT,
    possessions_won INT,
    possessions_lost INT,
    clean_sheets INT,
    clearances INT,
    interceptions INT,
    blocks INT,
    tackles INT,
    ground_duels INT,
    ground_duels_won INT,
    ground_duel_win_rate DECIMAL(5,2),
    aerial_duels INT,
    aerial_duels_won INT,
    aerial_duel_win_rate DECIMAL(5,2),
    goals_conceded INT,
    xGoT_conceded DECIMAL(5,2),
    own_goals INT,
    fouls INT,
    yellow_cards INT,
    red_cards INT,
    saves INT,
    save_percentage DECIMAL(5,2),
    penalties_saved INT,
    clearances_off_line INT,
    punches INT,
    high_claims INT,
    goals_prevented INT,
    CONSTRAINT stat_player FOREIGN KEY (player_id) REFERENCES pl_players(player_id),
    CONSTRAINT stat_team FOREIGN KEY (team_id) REFERENCES pl_teams(team_id),
    CONSTRAINT unique_player_stat UNIQUE (player_id, team_id)
) COMMENT 'Normalized table for Premiere League Player Stats, 2024-2025 Season';


INSERT INTO player_match_stats (
    Player, Team, nation, position, appearances, minutes, goals, assists, shots_total, 
shots_on_target, conversion_rate, big_chances_missed, hit_woodwork, offsides, 
touches, passes, passes_completed, pass_completion_rate, crosses, cross_completed, 
cross_completion_rate, final_third_passes, final_third_passes_completed, final_third_pass_completion_rate, 
through_balls, carries, progressive_carries, carries_ended_with_goal, carries_ended_with_assist, 
carries_ended_with_shot, carries_ended_with_chance, posessions_won, posessions_lost, clean_sheets, 
clearances, interceptions, blocks, tackles, ground_duels, ground_duels_won, ground_duel_win_rate, 
aerial_duels, aerial_duels_won, aerial_duel_win_rate, goals_conceded, xGoT_conceded, own_goals, fouls, 
yellow_cards, red_cards, saves, save_percentage, penalties_saved, clearances_off_line, punches, high_claims, goals_prevented
)


SELECT
    player_id INT,
    team_id INT,
    nation VARCHAR(50),
    position VARCHAR(10),
    appearances INT,
    minutes INT,
    goals INT,
    assists INT,
    shots_total INT,
    shots_on_target INT,
    conversion_rate DECIMAL(5,2),
    big_chances_missed INT,
    hit_woodwork INT,
    offsides INT,
    touches INT,
    passes INT,
    passes_completed INT,
    pass_completion_rate DECIMAL(5,2),
    crosses INT,
    cross_completed INT,
    cross_completion_rate DECIMAL(5,2),
    final_third_passes INT,
    final_third_passes_completed INT,
    final_third_pass_completion_rate DECIMAL(5,2),
    through_balls INT,
    carries INT,
    progressive_carries INT,
    carries_ended_with_goal INT,
    carries_ended_with_assist INT,
    carries_ended_with_shot INT,
    carries_ended_with_chance INT,
    possessions_won INT,
    possessions_lost INT,
    clean_sheets INT,
    clearances INT,
    interceptions INT,
    blocks INT,
    tackles INT,
    ground_duels INT,
    ground_duels_won INT,
    ground_duel_win_rate DECIMAL(5,2),
    aerial_duels INT,
    aerial_duels_won INT,
    aerial_duel_win_rate DECIMAL(5,2),
    goals_conceded INT,
    xGoT_conceded DECIMAL(5,2),
    own_goals INT,
    fouls INT,
    yellow_cards INT,
    red_cards INT,
    saves,
    save_percentage,
    penalties_saved,
    clearances_off_line,
    punches,
    high_claims,
    goals_prevented,
FROM pl_player_stats_staging s
JOIN pl_matches m
    ON m.match_date = r.Date
    AND (r.team_id = m.home_team_id 
    OR r.team_id = m.away_team_id);



## Adding indexes to improve join performance
CREATE INDEX idx_player_name ON pl_players(player_name);
CREATE INDEX idx_team_name ON pl_teams(team_name);
CREATE INDEX idx_venue_id ON pl_venues(venue_id);
CREATE INDEX idx_ref_id ON pl_referees(ref_id);
CREATE INDEX idx_fixture_id ON pl_fixtures(fixture_id);
CREATE INDEX idx_match_date ON pl_matches(match_date);

