-- Order_events transformation on table orders (Used to create another Table named order_events)

SELECT 
    id AS order_id,
    customer_id,
    status,
    CASE 
        WHEN status = 'placed' THEN 'order_placed'
        WHEN status = 'shipped' THEN 'order_shipped'
        WHEN status = 'delivered' THEN 'order_delivered'
        WHEN status = 'cancelled' THEN 'order_cancelled'
        ELSE 'unknown_event'
    END AS event_type
FROM orders;

-- Customers username transformation (Added username field to existing Customers table)
  -- extracting username from the email 
SELECT id,first_name,last_name,email,address,
COALESCE(SPLIT_PART(email, '@', 1), 'unknown_username') AS username
FROM customers
WHERE email IS NOT NULL AND email LIKE '%@%';
