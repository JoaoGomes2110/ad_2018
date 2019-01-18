DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `1_curCustomer`()
begin
    declare done int default false;
    declare aux_id_dim_customer int;
    declare aux_company varchar(50);
    declare aux_first_name_last_name varchar(100);
    declare aux_job_title varchar(50);
    declare aux_city varchar(50);
    declare aux_state_province varchar(50);
    declare aux_country_region varchar(50);
    declare cur cursor for select distinct id,company,concat(first_name,' ',last_name) as first_name_last_name,job_title,city,state_province,country_region from northwind.customers;
    declare continue handler for not found set done=true;
    open cur;
	insert into trabalho.dim_customer(id_dim_customer,company,first_name_last_name,job_title,city,state_province,country_region) 
    values(0,"N\A","N\A","N\A","N\A","N\A","N\A");
    readloop: loop
    fetch cur into aux_id_dim_customer,aux_company,aux_first_name_last_name,aux_job_title,aux_city,aux_state_province,aux_country_region;
    if aux_company is null then
        set aux_company = "N/A";
    end if;
    if aux_first_name_last_name is null then
        set aux_first_name_last_name = "N/A";
    end if;
    if aux_job_title is null then
        set aux_job_title = "N/A";
    end if;
    if aux_city is null then
        set aux_city = "N/A";
    end if;
    if aux_state_province is null then
        set aux_state_province = "N/A";
    end if;
    if aux_country_region is null then
        set aux_country_region = "N/A";
    end if;
    if done then
        leave readloop;
    end if;
    insert into trabalho.dim_customer(id_dim_customer,company,first_name_last_name,job_title,city,state_province,country_region) 
    values(aux_id_dim_customer,aux_company,aux_first_name_last_name,aux_job_title,aux_city,aux_state_province,aux_country_region);
    end loop;
    close cur;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `2_curEmployee`()
begin
	declare done int default false;
    declare aux_id int;
    declare aux_company varchar(50);
    declare aux_name varchar(100);
    declare aux_job_title varchar(50);
    declare aux_city varchar(50);
    declare aux_state_province varchar(50);
    declare aux_country_region varchar(50);
    declare cur cursor for select distinct id,company,concat(first_name,' ',last_name) as first_name_last_name, job_title, city, state_province, country_region from northwind.employees;
    declare continue handler for not found set done=true;
    open cur;
    insert into trabalho.dim_employee(id_dim_employer,company,first_name_last_name,job_title,city,state_province,country_region) 
    values(0,"N\A","N\A","N\A","N\A","N\A","N\A");
    readloop: loop
    fetch cur into aux_id,aux_company,aux_name,aux_job_title,aux_city,aux_state_province,aux_country_region;
    if aux_company is null then
		set aux_company = "N/A";
    end if;
    if aux_name is null then
		set aux_name = "N/A";
    end if;
    if aux_job_title is null then
		set aux_job_title = "N/A";
    end if;
	if aux_city is null then
		set aux_city = "N/A";
    end if;
	if aux_state_province is null then
		set aux_state_province = "N/A";
    end if;
	if aux_country_region is null then
		set aux_country_region = "N/A";
    end if;
    if done then
		leave readloop;
	end if;
    insert into trabalho.dim_employee(id_dim_employer,company,first_name_last_name,job_title,city,state_province,country_region) values(aux_id,aux_company,aux_name,aux_job_title,aux_city,aux_state_province,aux_country_region);
    end loop;
    close cur;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `3_curProducts`()
begin
    declare done int default false;
    declare aux_id_dim_products int;
    declare aux_name varchar(50);
    declare aux_standard_cost decimal(19,4);
    declare aux_list_price decimal(19,4);
    declare aux_quantity_per_unit varchar(50);
    declare aux_discontinued tinyint(1);
    declare aux_category varchar(50);
    declare cur cursor for select distinct id,product_name,standard_cost,list_price,quantity_per_unit,discontinued,category from northwind.products;
    declare continue handler for not found set done=true;
    open cur;
    insert into trabalho.dim_products(id_dim_products,name,standard_cost,list_price,quantity_per_unit,discontinued,category) 
    values(0,"N\A",-1.0,-1.0,-1.0,0,"N\A");
    readloop: loop
    fetch cur into aux_id_dim_products,aux_name,aux_standard_cost,aux_list_price,aux_quantity_per_unit,aux_discontinued,aux_category;
    if aux_name is null then
        set aux_name = "N/A";
    end if;
	if aux_name is null then
        set aux_name = "N/A";
    end if;
    if aux_standard_cost is null then
        set aux_standard_cost = "N/A";
    end if;
    if aux_quantity_per_unit is null then
        set aux_quantity_per_unit = "N/A";
    end if;
    if aux_category is null then
        set aux_category = "N/A";
    end if;
    if done then
        leave readloop;
    end if;
    insert into trabalho.dim_products(id_dim_products,name,standard_cost,list_price,quantity_per_unit,discontinued,category) 
    values(aux_id_dim_products,aux_name,aux_standard_cost,aux_list_price,aux_quantity_per_unit,aux_discontinued,aux_category);
    end loop;
    close cur;
