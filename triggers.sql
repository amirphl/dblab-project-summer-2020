create or replace function verify_order() returns trigger language plpgsql as $$ begin if is_order_valid(new.server_id, new.user_id, new.cpu_requested, new.ram_requested, new.disk_requested, new.bandwidth_requested, new.start_date, new.end_date) then return new; else return null; end if; end; $$;

