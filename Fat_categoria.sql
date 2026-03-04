
with valor_total as (
	select
		C."name" as "categoria",
		sum(P.amount) as "value_total"
	
	FROM public.payment P
	inner join public.rental R on R.rental_id = P.rental_id
	inner join public.inventory I on R.inventory_id = I.inventory_id
	inner join Public.film F on F.film_id = I.film_id
	inner join public.film_category FC on FC.film_id = F.film_id
	inner join public.category C on C.category_id = FC.category_id
    
	C."name"

)

SELECT 
	vl.categoria,
	sum(vl.value_total) as "total",
	round(
		vl.value_total *100
		/ sum(vl.value_total) over(),2
	) as "%"

FROM valor_total vl

group by
	vl.categoria,
	vl.value_total

order by 
	vl.value_total DESC