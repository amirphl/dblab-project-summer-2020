create user ali login superuser password 'passwordstring';

create role simple_user login;

create role operator login;

grant all on servers to operator;

grant select on servers to simple_user;

grant insert on sessions to simple_user;

grant all on users to operator;

grant insert, select on orders to simple_user;

grant all on orders to operator;

grant insert, select on payments to simple_user;

grant select on payments to operator;

