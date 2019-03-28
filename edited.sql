USE [master]
GO
/****** Object:  Database [BookStoreDB]    Script Date: 3/28/2019 7:51:44 AM ******/
drop DATABASE [BookStoreDB]
CREATE DATABASE [BookStoreDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BookStoreDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\BookStoreDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BookStoreDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\BookStoreDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [BookStoreDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BookStoreDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BookStoreDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BookStoreDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BookStoreDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BookStoreDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BookStoreDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BookStoreDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BookStoreDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BookStoreDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BookStoreDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BookStoreDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BookStoreDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BookStoreDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BookStoreDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BookStoreDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BookStoreDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BookStoreDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BookStoreDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BookStoreDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BookStoreDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BookStoreDB] SET RECOVERY FULL 
GO
ALTER DATABASE [BookStoreDB] SET  MULTI_USER 
GO
ALTER DATABASE [BookStoreDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BookStoreDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BookStoreDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BookStoreDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BookStoreDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BookStoreDB', N'ON'
GO
ALTER DATABASE [BookStoreDB] SET QUERY_STORE = OFF
GO
USE [BookStoreDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [BookStoreDB]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 3/28/2019 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [varchar](61) NOT NULL,
	[AuthorAddress] [varchar](62) NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 3/28/2019 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[PublisherID] [char](4) NULL,
	[AuthorID] [varchar](15) NULL,
	[BookTitle] [varchar](80) NOT NULL,
	[Notes] [nvarchar](max) NULL,
	[BookPrice] [money] NOT NULL,
	[BookType] [varchar](20) NOT NULL,
	[Status] [bit] NULL,
	[Url] [varchar](200) NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/28/2019 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
	[Total] [money] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderLine]    Script Date: 3/28/2019 7:51:44 AM ******/
drop TABLE [dbo].[OrderLine]
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderLine](
	[OrderID] [int] NOT NULL,
	[BookID] [int] NOT NULL,
	[BookPrice] [money] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderLine] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[BookID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 3/28/2019 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[PublisherID] [int] IDENTITY(1,1) NOT NULL,
	[PublisherName] [varchar](40) NULL,
	[PublisherAddress] [varchar](54) NULL,
 CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[PublisherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 3/28/2019 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](255) NOT NULL,
	[DisplayName] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[UserEmailAddress] [nvarchar](255) NOT NULL,
	[Role] [int] NOT NULL,
	[isActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserResponse]    Script Date: 3/28/2019 7:51:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserResponse](
	[ResponseID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[Username] [nvarchar](255) NULL,
	[Title] [nvarchar](max) NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Contents] [nvarchar](max) NOT NULL,
	[IsActive] [bit] NULL,
	[Reply] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ResponseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES ('N David Luyen',N'327 Lakeview Drive Maplewood, NJ 07040')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'George Orwell', N'7356 W. Sulphur Springs Rd. Dedham, MA 02026')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'E. L. James', N'807 Maiden St. Lansing, MI 48910')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'	Robert Louis Stevenson', N'8078 Annadale Ave. New Philadelphia, OH 44663')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Dale Carnegie', N'47 W. Manhattan Street Germantown, MD 20874')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'George Orwell', N'8204 Ridgeview St. ')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Rhonda Byrne', N'696 Peachtree St. ')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Orson Scott Card', N'84 Elmwood St. Calhoun, GA 30701')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Frank Herbert', N'459 Main Road. Plainfield, NJ 07060')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Erich Segal', N'357 St Paul St. Pleasanton, CA 94566 ')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Suzanne Collins', N'150 Tallwood Rd. West Orange, NJ 07052')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'William Shakespeare', N'9858 Clinton St. Marlton, NJ 08053')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Becky Albertalli', N'64 Buckingham Ave. ')
