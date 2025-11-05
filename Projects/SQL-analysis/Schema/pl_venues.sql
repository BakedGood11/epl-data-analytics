######################################################################
################### Creating a Table for pl_venues ####################
#######################################################################
CREATE TABLE pl_venues (
    venue_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY COMMENT 'Primary key for pl_venues',
    venue_name VARCHAR(150)
) COMMENT 'Venue Table for the Premiere League'

INSERT INTO pl_venues (venue_name)
SELECT DISTINCT Venue
FROM pl_fixtures
ORDER BY Venue;

DROP TABLE pl_venues;