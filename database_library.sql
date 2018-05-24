-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

DROP TABLE [PurchaseOrder];
GO


DROP TABLE [Ratings];
GO


DROP TABLE [dbo].[OrderItem];
GO


DROP TABLE [Lists];
GO


DROP TABLE [dbo].[Product];
GO


DROP TABLE [dbo].[Order];
GO


DROP TABLE [Schools];
GO


DROP TABLE [dbo].[Supplier];
GO


DROP TABLE [dbo].[Customer];
GO



DROP SCHEMA [dbo];
GO


DROP SCHEMA [guest];
GO


DROP SCHEMA [db_owner];
GO


DROP SCHEMA [db_accessadmin];
GO


DROP SCHEMA [db_securityadmin];
GO


DROP SCHEMA [db_ddladmin];
GO


DROP SCHEMA [db_backupoperator];
GO


DROP SCHEMA [db_datareader];
GO


DROP SCHEMA [db_datawriter];
GO


DROP SCHEMA [db_denydatareader];
GO


DROP SCHEMA [db_denydatawriter];
GO


CREATE SCHEMA [dbo];
GO


CREATE SCHEMA [guest];
GO


CREATE SCHEMA [db_owner];
GO


CREATE SCHEMA [db_accessadmin];
GO


CREATE SCHEMA [db_securityadmin];
GO


CREATE SCHEMA [db_ddladmin];
GO


CREATE SCHEMA [db_backupoperator];
GO


CREATE SCHEMA [db_datareader];
GO


CREATE SCHEMA [db_datawriter];
GO


CREATE SCHEMA [db_denydatareader];
GO


CREATE SCHEMA [db_denydatawriter];
GO

--************************************** [Schools]

CREATE TABLE [Schools]
(
 [SchoolId]      INT NOT NULL ,
 [SchoolName]    NVARCHAR(50) NOT NULL ,
 [SchoolAddress] NVARCHAR(50) NOT NULL ,
 [SchoolStatus]  INT NOT NULL ,

 CONSTRAINT [PK_Schools] PRIMARY KEY CLUSTERED ([SchoolId] ASC)
);
GO



--************************************** [dbo].[Supplier]

CREATE TABLE [dbo].[Supplier]
(
 [SupplierId]  INT IDENTITY (1, 1) NOT NULL ,
 [CompanyName] NVARCHAR(40) NOT NULL ,
 [Phone]       NVARCHAR(20) NULL ,
 [Address]     NVARCHAR(50) NOT NULL ,
 [City]        NVARCHAR(40) NOT NULL ,
 [Country]     NVARCHAR(40) NOT NULL ,
 [PostalCode]  SMALLINT NOT NULL ,

 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED ([SupplierId] ASC),
 CONSTRAINT [AK1_Supplier_CompanyName] UNIQUE NONCLUSTERED ([CompanyName] ASC)
);
GO



--************************************** [dbo].[Customer]

CREATE TABLE [dbo].[Customer]
(
 [CustomerId]        INT IDENTITY (1, 1) NOT NULL ,
 [CustomerFirstName] NVARCHAR(40) NOT NULL ,
 [CustomerLastName]  NVARCHAR(40) NOT NULL ,
 [Phone]             NVARCHAR(20) NULL ,
 [Address]           NVARCHAR(50) NOT NULL ,
 [City]              NVARCHAR(40) NOT NULL ,
 [Country]           NVARCHAR(40) NOT NULL ,
 [PostalCode]        SMALLINT NOT NULL ,

 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED ([CustomerId] ASC),
 CONSTRAINT [AK1_Customer_CustomerName] UNIQUE NONCLUSTERED ([CustomerFirstName] ASC)
);
GO



--************************************** [Lists]

CREATE TABLE [Lists]
(
 [ListId]     INT NOT NULL ,
 [PhotoPath]  VARCHAR(50) NOT NULL ,
 [SchoolId]   INT NOT NULL ,
 [CustomerId] INT NOT NULL ,

 CONSTRAINT [PK_Lists] PRIMARY KEY CLUSTERED ([ListId] ASC),
 CONSTRAINT [FK_165] FOREIGN KEY ([SchoolId])
  REFERENCES [Schools]([SchoolId]),
 CONSTRAINT [FK_169] FOREIGN KEY ([CustomerId])
  REFERENCES [dbo].[Customer]([CustomerId])
);
GO


CREATE NONCLUSTERED INDEX [Ind_128] ON [Lists] 

 )

GO

--SKIP Index: [fkIdx_165]

--SKIP Index: [fkIdx_169]


--************************************** [dbo].[Product]

