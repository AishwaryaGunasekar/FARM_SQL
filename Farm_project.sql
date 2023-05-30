
INSERT INTO farmers (farmer_id, farmer_name, farmer_address, farmer_phone)
VALUES (1, 'krishnana','123 first street',7878787);
INSERT INTO farmers (farmer_id, farmer_name, farmer_address, farmer_phone)
VALUES (2, 'Ruku','111 first street',9878787);
INSERT INTO farmers (farmer_id, farmer_name, farmer_address, farmer_phone)
VALUES (3, 'Gopal','222 first street',7878887);
INSERT INTO crops (crop_id, crop_name, crop_type,crop_yield) VALUES (1, 'Wheat', 'Grain',50);
INSERT INTO livestock (livestock_id, livestock_typel, livestock_breed,livestock_quantity) VALUES (1, 'Cattle', 'Angus', 50);
INSERT INTO fields (field_id, field_name, field_area) VALUES (1, 'Field A', 105);
INSERT INTO field_Crops (field_id, crop_id, planting_date, harvest_date) VALUES (1, 1, '2022-04-01', '2022-08-31');
INSERT INTO field_Livestock (fk_field_id,fk_livestock_id, start_date, end_date) VALUES (1, 1, '2022-05-01', '2022-11-30');
INSERT INTO harvests (harvest_id,field_id, crop_id,  harvest_date,harvested_quantity) VALUES (11,1, 1, '2022-09-15',1000);
INSERT INTO sales (sale_id,crop_id,sale_date, sale_quantity, sale_price ) VALUES (78,1, '2022-09-20',55,155);
INSERT INTO expenses (expense_id,field_id, expense_date, expense_type, expense_amount) VALUES (5,1, '2022-09-25', '2019-12-12', 200);
INSERT INTO weather (weather_id,field_id, weather_date, temperature, rainfall) VALUES (5,1, '2022-09-15', 25.5,'heavy');

select * from fields;
UPDATE farmers SET farmer_address = '456 second St' WHERE farmer_id = 1;
select * from farmers;
UPDATE crops SET crop_name = 'Corn' WHERE crop_id = 1;
UPDATE livestock SET livestock_quantity = 60 WHERE livestock_id = 1;
UPDATE fields SET field_area = 'Field B' WHERE field_id = 1;
UPDATE field_Crops SET harvest_date = '2022-09-30' WHERE field_id = 1 AND crop_id = 1;
UPDATE field_Livestock SET end_date = '2022-12-31' WHERE fk_field_id = 1 AND fk_livestock_id = 1;
UPDATE harvests SET harvested_quantity = 1200 WHERE field_id = 1 AND crop_id = 1;
UPDATE sales SET sale_quantity = 600, sale_price = 12.99 WHERE crop_id = 1;
UPDATE expenses SET expense_amount = 2500 WHERE field_id = 1 AND expense_type = '2019-12-12';
UPDATE weather SET temperature = 28, rainfall = 'low' WHERE field_id = 1 AND weather_date = '2022-08-15';

select * from expenses;

ALTER TABLE farmers ADD COLUMN farmer_email VARCHAR(255);
ALTER TABLE crops MODIFY COLUMN crop_type ENUM('Grain', 'Fruit', 'Vegetable');
ALTER TABLE Harvests DROP COLUMN harvest_date;
ALTER TABLE Sales MODIFY COLUMN sale_date DATE NOT NULL;



SELECT *FROM farmers JOIN crops ON farmers.farmer_id = crops.crop_id;

SELECT *FROM fields RIGHT JOIN field_crops  ON fields.field_id = field_crops.field_id
RIGHT JOIN crops  ON field_crops.crop_id = crops.crop_id;

SELECT * FROM fields INNER JOIN field_livestock  ON fields.field_id = field_livestock.fk_field_id
INNER JOIN livestock  ON field_livestock.fk_livestock_id = livestock.livestock_id;

SELECT field_crops.crop_id, COUNT(*) AS total_harvests
FROM field_crops 
JOIN harvests  ON field_crops.field_id = harvests.field_id AND field_crops.crop_id = harvests.crop_id
GROUP BY field_crops.crop_id;

SELECT harvests.field_id, SUM(harvests.harvested_quantity) AS total_harvested_quantity
FROM harvests 
GROUP BY harvests.field_id;

SELECT field_crops.crop_id, AVG(harvests.harvested_quantity) AS average_harvested_quantity
FROM field_crops 
JOIN harvests  ON field_crops.field_id = harvests.field_id AND field_crops.crop_id = harvests.crop_id
GROUP BY field_crops.crop_id;


SELECT field_crops.crop_id, SUM(sales.sale_quantity * sales.sale_price) AS total_revenue
FROM field_crops 
JOIN sales  ON field_crops.crop_id = sales.crop_id
GROUP BY field_crops.crop_id;

SELECT crop_id, SUM(harvested_quantity) AS total_harvested
FROM harvests
GROUP BY crop_id
HAVING SUM(harvested_quantity) > 1100;

SELECT field_id, COUNT(DISTINCT crop_id) AS unique_crops
FROM field_crops
GROUP BY field_id
HAVING COUNT(DISTINCT crop_id) > 0;

SELECT livestock_typel, SUM(livestock_quantity) AS total_quantity
FROM livestock
GROUP BY livestock_typel
HAVING SUM(livestock_quantity) > 50;


DELETE FROM farmers WHERE farmer_id = 1;

SELECT farmers.farmer_name, crops.crop_name, harvests.harvested_quantity
FROM farmers 
JOIN fields  ON farmers.farmer_id = fields.field_id
JOIN field_crops  ON fields.field_id = field_crops.field_id
JOIN crops  ON field_crops.crop_id = crops.crop_id
JOIN harvests  ON field_crops.field_id = harvests.field_id AND field_crops.crop_id = harvests.crop_id;

