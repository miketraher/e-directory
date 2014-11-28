USE [dir]
GO

/****** Object:  Table [dbo].[users]    Script Date: 04/17/2012 07:48:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[users](
	[user_id] [nvarchar](150) NOT NULL,
	[user_password] [nvarchar](50) NULL,
	[last_login_date] [datetime] NULL,
	[failed_login_attempts] [int] NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



delete from users;

insert into [users] ([user_id], user_password )
values ('admin' , 'F3463333D99279A96AF364AF4135DFED' );