INSERT [dbo].[Author] ([AuthorName], [AuthorAddress]) VALUES (N'Stephen R. Covey', N'10 High Lane Ravenna, OH 44266')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (1, 5, N'Catching Fire', N'Against all odds, Katniss Everdeen has won the annual Hunger Games with fellow district tribute Peeta Mellark. But it was a victory won by defiance of the Capitol and their harsh rules. Katniss and Peeta should be happy. After all, they have just won for themselves and their families a life of safety and plenty. But there are rumors of rebellion among the subjects, and Katniss and Peeta, to their horror, are the faces of that rebellion. The Capitol is angry. The Capitol wants revenge.', 2.7300, N'Action and Adventure', 1, N'https://i.imgur.com/EpD1S9V.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (2, 1, N'Treasure Island', N'On the ultimate treasure hunt young Jim Hawkins finds himself battling the infamous Long John Silver in this illustrated, easy-reading adaptation of the classic pirate yarn.', 3.9900, N'Action and Adventure', 0, N'https://i.imgur.com/AdvRYGa.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (3, 8, N'Novio Boy', N'Ninth grader Rudy has a date with eleventh grader Patricia. Now he has to come up with the money, the poise, and the conversation to carry it off. This one-act play, by turns heartwarming and heart-wrenching, follows Rudy from his desperate search for guidance through the hilarious date itself--all the way to its happy conclusion.', 6.9900, N'Drama', 1, N'https://i.imgur.com/9gQUmjs.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (4, 9, N'The Alchemist', N'The Alchemist by Paulo Coelho continues to change the lives of its readers forever. With more than two million copies sold around the world, The Alchemist has established itself as a modern classic, universally admired.', 12.2000, N'Drama', 1, N'https://i.imgur.com/kaDVp5h.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (5, 6, N'Romeo and Juliet', N'One of Shakespeare''s most popular and accessible plays, Romeo and Juliet tells the story of two star-crossed lovers and the unhappy fate that befell them as a result of a long and bitter feud between their families. The play contains some of Shakespeare''s most beautiful and lyrical love poetry and is perhaps the finest celebration of the joys of young love ever written. This inexpensive edition includes the complete, unabridged text with explanatory footnotes. Ideal for classroom use, it is a wonderful addition to the home library of anyone wanting to savor one of literature''s most sublime paeans to love.', 3.0000, N'Drama', 1, N'https://i.imgur.com/HGJVdDL.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (6, 7, N'Simon vs. the Homo Sapiens Agenda', N'Sixteen-year-old and not-so-openly gay Simon Spier prefers to save his drama for the school musical. But when an email falls into the wrong hands, his secret is at risk of being thrust into the spotlight. Now change-averse Simon has to find a way to step out of his comfort zone before he''s pushed out—without alienating his friends, compromising himself, or fumbling a shot at happiness with the most confusing, adorable guy he''s never met. Incredibly funny and poignant, this twenty-first-century coming-of-age, coming out story—wrapped in a geek romance—is a knockout of a debut novel by Becky Albertalli.', 8.9800, N'Drama', 0, N'https://i.imgur.com/Zgekmhh.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (7, 3, N'ASDSADAS', N'ADASDASD ', 1.1100, N'Drama', 1, N'https://i.imgur.com/Qv00582.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (8, 2, N'Fifty Shades of Grey', N'Christian leaves Georgia unexpectedly. Ana follows the next day. Ana goes straight to Christian''s apartment. They argue over Christian''s desire to punish her for rolling her eyes at him. Ana finally gives in, asking him to punish her to the extreme so she will know what to expect when she signs the contract. However, Ana is so shocked by the brutality of this punishment that she decides she can no longer be involved with Christian. Ana leaves.', 9.6900, N'Romance', 1, N'https://i.imgur.com/ji6P98C.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (9, 10, N'Daughters of the Night Sky', N'The Alchemist by Paulo Coelho continues to change the lives of its readers forever. With more than two million copies sold around the world, The Alchemist has established itself as a modern classic, universally admired.', 11.7000, N'Satire', 1, N'https://i.imgur.com/Qv00582.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (10, 14, N'Love Story', N'Love Story is romantic and funny, yet tragic. It is the tale of two college students whose love enables them to overcome the adversities they encounter in life: Oliver Barrett IV, a Harvard jock and heir to the Barrett fortune and legacy, and Jennifer Cavilleri, the quick-witted daughter of a Rhode Island baker.', 6.9800, N'Romance', 1, N'https://i.imgur.com/QBWJZyo.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (11, 13, N'Animal Farm', N'A farm is taken over by its overworked, mistreated animals. With flaming idealism and stirring slogans, they set out to create a paradise of progress, justice, and equality. Thus the stage is set for one of the most telling satiric fables ever penned—a razor-edged fairy tale for grown-ups that records the evolution from revolution against tyranny to a totalitarianism just as terrible. ', 8.8100, N'Satire', 1, N'https://i.imgur.com/I7p3A91.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (12, 12, N'Nineteen Eighty-Four', N'This is an extract from one of George Orwell’s literary notebooks, which he probably used in different periods of his life, and in which he wrote down ideas and outlines for his works. These pages contain manuscript notes for the novel that would eventually become Nineteen Eighty-Four.', 7.1500, N'Science Fiction', 1, N'https://i.imgur.com/TJ8Pxg4.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (13, 11, N'Dune', N'Dune begins on the planet Caladan, which is ruled by Duke Leto of the House of Atreides. The House of Atreides is one of the families that rules over the planets and planetary systems of the universe. Duke Leto''s son, Paul, is in bed when his mother, Jessica, and Reverend Mother Mohiam check in on him.', 8.9900, N'Science Fiction', 1, N'https://i.imgur.com/KU0tBto.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (14, 4, N'Ender''s Game', N'In the future, the world has been twice attacked by aliens called Buggers, and humanity almost perished. To prepare for the next battle, the world unites around the cause of collecting and training military geniuses from early childhood. their one goal in life is to be the leaders of the army that defends Earth from the "Third Invasion."', 8.4800, N'Science Fiction', 0, N'https://i.imgur.com/rNuZzRd.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (5, 2, N'The 7 Habits of Highly Effective People', N'The 7 Habits of Highly Effective People by Stephen R. Covey is a self-improvement book. It is written on Covey''s belief that the way we see the world is entirely based on our own perceptions. In order to change a given situation, we must change ourselves, and in order to change ourselves, we must be able to change our perceptions.', 26.9000, N'Self Help', 1, N'https://i.imgur.com/epIJ53J.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (8, 5, N'The Secret', N'In 2006, a groundbreaking feature-length film revealed the great mystery of the universe—The Secret—and, later that year, Rhonda Byrne followed with a book that became a worldwide bestseller. Fragments of a Great Secret have been found in the oral traditions, in literature, in religions and philosophies throughout the centuries. ', 18.6100, N'Self Help', 0, N'https://i.imgur.com/et7faFi.jpg')
INSERT [dbo].[Book] ([PublisherID], [AuthorID], [BookTitle], [Notes], [BookPrice], [BookType], [Status], [Url]) VALUES (10, 7, N'How to Win Friends and Influence People', N'You can go after the job you want—and get it! You can take the job you have—and improve it! You can take any situation—and make it work for you! Dale Carnegie’s rock-solid, time-tested advice has carried countless people up the ladder of success in their business and personal lives. One of the most groundbreaking and timeless bestsellers of all time, How to Win Friends & Influence People will teach you: -Six ways to make people like you -Twelve ways to win people to your way of thinking -Nine ways to change people without arousing resentment And much more! Achieve your maximum potential—a must-read for the twenty-first century with more than 15 million copies sold!', 11.8100, N'Self Help', 1, N'https://i.imgur.com/AknwKRo.jpg')
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [UserID], [OrderDate], [Total]) VALUES (2, 2, CAST(N'2018-05-05' AS Date), 3.0000)
SET IDENTITY_INSERT [dbo].[Order] OFF
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Chilton Books', N'9452 Shipley St. North Royalton, OH 44133')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Cassell and Company', N'187 West Woodland Avenue Canfield, OH 44406')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'John Hisberg + Adred Kostophki', N'914 Brickyard St. ')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Scholastic', N'20 Maple Street Hammonton, NJ 08037')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Secker and Warburg', N'61 Railroad Street Palm Harbor, FL 34683')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Atria Books Beyond Words Publishing', N'7426 Country St. ')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Ford Madox Brown', N'8969 Summit Drive ')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Harcourt', N'9766 West East Road Miami Beach, FL 33139')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'	Simon and Schuster ', N'7253 Harvey Dr. Traverse City, MI 49684')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Vintage Books', N'75 Summit Rd. Maplewood, NJ 07040')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Secker & Warburg', N'622 Front Rd. Uniondale, NY 11553')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Free Press', N'8078 Annadale Ave. New Philadelphia, OH 44663')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Harper & Row, Hodder & Stoughton', N'62 Grandrose Dr. Phoenix, AZ 85021')
INSERT [dbo].[Publisher] ([PublisherName], [PublisherAddress]) VALUES (N'Tor Books', N'225 N. Shadow Brook Lane Neenah, WI 54956')
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'admin', N'Admin', N'admin', N'admin@gmail.com', 2, 1)
INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'user1', N'User 1', N'user1', N'user1@gmail.com', 1, 1)
INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'user2', N'User 2', N'abc', N'user2@gmail.com', 1, 1)
INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'user3', N'User 3', N'abc', N'user3@gmail.com', 1, 1)
INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'user4', N'User 4', N'abc', N'user4@gmail.com', 1, 0)
INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'user5', N'User 5', N'abc', N'user5@gmail.com', 1, 1)
INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'phamhuyha', N'Pham Huy Ha', N'abc', N'phh@gmail.com', 1, 1)
INSERT [dbo].[User] ( [Username], [DisplayName], [Password], [UserEmailAddress], [Role], [isActive]) VALUES (N'phamhuyha', N'Pham Huy Ha', N'abc', N'phh@gmail.com', 1, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[UserResponse] ON 

INSERT [dbo].[UserResponse] ([UserID], [Username], [Title], [Email], [Contents], [IsActive], [Reply]) VALUES (NULL, N'user1', N'Login Error', N'user1@gmail.com', N'ad', 1, N'fssd')
INSERT [dbo].[UserResponse] ([UserID], [Username], [Title], [Email], [Contents], [IsActive], [Reply]) VALUES (NULL, N'sdas', N'Login Error', N'drchltfpt@gmail.com', N'sss', 1, NULL)
INSERT [dbo].[UserResponse] ([UserID], [Username], [Title], [Email], [Contents], [IsActive], [Reply]) VALUES (2, N'user1', N'test', N'user1@gmail.com', N'test', 1, N'test')
INSERT [dbo].[UserResponse] ([UserID], [Username], [Title], [Email], [Contents], [IsActive], [Reply]) VALUES (3, NULL, N'u are so stupid', N'user5@gmail.com', N'hihi
', 1, NULL)
INSERT [dbo].[UserResponse] ([ResponseID], [UserID], [Username], [Title], [Email], [Contents], [IsActive], [Reply]) VALUES (8, 10, NULL, N's', N'user5@gmail.com', N'wqwq', 1, NULL)
SET IDENTITY_INSERT [dbo].[UserResponse] OFF
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Author] ([AuthorID])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Author]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Publisher] FOREIGN KEY([PublisherID])
REFERENCES [dbo].[Publisher] ([PublisherID])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Publisher]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_Book] FOREIGN KEY([BookID])
REFERENCES [dbo].[Book] ([BookID])
GO
ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_Book]
GO
ALTER TABLE [dbo].[OrderLine]  WITH CHECK ADD  CONSTRAINT [FK_OrderLine_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderLine] CHECK CONSTRAINT [FK_OrderLine_Order]
GO
ALTER TABLE [dbo].[UserResponse]  WITH CHECK ADD  CONSTRAINT [FK_UserResponse_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserResponse] CHECK CONSTRAINT [FK_UserResponse_User]
GO
/****** Object:  StoredProcedure [dbo].[GetBooks]    Script Date: 3/28/2019 7:51:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetBooks]
@u int,
@v int
as
begin
 SELECT a.BookID ,a.PublisherID,a.AuthorID, a.BookTitle, a.Notes, a.BookPrice, a.BookType, a.[Status], a.Url FROM ( 
  SELECT *, ROW_NUMBER() OVER (ORDER BY Bookid) as row 
  FROM Book a
 ) a WHERE a.row >= @u and a.row <= @v
end
GO
/****** Object:  StoredProcedure [dbo].[GetResponses]    Script Date: 3/28/2019 7:51:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetResponses]
@u int,
@v int
as
begin
 SELECT a.ResponseID, a.UserID, a.Title, a.Email, a.Contents, a.IsActive, a.Reply FROM ( 
  SELECT *, ROW_NUMBER() OVER (ORDER BY ResponseID) as row 
  FROM [UserResponse] a
 ) a WHERE a.row >= @u and a.row <= @v
end
GO
/****** Object:  StoredProcedure [dbo].[GetUsers]    Script Date: 3/28/2019 7:51:45 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetUsers]
@u int,
@v int
as
begin
 SELECT a.UserID, a.Username, a.DisplayName, a.[Password], a.UserEmailAddress, a.[Role], a.isActive FROM ( 
  SELECT *, ROW_NUMBER() OVER (ORDER BY UserID) as row 
  FROM [User] a
 ) a WHERE a.row >= @u and a.row <= @v
end
GO
USE [master]
GO
ALTER DATABASE [BookStoreDB] SET  READ_WRITE 
GO
