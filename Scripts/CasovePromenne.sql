#Èasové promìnné
-- binární promìnná pro víkend / pracovní den
-- roèní období daného dne (zakódujte prosím jako 0 až 3)

SELECT *,
CASE WHEN WEEKDAY(`date`) IN (5,6) THEN 0 ELSE 1 END AS 'workday',
CASE WHEN (MONTH(`date`)>=3 AND DAYOFMONTH(`date`)>=1) AND (MONTH(cbd.`date`) <= 5 AND DAYOFMONTH(`date`)<=31) THEN 0
	 WHEN (MONTH(`date`)>=6 AND DAYOFMONTH(`date`)>=1) AND (MONTH(cbd.`date`) <= 8 AND DAYOFMONTH(`date`)<=31) THEN 1
	 WHEN (MONTH(`date`)>=9 AND DAYOFMONTH(`date`)>=1) AND (MONTH(cbd.`date`) <= 11 AND DAYOFMONTH(`date`)<=31) THEN 2
	 WHEN (MONTH(`date`)>=12 AND DAYOFMONTH(`date`)>=1) AND (MONTH(cbd.`date`) <= 12 AND DAYOFMONTH(`date`)<=31) THEN 3
     WHEN (MONTH(`date`)>=1 AND DAYOFMONTH(`date`)>=1) AND (MONTH(cbd.`date`) <= 2 AND DAYOFMONTH(`date`)<=31) THEN 3 END AS 'season'
FROM covid19_basic_differences cbd