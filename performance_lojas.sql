
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



===================================================================================================





===================================================================================================

with fat_store as (

Select 
S.store_id as cd_loja, 
sum(P.amount) as vl_total,
count(P.payment_id) as total_pagamento

from public.store S
left join public.inventory I on I.store_id = S.store_id
left join public.rental R on R.inventory_id = I.inventory_id
left join public.payment P on P.rental_id = R.rental_id

group by
	S.store_id
)

select
	cd_loja,
	vl_total,
	total_pagamento,
	round(vl_total / nullif(total_pagamento,0),2) as ticket_medio,
	round(vl_total*100 / sum(vl_total) over(),2) as "%",
	rank() over( order by vl_total DESC)
from 
	fat_store
where 
	vl_total > 0