end$$
DELIMITER ;
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `4_curShipper`()
begin
	declare done int default false;
    declare aux_id_dim_shipper int;
    declare aux_company varchar(50);
    declare aux_first_name_last_name varchar(100);
    declare aux_job_title varchar(50);
    declare aux_city varchar(50);
    declare aux_state_province varchar(50);
    declare aux_country_region varchar(50);
    declare cur cursor for select distinct id,company,concat(first_name,' ',last_name) as first_name_last_name,job_title,city,state_province,country_region from northwind.shippers;
    declare continue handler for not found set done=true;
    open cur;
    insert into trabalho.dim_shipper(id_dim_shipper,company,first_name_last_name,job_title,city,state_province,country_region) 
    values(0,"N\A","N\A","N\A","N\A","N\A","N\A");
    readloop: loop
    fetch cur into aux_id_dim_shipper,aux_company,aux_first_name_last_name,aux_job_title,aux_city,aux_state_province,aux_country_region;
    if aux_company is null then
        set aux_company = "N\A";
    end if;
    if aux_first_name_last_name is null then
		set aux_first_name_last_name = "N\A";
    end if;
    if aux_job_title is null then
		set aux_job_title = "N\A";
    end if;
	if aux_city is null then
		set aux_city = "N\A";
    end if;
	if aux_state_province is null then
		set aux_state_province = "N\A";
    end if;
	if aux_country_region is null then
		set aux_country_region = "N\A";
    end if;
    if done then
		leave readloop;
	end if;
    insert into trabalho.dim_shipper(id_dim_shipper,company,first_name_last_name,job_title,city,state_province,country_region) 
    values(aux_id_dim_shipper,aux_company,aux_first_name_last_name,aux_job_title,aux_city,aux_state_province,aux_country_region);
    end loop;
    close cur;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `5_curSupplier`()
begin
	declare done int default false;
    declare aux_id int;
    declare aux_company varchar(50);
    declare aux_name varchar(100);
    declare aux_job_title varchar(50);
    declare aux_city varchar(50);
    declare aux_state_province varchar(50);
    declare aux_country_region varchar(50);
    declare cur cursor for select distinct id,company,concat(first_name,' ',last_name) as first_name_last_name, job_title, city, state_province, country_region from northwind.suppliers;
    declare continue handler for not found set done=true;
    open cur;
    insert into trabalho.dim_supplier(id_dim_supplier,company,first_name_last_name,job_title,city,state_province,country_region) 
    values(0,"N\A","N\A","N\A","N\A","N\A","N\A");
    readloop: loop
    fetch cur into aux_id,aux_company,aux_name,aux_job_title,aux_city,aux_state_province,aux_country_region;
    if aux_company is null then
		set aux_company = "N\A";
    end if;
    if aux_name is null then
		set aux_name = "N\A";
    end if;
    if aux_job_title is null then
		set aux_job_title = "N\A";
    end if;
	if aux_city is null then
		set aux_city = "N\A";
    end if;
	if aux_state_province is null then
		set aux_state_province = "N\A";
    end if;
	if aux_country_region is null then
		set aux_country_region = "N\A";
    end if;
    if done then
		leave readloop;
	end if;
    insert into trabalho.dim_supplier(id_dim_supplier,company,first_name_last_name,job_title,city,state_province,country_region) values(aux_id,aux_company,aux_name,aux_job_title,aux_city,aux_state_province,aux_country_region);
    end loop;
    close cur;
end$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `6_inc_datas`()
BEGIN

SET @startDate = (SELECT LEAST( MIN(order_date), MIN(shipped_date), MIN(paid_date),
								MIN(submitted_date), MIN(approved_date)) AS OLD_DATE 
								FROM northwind.orders, northwind.purchase_orders);
SET @endDate = (SELECT GREATEST( MAX(order_date), MAX(shipped_date), MAX(paid_date),
				MAX(submitted_date), MAX(approved_date)) AS RECENT_DATE 
				FROM northwind.orders, northwind.purchase_orders);
                
SET @lastDate = (SELECT MAX(data) FROM `trabalho-ar`.pre_dim_time);

