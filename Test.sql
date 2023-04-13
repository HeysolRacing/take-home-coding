USE [Test]
GO
/************************************************************************************************************************************************
   CREATE STAGE THAT RECEIVE ALL THE INFORMATION
************************************************************************************************************************************************/
IF OBJECT_ID(N'dbo.ST_MultiDays', N'U') IS NULL
  BEGIN
     CREATE TABLE [dbo].[ST_MultiDays] 
		(
			Gregorian_date  VARCHAR(100),
			Customer VARCHAR(100),
			Account_number VARCHAR(150),
			Account_name VARCHAR(150),
			Account_status VARCHAR(150),
			Campaign_name VARCHAR(100),
			Campaign_status VARCHAR(15),
			Ad_group_ID VARCHAR(50),
			Ad_group VARCHAR(50),
			Ad_group_status VARCHAR(150),
			Ad_ID VARCHAR(50),
			Ad_description VARCHAR(150),
			Ad_distribution VARCHAR(150),
			Ad_status VARCHAR(50),
			Ad_title VARCHAR(255),
			Ad_type VARCHAR(50),
			Tracking_Template VARCHAR(150),
			Custom_Parameters VARCHAR(100),
			Final_Mobile_URL VARCHAR(100),
			Final_URL VARCHAR(500),
			Top_vs_other VARCHAR(100),
			Display_URL VARCHAR(100),
			Final_App_URL VARCHAR(100),
			Destination_URL VARCHAR(500),
			Device_type VARCHAR(50),
			Device_OS VARCHAR(50),
			Delivered_match_type VARCHAR(50),
			BidMatchType VARCHAR(50),
			[Language] VARCHAR(50),
			Network VARCHAR(100),
			Currency_code VARCHAR(50),
			Impressions INT,
			Clicks INT,
			Spend FLOAT,
			Avg_position FLOAT,
			Conversions INT,
			Assists INT
		) ON [PRIMARY] 
  END
ELSE 
  PRINT 'Table ST_MultiDays Exists'
	
