Use `trabalho-ar`;
DROP TRIGGER IF EXISTS trigger_aud_customers;
DELIMITER $$
CREATE TRIGGER trigger_aud_customers
AFTER INSERT ON `trabalho-ar`.aud_dim_customer
FOR EACH ROW
	BEGIN
    DECLARE last_id INT;
    IF(new.operation like 'INSERT') THEN
		INSERT INTO trabalho.dim_customer
		VALUES(new.idaud_dim_costumer,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province,new.country_region);
	END IF;
    IF(new.operation like 'UPDATE') THEN
		SET last_id = (SELECT id_dim_customer+1 FROM trabalho.dim_customer ORDER BY id_dim_customer DESC LIMIT 1);
		INSERT INTO trabalho.dim_customer
		VALUES(last_id,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province,new.country_region);
	END IF;
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_aud_employee;
DELIMITER $$
CREATE TRIGGER trigger_aud_employee
AFTER INSERT ON `trabalho-ar`.aud_dim_employee
FOR EACH ROW
	BEGIN
    DECLARE last_id INT;
    IF(new.operation like 'INSERT') THEN
		INSERT INTO trabalho.dim_employee
		VALUES(new.idaud_dim_employee,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province,new.country_region);
	END IF;
    IF(new.operation like 'UPDATE') THEN
		SET last_id = (SELECT id_dim_employee+1 FROM trabalho.dim_employee ORDER BY id_dim_employee DESC LIMIT 1);
		INSERT INTO trabalho.dim_employee
		VALUES(last_id,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province,new.country_region);
	END IF;
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_aud_shipper;
DELIMITER $$
CREATE TRIGGER trigger_aud_shipper
AFTER INSERT ON `trabalho-ar`.aud_dim_shipper
FOR EACH ROW
	BEGIN
    DECLARE last_id INT;
    IF(new.operation like 'INSERT') THEN
		INSERT INTO trabalho.dim_shipper
		VALUES(new.idaud_dim_shipper,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province,new.country_region);
	END IF;
    IF(new.operation like 'UPDATE') THEN
		SET last_id = (SELECT id_dim_shipper+1 FROM trabalho.dim_shipper ORDER BY id_dim_shipper DESC LIMIT 1);
		INSERT INTO trabalho.dim_shipper
		VALUES(last_id,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province,new.country_region);
	END IF;
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_aud_supplier;
DELIMITER $$
CREATE TRIGGER trigger_aud_supplier
AFTER INSERT ON `trabalho-ar`.aud_dim_supplier
FOR EACH ROW
	BEGIN
    DECLARE last_id INT;
    IF(new.operation like 'INSERT') THEN
		INSERT INTO trabalho.dim_supplier
		VALUES(new.idaud_dim_supplier,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province);
	END IF;
    IF(new.operation like 'UPDATE') THEN
		SET last_id = (SELECT id_dim_supplier+1 FROM trabalho.dim_supplier ORDER BY id_dim_supplier DESC LIMIT 1);
		INSERT INTO trabalho.dim_supplier
		VALUES(last_id,new.company,new.first_last_name,new.job_title,
		new.city,new.state_province);
	END IF;
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_aud_products;
DELIMITER $$
CREATE TRIGGER trigger_aud_products
AFTER INSERT ON `trabalho-ar`.aud_dim_products
FOR EACH ROW
	BEGIN
    DECLARE last_id INT;
    IF(new.operation like 'INSERT') THEN
		INSERT INTO trabalho.dim_products
		VALUES(new.idaud_dim_products,new.name,new.standard_cost,new.list_price,
		new.quantity_per_unit,new.discontinued,new.category);
	END IF;
    IF(new.operation like 'UPDATE') THEN
		SET last_id = (SELECT id_dim_products+1 FROM trabalho.dim_products ORDER BY id_dim_products DESC LIMIT 1);
		INSERT INTO trabalho.dim_products
		VALUES(new.idaud_dim_products,new.name,new.standard_cost,new.list_price,
		new.quantity_per_unit,new.discontinued,new.category);
	END IF;
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_aud_pre_order;
DELIMITER $$
CREATE  TRIGGER trigger_aud_pre_order 
	AFTER INSERT ON pre_order_facts 
    FOR EACH ROW BEGIN
    DECLARE last_id INT;
    IF(new.operation like 'INSERT') THEN
		INSERT INTO trabalho.orders_fact
		VALUES(default,new.unit_price,new.quantity,new.order_date,
        new.paid_date,new.shipped_date,new.id_dim_customer,new.id_dim_products,
        new.id_dim_shipper,new.id_dim_employer);
	END IF;
    IF(new.operation like 'UPDATE') THEN
		SET last_id = (SELECT id_orders_fact+1 FROM trabalho.orders_fact ORDER BY id_orders_fact DESC LIMIT 1);
		INSERT INTO trabalho.orders_fact
		VALUES(last_id,new.unit_price,new.quantity,new.order_date,
        new.paid_date,new.shipped_date,new.id_dim_customer,new.id_dim_products,
        new.id_dim_shipper,new.id_dim_employer);
	END IF;
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_aud_pre_purchase;
DELIMITER $$
CREATE TRIGGER trigger_aud_pre_purchase
AFTER INSERT ON `trabalho-ar`.pre_purchase_facts
FOR EACH ROW
	BEGIN
    DECLARE last_id INT;
    IF(new.operation like 'INSERT') THEN
		INSERT INTO trabalho.purchase_order_fact
		VALUES(default,new.unit_cost,new.submitted_date,
        new.payment_date,new.created_date,new.approved_date,new.id_dim_products,
        new.id_dim_employer,new.id_dim_supplier,new.quantity);
	END IF;
    IF(new.operation like 'UPDATE') THEN
		SET last_id = (SELECT id_purchase_order_fact+1 FROM trabalho.purchase_order_fact ORDER BY id_purchase_order_fact DESC LIMIT 1);
		INSERT INTO trabalho.purchase_order_fact
		VALUES(new.idpre_order_facts,new.unit_cost,new.quantity,new.submitted_date,
        new.payment_date,new.created_date,new.approved_date,new.id_dim_products,
        new.id_dim_employer,new.id_dim_supplier);
	END IF;
	END$$
DELIMITER ;

DROP TRIGGER IF EXISTS trigger_time;
DELIMITER $$
CREATE TRIGGER trigger_time
AFTER INSERT ON `trabalho-ar`.pre_dim_time
FOR EACH ROW
	BEGIN
    INSERT INTO trabalho.dim_time VALUES(new.mes,new,ano,new.data,new.dia_da_semana,new.estacao);
	END$$
DELIMITER ;