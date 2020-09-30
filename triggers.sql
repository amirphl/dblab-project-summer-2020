create trigger add_order before insert on orders for each row execute procedure verify_order();

create trigger validate_session before insert on orders for each row execute procedure check_user_logged_in();

create trigger validate_anonymous_access before insert on sessions for each row execute procedure check_user_logged_out();

