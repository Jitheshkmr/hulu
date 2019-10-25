Data analyst Test

Build a dummy database for Zomato with multiple tables and try to find an answer for the following question:

1.	Write a SQL query to find the number of Zomato users

SELECT
  COUNT(*)
FROM zomato.customer;

2.	Write a SQL query to find details of Zomato delivery Boy

SELECT
  *
FROM zomato.employee
WHERE position = 'delivery';

3.	Write a SQL query to find  the list of Zomato users who made more than 10 orders in a particular month

SELECT
  cust_name
FROM zomato.customer as o
INNER JOIN (SELECT DISTINCT
  cust_id
FROM zomato.orders
WHERE YEAR(order_time) = 2019
AND MONTH(order_time) = 10
GROUP BY cust_id
HAVING COUNT(cust_id) > 2) as i
on o.cust_id=i.cust_id;

4.	Write a SQL query to find top 10 Zomato delivery Boy on basis of customer rating and time to deliver the item

SELECT emp_name FROM employee as e 
inner join (SELECT distinct emp_id FROM zomato.orders order by  (cust_rating+time_rating) desc limit 2	) as f
on e.emp_id = f.emp_id;


5.	Write a SQL query to find the list of Zomato users who order food from the same restaurants more than 3 times in a week

SELECT cust_name 
FROM zomato.customer as o
inner join(select cust_id,rest_id,count(cust_id) FROM zomato.orders where datediff(curdate(),order_time)<8 group by rest_id,cust_id having count(cust_id)>3) as i
on o.cust_id=i.cust_id;

----------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE zomato;

CREATE TABLE customer(
cust_id INT PRIMARY KEY,
cust_name VARCHAR(50),
address VARCHAR(50),
city VARCHAR(50),
state VARCHAR(20),
phone VARCHAR(20),
email VARCHAR(50),
passwrd VARCHAR(50)
);

