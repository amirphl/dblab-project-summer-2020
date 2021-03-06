create 
or replace procedure delete_user(requested_id int) language plpgsql as $$ begin
DELETE FROM public.payments
WHERE payments.user_id = requested_id;
DELETE FROM public.orders
WHERE orders.user_id = requested_id;
DELETE FROM public.sessions
WHERE user_id = requested_id;
DELETE FROM public.users
WHERE users.user_id = requested_id;
commit;
end;
$$

create
or replace procedure add_payment(id_req int, charge int) language plpgsql as $$ 
DECLARE
namev TIMESTAMP;
begin
SELECT info -> 'expiration_time' AS ex
into namev
FROM sessions
where id_req = user_id
ORDER BY info ->> 'expiration_time' DESC limit 1;
if namev > CURRENT_TIMESTAMP then
     raise notice' expiration time is % so the payment is added successfully', 
	    namev;
INSERT INTO payments (user_id,pay_date,credit) VALUES (id_req, CURRENT_TIMESTAMP,charge);
else
  raise notice' expiration time is % so the payment failed',
       namev;
  end if;
commit;
end;
$$

