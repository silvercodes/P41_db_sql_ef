-- student
-- teacher
-- grade
-- homework
-- pair
-- subject
-- group
--------




CREATE TABLE schedule_items (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	number tinyint NOT NULL,
	item_start time NOT NULL,
	item_end time NOT NULL,
	status tinyint DEFAULT(1) NOT NULL
);


CREATE TABLE pairs (
	id int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	pair_date date NOT NULL,
	schedule_item_id int,
);


