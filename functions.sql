create or replace function get_cost(cpu int, ram int, disk int, bandwidth real, start_date timestamp, end_date timestamp) returns real language plpgsql as $$ begin return(select((extract(epoch from(end_date - start_date))/3600)*(cpu * 1000 + ram * 500 + disk * 200 + bandwidth * 100))); end;$$;

create or replace function get_user_current_charge(userid int) returns real language plpgsql as $$ declare total_credit real; declare total_orders_cost real; begin select sum(credit) into total_credit from users as u inner join payments using(user_id) where u.user_id=userid; select sum(get_cost(o.cpu_requested,o.ram_requested,o.disk_requested,o.bandwidth_requested,o.start_date, o.end_date)) into total_orders_cost from orders as o inner join users as u using(user_id) where u.user_id=userid; return(total_credit - total_orders_cost); end; $$;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

create or replace function login(userid int) returns void language plpgsql as $$ begin insert into sessions values(userid, (jsonb_build_object('uuid', uuid_generate_v4()::text) || jsonb_build_object('login_time', current_timestamp))::json); end; $$;

