-- =============================================
-- Author:		Sakshi Basapure
-- Description:	E-Commerce Database Script
-- =============================================

USE [master]
GO
/****** Object:  Database [ECommerce]    Script Date: 05-03-2021 14:27:04 ******/
CREATE DATABASE [ECommerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ECommerce', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ECommerce.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ECommerce_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ECommerce_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ECommerce] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ECommerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ECommerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ECommerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ECommerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ECommerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ECommerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ECommerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ECommerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ECommerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ECommerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ECommerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ECommerce] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ECommerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ECommerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ECommerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ECommerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ECommerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ECommerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ECommerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ECommerce] SET RECOVERY FULL 
GO
ALTER DATABASE [ECommerce] SET  MULTI_USER 
GO
ALTER DATABASE [ECommerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ECommerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ECommerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ECommerce] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ECommerce] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ECommerce', N'ON'
GO
ALTER DATABASE [ECommerce] SET QUERY_STORE = OFF
GO
USE [ECommerce]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(4001,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ShippingID] [int] NOT NULL,
	[OrderNumber] [int] NOT NULL,
	[OrderDate] [date] NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Table_OrderNumber] UNIQUE NONCLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(6001,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CardNumber] [int] NOT NULL,
	[ValidFromDate] [date] NOT NULL,
	[ValidToDate] [date] NOT NULL,
	[PaymentDate] [date] NOT NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_OrderPaymentDate]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[v_OrderPaymentDate] AS
select OrderNumber, OrderDate, PaymentDate
from Orders join Payments
on Orders.UserID = Payments.UserID 
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(2001,1) NOT NULL,
	[AddressLine1] [text] NOT NULL,
	[AddressLine2] [text] NULL,
	[City] [varchar](50) NOT NULL,
	[State] [varchar](50) NOT NULL,
	[Country] [varchar](50) NOT NULL,
	[PostalCode] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Addresses] PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AddressTypes]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddressTypes](
	[AddressTypeID] [int] IDENTITY(3001,1) NOT NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_AddressTypes] PRIMARY KEY CLUSTERED 
(
	[AddressTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CartDetails]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CartDetails](
	[ProductID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[OrderStatus] [text] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Discount] [int] NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(7001,1) NOT NULL,
	[CategoryName] [varchar](50) NOT NULL,
	[ShortDescription] [text] NOT NULL,
	[LongDescription] [text] NULL,
	[Picture] [varchar](255) NULL,
 CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductDetailsAudit]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetailsAudit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditData] [text] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(9001,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[ProductName] [varchar](50) NOT NULL,
	[ProductDesc] [text] NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Size] [int] NULL,
	[UnitInStock] [int] NOT NULL,
	[UnitInOrder] [int] NOT NULL,
	[ProductAvailable] [int] NOT NULL,
	[Discount] [int] NULL,
	[Picture] [varchar](255) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shippers]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shippers](
	[ShippingID] [int] IDENTITY(5001,1) NOT NULL,
	[ShipName] [varchar](50) NOT NULL,
	[ShipAddress] [text] NOT NULL,
	[ShipCity] [varchar](50) NOT NULL,
	[ShipState] [varchar](50) NOT NULL,
	[ShipCountry] [varchar](50) NOT NULL,
	[PostalCode] [int] NOT NULL,
 CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED 
(
	[ShippingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(8001,1) NOT NULL,
	[SupplierName] [varchar](50) NOT NULL,
	[ContactFName] [nchar](10) NOT NULL,
	[ContactMName] [varchar](50) NULL,
	[ContactLName] [varchar](50) NOT NULL,
	[Phone] [varchar](50) NOT NULL,
	[Email] [varchar](50) NULL,
	[Logo] [varchar](255) NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAddress]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAddress](
	[AddressID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[AddressTypeID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserDetailsAudit]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserDetailsAudit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AuditData] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1001,1) NOT NULL,
	[UserFName] [varchar](50) NOT NULL,
	[UserMName] [varchar](50) NULL,
	[UserLName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Phone] [varchar](15) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[CreatedOn] [date] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_Table_Email] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Addresses] ADD  CONSTRAINT [DF_Addresses_AddressLine2]  DEFAULT ('-') FOR [AddressLine2]
