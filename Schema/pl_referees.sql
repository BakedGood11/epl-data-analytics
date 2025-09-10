## Creating a Referee Table ###
CREATE TABLE pl_referees (
    ref_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT 'Primary key for Referee Table',
    referee_name VARCHAR(100)
)COMMENT 'Referee Table for the Premiere League'

INSERT INTO pl_referees (referee_name)
SELECT Referee
FROM pl_matches
GROUP BY Referee
ORDER BY Referee;
