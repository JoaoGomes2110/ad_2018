DELIMITER $$
create procedure curProducts()
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
    readloop: loop
    fetch cur into aux_id_dim_products,aux_name,aux_standard_cost,aux_list_price,aux_quantity_per_unit,aux_discontinued,aux_category;
    if aux_name is null then
        set aux_name = "Não tem";
    end if;
	if aux_name is null then
        set aux_name = "Não tem";
    end if;
    if aux_standard_cost is null then
        set aux_standard_cost = "Não tem";
    end if;
    if aux_quantity_per_unit is null then
        set aux_quantity_per_unit = "Não tem";
    end if;
    if aux_category is null then
        set aux_category = "Não tem";
    end if;
    if done then
        leave readloop;
    end if;
    insert into dim_products(id_dim_products,name,standard_cost,list_price,quantity_per_unit,discontinued,category) 
    values(aux_id_dim_products,aux_name,aux_standard_cost,aux_list_price,aux_quantity_per_unit,aux_discontinued,aux_category);
    end loop;
    close cur;
end 
$$

call curProducts;

drop procedure curProducts;