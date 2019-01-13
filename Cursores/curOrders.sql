CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_orders_fact`()
BEGIN
	DECLARE done INT DEFAULT FALSE;
    DECLARE up decimal(19,4);
    DECLARE qt decimal(18,4);
    DECLARE od, pd, sd DATETIME;
    DECLARE idP, idC, idS, idT, idE INT;
    DECLARE curG CURSOR FOR SELECT DISTINCT  unit_price, quantity, order_date, shipped_date, paid_date, id_dim_products, id_dim_customer,
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
	
OPEN curG;

    
    read_loop: LOOP
		FETCH curG INTO up,qt,od, pd, sd, idP, idC, idS, idT, idE;
            
		IF done THEN
			LEAVE read_loop;
		END IF;
	
		INSERT INTO pre_order_facts(unit_price,quantity,order_date,paid_date,shipped_date,id_dim_customer,
					id_dim_products,id_dim_shipper,id_dim_time,id_dim_employer)
		VALUES(up,qt,od, pd, sd, idC, idP, idS, idT, idE);
		

    END LOOP;
    
    CLOSE curG;
END