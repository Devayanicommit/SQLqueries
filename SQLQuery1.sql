-- Create the table
CREATE TABLE stock (
    supplier_id INT,
    product_id INT,
    stock_quantity INT,
    record_date DATE
);

-- Insert the data
delete from stock;
INSERT INTO stock (supplier_id, product_id, stock_quantity, record_date)
VALUES
    (1, 1, 60, '2022-01-01'),
    (1, 1, 40, '2022-01-02'),
    (1, 1, 35, '2022-01-03'),
    (1, 1, 45, '2022-01-04'),
 (1, 1, 51, '2022-01-06'),
 (1, 1, 55, '2022-01-09'),
 (1, 1, 25, '2022-01-10'),
    (1, 1, 48, '2022-01-11'),
 (1, 1, 45, '2022-01-15'),
    (1, 1, 38, '2022-01-16'),
    (1, 2, 45, '2022-01-08'),
    (1, 2, 40, '2022-01-09'),
    (2, 1, 45, '2022-01-06'),
    (2, 1, 55, '2022-01-07'),
    (2, 2, 45, '2022-01-08'),
 (2, 2, 48, '2022-01-09'),
    (2, 2, 35, '2022-01-10'),
 (2, 2, 52, '2022-01-15'),
    (2, 2, 23, '2022-01-16');  
	select * from stock
--Write a sql query to find out supplier_id,product_id,no of days and starting date of record for which stock quantity is 
--less than 50 for two or more consecutive days

with cte as(select *, 
                row_number() over(partition by supplier_id, product_id order by iif( stock_quantity<50, 0,stock_quantity)) 
               - day(record_date) group_flag 
           from stock
           where stock_quantity<50)

select  supplier_id, product_id,min(record_date) first_date ,count(*) no_of_records from cte
group by supplier_id, product_id,group_flag
having count(*)>1;