CREATE TABLE [dbo].[Product]
(
 [ProductId]      INT IDENTITY (1, 1) NOT NULL ,
 [ProductName]    NVARCHAR(50) NOT NULL ,
 [SupplierId]     INT NOT NULL ,
 [UnitPrice]      DECIMAL(12,2) NULL ,
 [IsDiscontinued] BIT NOT NULL CONSTRAINT [DF_Product_IsDiscontinued] DEFAULT ((0)) ,

 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED ([ProductId] ASC),
 CONSTRAINT [AK1_Product_SupplierId_ProductName] UNIQUE NONCLUSTERED ([SupplierId] ASC, [ProductName] ASC),
 CONSTRAINT [FK_Product_SupplierId_Supplier] FOREIGN KEY ([SupplierId])
  REFERENCES [dbo].[Supplier]([SupplierId])
);
GO


--SKIP Index: [FK_Product_SupplierId_Supplier]


--************************************** [dbo].[Order]

CREATE TABLE [dbo].[Order]
(
 [OrderId]     INT IDENTITY (1, 1) NOT NULL ,
 [OrderNumber] NVARCHAR(10) NULL ,
 [CustomerId]  INT NOT NULL ,
 [OrderDate]   DATETIME NOT NULL CONSTRAINT [DF_Order_OrderDate] DEFAULT (getdate()) ,
 [TotalAmount] DECIMAL(12,2) NOT NULL ,

 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED ([OrderId] ASC),
 CONSTRAINT [AK1_Order_OrderNumber] UNIQUE NONCLUSTERED ([OrderNumber] ASC),
 CONSTRAINT [FK_Order_CustomerId_Customer] FOREIGN KEY ([CustomerId])
  REFERENCES [dbo].[Customer]([CustomerId])
);
GO


--SKIP Index: [FK_Order_CustomerId_Customer]


--************************************** [PurchaseOrder]

CREATE TABLE [PurchaseOrder]
(
 [OrderId]         INT NOT NULL ,
 [CustomerId]      INT NOT NULL ,
 [TotalPrice]      INT NOT NULL ,
 [Date]            DATE NOT NULL ,
 [Payment]         TINYINT NOT NULL ,
 [DeliveryAddress] NVARCHAR(50) NOT NULL ,
 [ExpDate]         DATE NOT NULL ,
 [ListId]          INT NOT NULL ,
 [SupplierId]      INT NOT NULL ,

 CONSTRAINT [PK_PurchaseOrder] PRIMARY KEY CLUSTERED ([OrderId] ASC, [CustomerId] ASC),
 CONSTRAINT [FK_181] FOREIGN KEY ([OrderId])
  REFERENCES [dbo].[Order]([OrderId]),
 CONSTRAINT [FK_185] FOREIGN KEY ([CustomerId])
  REFERENCES [dbo].[Customer]([CustomerId]),
 CONSTRAINT [FK_189] FOREIGN KEY ([ListId])
  REFERENCES [Lists]([ListId]),
 CONSTRAINT [FK_193] FOREIGN KEY ([SupplierId])
  REFERENCES [dbo].[Supplier]([SupplierId])
);
GO


--SKIP Index: [fkIdx_181]

--SKIP Index: [fkIdx_185]

--SKIP Index: [fkIdx_189]

--SKIP Index: [fkIdx_193]


--************************************** [Ratings]

CREATE TABLE [Ratings]
(
 [CustomerId] INT NOT NULL ,
 [ProductId]  INT NOT NULL ,
 [Rating]     TINYINT NOT NULL ,

 CONSTRAINT [PK_Ratings] PRIMARY KEY CLUSTERED ([CustomerId] ASC, [ProductId] ASC),
 CONSTRAINT [FK_173] FOREIGN KEY ([CustomerId])
  REFERENCES [dbo].[Customer]([CustomerId]),
 CONSTRAINT [FK_177] FOREIGN KEY ([ProductId])
  REFERENCES [dbo].[Product]([ProductId])
);
GO


--SKIP Index: [fkIdx_173]

--SKIP Index: [fkIdx_177]


--************************************** [dbo].[OrderItem]

CREATE TABLE [dbo].[OrderItem]
(
 [OrderId]   INT NOT NULL ,
 [ProductId] INT NOT NULL ,
 [UnitPrice] DECIMAL(12,2) NOT NULL ,
 [Quantity]  INT NOT NULL ,

 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED ([OrderId] ASC, [ProductId] ASC),
 CONSTRAINT [FK_OrderItem_OrderId_Order] FOREIGN KEY ([OrderId])
  REFERENCES [dbo].[Order]([OrderId]),
 CONSTRAINT [FK_OrderItem_ProductId_Product] FOREIGN KEY ([ProductId])
  REFERENCES [dbo].[Product]([ProductId])
);
GO


--SKIP Index: [FK_OrderItem_OrderId_Order]

--SKIP Index: [FK_OrderItem_ProductId_Product]


