--1. Customers table

create table customers(
id int primary key,
first_name text,
last_name text,
email text,
address json);

--2. Orders table

create table orders(
id int primary key,
customer_id int references customers(id),
status text);

--3. Feedback table

create table feedback(
id int primary key,
order_id int unique references orders(id),
feedback_comment text,
rating int);
