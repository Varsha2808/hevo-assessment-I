-- To Check ROWS COUNT for each table
select count(*) from orders;
select count(*) from customers;
select count(*) from feedback;
select count(*) from order_events;

-- To Verify order status transformation

select status, event_type from order_events limit 5;

-- To Check Username

select email, username from customers limit 5;