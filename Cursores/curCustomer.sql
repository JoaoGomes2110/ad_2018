DELIMITER $$
create procedure curCustomer()
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
    readloop: loop
    fetch cur into aux_id_dim_customer,aux_company,aux_first_name_last_name,aux_job_title,aux_city,aux_state_province,aux_country_region;
    if aux_company is null then
        set aux_company = "Não tem";
    end if;
    if aux_first_name_last_name is null then
        set aux_first_name_last_name = "Não tem";
    end if;
    if aux_job_title is null then
        set aux_job_title = "Não tem";
    end if;
    if aux_city is null then
        set aux_city = "Não tem";
    end if;
    if aux_state_province is null then
        set aux_state_province = "Não tem";
    end if;
    if aux_country_region is null then
        set aux_country_region = "Não tem";
    end if;
    if done then
        leave readloop;
    end if;
    insert into dim_customer(id_dim_customer,company,first_name_last_name,job_title,city,state_province,country_region) 
    values(aux_id_dim_customer,aux_company,aux_first_name_last_name,aux_job_title,aux_city,aux_state_province,aux_country_region);
    end loop;
    close cur;
end 
$$

call curCustomer;

drop procedure curCustomer;
