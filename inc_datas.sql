CREATE DEFINER=`root`@`localhost` PROCEDURE `inc_datas`()
BEGIN

SET @startDate = (SELECT LEAST( MIN(order_date), MIN(shipped_date), MIN(paid_date),
								MIN(submitted_date), MIN(approved_date)) AS OLD_DATE 
								FROM northwind.orders, northwind.purchase_orders);
SET @endDate = (SELECT GREATEST( MAX(order_date), MAX(shipped_date), MAX(paid_date),
				MAX(submitted_date), MAX(approved_date)) AS RECENT_DATE 
				FROM northwind.orders, northwind.purchase_orders);
                
while @startDate<=@endDate DO
	SET @m = (SELECT MONTH(@startDate));
	SET @ano = (SELECT YEAR(@startDate));
    SET @mes = concat(@m,"-",@ano);
    SET @dia = dayname(@startDate);
    select 
	CASE WHEN MONTH(@startDate) IN (3,4,5) THEN "SPRING"
		WHEN MONTH(@startDate) IN (6,7,8) THEN "SUMMER"
		WHEN MONTH(@startDate) IN (9,10,11) THEN "AUTUMN"
		ELSE "WINTER"
		END
	INTO @est;
    INSERT INTO `trabalho-ar`.pre_dim_time(mes,ano,data,`dia_da_semana`,estacao)
    VALUES(@mes,@ano,@startDate,@dia,@est);
    
	SET @startDate = DATE_ADD(@startDate, INTERVAL 1 DAY);
END WHILE;

SET @m = (SELECT MONTH(@startDate));
SET @ano = (SELECT YEAR(@startDate));
SET @mes = concat(@m,"-",@ano);
SET @dia = dayname(@startDate);
select 
	CASE WHEN MONTH(@startDate) IN (3,4,5) THEN "SPRING"
		WHEN MONTH(@startDate) IN (6,7,8) THEN "SUMMER"
		WHEN MONTH(@startDate) IN (9,10,11) THEN "AUTUMN"
		ELSE "WINTER"
		END
	INTO @est;
INSERT INTO `trabalho-ar`.pre_dim_time(mes,ano,data,`dia_da_semana`,estacao)
VALUES(@mes,@ano,@startDate,@dia,@est);

END