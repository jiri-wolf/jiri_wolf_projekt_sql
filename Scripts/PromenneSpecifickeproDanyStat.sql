SELECT c.country, population_density,
	(SELECT e.GDP / e.population FROM economies e 
	WHERE e.country = cbd.country AND e.`year` = 2018) AS 'hdp_population_ratio_2018',
	(SELECT e.`gini` FROM economies e 
	WHERE e.country = cbd.country AND e.`year` = 2018) AS 'gini_2018',
	(SELECT e.mortaliy_under5 FROM economies e 
	WHERE e.country = cbd.country AND e.`year` = 2018) AS 'mortality_under_5_2018',
	(SELECT rbps.Christians FROM religions_by_percentage_share rbps
	WHERE rbps.country = cbd.country and rbps.`Year`=2020) AS 'christianity_ratio',
	(SELECT rbps.Christians FROM religions_by_percentage_share rbps
	WHERE rbps.Buddhists = cbd.country and rbps.`Year`=2020) AS 'budhism_ratio',
	(SELECT rbps.`Folk Religions` FROM religions_by_percentage_share rbps
	WHERE rbps.country = cbd.country and rbps.`Year`=2020) AS 'folk_religions_ratio',
	(SELECT rbps.Hindus FROM religions_by_percentage_share rbps
	WHERE rbps.country = cbd.country and rbps.`Year`=2020) AS 'hinduism_ratio',
	(SELECT rbps.Jews FROM religions_by_percentage_share rbps
	WHERE rbps.country = cbd.country and rbps.`Year`=2020) AS 'judaism_ratio',
	(SELECT rbps.Muslims FROM religions_by_percentage_share rbps
	WHERE rbps.country = cbd.country and rbps.`Year`=2020) AS 'islam_ratio',
	(SELECT rbps.`Other Religions` FROM religions_by_percentage_share rbps
	WHERE rbps.country = cbd.country and rbps.`Year`=2020) AS 'other_religions_ratio',
	(SELECT rbps.Unaffiliated FROM religions_by_percentage_share rbps
	WHERE rbps.country = cbd.country and rbps.`Year`=2020) AS 'unaffiliated_ratio',
	((SELECT le.life_expectancy FROM life_expectancy le 
	WHERE le.country = cbd.country AND le.`year` = '2015') - (SELECT le.life_expectancy FROM life_expectancy le 
	WHERE le.country = cbd.country AND le.`year` = '1965')) AS 'life_expectancy_diff_1965_2015',
	c.median_age_2018 
FROM covid19_basic_differences cbd
inner JOIN countries c ON c.country = cbd.country;