create or replace function get_cost(cpu int, ram int, disk int, bandwidth real, start_date timestamp, end_date timestamp) returns real language plpgsql as $$ begin return(select((extract(epoch from(end_date - start_date))/3600)*(cpu * 1000 + ram * 500 + disk * 200 + bandwidth * 100))); end;$$;

create or replace function get_user_current_charge(userid int) returns real language plpgsql as $$ declare total_credit real; declare total_orders_cost real; begin select sum(credit) into total_credit from users as u inner join payments using(user_id) where u.user_id=userid; select sum(get_cost(o.cpu_requested,o.ram_requested,o.disk_requested,o.bandwidth_requested,o.start_date, o.end_date)) into total_orders_cost from orders as o inner join users as u using(user_id) where u.user_id=userid; return(total_credit - total_orders_cost); end; $$;

create extension if not exists "uuid-ossp";

create or replace function login(userid int) returns void language plpgsql as $$ begin insert into sessions values(userid, (jsonb_build_object('uuid', uuid_generate_v4()::text) || jsonb_build_object('login_time', current_timestamp) || jsonb_build_object('expiration_time', current_timestamp +  interval '5h'))::json); end; $$;

create or replace function get_orders_between(serverid int, startdate timestamp, enddate timestamp) returns table(order_id int, user_id int, server_id int, start_date timestamp, end_date timestamp, cpu_requested int, ram_requested int, disk_requested int, bandwidth_requested real) language plpgsql as $$ begin return query select * from orders as o where not(o.end_date < startdate or enddate < o.start_date) and o.server_id=serverid; end; $$;

create or replace function get_max_resource_usages_between(serverid int, startdate timestamp, enddate timestamp) returns table(cpu bigint, ram bigint, disk bigint, bandwidth real) language plpgsql as $$ begin return query select coalesce(max(t3.cpu),0) as cpu, coalesce(max(t3.ram),0) as ram, coalesce(max(t3.disk),0) as disk, coalesce(max(t3.bandwidth),0) as bandwidth from (select coalesce(sum(t2.cpu_requested),0) as cpu, coalesce(sum(t2.ram_requested),0) as ram, coalesce(sum(t2.disk_requested),0) as disk, coalesce(sum(t2.bandwidth_requested),0) as bandwidth from get_orders_between(serverid, startdate, enddate) as t1, get_orders_between(serverid, startdate, enddate) as t2 where not(t2.end_date < t1.start_date or t1.end_date < t2.start_date) group by t1.order_id) as t3; end; $$;

create or replace function is_resources_available_between(serverid int, requested_cpu int, requested_ram int, requested_disk int, requested_bandwidth real, startdate timestamp, enddate timestamp) returns boolean language plpgsql as $$ declare max_cpu_used int; declare max_ram_used int; declare max_disk_used int; declare max_bandwidth_used real; declare server_total_cpu int; declare server_total_ram int; declare server_total_disk int; declare server_total_bandwidth real; begin select t.cpu,t.ram,t.disk,t.bandwidth into max_cpu_used,max_ram_used,max_disk_used,max_bandwidth_used from (select * from get_max_resource_usages_between(serverid, startdate, enddate)) as t; select t2.cpu,t2.ram,t2.disk,t2.bandwidth into server_total_cpu,server_total_ram,server_total_disk,server_total_bandwidth from servers as t2 where t2.server_id=serverid;  if server_total_cpu > max_cpu_used + requested_cpu and server_total_ram > max_ram_used + requested_ram and server_total_disk > max_disk_used + requested_disk and server_total_bandwidth > max_bandwidth_used + requested_bandwidth then return true; else return false; end if; end; $$;

create or replace function get_server_available_resources(serverid int, requested_cpu int, requested_ram int, requested_disk int, requested_bandwidth real, startdate timestamp, enddate timestamp) returns table(cpu int, ram int, disk int, bandwidth real) language plpgsql as $$ declare max_cpu_used int; declare max_ram_used int; declare max_disk_used int; declare max_bandwidth_used real; begin select t.cpu,t.ram,t.disk,t.bandwidth into max_cpu_used,max_ram_used,max_disk_used,max_bandwidth_used from (select * from get_max_resource_usages_between(serverid, startdate, enddate)) as t; return query select t2.cpu - max_cpu_used - requested_cpu, t2.ram - max_ram_used - requested_ram, t2.disk - max_disk_used - requested_disk, t2.bandwidth - max_bandwidth_used - requested_bandwidth from servers as t2 where t2.server_id=serverid; end; $$;

create or replace function is_order_valid(serverid int, userid int, requested_cpu int, requested_ram int, requested_disk int, requested_bandwidth real, startdate timestamp, enddate timestamp) returns boolean language plpgsql as $$ declare user_credit real; declare is_resource_available boolean; declare server_cost real; declare is_crashed boolean; begin select get_user_current_charge(userid) into user_credit; select is_resources_available_between(serverid, requested_cpu, requested_ram, requested_disk, requested_bandwidth, startdate, enddate) into is_resource_available; select get_cost(requested_cpu, requested_ram, requested_disk, requested_bandwidth, startdate, enddate) into server_cost; select crashed into is_crashed from servers as s where s.server_id=serverid; if user_credit > server_cost and is_resource_available and not is_crashed then return true; else return false; end if; end; $$;

create or replace function verify_order() returns trigger language plpgsql as $$ begin if is_order_valid(new.server_id, new.user_id, new.cpu_requested, new.ram_requested, new.disk_requested, new.bandwidth_requested, new.start_date, new.end_date) then return new; else return null; end if; end; $$;
