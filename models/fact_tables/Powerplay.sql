{{
    config(MATERIALIZED = "table")
}}

WITH powerplay_cte AS (
    Select 
    cmd.season,
    cmd.match_id,
    cmd.city,
    cmd.winner,
    cmd.team,
    cmd.team_1,
    cmd.team_2,
    cmd.by_innings,
    cmd.by_runs,
    cmd.by_wickets,
    sum(cmd.runs_total) as Total
    from 
    {{source('ipl_data','ipl_match_data')}} as cmd
    WHERE cmd.powerplay = 'yes'
    GROUP BY cmd.season,
    cmd.match_id,
    cmd.city,
    cmd.winner,
    cmd.team,
    cmd.team_1,
    cmd.team_2,
    cmd.by_innings,
    cmd.by_runs,
    cmd.by_wickets
)

Select  
p.season,
p.match_id,
p.city,
p.team,
case
when p.team = p.team_1 then p.team_2
when p.team = p.team_2 then p.team_1
end as opponent,
p.winner,
case 
when p.winner = p.team then 1 else 0 
end as Win_Flag,
p.Total
from powerplay_cte as p