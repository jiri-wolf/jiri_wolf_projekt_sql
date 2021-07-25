 
 
create or replace algorithm = UNDEFINED view `data`.`vi_wolf_final_sql` as 
select
    `cbd`.`date` as `date`,
    `cbd`.`country` as `country`,
    `cbd`.`confirmed` as `confirmed`,
    `cbd`.`deaths` as `deaths`,
    `cbd`.`recovered` as `recovered`,
    case
        when weekday(`cbd`.`date`) in (5, 6) then 0
        else 1
    end as `workday`,
    case
        when month(`cbd`.`date`) >= 3
        and dayofmonth(`cbd`.`date`) >= 1
        and month(`cbd`.`date`) <= 5
        and dayofmonth(`cbd`.`date`) <= 31 then 0
        when month(`cbd`.`date`) >= 6
        and dayofmonth(`cbd`.`date`) >= 1
        and month(`cbd`.`date`) <= 8
        and dayofmonth(`cbd`.`date`) <= 31 then 1
        when month(`cbd`.`date`) >= 9
        and dayofmonth(`cbd`.`date`) >= 1
        and month(`cbd`.`date`) <= 11
        and dayofmonth(`cbd`.`date`) <= 31 then 2
        when month(`cbd`.`date`) >= 12
        and dayofmonth(`cbd`.`date`) >= 1
        and month(`cbd`.`date`) <= 12
        and dayofmonth(`cbd`.`date`) <= 31 then 3
        when month(`cbd`.`date`) >= 1
        and dayofmonth(`cbd`.`date`) >= 1
        and month(`cbd`.`date`) <= 2
        and dayofmonth(`cbd`.`date`) <= 31 then 3
    end as `season`,
    `c`.`population_density` as `population_density`,
    (
    select
        `e`.`GDP` / `e`.`population`
    from
        `data`.`economies` `e`
    where
        `e`.`country` = `cbd`.`country`
        and `e`.`year` = 2018) as `hdp_population_ratio_2018`,
    (
    select
        `e`.`gini`
    from
        `data`.`economies` `e`
    where
        `e`.`country` = `cbd`.`country`
        and `e`.`year` = 2018) as `gini_2018`,
    (
    select
        `e`.`mortaliy_under5`
    from
        `data`.`economies` `e`
    where
        `e`.`country` = `cbd`.`country`
        and `e`.`year` = 2018) as `mortality_under_5_2018`,
    (
    select
        `rbps`.`Christians`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `christianity_ratio`,
    (
    select
        `rbps`.`Buddhists`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `budhism_ratio`,
    (
    select
        `rbps`.`Folk Religions`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `folk_religions_ratio`,
    (
    select
        `rbps`.`Hindus`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `hinduism_ratio`,
    (
    select
        `rbps`.`Jews`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `judaism_ratio`,
    (
    select
        `rbps`.`Muslims`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `islam_ratio`,
    (
    select
        `rbps`.`Other Religions`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `other_religions_ratio`,
    (
    select
        `rbps`.`Unaffiliated`
    from
        `data`.`religions_by_percentage_share` `rbps`
    where
        `rbps`.`Country` = `cbd`.`country`
        and `rbps`.`Year` = 2020) as `unaffiliated_ratio`,
    (
    select
        `le`.`life_expectancy`
    from
        `data`.`life_expectancy` `le`
    where
        `le`.`country` = `cbd`.`country`
        and `le`.`year` = '2015') - (
    select
        `le`.`life_expectancy`
    from
        `data`.`life_expectancy` `le`
    where
        `le`.`country` = `cbd`.`country`
        and `le`.`year` = '1965') as `life_expectancy_diff_1965_2015`,
    (
    select
        truncate(avg(`w`.`temp`), 2)
    from
        `data`.`weather` `w`
    where
        `w`.`time` between '06:00' and '21:00'
        and month(`w`.`date`) >= 3
            and dayofmonth(`w`.`date`) >= 1
                and month(`w`.`date`) <= 5
                    and dayofmonth(`w`.`date`) <= 31
                        and `w`.`city` = `c`.`capital_city`) as `average_temp_season_0`,
    (
    select
        truncate(avg(`w`.`temp`), 2)
    from
        `data`.`weather` `w`
    where
        `w`.`time` between '06:00' and '21:00'
        and month(`w`.`date`) >= 6
            and dayofmonth(`w`.`date`) >= 1
                and month(`w`.`date`) <= 8
                    and dayofmonth(`w`.`date`) <= 31
                        and `w`.`city` = `c`.`capital_city`) as `average_temp_season_1`,
    (
    select
        truncate(avg(`w`.`temp`), 2)
    from
        `data`.`weather` `w`
    where
        `w`.`time` between '06:00' and '21:00'
        and month(`w`.`date`) >= 9
            and dayofmonth(`w`.`date`) >= 1
                and month(`w`.`date`) <= 11
                    and dayofmonth(`w`.`date`) <= 31
                        and `w`.`city` = `c`.`capital_city`) as `average_temp_season_2`,
    (
    select
        truncate(avg(`w`.`temp`), 2)
    from
        `data`.`weather` `w`
    where
        `w`.`time` between '06:00' and '21:00'
        and (month(`w`.`date`) >= 12
            and dayofmonth(`w`.`date`) >= 1
                and month(`w`.`date`) <= 12
                    and dayofmonth(`w`.`date`) <= 31
                        or month(`w`.`date`) >= 1
                            and dayofmonth(`w`.`date`) >= 1
                                and month(`w`.`date`) <= 2
                                    and dayofmonth(`w`.`date`) <= 31)
            and `w`.`city` = `c`.`capital_city`) as `average_temp_season_3`,
    (
    select
        sum(case when `w`.`rain` <> 0 then 3 else 0 end)
    from
        `data`.`weather` `w`
    where
        `w`.`date` = `cbd`.`date`
        and `w`.`city` = `c`.`capital_city`) as `sum_hours_none_zero_rainfall`,
    (
    select
        max(`w`.`gust`)
    from
        `data`.`weather` `w`
    where
        `w`.`date` = `cbd`.`date`
        and `w`.`city` = `c`.`capital_city`) as `max_gust_wind_speed`,
    `c`.`median_age_2018` as `median_age_2018`
from
    (`data`.`covid19_basic_differences` `cbd`
join `data`.`countries` `c` on
    (`c`.`country` = `cbd`.`country`))
    
    
    
select * from vi_wolf_final_sql vwfs 
where season = 0
    
    
     
    
select * from countries c 
group by country 