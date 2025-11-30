-- =============== INSERT ==============

-- INSERT [INTO] <table> [(<fields...>)] VALUES (<values>);
-- INSERT [INTO] <table> [(<fields...>)] SELECT ....

INSERT INTO albums (title, creation_date, user_id, rate)
	VALUES ('fall_2025', GETDATE(), 7, 1);


