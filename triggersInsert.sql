Use `northwind`;
DROP TRIGGER IF EXISTS trigger_insert_customers;
DELIMITER $$
CREATE TRIGGER trigger_insert_customers
AFTER INSERT ON `northwind`.customers
FOR EACH ROW
	BEGIN
    DECLARE id INT;
    DECLARE op,cp,jt,ct,sp,cr VARCHAR(50);
    DECLARE fln VARCHAR(100);
	SET op = 'INSERT',
		id = new.id;
        IF(new.company is null) THEN SET cp = "N/A";
        ELSE SET cp = new.company;
        END IF;
        IF(new.first_name is null AND new.last_name is null) THEN SET fln = "N/A";
        ELSE SET fln = concat(new.first_name,' ', new.last_name);
        END IF;
        IF(new.job_title is null) THEN SET jt = "N/A";
        ELSE SET jt = new.job_title;
        END IF;
        IF(new.city is null) THEN SET ct = "N/A";
        ELSE SET ct = new.city;
        END IF;
        IF(new.state_province is null) THEN SET sp = "N/A";
        ELSE SET sp = new.state_province;
        END IF;
        IF(new.country_region is null) THEN SET cr = "N/A";
        ELSE SET cr = new.country_region;
        END IF;
	INSERT INTO `trabalho-ar`.aud_dim_customer values(id,cp,fln,jt,ct,sp,cr,op);
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_insert_employee;
DELIMITER $$
CREATE TRIGGER trigger_insert_employee
AFTER INSERT ON `northwind`.employees
FOR EACH ROW
	BEGIN
    DECLARE id INT;
    DECLARE op,cp,jt,ct,sp,cr VARCHAR(50);
    DECLARE fln VARCHAR(100);
	SET op = 'INSERT',
		id = new.id;
        IF(new.company is null) THEN SET cp = "N/A";
        ELSE SET cp = new.company;
        END IF;
        IF(new.first_name is null AND new.last_name is null) THEN SET fln = "N/A";
        ELSE SET fln = concat(new.first_name,' ', new.last_name);
        END IF;
        IF(new.job_title is null) THEN SET jt = "N/A";
        ELSE SET jt = new.job_title;
        END IF;
        IF(new.city is null) THEN SET ct = "N/A";
        ELSE SET ct = new.city;
        END IF;
        IF(new.state_province is null) THEN SET sp = "N/A";
        ELSE SET sp = new.state_province;
        END IF;
        IF(new.country_region is null) THEN SET cr = "N/A";
        ELSE SET cr = new.country_region;
        END IF;
	INSERT INTO `trabalho-ar`.aud_dim_employee values(id,cp,fln,jt,ct,sp,cr,op);
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_insert_shipper;
DELIMITER $$
CREATE TRIGGER trigger_insert_shipper
AFTER INSERT ON `northwind`.shippers
FOR EACH ROW
	BEGIN
    DECLARE id INT;
    DECLARE op,cp,jt,ct,sp,cr VARCHAR(50);
    DECLARE fln VARCHAR(100);
	SET op = 'INSERT',
		id = new.id;
        IF(new.company is null) THEN SET cp = "N/A";
        ELSE SET cp = new.company;
        END IF;
        IF(new.first_name is null AND new.last_name is null) THEN SET fln = "N/A";
        ELSE SET fln = concat(new.first_name,' ', new.last_name);
        END IF;
        IF(new.job_title is null) THEN SET jt = "N/A";
        ELSE SET jt = new.job_title;
        END IF;
        IF(new.city is null) THEN SET ct = "N/A";
        ELSE SET ct = new.city;
        END IF;
        IF(new.state_province is null) THEN SET sp = "N/A";
        ELSE SET sp = new.state_province;
        END IF;
        IF(new.country_region is null) THEN SET cr = "N/A";
        ELSE SET cr = new.country_region;
        END IF;
	INSERT INTO `trabalho-ar`.aud_dim_shipper values(id,cp,fln,jt,ct,sp,cr,op);
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_insert_supplier;
DELIMITER $$
CREATE TRIGGER trigger_insert_supplier
AFTER INSERT ON `northwind`.suppliers
FOR EACH ROW
	BEGIN
    DECLARE id INT;
    DECLARE op,cp,jt,ct,sp VARCHAR(50);
    DECLARE fln VARCHAR(100);
	SET op = 'INSERT',
		id = new.id;
        IF(new.company is null) THEN SET cp = "N/A";
        ELSE SET cp = new.company;
        END IF;
        IF(new.first_name is null AND new.last_name is null) THEN SET fln = "N/A";
        ELSE SET fln = concat(new.first_name,' ', new.last_name);
        END IF;
        IF(new.job_title is null) THEN SET jt = "N/A";
        ELSE SET jt = new.job_title;
        END IF;
        IF(new.city is null) THEN SET ct = "N/A";
        ELSE SET ct = new.city;
        END IF;
        IF(new.state_province is null) THEN SET sp = "N/A";
        ELSE SET sp = new.state_province;
        END IF;
	INSERT INTO `trabalho-ar`.aud_dim_supplier values(id,cp,fln,jt,ct,sp,op);
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_insert_products;
DELIMITER $$
CREATE TRIGGER trigger_insert_products
AFTER INSERT ON `northwind`.products
FOR EACH ROW
	BEGIN
    DECLARE id INT;
    DECLARE nm,qpu,ct,op VARCHAR(50);
    DECLARE sc,lp DECIMAL(19,4);
    DECLARE dc TINYINT(1);
    SET op= 'INSERT',
		id = new.id,
        lp = new.list_price,
        dc= new.discontinued;
        IF(new.product_name is null) THEN SET nm = "N/A";
        ELSE SET nm = new.product_name;
        END IF;
        IF(new.standard_cost is null) THEN SET sc = "N/A";
        ELSE SET sc = new.standard_cost;
        END IF;
        IF(new.quantity_per_unit is null) THEN SET qpu = "N/A";
        ELSE SET qpu = new.quantity_per_unit;
        END IF;
        IF(new.category is null) THEN SET ct = "N/A";
        ELSE SET ct = new.category;
        END IF;        
	INSERT INTO `trabalho-ar`.aud_dim_products VALUES(id,nm,sc,lp,qpu,dc,ct,op);
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_insert_orders;
DELIMITER $$
CREATE TRIGGER trigger_insert_orders
AFTER INSERT ON `northwind`.orders
FOR EACH ROW
	BEGIN
    DECLARE od,pd,sd,idc,idp,ids,ide INT;
    DECLARE op VARCHAR(50);
    DECLARE up,qt DECIMAL(18,4);
    DECLARE newDate, last_date DATETIME;
    SET newDate = (SELECT GREATEST(new.order_date,new.paid_date,new.shipped_date));
    SET last_date = (SELECT max(data) FROM pre_dim_time);
    IF(newDate>last_date) THEN CALL `trabalho-ar`.inc_datas_trigger(newDate,last_date);
    END IF;
    SET op = 'INSERT',
		up= (SELECT OFC.unit_cost FROM northwind.order_details AS OFC
						WHERE OFC.order_id = new.id),
        qt = (SELECT OFC.quantity FROM northwind.order_details AS OFC
                    WHERE OFC.order_id = new.id),
		od = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
					  WHERE DT.date = new.order_date),
		pd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
					  WHERE DT.date = new.paid_date),
		sd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
					  WHERE DT.date = new.shipped_date),
		idc = new.customer_id,
        idp = (SELECT OFC.product_id FROM northwind.order_details AS OFC
							WHERE OFC.order_id = new.id),
		ids = new.shipper_id,
        ide = new.employee_id;
        IF(up is null) THEN SET up = -1.0; 
        END IF;
        IF(od is null) THEN SET od = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
										where DT.date = '0000-00-00'); 
        END IF;
        IF(pd is null) THEN SET pd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
										where DT.date = '0000-00-00'); 
        END IF;
        IF(sd is null) THEN SET sd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
										where DT.date = '0000-00-00'); 
        END IF;
        IF(idc is null) THEN SET idc = 0; 
        END IF;
        IF(idp is null) THEN SET idp = 0; 
        END IF;
        IF(ids is null) THEN SET ids = 0; 
        END IF;
        IF(ide is null) THEN SET ide = 0; 
        END IF;
        
	INSERT INTO `trabalho-ar`.pre_order_facts
    VALUES(up,qt,od,pd,sd,idc,idp,ids,ide);
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_insert_purchase;
DELIMITER $$
CREATE TRIGGER trigger_insert_purchase
AFTER INSERT ON `northwind`.purchase_orders
FOR EACH ROW
	BEGIN
    DECLARE sd,pd,cd,ad,idp,ide,ids INT;
    DECLARE op VARCHAR(50);
    DECLARE up,qt DECIMAL(18,4);
    DECLARE newDate, last_date DATETIME;
    SET newDate = (SELECT GREATEST(new.submitted_date,new.payment_date,new.creation_date,new.approved_date));
    SET last_date = (SELECT max(data) FROM pre_dim_time);
    IF(newDate>last_date) THEN CALL `trabalho-ar`.inc_datas_trigger(newDate,last_date);
    END IF;
    SET op = 'INSERT',
		up= (SELECT OFC.unit_cost FROM northwind.purchase_orders_detais AS OFC
						WHERE OFC.purchase_order_id = new.id),
        qt = (SELECT OFC.quantity FROM northwind.purchase_orders_detais AS OFC
                    WHERE OFC.purchase_order_id = new.id),
		sd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
					  WHERE DT.date = new.submitted_date),
		pd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
					  WHERE DT.date = new.payment_date),
		cd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
					  WHERE DT.date = new.creation_date),
		ad = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
					  WHERE DT.date = new.approved_date),
        idp = (SELECT OFC.product_id FROM northwind.purchase_orders_detais AS OFC
							WHERE OFC.purchase_order_id = new.id),
		ide = new.created_by,
        ids = new.supplier_id;
        IF(up is null) THEN SET up = -1.0; 
        END IF;
        IF(sd is null) THEN SET sd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
										where DT.date = '0000-00-00'); 
        END IF;
        IF(pd is null) THEN SET pd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
										where DT.date = '0000-00-00'); 
        END IF;
        IF(cd is null) THEN SET cd = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
										where DT.date = '0000-00-00'); 
        END IF;
        IF(ad is null) THEN SET ad = (SELECT DT.id_dim_time FROM trabalho.dim_time AS DT
										where DT.date = '0000-00-00'); 
        END IF;
        IF(idp is null) THEN SET idp = 0; 
        END IF;
        IF(ids is null) THEN SET ids = 0; 
        END IF;
        IF(ide is null) THEN SET ide = 0; 
        END IF;
        
	INSERT INTO `trabalho-ar`.pre_purchase_facts
    VALUES(up,qt,sd,pd,cd,ad,idp,ide,ids);
	END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inc_datas_trigger`(startDate DATETIME, endDate DATETIME)
BEGIN
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

	INSERT INTO `trabalho-ar`.pre_dim_time(mes,ano,data,`dia_da_semana`,estacao)
	VALUES(@mes,@ano,@startDate,@dia,@est);
END$$
DELIMITER ;

