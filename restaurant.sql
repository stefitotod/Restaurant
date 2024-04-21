DROP DATABASE IF EXISTS restaurant;
CREATE DATABASE restaurant;
USE restaurant;

CREATE TABLE employees(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    hour_salary DOUBLE NOT NULL,
    address VARCHAR(200) NOT NULL,
    experience INT NOT NULL,
    phone VARCHAR(13) UNIQUE NOT NULL,
    egn VARCHAR(10) NOT NULL UNIQUE,
    CONSTRAINT egn_length CHECK (CHAR_LENGTH(egn) = 10)        
);

CREATE TABLE manager(
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE waiters(
    id INT AUTO_INCREMENT PRIMARY KEY,
	month_tip DOUBLE NOT NULL,
    employee_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE chefs(
    id INT AUTO_INCREMENT PRIMARY KEY,
	chef_type ENUM ('Head_Chef', 'Sous_Chef', 'Assistant') NOT NULL,
    employee_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE bartenders(
    id INT AUTO_INCREMENT PRIMARY KEY,
	special_cocktail ENUM ('Espresso Martini', 'French 75', 'Pisco Sour', 'Negroni', 'Moscow Mule', 'Paloma', 'DarknStormy', 'Bramble') NOT NULL,
    employee_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE cleaners(
    id INT AUTO_INCREMENT PRIMARY KEY,
    section ENUM ('Toilet', 'Kitchen', 'Dining Area', 'Bar'),
    employee_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE salary(
    id INT AUTO_INCREMENT PRIMARY KEY,
    amount DOUBLE NOT NULL,
    dateOfPayment DATE NOT NULL,
    month VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    employee_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE menu(
    id INT AUTO_INCREMENT PRIMARY KEY,
    special_of_the_day VARCHAR(255) UNIQUE NOT NULL,
    day_of_week ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL
);

CREATE TABLE drinks(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    drink_type ENUM ('Non-Alcoholic', 'Alcoholic') NOT NULL,
    price DOUBLE NOT NULL
);

CREATE TABLE dishes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    category ENUM ('Starters', 'Main courses', 'Desserts') NOT NULL,
    preparation_time TIME NOT NULL,
    price DOUBLE NOT NULL,
    ingredients VARCHAR(255) NOT NULL,
    weight INT NOT NULL,
    allergens VARCHAR(255) NOT NULL
);

CREATE TABLE client_tables(
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_status ENUM ('Free', 'Reserved', 'Taken') NOT NULL,
    capacity INT NOT NULL
);

CREATE TABLE reservations(
    id INT AUTO_INCREMENT PRIMARY KEY,
    reservation_date DATE NOT NULL,
    client_tables_id INT UNIQUE NOT NULL,
    CONSTRAINT FOREIGN KEY (client_tables_id) REFERENCES client_tables(id)
);

CREATE TABLE clients(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
	phone VARCHAR(13) NOT NULL,
    email VARCHAR(200) NOT NULL,
    loyal_bonus_points INT NOT NULL
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_status ENUM ('Inprocess', 'Served'),
    client_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (client_id) REFERENCES clients(id)
);

CREATE TABLE menu_drinks(
    menu_id INT NOT NULL,
    drink_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (menu_id) REFERENCES menu(id),
    CONSTRAINT FOREIGN KEY (drink_id) REFERENCES drinks(id),
    PRIMARY KEY(menu_id, drink_id)
);

CREATE TABLE menu_dishes(
    menu_id INT NOT NULL,
    dish_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (menu_id) REFERENCES menu(id),
    CONSTRAINT FOREIGN KEY (dish_id) REFERENCES dishes(id),
    PRIMARY KEY(menu_id, dish_id)
);

CREATE TABLE employee_work(
    id INT AUTO_INCREMENT PRIMARY KEY,
    numberOfHours INT NOT NULL DEFAULT 1,
    date DATETIME NOT NULL,
    isPayed BOOLEAN NOT NULL DEFAULT 0,
    employee_id INT NOT NULL,
    CONSTRAINT FOREIGN KEY (employee_id) REFERENCES employees(id)
);

INSERT INTO employees (name, hour_salary, address, experience, phone, egn) VALUES
    ('John Doe', 20, '123 Main St, Anytown', 7, '1234567890', '1234567890'), 
    ('Jane Smith', 10, '456 Elm St, Othertown', 5, '0987654321', '0987654321'),
    ('Alice Johnson', 10, '789 Oak St, Anothertown', 4, '9876543210', '9876543210'),
    ('Bob Williams', 20, '101 Pine St, Newville', 4, '1112223333', '1112223333'),
    ('Emma Brown', 10, '222 Cedar St, Smalltown', 4, '4445556666', '4445556666'),
    ('Michael Davis', 20, '333 Maple St, Bigtown', 3, '7778889999', '7778889999'),
    ('Sarah Wilson', 10, '444 Birch St, Largetown', 8, '8889990000', '8889990000'),  
    ('David Miller', 15, '555 Oak St, Hilltown', 1, '5554443333', '5554443333'),   
    ('Jennifer Lee', 18, '666 Elm St, Rivertown', 9, '2223334444', '2223334444'),   -- manager
    ('Ryan Garcia', 19, '777 Pine St, Foresttown', 10, '9998887777', '9998887777'),
    ('Emily Martinez', 20, '888 Maple St, Beachtown', 8, '3332221111', '3332221111'),
    ('Jacob Hernandez', 10, '999 Cedar St, Mountainville', 11, '6667778888', '6667778888'),
    ('Olivia Lopez', 11, '121 Birch St, Downton', 2, '1212121212', '1212121212'),
    ('William King', 20, '232 Elm St, Uptown', 9, '2323232323', '2323232323'),
    ('Sophia Adams', 20, '343 Pine St, Lowertown', 4, '3434343434', '3434343434'),
    ('James Scott', 10, '454 Oak St, Midtown', 8, '4545454545', '4545454545'),    
    ('Ava Campbell', 10, '565 Maple St, Easttown', 1, '5656565656', '5656565656'); 
    
INSERT INTO salary (amount, dateOfPayment, month, year, employee_id) VALUES
    (1500.00, '2024-04-30', 'April', 2024, 1),
    (1600.00, '2024-05-31', 'May', 2024, 1),
    (1700.00, '2024-06-30', 'June', 2023, 1),
    (1800.00, '2024-07-31', 'July', 2024, 4),
    (1900.00, '2024-08-31', 'August', 2024, 5),
    (2000.00, '2024-09-30', 'September', 2024, 6),
    (1600.00, '2024-05-31', 'May', 2024, 2),
    (1700.00, '2024-06-30', 'June', 2023, 3);

INSERT INTO manager (employee_id) VALUES (9);
    
INSERT INTO waiters (month_tip, employee_id) VALUES
    (100, 17),
	(500, 16),
    (300, 8),
    (150, 7);
    
INSERT INTO chefs (chef_type, employee_id) VALUES
    ('Head_Chef', 1),
	('Sous_Chef', 2),
    ('Assistant', 3),
    ('Assistant', 4);
    
INSERT INTO cleaners (section, employee_id) VALUES
    ('Bar', 5),
    ('Dining Area', 6),
    ('Toilet', 10),
    ('Kitchen', 11);
    
INSERT INTO bartenders (special_cocktail, employee_id) VALUES
    ('Espresso Martini', 12),
    ('DarknStormy', 13),
    ('Paloma', 14),
    ('Moscow Mule', 15);
    
INSERT INTO menu (special_of_the_day, day_of_week) VALUES 
    ('Meatless Special', 'Monday'),
    ('Taco', 'Tuesday'),
    ('Pasta Night', 'Wednesday'),
    ('Seafood Night', 'Thursday'),
    ('Fish Fry', 'Friday'),
    ('Steakhouse', 'Saturday'),
    ('Brunch Special', 'Sunday'),
    ('Vegan Delight', 'Monday'),
    ('Italian Feast', 'Wednesday'),
    ('Fresh Catch', 'Thursday'),
    ('BBQ Extravaganza', 'Friday'),
    ('Prime Rib Special', 'Saturday'),
    ('Sunday Roast', 'Sunday');
    
INSERT INTO drinks (name, drink_type, price) VALUES 
    ('Whiskey', 'Alcoholic', 7),   
    ('Vodka', 'Alcoholic', 6.50),     
    ('Rum', 'Alcoholic', 5.50),        
    ('Gin', 'Alcoholic', 6.60),       
    ('Tequila', 'Alcoholic', 5),   
    ('Brandy', 'Alcoholic', 8),    
    ('Cognac', 'Alcoholic', 9),    
    ('Water', 'Non-Alcoholic', 2),   
    ('Soda', 'Non-Alcoholic', 2.20),    
    ('Juice', 'Non-Alcoholic', 4);
     
INSERT INTO clients (name, phone, email, loyal_bonus_points) VALUES
    ('John Doe', '+1234567890', 'john@example.com', 100),  
    ('Jane Smith', '+1987654321', 'jane@example.com', 50),  
    ('Alice Johnson', '+1122334455', 'alice@example.com', 75),  
    ('Bob Brown', '+1555666777', 'bob@example.com', 25);  

INSERT INTO dishes (name, category, preparation_time, price, ingredients, weight, allergens) VALUES 
('Spaghetti Carbonara', 'Main courses', '00:30:00', 12.99, 'Pasta, eggs, bacon, Parmesan cheese, black pepper', 300 , 'Eggs, dairy'),
('Grilled Salmon', 'Main courses', '00:20:00', 18.50, 'Salmon fillet, lemon, olive oil, salt, pepper', 200, 'Fish'),
('Caesar Salad', 'Starters', '00:15:00', 9.99, 'Romaine lettuce, Caesar dressing, croutons, Parmesan cheese', 250, 'Dairy, gluten'),
('Margherita Pizza', 'Main courses', '00:25:00', 10.99, 'Pizza dough, tomato sauce, mozzarella cheese, basil', 400, 'Dairy, gluten'),
('Chicken Tikka Masala', 'Main courses', '00:45:00', 14.99, 'Chicken, yogurt, tomato, onion, spices', 350, 'Dairy'),
('Beef Burger', 'Main courses', '00:20:00', 13.99, 'Beef patty, buns, lettuce, tomato, cheese, ketchup', 250, 'Dairy, gluten'),
('Vegetable Stir Fry', 'Main courses', '00:25:00', 11.50, 'Mixed vegetables, soy sauce, garlic, ginger', 300, 'Soy'),
('Tiramisu', 'Desserts', '00:40:00', 7.99, 'Ladyfingers, coffee, mascarpone cheese, cocoa powder', 200, 'Dairy, gluten'),
('Sushi Platter', 'Main courses', '00:35:00', 22.99, 'Assorted sushi rolls (salmon, tuna, avocado, cucumber)', 500, 'Fish, soy'),
('Falafel Wrap', 'Main courses', '00:15:00', 8.99, 'Falafel balls, pita bread, lettuce, tomato, tahini sauce', 300, 'Gluten');

INSERT INTO client_tables (reservation_status, capacity) VALUES 
    ('Free', 4),
    ('Free', 6),
    ('Free', 2),
    ('Reserved', 8),
    ('Taken', 10);
    
INSERT INTO reservations (reservation_date, client_tables_id) VALUES 
    ('2024-04-07', 4),
    ('2024-04-08', 2),
    ('2024-04-10', 1);

INSERT INTO orders (order_status, client_id) VALUES 
    ('Inprocess', 1),
    ('Inprocess', 2),
    ('Served', 3),
    ('Served', 4);

INSERT INTO menu_drinks (menu_id, drink_id) VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7);

INSERT INTO menu_dishes (menu_id, dish_id) VALUES 
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10);
    
INSERT INTO employee_work (employee_id, date, numberOfHours, isPayed) VALUES
    (1, '2024-02-01', 8, 0), 
    (2, '2024-02-01', 6, 0), 
    (1, '2024-02-02', 7, 0), 
    (3, '2024-02-02', 5, 0); 
    
-- task 2
SELECT name AS Main_Course, price AS Price
FROM dishes
WHERE category = 'Main courses' AND weight > 230;

-- task 3
SELECT employee_id AS ID, MAX(amount) AS MONTH_SALARY
FROM salary
WHERE employee_id = 1;

-- task 4 
SELECT client_tables.id AS ID, client_tables.capacity AS CAPACITY, reservations.reservation_date AS DATE
FROM client_tables 
JOIN reservations ON client_tables.id = reservations.client_tables_id;

-- task 5
SELECT employees.id AS ID, employees.name AS NAME, salary.amount AS AMOUNT
FROM employees 
LEFT OUTER JOIN salary ON employees.id = salary.employee_id;

-- task 6
SELECT menu.id AS ID, menu.special_of_the_day AS SPECIAL, dishes.name AS DISH
FROM menu 
JOIN menu_dishes ON menu.id = menu_dishes.menu_id 
JOIN dishes ON menu_dishes.dish_id = dishes.id
WHERE dishes.category = 'Main courses';

-- task 7 
SELECT employees.id AS ID, employees.name AS NAME, employees.experience AS EXPERIENCE, SUM(salary.amount) AS AMOUNT
FROM employees
JOIN salary ON employees.id = salary.employee_id 
WHERE EXPERIENCE > 3
GROUP BY employee_id 
ORDER BY NAME 
LIMIT 5;

-- task 8 
CREATE TABLE salary_update_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    operation ENUM('UPDATE', 'INSERT', 'DELETE') NOT NULL,
    old_employee_id INT,
    new_employee_id INT,
    old_month VARCHAR(50),
    new_month VARCHAR(50),
    old_amount DOUBLE,
    new_amount DOUBLE,
    old_dateOfPayment DATE,
    new_dateOfPayment DATE,
    dateOfLog DATETIME 
);

DELIMITER |
CREATE TRIGGER salary_update AFTER UPDATE ON salary
FOR EACH ROW 
BEGIN 
    INSERT INTO salary_update_log (
        operation,
        old_employee_id,
        new_employee_id,
        old_month,
        new_month,
        old_amount,
        new_amount,
        old_dateOfPayment,
        new_dateOfPayment,
        dateOfLog
    )
    VALUES (
        'UPDATE', 
        OLD.employee_id, 
        CASE NEW.employee_id WHEN OLD.employee_id THEN NULL ELSE NEW.employee_id END, 
        OLD.month, 
        CASE NEW.month WHEN OLD.month THEN NULL ELSE NEW.month END,
        OLD.amount, 
        CASE NEW.amount WHEN OLD.amount THEN NULL ELSE NEW.amount END,
        OLD.dateOfPayment, 
        CASE NEW.dateOfPayment WHEN OLD.dateOfPayment THEN NULL ELSE NEW.dateOfPayment END,
        NOW()
    );
END;
|
DELIMITER ;

UPDATE salary
SET employee_id = 1, month = 'April', amount = 2000.00
WHERE id = 1;

SELECT * FROM salary_update_log;

-- task 9
DELIMITER |
CREATE PROCEDURE updateSalaryFromEmployeeWork()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE tempEmployeeId INT;
    DECLARE tempHoursWorked INT;
    DECLARE tempSalary DOUBLE;

    DECLARE curEmployeeWork CURSOR FOR 
        SELECT employee_id, SUM(numberOfHours)
        FROM employee_work
        WHERE isPayed = 0
        GROUP BY employee_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN curEmployeeWork;

    read_loop: LOOP
        FETCH curEmployeeWork INTO tempEmployeeId, tempHoursWorked;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET tempSalary = tempHoursWorked * (SELECT hour_salary FROM employees WHERE id = tempEmployeeId);
        UPDATE salary 
        SET amount = amount + tempSalary
        WHERE employee_id = tempEmployeeId;

        UPDATE employee_work
        SET isPayed = 1
        WHERE employee_id = tempEmployeeId;
    END LOOP;
    CLOSE curEmployeeWork;
END
|
DELIMITER ;

CALL updateSalaryFromEmployeeWork();
    

 
