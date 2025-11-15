USE [p41_intro_db]
GO
/****** Object:  Table [dbo].[users]    Script Date: 15.11.2025 17:20:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(10,1) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[age] [int] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[users] ON 
GO
INSERT [dbo].[users] ([id], [email], [age]) VALUES (1, N'vasia@mail.com', 23)
GO
INSERT [dbo].[users] ([id], [email], [age]) VALUES (2, N'petya@mail.com', NULL)
GO
INSERT [dbo].[users] ([id], [email], [age]) VALUES (3, N'dima@mail.com', 34)
GO
INSERT [dbo].[users] ([id], [email], [age]) VALUES (4, N'no_email', 18)
GO
INSERT [dbo].[users] ([id], [email], [age]) VALUES (5, N'no_email', 45)
GO
INSERT [dbo].[users] ([id], [email], [age]) VALUES (10, N'kolya@mail.com', 25)
GO
INSERT [dbo].[users] ([id], [email], [age]) VALUES (11, N'chack@mail.com', 45)
GO
SET IDENTITY_INSERT [dbo].[users] OFF
GO
ALTER TABLE [dbo].[users] ADD  CONSTRAINT [DF_users_email]  DEFAULT ('no_email') FOR [email]
GO
