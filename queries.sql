create or replace function notif_crash() returns table(username varchar(255), user_id int, phone_number varchar(255), email varchar(255)) language plpgsql as $$
begin 
return query   
select u.user_name,u.user_id,u.phone_number,u.email
from users u
inner join orders o
    on o.user_id = u.user_id
inner join servers s 
    on o.server_id = s.server_id
group by u.user_id, s.server_id
having s.crashed = true;
end; $$;

create or replace function total_orders_from_time(from_time timestamp) returns real language plpgsql as $$
declare s real;
begin
select coalesce(sum(public.get_cost(cpu_requested, ram_requested, disk_requested, bandwidth_requested, start_date, end_date)),0) into s
from orders
where from_time < start_date;
return s;
end; $$;

create or replace function sold_category_crashed() returns table(category varchar(255), crashed Boolean, total real) language plpgsql as $$
begin
return query
select servers.category, servers.crashed, coalesce(sum(public.get_cost(orders.cpu_requested, orders.ram_requested, orders.disk_requested, orders.bandwidth_requested, orders.start_date, orders.end_date)),0)
from servers
INNER JOIN orders
ON servers.server_id = orders.server_id
GROUP BY cube(servers.category, servers.crashed)
having servers.crashed is not null and servers.category is not null;
end; $$;

create or replace function logged_in_users_charge_less_than(charge real) returns table(userid int, info json) language plpgsql as $$
begin
return query
select *
FROM sessions
where ((sessions.info ->> 'expiration_time')::timestamp > current_timestamp) and (charge > public.get_user_current_charge(user_id));
end; $$;

create extension if not exists tablefunc;
select * from crosstab(
  'select extract(year from start_date), extract(month from start_date), public.get_cost(cpu_requested, ram_requested, disk_requested, bandwidth_requested, start_date, end_date) from orders order by 1', 
  'select m from generate_series(1,12) m'
) as (
year int,
"1" real,
"2" real,
"3" real,
"4" real,
"5" real,
"6" real,
"7" real,
"8" real,
"9" real,
"10" real,
"11" real,
"12" real
);

select category, extract(year from start_date) as year, extract(month from start_date) as month, sum(s.cpu - o.cpu_requested) as cpu_remained, sum(s.ram - o.ram_requested) as ram_remained, sum(s.disk - o.disk_requested) as disk_remained, sum(s.bandwidth - o.bandwidth_requested) as bandwidth_remained from orders as o inner join servers as s using(server_id) group by category, year, month order by year, month, category;

