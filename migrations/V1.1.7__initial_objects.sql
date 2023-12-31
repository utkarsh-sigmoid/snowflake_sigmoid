Use SCHEMA DDA;

CREATE or REPLACE TABLE STG_dim_Date
(
	DateId int NOT NULL,
	Date date NOT NULL,
	Day tinyint NOT NULL,
	DaySuffix char(2) NOT NULL,
	Weekday tinyint NOT NULL,
	WeekDayName varchar(10) NOT NULL,
	IsWeekend Integer NOT NULL,
	IsHoliday varchar NULL,
	HolidayText varchar(64) NULL,
	DOWInMonth tinyint NOT NULL,
	DayOfYear smallint NOT NULL,
	WeekOfMonth tinyint NOT NULL,
	WeekOfYear tinyint NOT NULL,
	ISOWeekOfYear tinyint NOT NULL,
	Month tinyint NOT NULL,
	MonthName varchar(10) NOT NULL,
	Quarter tinyint NOT NULL,
	QuarterName varchar(6) NOT NULL,
	Year int NOT NULL,
	MMYYYY char(6) NOT NULL,
	MonthYear varchar(10) NOT NULL,
	FirstDayOfWeek date NOT NULL,
	LastDayOfWeek date NOT NULL,
	FirstDayOfMonth date NOT NULL,
	LastDayOfMonth date NOT NULL,
	FirstDayOfQuarter date NOT NULL,
	LastDayOfQuarter date NOT NULL,
	FirstDayOfYear date NOT NULL,
	LastDayOfYear date NOT NULL,
	FirstDayOfNextMonth date NOT NULL,
	FirstDayOfNextYear date NOT NULL
);


CREATE OR REPLACE TABLE STG_dim_Customer
(
    CustomerId INT IDENTITY(1,1) NOT NULL,
    NonSigCode VARCHAR(100) NOT NULL,
    BranchCode VARCHAR(100) NULL,
    CustomerName VARCHAR(510) NULL,
    Address VARCHAR(1000) NULL,
    City VARCHAR(510) NULL,
    PhoneNumber VARCHAR(100) NULL,
    FaxNumber VARCHAR(100) NULL,
    State VARCHAR(100) NULL,
    PostalCode VARCHAR(100) NULL,
    Country VARCHAR(2) NULL,
    Latitude DECIMAL(5, 0) NULL,
    Longitude DECIMAL(5, 0) NULL,
    MonOpen VARCHAR(10) NULL,
    MonClose VARCHAR(10) NULL,
    TueOpen VARCHAR(10) NULL,
    TueClose VARCHAR(10) NULL,
    WedOpen VARCHAR(10) NULL,
    WedClose VARCHAR(10) NULL,
    ThuOpen VARCHAR(10) NULL,
    ThuClose VARCHAR(10) NULL,
    FriOpen VARCHAR(10) NULL,
    FriClose VARCHAR(10) NULL,
    SatOpen VARCHAR(10) NULL,
    SatClose VARCHAR(10) NULL,
    SunOpen VARCHAR(10) NULL,
    SunClose VARCHAR(10) NULL,
    CompCode VARCHAR(50) NULL,
    SalesOrg VARCHAR(100) NULL,
    DistributionChannel VARCHAR(100) NULL,
    Division VARCHAR(100) NULL,
    CustomerGroup VARCHAR(100) NULL,
    CommonOwner VARCHAR(100) NULL,
    SubCommonOwner VARCHAR(100) NULL,
    HeadOffice VARCHAR(100) NULL,
    TimeZone VARCHAR(510) NULL,
    CommercialFlag INT NULL,
    ConsumerFlag INT NULL,
    OTRFlag INT NULL,
    QSeriesCode VARCHAR(50) NULL,
    TaxCode VARCHAR(50) NULL,
    g3x INT NULL,
    g3xDunlop INT NULL,
    g3xKelly INT NULL,
    g3xRepublic INT NULL,
    g3xCommercial INT NULL,
    FleetHQ INT NULL,
    TrailerTiresInstallation int NULL,
    StoreInventoryExist INT NULL,
    GoodyearOwnControl INT NULL,
    BayCount VARCHAR(10) NULL,
    StoreManagerPhone VARCHAR(100) NULL,
    StoreEmail VARCHAR(100) NULL,
    StoreManagerName VARCHAR(100) NULL,
    DistrictManagerEmail VARCHAR(100) NULL,
    DistrictManagerName VARCHAR(100) NULL,
    DistrictNumber VARCHAR(100) NULL,
    RegionManagerEmail VARCHAR(100) NULL,
    RegionManagerName VARCHAR(100) NULL,
    RegionNumber VARCHAR(100) NULL,
    iStore VARCHAR(100) NULL,
    POSType VARCHAR(50) NULL,
    PartsProvider VARCHAR(100) NULL,
    TOW365 INT NULL,
    LocationType VARCHAR(510) NULL,
    LocationTypeDescription VARCHAR(510) NULL,
    DWMFIsWarehouse INT NULL,
    TRSOnly INT NULL,
    GeminiFlag INT NULL,
    LCPlantCode VARCHAR(500) NULL,
    ShuttleService INT NULL,
    POSId VARCHAR(100) NULL,
    InstallerType VARCHAR(100) NULL,
    LastUpdatedOn VARCHAR(50) NOT NULL,
    DeActivateOn VARCHAR(50) NULL,
    Status VARCHAR(50) NULL,
    _srcCustomerId VARCHAR(100) NULL,
    HubName VARCHAR(50) NULL,
    MarketName VARCHAR(50) NULL,
    MarketActivatedDate TIMESTAMP_NTZ NULL,
    IsRealTimeSchedule INT NULL
);





CREATE or REPLACE TABLE stg_fact_Mobilezipcode
(
	ZipcodeId bigint IDENTITY(1,1) NOT NULL,
	Zipcode varchar(50) NOT NULL,
	NonSig varchar(50) NOT NULL,
	StopTimeInterval varchar(50) NOT NULL,
	FixedStopDateTime int NOT NULL,
	VariableStopDateTime int NOT NULL,
	SpecialEventAddedDateTime int NOT NULL,
	WeatherAddedDateTime int NOT NULL,
	CustomerId int NOT NULL,
	CreatedDateTime date NOT NULL,
	ModifiedDateTime varchar NULL,
	EffectiveDateId int NOT NULL,
	EffectiveDateTime date NOT NULL,
	EndDateId varchar NULL,
	EndDateTime varchar NULL,
	IsCurrent varchar NOT NULL
);