IF(@lastDate<=@endDate OR @lastDate is null) THEN
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
END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `7_dim_time_st`()
BEGIN
INSERT INTO trabalho.dim_time(month,year,date,dayofweek,season)
VALUES("N/A","N/A", '0000-00-00',"N/A","N/A");
INSERT INTO trabalho.dim_time(month,year,date,dayofweek,season)
SELECT mes,ano,data,`dia_da_semana`,estacao FROM `trabalho-ar`.`pre_dim_time`;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `8_sp_order_facts`()
BEGIN
    
DECLARE done INT DEFAULT FALSE;
    DECLARE up decimal(19,4);
    DECLARE qt decimal(18,4);
    DECLARE od, pd, sd DATETIME;
    DECLARE idP, idC, idS, idT, idE INT;
    DECLARE curG CURSOR FOR SELECT DISTINCT unit_price, quantity, order_date, shipped_date, paid_date, id_dim_products, id_dim_customer,
									id_dim_shipper,id_dim_employer
							FROM northwind.orders AS O
                            INNER JOIN northwind.order_details AS OD
                            ON O.id = OD.order_id
                            INNER JOIN trabalho.dim_customer AS DC
                            ON O.customer_id = DC.id_dim_customer
                            INNER JOIN trabalho.dim_employee AS DE
                            ON O.employee_id = DE.id_dim_employer
                            INNER JOIN trabalho.dim_products AS DP
                            ON OD.product_id = DP.id_dim_products
                            INNER JOIN trabalho.dim_shipper AS DS
                            ON O.shipper_id = DS.id_dim_shipper;
declare continue handler for not found set done=true;
OPEN curG;

    
    read_loop: LOOP
		FETCH curG INTO up,qt,od, sd, pd, idP, idC, idS, idE;
        SET @o_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
						   where DT.date = od);
		 SET @p_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
						   where DT.date = pd);
		 SET @s_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
						   where DT.date = sd);
                           
		if @p_date is null then
        set @p_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
						   where DT.date = '0000-00-00');
		end if;
        if @s_date is null then
        set @s_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
						   where DT.date = '0000-00-00');
		end if;
        if @o_date is null then
        set @o_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
						   where DT.date = '0000-00-00');
		end if;
        
		IF done THEN
			LEAVE read_loop;
		END IF;
	
		INSERT INTO trabalho.orders_fact(unit_price,quantity,order_date,shipped_date,paid_date,id_dim_products,
					id_dim_customer,id_dim_shipper,id_dim_employer)
		VALUES(up,qt,@o_date,@s_date, @p_date, idP, idC, idS, idE);
		

    END LOOP;
    
    CLOSE curG;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `9_sp_purchase_facts`()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE am decimal(19,4);
    DECLARE sd,pd,ad, cd DATETIME;
    DECLARE qt, idP,idE,idS INT;
    DECLARE curG CURSOR FOR SELECT DISTINCT unit_cost, quantity,submitted_date, payment_date, approved_date, creation_date,
						id_dim_products,id_dim_employer, id_dim_supplier
							FROM northwind.purchase_orders AS PO
                            INNER JOIN northwind.purchase_order_details AS POD
                            ON PO.id = POD.purchase_order_id
                            INNER JOIN trabalho.dim_products AS DP
                            ON POD.product_id = DP.id_dim_products
                            INNER JOIN trabalho.dim_employee AS DE
                            ON PO.created_by = DE.id_dim_employer
                            INNER JOIN trabalho.dim_supplier AS DS
                            ON PO.supplier_id = DS.id_dim_supplier;
declare continue handler for not found set done=true;
OPEN curG;

    
    read_loop: LOOP
		FETCH curG INTO am,qt,sd,pd,ad, cd,idP,idE,idS;
            
            SET @s_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
								where DT.date = sd);
			SET @p_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
									where DT.date = pd);
			SET @c_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
									where DT.date = cd);
			SET @a_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
									where DT.date = ad);
                                    
			if @s_date is null then
			set @s_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
							   where DT.date = '0000-00-00');
			end if;
			if @p_date is null then
			set @p_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
							   where DT.date = '0000-00-00');
			end if;
			if @c_date is null then
			set @c_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
							   where DT.date = '0000-00-00');
			end if;
			if @a_date is null then
			set @a_date = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
							   where DT.date = '0000-00-00');
			end if;
                        
		IF done THEN
			LEAVE read_loop;
		END IF;
	
		INSERT INTO trabalho.purchase_order_fact(unit_cost, quantity,submitted_date, payment_date, created_date,approved_date, 
					id_dim_products,id_dim_employer, id_dim_supplier)
		VALUES(am,qt,@s_date,@p_date,@c_date,@a_date,idP,idE,idS);
		

    END LOOP;
    
    CLOSE curG;
END$$
DELIMITER ;