/************************************************************************************************************************************************
   CREATE TABLES FOR DIMENSIONS AND FACT TABLES
   -  WE CAN DIVIDE THE INFORMATION INTO SCHEMAS BUT FOR LAB SCENARIO WE WILL CONTINUE IN [dbo]
************************************************************************************************************************************************/
IF OBJECT_ID(N'dbo.DimCustomer', N'U') IS NULL
  BEGIN
    -- Dimension table for Customer
	CREATE TABLE [dbo].[DimCustomer]  -- Posible name "Sales.Customer" analysis depends on Data Purpose
	(
		[customer_id] [int] IDENTITY(1,1) NOT NULL,
		[customer_name] [varchar](100) NULL,
	 CONSTRAINT [PK__Customer_ID] PRIMARY KEY CLUSTERED 
	(
		[customer_id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
  END
 ELSE 
   PRINT 'Table DimCustomer Exists'

IF OBJECT_ID(N'dbo.DimAccount', N'U') IS NULL
  BEGIN
	-- Dimension table for Account
	CREATE TABLE [dbo].[DimAccount] -- Posible name "Information.Account" 
	(
		[Account_Id] [int] IDENTITY(1,1) NOT NULL,
		[Account_Number] [varchar](150) NULL,
		[Account_Name] [varchar](150) NULL,
		[Account_Status] [varchar](150) NULL,
	 CONSTRAINT [PK__Account_ID] PRIMARY KEY CLUSTERED 
	(
		[Account_Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
  END
ELSE 
  PRINT 'Table DimAccount Exists'

IF OBJECT_ID(N'dbo.DimCampaign', N'U') IS NULL
  BEGIN
	-- Dimension table for Campaign
	CREATE TABLE [dbo].[DimCampaign]
	(
		[Campaign_Id] [int] IDENTITY(1,1) NOT NULL,
		[Campaign_Name] [varchar](100) NULL,
		[Campaign_Status] [varchar](15) NULL,
	 CONSTRAINT [PK_Campaign_Id] PRIMARY KEY CLUSTERED 
	(
		[Campaign_Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
  END
 ELSE 
   PRINT 'Table DimCampaign Exists'

IF OBJECT_ID(N'dbo.DimAdGroup', N'U') IS NULL
  BEGIN
	-- Dimension table for Ad group
	CREATE TABLE [dbo].[DimAdGroup]
	(
		[Ad_Group_Id] [bigint] NOT NULL,
		[Ad_Group_Name] [varchar](50) NULL,
		[Ad_Group_Status] [varchar](6) NULL,
	 CONSTRAINT [PK_Ad_Group_Id] PRIMARY KEY CLUSTERED 
	(
		[Ad_Group_Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
  END
 ELSE 
   PRINT 'Table DimAdGroup Exists'

IF OBJECT_ID(N'dbo.DimAd', N'U') IS NULL
  BEGIN
	-- Dimension table for Ad
	CREATE TABLE [dbo].[DimAd]
	(
		[Ad_ID] [varchar](50) NOT NULL, -- IN THIS PART WE NEED TO IDENTIFY IF INFORMATION IS NOT NULL SO WE CAN TREAT AS A KEY
		[Ad_Description] [varchar](150) NULL,
		[Ad_Distribution] [varchar](150) NULL,
		[Ad_Status] [varchar](6) NULL,
		[Ad_Title] [varchar](100) NULL,
		[Ad_Type] [varchar](50) NULL,
		[Tracking_Template] [varchar](150) NULL,
		[Custom_Parameters] [varchar](100) NULL,
		[Final_Mobile_URL] [varchar](100) NULL,
		[Final_URL] [varchar](500) NULL,
		[Top_vs_other] [varchar](100) NULL,
		[Display_URL] [varchar](100) NULL,
		[Final_App_URL] [varchar](100) NULL,
		[Destination_URL] [varchar](500) NULL,
	 CONSTRAINT [PK_dim_ad] PRIMARY KEY CLUSTERED 
	(
		[Ad_ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
  END
 ELSE 
   PRINT 'Table DimAd Exists'

IF OBJECT_ID(N'dbo.FactTracking', N'U') IS NULL
  BEGIN
	-- Fact table
	CREATE TABLE [dbo].[FactTracking](
		[Tracking_Id] [int] IDENTITY(1,1) NOT NULL,
		[Gregorian_Date] [date] NULL,
		[Customer_id] [int] NULL,
		[Account_id] [int] NULL,
		[Campaign_id] [int] NULL,
		[Ad_group_id] [bigint] NULL,
		[Ad_id] [int] NULL,
		[Device_type] [varchar](50) NULL,
		[Device_OS] [varchar](50) NULL,
		[Delivered_match_type] [varchar](50) NULL,
		[BidMatchType] [varchar](50) NULL,
		[Language] [varchar](50) NULL,
		[Network] [varchar](100) NULL,
		[Currency_code] [varchar](50) NULL,
		[Impressions] [int] NULL,
		[Clicks] [int] NULL,
		[Spend] [float] NULL,
		[Avg_position] [float] NULL,
		[Conversions] [int] NULL,
		[Assists] [int] NULL,
	 CONSTRAINT [PK_fact_tracking] PRIMARY KEY CLUSTERED 
	(
		[Tracking_Id] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	
	ALTER TABLE [dbo].[FactTracking]  WITH CHECK ADD CONSTRAINT [FK_FactTracking_Accouunt] FOREIGN KEY([Account_id])
	REFERENCES [dbo].[DimAccount] ([Account_Id])
	
	ALTER TABLE [dbo].[FactTracking] CHECK CONSTRAINT [FK_FactTracking_Accouunt]
	
	ALTER TABLE [dbo].[FactTracking]  WITH CHECK ADD CONSTRAINT [FK_FactTracking_ADGroup] FOREIGN KEY([Ad_group_id])
	REFERENCES [dbo].[DimAdGroup] ([Ad_Group_Id])
	
	ALTER TABLE [dbo].[FactTracking] CHECK CONSTRAINT [FK_FactTracking_ADGroup]
	
	ALTER TABLE [dbo].[FactTracking]  WITH CHECK ADD CONSTRAINT [FK_FactTracking_Customer] FOREIGN KEY([Customer_id])
	REFERENCES [dbo].[DimCustomer] ([customer_id])
	
	ALTER TABLE [dbo].[FactTracking] CHECK CONSTRAINT [FK_FactTracking_Customer]
	
	ALTER TABLE [dbo].[FactTracking]  WITH CHECK ADD CONSTRAINT [FK_FactTracking_Campaign] FOREIGN KEY([Campaign_id])
	REFERENCES [dbo].[DimCampaign] ([Campaign_Id])
	
	ALTER TABLE [dbo].[FactTracking] CHECK CONSTRAINT [FK_FactTracking_Campaign]
  END
 ELSE 
   PRINT 'Table FactTracking Exists'

GO
/************************************************************************************************************************************************
   MERGE PROCESS 
   -  IN THIS CASE WE CAN GET THE INFORMATION FROM DATASOURCE AND POPULATE IN THE SPECIFIC TABLES
   -  PROCEDURE HAVE THE LOGIC TO INSERT / UPDATE / EVEN DELETE
   -  THIS WILL BE CALL BY PYTHON OR ANY OTHER LANGUAGE CODE
************************************************************************************************************************************************/

IF OBJECT_ID(N'dbo.getAdGroups', N'P') IS NOT NULL
  BEGIN
   DROP PROCEDURE [dbo].[getAdGroups]
   PRINT 'SP [dbo].[getAdGroups] dropped successfully'
  END
GO

CREATE PROCEDURE [dbo].[getAdGroups]
/* ================================================================================================================================================
   Procedure Name :  [dbo].[getAdGroups]
   Purpose : Get all information from AD Groups
   Created: 13/04/2023
   Date Modified:   
   Inputs : N/A
   Outputs: N/A	 
================================================================================================================================================*/
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY

	WITH Cte_stage 
	AS 
	(
		SELECT DISTINCT 
				REPLACE( REPLACE([Ad_Group_Id],'[',''), ']','') AS Ad_Group_Id,
	   			[Ad_Group] AS Ad_Group_Name,
	   			[Ad_Group_Status]
		FROM [ST_MultiDays]
	)

   	MERGE [dbo].[DimAdGroup] AS T
	USING Cte_stage AS S
		ON S.Ad_Group_Id = T.Ad_Group_Id
    
		-- For Inserts
		WHEN NOT MATCHED BY Target THEN
			INSERT (Ad_Group_Id, Ad_Group_Name, Ad_Group_Status) 
			VALUES (S.Ad_Group_Id,S.Ad_Group_Name, S.Ad_Group_Status)
    
		-- For Updates
		WHEN MATCHED THEN 
			UPDATE SET T.Ad_Group_Name = S.Ad_Group_Name,
						T.Ad_Group_Status = S.Ad_Group_Status;
    
		-- For Deletes
		--WHEN NOT MATCHED BY Source THEN
		--	DELETE statement but it seem to be a logical delete instead of physical 
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		SELECT ERROR_NUMBER() AS ErrorNumber
			,ERROR_SEVERITY() AS ErrorSeverity
			,ERROR_STATE() AS ErrorState
			,ERROR_PROCEDURE() AS ErrorProcedure
			,ERROR_LINE() AS ErrorLine
			,ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
END
GO

IF OBJECT_ID(N'dbo.getCustomers', N'P') IS NOT NULL
  BEGIN
   DROP PROCEDURE [dbo].[getCustomers]
   PRINT 'SP [dbo].[getCustomers] dropped successfully'
  END
GO

CREATE PROCEDURE [dbo].[getCustomers]
/* ================================================================================================================================================
   Procedure Name :  [dbo].[getCustomers]
   Purpose : Get all information from Customers
   Created: 13/04/2023
   Date Modified: N/A   
   Inputs : N/A
   Outputs: N/A	 
================================================================================================================================================*/
AS
BEGIN
 SET NOCOUNT ON;
   BEGIN TRY

    WITH Cte_stage 
	AS 
    (
	    SELECT DISTINCT Customer AS Customer_name
	    FROM [ST_MultiDays]
	),
	Cte_Calc_Id
	AS
	(
	    SELECT ROW_NUMBER() OVER(ORDER BY Customer_name ASC) AS Customer_id,
		       Customer_name
	    FROM Cte_stage
	)
	
   	MERGE [dbo].[DimCustomer] AS T
	USING Cte_Calc_Id AS S
		ON S.Customer_id = T.Customer_id
    
		-- For Inserts
		WHEN NOT MATCHED BY Target THEN
			INSERT (Customer_name) VALUES (S.Customer_name)
    
		-- For Updates
		WHEN MATCHED THEN 
			UPDATE SET Customer_name = S.Customer_name;
   END TRY
   BEGIN CATCH
     ROLLBACK TRANSACTION
     SELECT ERROR_NUMBER() AS ErrorNumber
		   ,ERROR_SEVERITY() AS ErrorSeverity
		   ,ERROR_STATE() AS ErrorState
		   ,ERROR_PROCEDURE() AS ErrorProcedure
		   ,ERROR_LINE() AS ErrorLine
		   ,ERROR_MESSAGE() AS ErrorMessage;
  END CATCH
END


/************************************************************************************************************************************************
   IN CASE YOU WANT TO RESET ALL THE OBJECTS
   DROP TABLES TO VALIDATE ALL SCRIPT IS WORKING FINE
************************************************************************************************************************************************/
/*

DROP TABLE [dbo].[ST_MultiDays] 
DROP TABLE [dbo].[FactTracking]
DROP TABLE [dbo].[DimAccount]  --python
DROP TABLE [dbo].[DimCampaign] --python
DROP TABLE [dbo].[DimAdGroup]  --sql
DROP TABLE [dbo].[DimCustomer] --sql
DROP TABLE [dbo].[DimAd]

DROP PROCEDURE [dbo].[getAdGroups]
DROP PROCEDURE [dbo].[getCustomers]
*/
