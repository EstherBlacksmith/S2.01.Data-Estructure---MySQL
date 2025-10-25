-- List the total factures of a client in a determinated period of time
SELECT COUNT(sales.id) FROM sales 
		INNER JOIN customer ON sales.customer_id = customer.person_id
		INNER JOIN person ON customer.person_id = person.id
WHERE person.telephone_number ='611223344' ;

-- List the differents glasses models solded by a determinated employee in one year
select glasses.id , glasses.frame_material, glasses.frame_color from sales inner join glasses on sales.glasses_id = glasses.id
inner join person on sales.employee_id = person.id
where person.employee = 1 
and person.name ='Carlos'
group by glasses.id;  

-- List the different suppliers who have supplied successfully sold glasses
select person.name, person.surname, person.telephone_number , brand_name , count(sales.id) from sales inner join glasses on sales.glasses_id = glasses.id
inner join brand on brand.id = glasses.brand_id
inner join supplier on brand.supplier_id = supplier.id
inner join person on person.id = supplier.person_id
group by person.name, person.surname, person.telephone_number ,brand_name;