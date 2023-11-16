	
	
	drop table rm_example;
	create table rm_example (id int , orders int);

	insert into rm_example values (1,20)  , (1,20) , (1,20) , (1,30) , (1,30) , (1,30), (1,40) , (2,24) , (2,26) , (2,25) , (2,25);
	select * , rank() over(partition by id order by orders) from rm_example ;

	--dense_rank 

	select * from rm_example;

		with cte as
		(
			select a.id , a.orders as ordera , count( distinct b.orders) as seq
			from rm_example as a inner join rm_example as b on a.id = b.id and a.orders >= b.orders
			group by a.id , a.orders
		)
		select a.* from cte as a inner join rm_example as b on a.id = b.id and a.ordera = b.orders;

	-- rank()

		with cte as
		(
			select a.* , count(b.orders)+1 as seq  from
			(
				select distinct id , orders from rm_example
			) as a left join rm_example as b on a.orders > b.orders and a.id = b.id
			group by a.id , a.orders
		)
		select a.* from cte as a inner join rm_example as b on a.id = b.id and a.orders = b.orders;