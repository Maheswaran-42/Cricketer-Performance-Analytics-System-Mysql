select * from players;
select * from player_status;
select * from playerteams;
select * from format_runs;
select * from teams;
 
-- Querys

 -- Get the name, country, and role of all players who have a batting average above 50 in any format. 
 select pl.name , pl.country,pl.role 
 from players pl left join player_status ps
 on pl.player_id = ps.player_id 
 where ps.batting_avg > 50;
 
-- Find players who have taken more than 100 wickets in Test cricket.
select pl.name , ps.wickets,ps.format
from players pl right join player_status ps
on pl.player_id = ps.player_id 
where ps.wickets > 100 and ps.format = "test";

-- Aggregations
-- Show the total runs scored by each player across all formats (using format_runs).
select  pl.name , fr.test_runs,fr.odi_runs,fr.t20_runs
from format_runs fr right join players pl
on pl.player_id = fr.player_id;

-- Find the player with the highest total runs across all formats.
select pl.name ,sum(fr.test_runs + fr.odi_runs + fr.t20_runs) as total_runs 
from players pl right join format_runs fr
on pl.player_id = fr.player_id
group by pl.name
order by total_runs desc limit 1;

-- Get the average bowling average of all bowlers in T20 format.
select avg(ps.bowling_avg) as avg_bowl, ps.format 
from player_status ps where ps.format= "t20";


-- Team & Player Relations
-- List all players who have played for  one team.
select pl.player_id , pl.name , count(distinct t.team_id) as team_count
from players pl left join playerteams t
on pl.player_id = t.player_id
group by pl.player_id;


-- Get all players who played for a team in 2023.
select pl.name , t.team_name
from players pl inner join playerteams pt
on pl.player_id = pt.player_id
inner join teams t
on pt.team_id = t.team_id
where 2023 between pt.from_year and pt.to_year;


-- Find the top 5 players with the highest ODI runs.
select pl.name , fr.odi_runs
from players pl inner join format_runs fr
on pl.player_id = fr.player_id
order by fr.odi_runs desc limit 5;

-- Get players who have never played Tests (no record in player_status or format_runs).
select pl.name from players pl
left join player_status ps
on pl.player_id = ps.player_id 
and ps.format="test" where ps.player_id is null;


-- Which countries have the highest number of players in your dataset?
select country , count(*) as player_count
from players 
group by country
order by player_count desc;

-- Find all bowlers (role = 'Bowler') who have a batting average above 30 in any format.
select distinct pl.name 
from players pl left join player_status ps
on pl.player_id = ps.player_id
where pl.role = "bowler" and ps.batting_avg > 30;


-- Show the players and their teams who have scored more than 5000 Test runs.
select pl.name ,t.team_name , fr.test_runs
from players pl inner join format_runs fr
on pl.player_id = fr.player_id
inner join playerteams pt
on pl.player_id = pt.player_id 
inner join teams t
on pt.team_id = t.team_id
where fr.test_runs > 5000 ;


-- For each country, get the average batting average of its players in ODI format.
select pl.country , avg(ps.batting_avg) as bat_avg  
from players pl join player_status ps
on pl.player_id = ps.player_id
where ps.format = "odi"
group by pl.country;

-- Get the youngest player who has played T20s.
select pl.age 
from players pl left join player_status ps
on pl.player_id = ps.player_id
where ps.format = "t20" 
order by pl.age asc limit 1;

-- Find the player(s) who have the highest wickets in all formats combined.
select pl.name ,sum(ps.wickets) as highest_wicket_taker
from players pl left join player_status ps
on pl.player_id = ps.player_id
group by pl.name
order by highest_wicket_taker desc limit 1 ;

-- Find players who have a batting average above 40 in all formats they’ve played.
select pl.name , ps.format
from players pl inner join player_status ps
on pl.player_id = ps.player_id
where ps.batting_avg > 40 ;

-- Find the player who has served the longest duration for any single team.
select  p.name ,t.team_name,(pt.to_year - pt.from_year) as duration
from playerteams pt left join players p
on pt.player_id = pt.player_id
join teams t 
on pt.team_id = t.team_id
order by duration desc
limit 1;


-- List all players who have more than 3000 runs and more than 100 wickets in any format.
select distinct p.name 
from players p right join player_status ps
on p.player_id = ps.player_id
where ps.runs > 3000 and ps.wickets > 100; 

-- Find all players not linked to any team (i.e., never played for any team).
 select pl.name ,pt.player_id
 from players pl left join playerteams pt
 on pl.player_id = pt.player_id
left join teams t
on pt.team_id = t.team_id
where t.team_name is null;

--  Most Experienced Player
select p.name , sum(ps.matches) as total
from players p left join player_status ps
on p.player_id = ps.player_id
group by p.name
order by total desc limit 1;