CREATE TABLE employee(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
address VARCHAR(50),
birth_day DATE,
sex VARCHAR(1),
phone VARCHAR(20),
super_id INT,
position VARCHAR(50),
hire_date DATE,
passwrd VARCHAR(50)
);

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE orders(
order_id INT PRIMARY KEY,
cust_id INT,
emp_id INT,
order_time DATETIME,
deliver_time DATETIME,
time_taken INT,
wait_time INT,
distance DECIMAL(2,1),
cust_rating INT,
price DECIMAL(5,2),
pay_method VARCHAR(20),
pay_status VARCHAR(20),
foreign key(cust_id) REFERENCES customer(cust_id) ON DELETE SET NULL,
foreign key(emp_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

CREATE TABLE food(
food_id INT PRIMARY KEY,
restaurant varchar(50),
food_name VARCHAR(50),
food_size INT,
food_price DECIMAL(5,2),
order_id INT,
foreign key(order_id) REFERENCES orders(order_id) ON DELETE SET NULL
);

CREATE table restaurant(
rest_id INT PRIMARY KEY,
rest_name VARCHAR(50),
cuisine VARCHAR(50),
rating INT
);

INSERT INTO customer values (101,'aai','kanakapura','bangalore','karnataka','+919999999991','aai@gmail.com',1263565);
INSERT INTO customer values (102,'bai','ranakapura','bangalore','karnataka','+919999999992','bai@gmail.com',1263566);
INSERT INTO customer values (103,'cai','manakapura','bangalore','karnataka','+919999999993','cai@gmail.com',1263567);
INSERT INTO customer values (104,'dai','sanakapura','bangalore','karnataka','+919999999994','dai@gmail.com',1263568);
INSERT INTO customer values (105,'eai','tanakapura','bangalore','karnataka','+919999999995','eai@gmail.com',1263569);
INSERT INTO customer values (106,'fai','ranakapura','bangalore','karnataka','+919999999996','fai@gmail.com',1263570);
INSERT INTO customer values (107,'gai','janakapura','bangalore','karnataka','+919999999997','gai@gmail.com',1263571);
INSERT INTO customer values (108,'hai','panakapura','bangalore','karnataka','+919999999998','hai@gmail.com',1263572);
INSERT INTO customer values (109,'iai','oanakapura','bangalore','karnataka','+919999999999','iai@gmail.com',1263573);
INSERT INTO customer values (110,'jai','ianakapura','bangalore','karnataka','+919999999990','jai@gmail.com',1263574);

-----------------------------------------------------------------------

INSERT INTO employee values (501,'aat','ranakapura','1978/08/13','M','+919999999991',NULL,'manager','2018/01/15',546456);

INSERT INTO employee values (502,'bat','janakapura','1978/08/15','M','+919999999992',501,'supervisor','2018/01/17',546457);
INSERT INTO employee values (503,'cat','panakapura','1978/08/16','M','+919999999993',501,'delivery','2018/01/18',546458);
INSERT INTO employee values (504,'dat','oanakapura','1978/08/17','M','+919999999994',501,'delivery','2018/01/19',546459);
INSERT INTO employee values (505,'eat','ianakapura','1978/08/18','M','+919999999995',501,'delivery','2018/01/20',546460);
INSERT INTO employee values (506,'fat','kanakapura','1978/08/19','F','+919999999996',501,'delivery','2018/01/21',546461);

INSERT INTO employee values (507,'gat','ranakapura','1978/08/21','F','+919999999997',502,'delivery','2018/01/23',546462);
INSERT INTO employee values (508,'hat','manakapura','1978/08/22','F','+919999999998',502,'delivery','2018/01/24',546463);
INSERT INTO employee values (509,'iat','sanakapura','1978/08/23','F','+919999999999',502,'delivery','2018/01/25',546464);
INSERT INTO employee values (510,'jat','tanakapura','1978/08/24','M','+919999999990',502,'delivery','2018/01/26',546465);

-------------------------------------------------------------

INSERT INTO orders values (7001,106,501,'701','2019/10/21 01:02:22','2019/10/21 01:12:22',10,5,3.2,5,50.5,'prepare','unpaid');
INSERT INTO orders values (7002,102,502,'701','2019/10/22 01:02:23','2019/10/22 01:07:23',5,3,2.5,1,75,'delivered','paid');
INSERT INTO orders values (7003,106,506,'701','2019/10/23 01:02:22','2019/10/23 01:08:22',6,5,3.4,2,100,'delivered','paid');
INSERT INTO orders values (7004,109,506,'704','2019/10/23 01:02:22','2019/10/23 01:10:22',8,4,3,4,65,'prepare','paid');
INSERT INTO orders values (7005,106,503,'704','2019/10/24 01:02:22','2019/10/24 01:14:22',12,3,3.1,2,90,'prepare','paid');
INSERT INTO orders values (7006,102,506,'703','2019/10/24 01:02:22','2019/10/24 01:11:22',9,5,1.2,4,30.5,'delivered','paid');
INSERT INTO orders values (7007,106,504,'702','2019/10/25 01:02:22','2019/10/25 01:07:22',5,3,1,5,120,'picked','unpaid');

-------------------------------------------------

INSERT INTO food values (90001,'abc','meat',1,50,7002);
INSERT INTO food values (90002,'abc','curd',1,100,7007);
INSERT INTO food values (90003,'xyz','fish',1,100,7003);
INSERT INTO food values (90004,'mno','raita',1,25,7002);
INSERT INTO food values (90005,'mno','fruits',1,50.5,7001);
INSERT INTO food values (90006,'mno','vegetables',1,30.5,7006);
INSERT INTO food values (90007,'rst','sweet',1,20,7007);

---------------------------------------------------

INSERT INTO restaurant values (701,'abc ','south-indian',5);
INSERT INTO restaurant values (702,'xyz','vegetarian',5);
INSERT INTO restaurant values (703,'mno','bakery',4);
INSERT INTO restaurant values (704,'rst','north-indian',3);
-----------------------------------------------------------------------------------------------------------------------

SELECT
  cust_name
FROM zomato.customer
WHERE cust_id IN (SELECT DISTINCT
  cust_id
FROM zomato.orders
WHERE YEAR(order_time) = 2019
AND MONTH(order_time) = 10
GROUP BY cust_id
HAVING COUNT(cust_id) > 2);




