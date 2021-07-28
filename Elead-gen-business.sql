
/*1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?*/
select monthname(billing.charged_datetime) as month, SUM(BILLING.AMOUNT) as revenue
from BILLING
WHERE charged_datetime  BETWEEN '2012-03-01' AND '2012-03-31' 
group by monthname(billing.charged_datetime);


/*2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?*/
select clients.client_id, sum(Billing.amount) as total_revenue
from billing
join clients
on billing.client_id = clients.client_id
where clients.client_id = 2;

/*3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?*/

select s.domain_name as website, c.client_id
from sites s
join clients c
on s.client_id = c.client_id
where c.client_id = 10;

/*4. ¿Qué consulta ejecutaría para obtener el número total de sitios 
creados por mes por año para el cliente con una identificación de 1? 
¿Qué pasa con el cliente = 20?*/

SELECT c. client_id, count(s.site_id) as number_of_websites, monthname(created_datetime) month_created, 
year(created_datetime) as year_created
from sites s
join clients c
on s.client_id = c.client_id
where c.client_id = 1
group by s.site_id asc;

SELECT c. client_id, count(s.site_id) as number_of_websites, monthname(created_datetime) as month_created,
year(created_datetime) as year_created
from sites s
join clients c
on s.client_id = c.client_id
where c.client_id = 20
group by s.site_id asc;

-- 5. ¿Qué consulta ejecutaría para obtener el número total de clientes 
-- potenciales generados para cada uno de los sitios entre el 1 de enero de 2011
-- y el 15 de febrero de 2011?

select s.domain_name as website, count(l.leads_id) as number_of_leads , 
DATE_FORMAT(l.registered_datetime, "%M %e , %Y") as date_generated
from  sites s, leads l
where s.site_id = l.site_id
and l.registered_datetime between '2011-1-1' 
and '2011-2-15'
group by s.domain_name, l.registered_datetime;


-- 6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes
-- y el número total de clientes potenciales que hemos generado para cada uno de 
-- nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?

select concat_ws(" ",c.first_name, c.last_name) as client_name, count(l.leads_id) as number_of_leads
from clients c
left join sites s on c.client_id = s.client_id
left join leads l on l.site_id = s.site_id
where l.registered_datetime between '2011-01-01' and '2011-12-31'
group by client_name
order by number_of_leads desc;

-- 7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes
-- y el número total de clientes potenciales que hemos generado para cada cliente 
-- cada mes entre los meses 1 y 6 del año 2011?
SELECT concat_ws(' ', c.first_name, c.last_name) AS client_name, count(l.leads_id) AS number_of_leads,
Date_format(l.registered_datetime,'%M') AS month_generated
FROM clients c
LEFT JOIN sites s ON c.client_id = s.client_id
LEFT JOIN leads l ON s.site_id = l.site_id
WHERE EXTRACT(MONTH FROM l.registered_datetime)>=1
AND EXTRACT(MONTH From l.registered_datetime)<=6
AND EXTRACT(YEAR FROM l.registered_datetime) = 2011
GROUP BY l.leads_id;


-- 8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes
-- y el número total de clientes potenciales que hemos generado para cada uno 
-- de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? 
-- Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre todos los 
-- clientes, los nombres del sitio y el número total de clientes potenciales 
-- generados en cada sitio en todo momento.
SELECT concat_ws(' ', c.first_name, c.last_name) AS client_Name, s.domain_name as website, count(l.leads_id) as numbers_of_leads,
date_format(MIN(l.registered_datetime) , "%M %e , %Y") as date_generated -- MIN(l.registered_datetime)
FROM clients c
JOIN sites s ON c.client_id = s.client_id
JOIN leads l ON s.site_id = l.site_id
WHERE l.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY client_Name,s.domain_name
order by client_Name desc;

SELECT concat_ws(' ', c.first_name, c.last_name) AS client_Name, s.domain_name as website, count(l.leads_id) as numbers_of_leads
-- date_format(MIN(l.registered_datetime) , "%M %e , %Y") as date_generated -- MIN(l.registered_datetime)
FROM clients c
LEFT JOIN sites s ON c.client_id = s.client_id
LEFT JOIN leads l ON s.site_id = l.site_id
-- WHERE l.registered_datetime BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY client_Name,s.domain_name
order by client_Name desc;

-- 9. Escriba una sola consulta que recupere los ingresos 
-- totales recaudados de cada cliente para cada mes del año. Pídalo por ID de cliente.

SELECT concat_ws(' ', c.first_name, c.last_name) as client_name, sum(b.amount) as Total_revenue,
date_format(b.charged_datetime, '%M') as month_charge, date_format(b.charged_datetime, '%Y') as year_charge
FROM clients C
JOIN BILLING B ON C.client_id = B.client_id
group by c.client_id, date_format(b.charged_datetime, '%M'), date_format(b.charged_datetime, '%Y');
-- order by  month_charge,year_charge asc;


-- 10. Escriba una sola consulta que recupere todos los sitios 
-- que posee cada cliente. Agrupe los resultados para que cada fila 
-- muestre un nuevo cliente. Se volverá más claro cuando agregue un 
-- nuevo campo llamado 'sitios' que tiene todos los sitios que posee 
-- el cliente. (SUGERENCIA: use GROUP_CONCAT)

select concat_ws(' ', c.first_name, c.last_name) as client_name, GROUP_CONCAT(DISTINCT s.domain_name 
order by s.domain_name asc separator '/') as sites
from sites s
right join clients c 
on s.client_id = c.client_id
group by client_name;
