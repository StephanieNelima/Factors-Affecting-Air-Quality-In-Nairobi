USE nrb_stats;
DELETE FROM nrb_stats WHERE Year<2014;
ALTER table nrb_stats
ADD Population int(255);
INSERT INTO nrb_stats(Population)
select Population
from nrb_population;