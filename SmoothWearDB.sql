USE [master]
GO
/****** Object:  Database [SmoothWear_DB]    Script Date: 09-05-2025 12:06:45 PM ******/
CREATE DATABASE [SmoothWear_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SmoothWear_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SmoothWear_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SmoothWear_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\SmoothWear_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SmoothWear_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SmoothWear_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SmoothWear_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SmoothWear_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SmoothWear_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SmoothWear_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SmoothWear_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SmoothWear_DB] SET  MULTI_USER 
GO
ALTER DATABASE [SmoothWear_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SmoothWear_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SmoothWear_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SmoothWear_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SmoothWear_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SmoothWear_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [SmoothWear_DB] SET QUERY_STORE = OFF
GO
USE [SmoothWear_DB]
GO
/****** Object:  Table [dbo].[Tbl_Cart]    Script Date: 09-05-2025 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Cart](
	[CartId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[UserName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](150) NOT NULL,
	[Quantity] [int] NOT NULL,
	[DateAdded] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CartId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_OrderedItems]    Script Date: 09-05-2025 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_OrderedItems](
	[OrderItemId] [int] IDENTITY(100000,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[ProductName] [nvarchar](100) NOT NULL,
	[ProductImage] [nvarchar](255) NULL,
	[PricePerItem] [decimal](10, 2) NOT NULL,
	[Quantity] [int] NOT NULL,
	[TotalPrice] [decimal](10, 2) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[CreatedAt] [datetime] NULL,
 CONSTRAINT [PK__Tbl_Orde__57ED06810D691B0E] PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_Orders]    Script Date: 09-05-2025 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Orders](
	[OrderId] [int] IDENTITY(10000,1) NOT NULL,
	[UserId] [int] NULL,
	[UserEmail] [nvarchar](100) NULL,
	[PhoneNo] [nvarchar](15) NULL,
	[Address] [nvarchar](250) NULL,
	[City] [nvarchar](100) NULL,
	[Zip] [nvarchar](10) NULL,
	[PreferredPickupSlot] [nvarchar](50) NULL,
	[PaymentMode] [nvarchar](20) NULL,
	[PaymentStatus] [nvarchar](20) NULL,
	[Status] [nvarchar](20) NULL,
	[OrderDate] [datetime] NULL,
 CONSTRAINT [PK__Tbl_Orde__C3905BCF33413B88] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_ProductDetails]    Script Date: 09-05-2025 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_ProductDetails](
	[ProductId] [int] IDENTITY(1000,1) NOT NULL,
	[ProductImage] [nvarchar](500) NOT NULL,
	[ProductName] [nvarchar](50) NOT NULL,
	[ProductCategory] [nvarchar](50) NOT NULL,
	[Cost] [decimal](10, 2) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[CreatedAt] [datetime] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Tbl_ProductDetails] PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tbl_UserDetails]    Script Date: 09-05-2025 12:06:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_UserDetails](
	[Id] [int] IDENTITY(100,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[PhoneNo] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NOT NULL,
	[DOB] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](150) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Tbl_UserDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Tbl_Cart] ON 

INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [UserName], [Email], [Quantity], [DateAdded]) VALUES (5, 1001, N'Kumar', N'kumar5@gmail.com', 3, CAST(N'2025-04-23T12:23:20.307' AS DateTime))
INSERT [dbo].[Tbl_Cart] ([CartId], [ProductId], [UserName], [Email], [Quantity], [DateAdded]) VALUES (19, 1010, N'DemoUser', N'DemoUser@gmail.com', 1, CAST(N'2025-05-06T11:36:08.713' AS DateTime))
SET IDENTITY_INSERT [dbo].[Tbl_Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_OrderedItems] ON 

INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (1, 10002, 1000, N'PQR', N'/Uploads/Products/logo.JPG', CAST(25.00 AS Decimal(10, 2)), 1, CAST(25.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-23T13:40:49.197' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (100001, 10002, 1001, N'PQR', N'/Uploads/Products/logo.JPG', CAST(25.00 AS Decimal(10, 2)), 3, CAST(75.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-23T13:40:53.467' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (200001, 10003, 1001, N'PQR', N'/Uploads/Products/logo.JPG', CAST(25.00 AS Decimal(10, 2)), 1, CAST(25.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-23T13:44:17.493' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300001, 10003, 1005, N'Shirt', N'/Uploads/Products/LOAD.bmp', CAST(25.00 AS Decimal(10, 2)), 1, CAST(25.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-23T13:44:17.500' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300002, 10004, 1004, N'Abc', N'/Uploads/Products/logo.JPG', CAST(10.00 AS Decimal(10, 2)), 1, CAST(10.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-28T10:41:49.753' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300003, 10005, 1006, N'Shirt', N'/Uploads/Products/logo.JPG', CAST(25.00 AS Decimal(10, 2)), 1, CAST(25.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-28T11:34:28.583' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300004, 10006, 1006, N'Shirt', N'/Uploads/Products/logo.JPG', CAST(25.00 AS Decimal(10, 2)), 1, CAST(25.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-28T11:37:49.297' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300005, 10007, 1006, N'Shirt', N'/Uploads/Products/logo.JPG', CAST(25.00 AS Decimal(10, 2)), 2, CAST(50.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-04-28T11:42:45.227' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300006, 10008, 1009, N'Shirt', N'/Uploads/Products/Shirt.jpg', CAST(10.00 AS Decimal(10, 2)), 13, CAST(130.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-05-01T13:43:27.727' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300007, 10009, 1009, N'Shirt', N'/Uploads/Products/Shirt.jpg', CAST(10.00 AS Decimal(10, 2)), 3, CAST(30.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-05-06T10:50:55.873' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300008, 10010, 1009, N'Shirt', N'/Uploads/Products/Shirt.jpg', CAST(10.00 AS Decimal(10, 2)), 1, CAST(10.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-05-06T11:09:37.520' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300009, 10010, 1010, N'T-Shirt', N'/Uploads/Products/Tshirt.jpg', CAST(10.00 AS Decimal(10, 2)), 1, CAST(10.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-05-06T11:09:37.527' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300010, 10011, 1009, N'Shirt', N'/Uploads/Products/Shirt.jpg', CAST(10.00 AS Decimal(10, 2)), 1, CAST(10.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-05-06T11:22:07.807' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300011, 10012, 1014, N'Dress1', N'/Uploads/Products/Dess1.png', CAST(12.00 AS Decimal(10, 2)), 3, CAST(36.00 AS Decimal(10, 2)), N'DemoUser', N'DemoUser@gmail.com', CAST(N'2025-05-06T11:35:54.203' AS DateTime))
INSERT [dbo].[Tbl_OrderedItems] ([OrderItemId], [OrderId], [ProductId], [ProductName], [ProductImage], [PricePerItem], [Quantity], [TotalPrice], [UserName], [Email], [CreatedAt]) VALUES (300012, 10013, 1010, N'T-Shirt', N'/Uploads/Products/Tshirt.jpg', CAST(10.00 AS Decimal(10, 2)), 2, CAST(20.00 AS Decimal(10, 2)), N'Anil', N'anil123@gmail.com', CAST(N'2025-05-07T17:13:55.397' AS DateTime))
SET IDENTITY_INSERT [dbo].[Tbl_OrderedItems] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_Orders] ON 

INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10000, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Morning (8–10 AM)', N'COD', N'NotRequired', N'Accepted', CAST(N'2025-04-23T13:02:02.210' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10001, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Midday (12–2 PM)', N'COD', N'NotRequired', N'Accepted', CAST(N'2025-04-23T13:06:07.553' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10002, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Evening (4–6 PM)', NULL, N'Pending', N'Rejected', CAST(N'2025-04-23T13:40:31.743' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10003, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Midday (12–2 PM)', N'COD', N'Pending', N'Rejected', CAST(N'2025-04-23T13:44:17.433' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10004, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Morning (8–10 AM)', N'Online', N'Pending', N'Placed', CAST(N'2025-04-28T10:41:49.700' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10005, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Midday (12–2 PM)', N'COD', N'Pending', N'Placed', CAST(N'2025-04-28T11:34:28.550' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10006, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Morning (8–10 AM)', N'COD', N'Pending', N'Placed', CAST(N'2025-04-28T11:37:49.277' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10007, 103, N'anil123@gmail.com', N'8688057738', N'Bangalore', N'Bangalore', N'560099', N'Morning (8–10 AM)', N'COD', N'Pending', N'Placed', CAST(N'2025-04-28T11:42:45.203' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10008, 103, N'anil123@gmail.com', N'8688057738', N'12345678', N'Bangalore', N'560099', N'Morning (8–10 AM)', N'COD', N'Pending', N'Placed', CAST(N'2025-05-01T13:43:27.690' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10009, 103, N'anil123@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, N'Pending', N'Placed', CAST(N'2025-05-06T10:50:55.827' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10010, 103, N'anil123@gmail.com', N'0123456789', N'Bangalore', N'Bangalore', N'560099', N'Midday (12–2 PM)', N'Online', N'Pending', N'Placed', CAST(N'2025-05-06T11:09:37.450' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10011, 103, N'anil123@gmail.com', N'0123456789', N'Bangalore', N'Bangalore', N'560099', N'Morning (8–10 AM)', N'COD', N'NotRequired', N'Rejected', CAST(N'2025-05-06T11:22:07.777' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10012, 1105, N'DemoUser@gmail.com', N'0123456789', N'Bangalore', N'Bangalore', N'560099', N'Evening (4–6 PM)', N'COD', N'NotRequired', N'Accepted', CAST(N'2025-05-06T11:35:54.150' AS DateTime))
INSERT [dbo].[Tbl_Orders] ([OrderId], [UserId], [UserEmail], [PhoneNo], [Address], [City], [Zip], [PreferredPickupSlot], [PaymentMode], [PaymentStatus], [Status], [OrderDate]) VALUES (10013, 103, N'anil123@gmail.com', N'0123456789', N'Bangalore', N'Bangalore', N'560099', N'Morning (8–10 AM)', N'COD', N'NotRequired', N'Placed', CAST(N'2025-05-07T17:13:55.357' AS DateTime))
SET IDENTITY_INSERT [dbo].[Tbl_Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_ProductDetails] ON 

INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1001, N'/Uploads/Products/logo.JPG', N'PQR', N'Washing', CAST(25.00 AS Decimal(10, 2)), N'good', CAST(N'2025-04-15T17:53:15.497' AS DateTime), N'Admin', 1)
INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1009, N'/Uploads/Products/Shirt.jpg', N'Shirt', N'Ironing', CAST(10.00 AS Decimal(10, 2)), N'Cotton Shirt Ironing', CAST(N'2025-04-30T11:10:33.153' AS DateTime), N'Admin', 1)
INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1010, N'/Uploads/Products/Tshirt.jpg', N'T-Shirt', N'Ironing', CAST(10.00 AS Decimal(10, 2)), N'T-Shirt Ironing', CAST(N'2025-04-30T11:11:30.363' AS DateTime), N'Admin', 1)
INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1011, N'/Uploads/Products/Jeans Pant.jpg', N'Jeans Pant', N'Ironing', CAST(10.00 AS Decimal(10, 2)), N'Jeans Pant Ironing', CAST(N'2025-04-30T11:12:10.007' AS DateTime), N'Admin', 1)
INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1012, N'/Uploads/Products/Formal Pant.jpg', N'Formal Pant ', N'Ironing', CAST(10.00 AS Decimal(10, 2)), N'Formal Pant Ironing', CAST(N'2025-04-30T11:12:42.457' AS DateTime), N'Admin', 1)
INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1013, N'/Uploads/Products/Saree1.jpg', N'Saree', N'Ironing', CAST(30.00 AS Decimal(10, 2)), N'Saree Ironing', CAST(N'2025-04-30T11:13:38.897' AS DateTime), N'Admin', 1)
INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1014, N'/Uploads/Products/Dess1.png', N'Dress1', N'Ironing', CAST(12.00 AS Decimal(10, 2)), N'Dess', CAST(N'2025-04-30T11:14:29.017' AS DateTime), N'Admin', 1)
INSERT [dbo].[Tbl_ProductDetails] ([ProductId], [ProductImage], [ProductName], [ProductCategory], [Cost], [Description], [CreatedAt], [CreatedBy], [IsActive]) VALUES (1015, N'/Uploads/Products/Dess2.jpg', N'Dress2', N'Ironing', CAST(12.00 AS Decimal(10, 2)), N'Dress', CAST(N'2025-04-30T11:14:51.383' AS DateTime), N'Admin', 1)
SET IDENTITY_INSERT [dbo].[Tbl_ProductDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Tbl_UserDetails] ON 

INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (100, N'Anil', N'kumar@gmail.com', N'1234567890', N'Male', N'22/12/2025', N'Abc', N'Anil@123')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (101, N'Kumar', N'kumar5@gmail.com', N'2345678901', N'Male', N'22/10/2002', N'ABC', N'Kumar@123')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (102, N'C Anil Kumar', N'anil.kumar@tareta.in', N'0123456789', N'Male', N'2025-04-30', N'fghj', N'Anil@123')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (103, N'Anil', N'anil123@gmail.com', N'8688057738', N'Male', N'2002-06-05', N'Bangalore', N'Anil@123')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (104, N'Admin', N'admin@smoothwear.com', N'8688057738', N'Male', N'2025-04-01', N'Bangalore', N'Admin@123')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (1101, N'A', N'a@gmail.com', N'0123456789', N'Male', N'2025-04-16', N'Bangalore', N'Abc@123')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (1102, N'Anil', N'anil1123@gmail.com', N'08688057738', N'Female', N'2025-04-02', N'Bangalore', N'Anil@123')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (1103, N'B', N'B@gmail.com', N'0123456789', N'Female', N'2025-04-30', N'fghj', N'Abc@gmail')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (1104, N'Demo', N'Demo@gmail.com', N'9999999999', N'Male', N'2025-04-02', N'Bangalore', N'Demo@456')
INSERT [dbo].[Tbl_UserDetails] ([Id], [Name], [Email], [PhoneNo], [Gender], [DOB], [Address], [Password]) VALUES (1105, N'DemoUser', N'DemoUser@gmail.com', N'9898989898', N'Male', N'2025-04-28', N'Bangalore', N'Demo@123')
SET IDENTITY_INSERT [dbo].[Tbl_UserDetails] OFF
GO
ALTER TABLE [dbo].[Tbl_Cart] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Tbl_Cart] ADD  DEFAULT (getdate()) FOR [DateAdded]
GO
ALTER TABLE [dbo].[Tbl_OrderedItems] ADD  CONSTRAINT [DF__Tbl_Order__Creat__3C69FB99]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Tbl_Orders] ADD  CONSTRAINT [DF__Tbl_Order__Order__36B12243]  DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Tbl_ProductDetails] ADD  CONSTRAINT [DF_Tbl_ProductDetails_CreatedAt]  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Tbl_ProductDetails] ADD  CONSTRAINT [DF_Tbl_ProductDetails_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Tbl_Cart]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_Cart_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Tbl_ProductDetails] ([ProductId])
GO
ALTER TABLE [dbo].[Tbl_Cart] CHECK CONSTRAINT [FK_Tbl_Cart_Product]
GO
ALTER TABLE [dbo].[Tbl_OrderedItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderedItems_Orders] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Tbl_Orders] ([OrderId])
GO
ALTER TABLE [dbo].[Tbl_OrderedItems] CHECK CONSTRAINT [FK_OrderedItems_Orders]
GO
USE [master]
GO
ALTER DATABASE [SmoothWear_DB] SET  READ_WRITE 
GO
