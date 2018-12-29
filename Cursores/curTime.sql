CREATE PROCEDURE `dim_time_st`()
BEGIN
INSERT INTO trabalho.dim_time(month,year,date,dayofweek,season)
SELECT mes,ano,data,`dia_da_semana`,estacao FROM `trabalho-ar`.`pre_dim_time`;
END