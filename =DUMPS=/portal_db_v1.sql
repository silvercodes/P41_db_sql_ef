USE [p23_portal_db]
GO
/****** Object:  UserDefinedFunction [dbo].[fnBestUsers]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnBestUsers]()
RETURNS @resultTable table(user_nickname nvarchar(50), albums_count int)
AS
BEGIN
	DECLARE @usersPivotTable table(user_nickname nvarchar(50), albums_count int)

	INSERT INTO @usersPivotTable
	SELECT u.nickname, COUNT(a.id)
	FROM users as u JOIN albums as a ON a.user_id = u.id
	GROUP BY u.id, u.nickname

	INSERT INTO @resultTable
	SELECT user_nickname, albums_count
	FROM @usersPivotTable
	WHERE albums_count = (SELECT MAX(albums_count) FROM @usersPivotTable)

	RETURN

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetShortDay]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetShortDay] (@date datetime)
RETURNS char(3)
AS
BEGIN
	DECLARE @day char(3)
	DECLARE @dayName varchar(16) = DATENAME(dw, @date)
	IF @dayName = 'Monday'
		set @day = 'MON'
	IF @dayName = 'Tuesday'
		set @day = 'TUE'
	ELSE
		set @day = 'XXX'

	RETURN @day

END
GO
/****** Object:  Table [dbo].[images]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[images](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[publish_date] [smalldatetime] NOT NULL,
	[link] [varchar](200) NOT NULL,
	[deleted_at] [smalldatetime] NULL,
	[user_id] [int] NOT NULL,
	[album_id] [int] NOT NULL,
 CONSTRAINT [PK__images__3213E83F209992F8] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](50) NOT NULL,
	[nickname] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[birthday] [date] NOT NULL,
	[deleted_at] [smalldatetime] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnUsersImages]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- FUNCTOINS
-- Types
-- скалярные
-- однотабличные
-- многооператорые

--CREATE FUNCTION f_name
--[@a int = default_value | [READONLY]]
--RETURNS value_type
--[WITH ... ]
--AS..

--SELECT f_name [parameters]
--EXECUTE @result = f_name [parameters]

--CREATE FUNCTION fnGetShortDay (@date datetime)
--RETURNS char(3)
--AS
--BEGIN
--	DECLARE @day char(3)
--	DECLARE @dayName varchar(16) = DATENAME(dw, @date)
--	IF @dayName = 'Monday'
--		set @day = 'MON'
--	IF @dayName = 'Tuesday'
--		set @day = 'TUE'
--	ELSE
--		set @day = 'XXX'

--	RETURN @day

--END

-- SELECT dbo.fnGetShortDay(GETDATE()) as 'day_of_week'

--DECLARE @result char(3)
--DECLARE @date DATETIME = GETDATE()
--EXECUTE @result = dbo.fnGetShortDay @date
--SELECT @result



--CREATE FUNCTION f_name
--[@a int = default_value | [READONLY]]
--RETURNS TABLE
--[WITH ... ]
--AS..

CREATE FUNCTION [dbo].[fnUsersImages]()
RETURNS TABLE
AS
RETURN (
	SELECT u.id as u_id, u.nickname as u_nick, COUNT(i.id) as i_count
	FROM users as u LEFT JOIN images as i ON i.user_id = u.id
	GROUP BY u.id, u.nickname
)

GO
/****** Object:  Table [dbo].[albums]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[description] [nvarchar](512) NULL,
	[creation_date] [smalldatetime] NOT NULL,
	[user_id] [int] NOT NULL,
	[deleted_at] [smalldatetime] NULL,
	[updated_at] [smalldatetime] NULL,
	[rate] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[images_news]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[images_news](
	[image_id] [int] NOT NULL,
	[news_id] [int] NOT NULL,
 CONSTRAINT [PK_images_news] PRIMARY KEY CLUSTERED 
(
	[image_id] ASC,
	[news_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[news]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[news](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[message] [nvarchar](1024) NULL,
	[publish_date] [smalldatetime] NOT NULL,
	[user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[profiles]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[profiles](
	[id] [int] NOT NULL,
	[photo_path] [nvarchar](50) NULL,
	[history] [varchar](200) NOT NULL,
	[deleted_at] [smalldatetime] NULL,
 CONSTRAINT [PK__profiles__3213E83FEF09AD2B] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[albums] ON 
GO

INSERT [dbo].[albums] ([id], [title], [description], [creation_date], [user_id], [deleted_at], [updated_at], [rate]) VALUES (70, N'Bicolored Spleenwort', NULL, CAST(N'2021-07-01T00:00:00' AS SmallDateTime), 85, NULL, CAST(N'2021-06-12T00:00:00' AS SmallDateTime), 8)
GO
INSERT [dbo].[albums] ([id], [title], [description], [creation_date], [user_id], [deleted_at], [updated_at], [rate]) VALUES (72, N'alb1', NULL, CAST(N'2022-05-26T00:00:00' AS SmallDateTime), 1, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[albums] OFF
GO
SET IDENTITY_INSERT [dbo].[images] ON 
GO

SET IDENTITY_INSERT [dbo].[images] OFF

GO
SET IDENTITY_INSERT [dbo].[news] ON 
GO

SET IDENTITY_INSERT [dbo].[news] OFF

SET IDENTITY_INSERT [dbo].[users] ON 

SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_users_email_unique]    Script Date: 15.11.2024 19:40:51 ******/
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [IX_users_email_unique] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[albums]  WITH NOCHECK ADD  CONSTRAINT [FK_albums_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[albums] CHECK CONSTRAINT [FK_albums_users]
GO
ALTER TABLE [dbo].[images]  WITH NOCHECK ADD  CONSTRAINT [FK_images_albums] FOREIGN KEY([album_id])
REFERENCES [dbo].[albums] ([id])
GO
ALTER TABLE [dbo].[images] CHECK CONSTRAINT [FK_images_albums]
GO
ALTER TABLE [dbo].[images]  WITH NOCHECK ADD  CONSTRAINT [FK_images_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[images] CHECK CONSTRAINT [FK_images_users]
GO
ALTER TABLE [dbo].[images_news]  WITH NOCHECK ADD  CONSTRAINT [FK_images_news_images] FOREIGN KEY([image_id])
REFERENCES [dbo].[images] ([id])
GO
ALTER TABLE [dbo].[images_news] CHECK CONSTRAINT [FK_images_news_images]
GO
ALTER TABLE [dbo].[images_news]  WITH NOCHECK ADD  CONSTRAINT [FK_images_news_news] FOREIGN KEY([news_id])
REFERENCES [dbo].[news] ([id])
GO
ALTER TABLE [dbo].[images_news] CHECK CONSTRAINT [FK_images_news_news]
GO
ALTER TABLE [dbo].[news]  WITH NOCHECK ADD  CONSTRAINT [FK_news_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[news] CHECK CONSTRAINT [FK_news_users]
GO
ALTER TABLE [dbo].[profiles]  WITH NOCHECK ADD  CONSTRAINT [FK_profiles_id] FOREIGN KEY([id])
REFERENCES [dbo].[users] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[profiles] CHECK CONSTRAINT [FK_profiles_id]
GO
/****** Object:  StoredProcedure [dbo].[getUsersCountByEmail]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[getUsersCountByEmail]
    @pattern nvarchar(50),
    @count int out
    AS
        SET @count = (SELECT COUNT(email) FROM users WHERE email LIKE @pattern);
GO
/****** Object:  StoredProcedure [dbo].[spAlbumsCount]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spAlbumsCount]
WITH RECOMPILE
AS
BEGIN
	SELECT u.id, u.nickname, COUNT(a.id)
	FROM users as u JOIN albums as a ON u.id = a.user_id
	GROUP BY u.id, u.nickname
END
GO
/****** Object:  StoredProcedure [dbo].[spFindUserByEmail]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spFindUserByEmail]
@email nvarchar(50)
AS
BEGIN
	IF @email IS NOT NULL
	BEGIN
		DECLARE @findedId int
		SELECT @findedId = u.id FROM users AS u WHERE u.email = @email
		RETURN @findedId
	END
	ELSE
		RAISERROR('NULL reseived!', 0, 1);
END
GO
/****** Object:  StoredProcedure [dbo].[spGroup]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- === STORED PROCEDURES

--CREATE PROCEDURE name [;1]
--[@ parameters [OUT | OUTPUT] [READONLY]]
--[WITH [RECOMPILE | ENCRYPTION | EXECUTE AS ...]]
--AS
--BEGIN
--	--
--	--
--END

-- execute name arguments [WITH RECOMPILE]


--CREATE PROCEDURE spAlbumsCount
---- WITH RECOMPILE
--AS
--BEGIN
--	SELECT u.id, u.nickname, COUNT(a.id)
--	FROM users as u JOIN albums as a ON u.id = a.user_id
--	GROUP BY u.id, u.nickname
--END

--EXECUTE spAlbumsCount;


CREATE PROCEDURE [dbo].[spGroup]
AS
BEGIN
	SELECT * FROM users;
END

GO
/****** Object:  NumberedStoredProcedure [dbo].[spGroup];2    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spGroup];2
AS
BEGIN
	SELECT u.id, u.nickname, COUNT(a.id)
	FROM users as u JOIN albums as a ON u.id = a.user_id
	GROUP BY u.id, u.nickname
END
GO
/****** Object:  StoredProcedure [dbo].[spSelectAllAlbums]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    CREATE PROCEDURE [dbo].[spSelectAllAlbums]
    AS
    BEGIN
        SELECT * FROM albums
    END
GO
/****** Object:  StoredProcedure [dbo].[spSum]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSum]
@a int,
@b int,
@result int output
AS
BEGIN
	set @result = @a + @b;
END
GO
/****** Object:  StoredProcedure [dbo].[spSum2]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSum2]
@a int,
@b int
AS
BEGIN
	declare @res int
	set @res = @a + @b
	return @res
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateUser]    Script Date: 15.11.2024 19:40:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spUpdateUser]
@nickname nvarchar(50),
@birthday date,
@id int
as
begin
	update users set nickname = @nickname, birthday = @birthday where id = @id
end
GO
