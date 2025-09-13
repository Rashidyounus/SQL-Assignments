CREATE TABLE runner (
    id INT PRIMARY KEY,                     
    name VARCHAR(100) NOT NULL,            
    main_distance INT NOT NULL,             
    age INT NOT NULL,                       
    is_female BIT  NOT NULL              
);


INSERT INTO runner (id, name, main_distance, age, is_female) VALUES
(1, 'Ali Khan', 5000, 28, 0),  -- Male
(2, 'Jack Malik', 10000, 25, 1), -- Female
(3, 'John Smith', 21097, 34, 0),
(4, 'Alison Mike', 42195, 30, 1);

-- Insert sample data into runner table
INSERT INTO runner (id, name, main_distance, age, is_female) VALUES
(1, 'Ali Khan', 5000, 25, 0),
(2, 'Sara Ahmed', 5000, 22, 1),
(3, 'Usman Tariq', 5000, 28, 0),
(4, 'Fatima Noor', 5000, 30, 1),
(5, 'Bilal Hassan', 10000, 35, 0),
(6, 'Ayesha Malik', 10000, 26, 1),
(7, 'Hamza Yousuf', 10000, 29, 0),
(8, 'Nida Farooq', 10000, 27, 1),
(9, 'Imran Ali', 42195, 40, 0),
(10, 'Zara Khan', 1500, 19, 1);



CREATE TABLE event (
    id INT PRIMARY KEY,                     
    name VARCHAR(100) NOT NULL,             
    start_date DATE NOT NULL,               
    city VARCHAR(100) NOT NULL              
);


INSERT INTO event (id, name, start_date, city) VALUES
(1, 'London Marathon', '2025-04-21', 'London'),
(2, 'Warsaw Runs', '2025-05-12', 'Warsaw'),
(3, 'New Year Run', '2025-01-01', 'Karachi');


CREATE TABLE runner_event (
    runner_id INT NOT NULL,
    event_id INT NOT NULL,

    PRIMARY KEY (runner_id, event_id),

    CONSTRAINT fk_runner FOREIGN KEY (runner_id) REFERENCES runner(id),
    CONSTRAINT fk_event FOREIGN KEY (event_id) REFERENCES event(id)
);

INSERT INTO runner_event (runner_id, event_id) VALUES
(1, 1),
(1, 3),
(2, 2),
(3, 1),
(4, 1),
(4, 2);


--Exercise 4: Organize Runners Into Groups


SELECT 
    main_distance,
    COUNT(*) AS runners_number
FROM runner
GROUP BY main_distance
HAVING COUNT(*) > 3;


--Exercise 5: How Many Runners Participate in Each Event

--Exercise:
--Display the event name and the number of club members that take part in this event (call this column runner_count). 
--Note that there may be events in which no club members participate. For these events, the runner_count should equal 0.


SELECT 
    e.name AS event_name,
    COUNT(re.runner_id) AS runner_count
FROM event e
LEFT JOIN runner_event re 
    ON e.id = re.event_id
GROUP BY e.name;


--Exercise 6: Group Runners by Main Distance and Age

--Exercise:
--Display the distance and the number of runners there are for the following age categories:\
-- under 20, 20–29, 30–39, 40–49, and over 50. Use the following column aliases: 
--under_20, age_20_29, age_30_39, age_40_49, and over_50.

SELECT 
    main_distance,
    SUM(CASE WHEN age < 20 THEN 1 ELSE 0 END) AS under_20,
    SUM(CASE WHEN age BETWEEN 20 AND 29 THEN 1 ELSE 0 END) AS age_20_29,
    SUM(CASE WHEN age BETWEEN 30 AND 39 THEN 1 ELSE 0 END) AS age_30_39,
    SUM(CASE WHEN age BETWEEN 40 AND 49 THEN 1 ELSE 0 END) AS age_40_49,
    SUM(CASE WHEN age >= 50 THEN 1 ELSE 0 END) AS over_50
FROM runner
GROUP BY main_distance;
