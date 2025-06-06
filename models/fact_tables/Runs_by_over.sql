{{config(materialized='view')}}

select 
p.season,
p.match_id,
p.city,
p.bowler,
p.team,
count(p.wicket_kind) as wickets,
sum(p.runs_total) as total_runs,
sum(p.extras_byes) as extra_byes,
sum(p.extras_legbyes) as extra_legbyes,
sum(p.extras_noballs) as noballs,
sum(p.extras_wides) as wide,
sum(p.runs_extras) as total_extra,
sum(p.runs_batter) as batter_run
 from {{source('ipl_data','ipl_match_data')}} p
group by
p.season,
p.match_id,
p.city,
p.bowler,
p.team
