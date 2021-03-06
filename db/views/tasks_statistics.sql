create view task_statistics as 
select (r.task_id*100000+r.parameter_id) id,r.task_id,r.parameter_id,p.parameter_role_id,p.parameter_type_id,p.data_type_id,
    avg(r.data_value) avg_values,
	stddev(r.data_value) stddev_values,
 	count(r.data_value) num_values ,
 	count(distinct r.data_value) num_unique ,
	max(r.data_value) max_values ,
	min(r.data_value) min_values 
from task_values r,parameters p
where p.id =r.parameter_id
group by r.parameter_id,r.task_id,p.parameter_role_id,p.parameter_type_id,p.data_type_id
;