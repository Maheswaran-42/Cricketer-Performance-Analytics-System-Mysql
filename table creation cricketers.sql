create database cricketdb;
use cricketdb;
drop database cricketdb;
create table players(
  player_id int,
  name varchar(30),
  age int,
  country varchar(30),
  role varchar(30),
  batting_style varchar(30),
  bowling_style varchar(30),
  constraint player_id_pk primary key (player_id) 
);
create table player_status(
  stat_id int auto_increment,
  player_id int,
  format enum ("test","Odi","t20"),
  matches int,
  runs int,
  wickets int,
  batting_avg float,
  bowling_avg float,
  constraint stat_id_pk primary key (stat_id),
  constraint player_id_fk foreign key (player_id) references players(player_id)
);
  
create table teams(
  team_id int primary key,
  team_name varchar(25),
  country varchar(25)
  );
  drop table teams;

  
create table  PlayerTeams (
    player_id INT,
    team_id INT,
    from_year INT,
    to_year INT,
    PRIMARY KEY (player_id, team_id),
    FOREIGN KEY (player_id) REFERENCES Players(player_id),
    FOREIGN KEY (team_id) REFERENCES Teams(team_id)
);
select * from playerteams;

create table format_runs(
  player_id int,
  test_runs int,
  odi_runs int,
  t20_runs int,
  foreign key (player_id) references players(player_id)
  );
select * from players;
select * from player_status;
select * from playerteams;
select * from format_runs;
select * from teams;
 