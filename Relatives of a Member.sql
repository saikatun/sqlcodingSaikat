

	with cte as
	(
		select  child , parent from child_parent as a
		union all
		select  a.child , b.parent from cte as a inner join child_parent as b on a.parent = b.child
	),
	base_cte as
	(
		select parent as child , child as parent from child_parent as a
	),
	next_cte as
	(
		select child , parent from base_cte as a
		union all
		select b.child , a.parent from next_cte as a inner join base_cte as b on a.child = b.parent
		union all
		select b.child , a.child from next_cte as a inner join base_cte as b on a.parent = b.parent
	) , 
	final_cte as
	(
		select child as person  , parent as relatives from
		(
			select child , parent from cte 
			union all
			select child , parent from next_cte 
			where child<> parent
		) as a
		group by child , parent
	)
	select person , string_agg(cast(relatives as varchar(1)) , ',') as realtives from final_cte group by person;