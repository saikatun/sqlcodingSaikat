	create table participants (eventId int , person varchar(30) , guests int);
	insert into participants values (22,'John',10);
	insert into participants values (22,'Pete',5);
	insert into participants values (30,'Ian',3);

	create table wp_posts (Id int , post_title varchar(30) , post_type varchar(30));

	insert into wp_posts values(22,'Christmas','events');
	insert into wp_posts values(30,'New Year','events');
	insert into wp_posts values(34,'Birthday','events');
	insert into wp_posts values(38,'Easter','events');
	insert into wp_posts values(39,'Ruhetag','events');
	insert into wp_posts values(40,'St Patrick','events');

	select * from participants;
	select * from wp_posts;

	select 
		b.Id , 
		coalesce(a.total_guests , 0) as total_guests 
	from
	(
		select 
			eventId , 
			sum(guests) as total_guests 
		from participants 
		group by eventId
		) as a 
		right join wp_posts as b 
		on a.eventId = b.Id and b.post_type = 'events'
	order by coalesce(a.total_guests , 0) desc;