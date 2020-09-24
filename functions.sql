create or replace function get_cost(cpu int, ram int, disk int, bandwidth real, start_date timestamp, end_date timestamp) returns real language plpgsql as $$ begin return(select((extract(epoch from(end_date - start_date))/3600)*(cpu * 1000 + ram * 500 + disk * 200 + bandwidth * 100))); end;$$;