GO
ALTER TABLE [dbo].[AddressTypes] ADD  CONSTRAINT [DF_AddressTypes_Description]  DEFAULT ('-') FOR [Description]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_UserMName]  DEFAULT ('-') FOR [UserMName]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Phone]  DEFAULT ('xxx-xxx-xxxx') FOR [Phone]
GO
ALTER TABLE [dbo].[CartDetails]  WITH CHECK ADD  CONSTRAINT [FK_CartDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[CartDetails] CHECK CONSTRAINT [FK_CartDetails_Orders]
GO
ALTER TABLE [dbo].[CartDetails]  WITH CHECK ADD  CONSTRAINT [FK_CartDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[CartDetails] CHECK CONSTRAINT [FK_CartDetails_Products]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY([ShippingID])
REFERENCES [dbo].[Shippers] ([ShippingID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Shippers]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Users]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[UserAddress]  WITH CHECK ADD  CONSTRAINT [FK_UserAddress_Addresses] FOREIGN KEY([AddressID])
REFERENCES [dbo].[Addresses] ([AddressID])
GO
ALTER TABLE [dbo].[UserAddress] CHECK CONSTRAINT [FK_UserAddress_Addresses]
GO
ALTER TABLE [dbo].[UserAddress]  WITH CHECK ADD  CONSTRAINT [FK_UserAddress_AddressTypes] FOREIGN KEY([AddressTypeID])
REFERENCES [dbo].[AddressTypes] ([AddressTypeID])
GO
ALTER TABLE [dbo].[UserAddress] CHECK CONSTRAINT [FK_UserAddress_AddressTypes]
GO
ALTER TABLE [dbo].[UserAddress]  WITH CHECK ADD  CONSTRAINT [FK_UserAddress_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserAddress] CHECK CONSTRAINT [FK_UserAddress_Users]
GO
/****** Object:  StoredProcedure [dbo].[sp_getCategoryProducts]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sakshi Basapure
-- Description:	To get all Products of each Category
-- =============================================
CREATE PROCEDURE [dbo].[sp_getCategoryProducts]
	-- Add the parameters for the stored procedure here
	@CategoryName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ProductName, ProductDesc, UnitPrice, UnitInStock, UnitInOrder, ProductAvailable, Discount
	FROM Categories c, Products p
	WHERE p.CategoryID= c.CategoryID and c.CategoryName=@CategoryName
END
GO
/****** Object:  StoredProcedure [dbo].[sp_getSupplierProducts]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sakshi Basapure
-- Description:	To get all Prodcuts of each Supplier
-- =============================================
CREATE PROCEDURE [dbo].[sp_getSupplierProducts]
	-- Add the parameters for the stored procedure here
	@SupplierName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ProductName, ProductDesc, UnitPrice, UnitInStock, UnitInOrder, ProductAvailable, Discount
	FROM Suppliers s, Products p
	WHERE s.SupplierID = p.SupplierID and s.SupplierName=@SupplierName
END
GO


/****** Object:  StoredProcedure [dbo].[sp_getUserAddresses]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Sakshi Basapure
-- Description:	To get all Addresses of each User
-- =============================================

CREATE PROCEDURE [dbo].[sp_getUserAddresses]
	-- Add the parameters for the stored procedure here
	@UserFName varchar(50),
	@UserLName varchar(50)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	select AddressLine1, AddressLine2, City, State, Country, PostalCode
	from Addresses a, UserAddress us, Users u
	where a.AddressID = us.AddressID and u.UserID = us.UserID and u.UserFName = @UserFName and u.UserLName = @UserLName 
END

GO
/****** Object:  StoredProcedure [dbo].[sp_getUserOrders]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Sakshi Basapure
-- Description:	To get all Orders of each User
-- =============================================
CREATE PROCEDURE [dbo].[sp_getUserOrders]
	-- Add the parameters for the stored procedure here
	@UserFName varchar(50),
	@UserLName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT OrderID, OrderNumber, OrderDate
	FROM Orders o, Users u
	WHERE o.UserID=u.UserID and u.UserFName=@UserFName and u.UserLName=@UserLName
END
GO
/****** Object:  Trigger [dbo].[tr_ProductsForDelete]    Script Date: 05-03-2021 14:27:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_ProductsForDelete]
ON [dbo].[Products]
FOR DELETE
AS
BEGIN
 Declare @ProductID int
 Select @ProductID = ProductID from deleted
 
 insert into ProductDetailsAudit
 values('Existing Product with ID  = ' + Cast(@ProductID as nvarchar(5)) + ' is deleted at ' + cast(Getdate() as nvarchar(20)))
END

GO
ALTER TABLE [dbo].[Products] ENABLE TRIGGER [tr_ProductsForDelete]
GO
/****** Object:  Trigger [dbo].[tr_ProductsForInsert]    Script Date: 05-03-2021 14:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_ProductsForInsert]
ON [dbo].[Products]
FOR INSERT
AS
BEGIN
 Declare @ProductID int
 Select @ProductID = ProductID from inserted
 
 insert into ProductDetailsAudit
 values('New Product with ID  = ' + Cast(@ProductID as nvarchar(5)) + ' is added at ' + cast(Getdate() as nvarchar(20)))
END

GO
ALTER TABLE [dbo].[Products] ENABLE TRIGGER [tr_ProductsForInsert]
GO
/****** Object:  Trigger [dbo].[tr_UsersForDelete]    Script Date: 05-03-2021 14:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[tr_UsersForDelete]
ON [dbo].[Users]
FOR DELETE
AS
BEGIN
 Declare @UserID int
 Select @UserID = UserID from deleted
 
insert into UserDetailsAudit
 values('An existing User with ID  = ' + Cast(@UserID as nvarchar(5)) + ' is deleted at ' + Cast(Getdate() as nvarchar(20)))
END
GO
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [tr_UsersForDelete]
GO
/****** Object:  Trigger [dbo].[tr_UsersForInsert]    Script Date: 05-03-2021 14:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_UsersForInsert]
ON [dbo].[Users]
FOR INSERT
AS
BEGIN
 Declare @UserID int
 Select @UserID = UserID from inserted
 
 insert into UserDetailsAudit
 values('New User with ID  = ' + Cast(@UserID as nvarchar(5)) + ' is added at ' + cast(Getdate() as nvarchar(20)))
END

GO
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [tr_UsersForInsert]
GO
/****** Object:  Trigger [dbo].[tr_UsersForUpdate]    Script Date: 05-03-2021 14:27:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_UsersForUpdate]
on [dbo].[Users]
for Update
as
Begin
      -- Declare variables to hold old and updated data
      Declare @Id int
      Declare @OldUserFName varchar(50), @NewUserFName varchar(50)
      Declare @OldUserMName varchar(50), @NewUserMName varchar(50)
	  Declare @OldUserLName varchar(50), @NewUserLName varchar(50)
	  Declare @OldEmail varchar(50), @NewEmail varchar(50)
	  Declare @OldPhone varchar(15), @NewPhone varchar(15)
	  Declare @OldPassword varchar(50), @NewPassword varchar(50)

     
      -- Variable to build the audit string
      Declare @AuditString nvarchar(1000)
      
      -- Load the updated records into temporary table
      Select *
      into #TempTable
      from inserted
     
      -- Loop thru the records in temp table
      While(Exists(Select UserID from #TempTable))
      Begin
            --Initialize the audit string to empty string
            Set @AuditString = ''
           
            -- Select first row data from temp table
            Select Top 1 @Id = UserID, @NewUserFName = UserFName, @NewUserMName  = UserMName, @NewUserLName = UserLName,
			@NewEmail = Email, @NewPassword= Password, @NewPhone=Phone
            from #TempTable
           
            -- Select the corresponding row from deleted table
            Select  @OldUserFName = UserFName, @OldUserMName  = UserMName, @OldUserLName = UserLName,
			@OldEmail = Email, @OldPassword= Password, @OldPhone=Phone
            from deleted where UserID = @Id
   
     -- Build the audit string dynamically           
            Set @AuditString = 'User with ID = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@NewUserFName <> @OldUserFName)
                  Set @AuditString = @AuditString + ' FIRST NAME from ' + @OldUserFName + ' to ' + @NewUserFName

            if(@NewUserMName <> @OldUserMName)
                  Set @AuditString = @AuditString + ' MIDDLE NAME from ' + @OldUserMName + ' to ' + @NewUserMName

            if(@NewUserLName <> @OldUserLName)
                  Set @AuditString = @AuditString + ' LAST NAME from ' + @OldUserLName + ' to ' + @NewUserLName

            if(@NewEmail <> @OldEmail)
                  Set @AuditString = @AuditString + ' EMAIL from ' + @OldEmail + ' to ' + @NewEmail

            if(@NewPassword <> @OldPassword)
                  Set @AuditString = @AuditString + ' PASSWORD from ' + @OldPassword + ' to ' + @NewPassword

            if(@NewPhone <> @OldPhone)
                  Set @AuditString = @AuditString + ' PHONE from ' + @OldPhone + ' to ' + @NewPhone


          
           
            insert into UserDetailsAudit values(@AuditString)
            
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where UserID = @Id
      End
End
GO
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [tr_UsersForUpdate]
GO
USE [master]
GO
ALTER DATABASE [ECommerce] SET  READ_WRITE 
GO
