CREATE SCHEMA DDA;

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


CREATE or REPLACE TABLE STG_dim_Customer
(
	CustomerId int IDENTITY(1,1) NOT NULL,
	NonSigCode varchar(100) NOT NULL,
	BranchCode varchar(100) NULL,
	CustomerName varchar(510) NULL,
	Address varchar(1000) NULL,
	City varchar(510) NULL,
	PhoneNumber varchar(100) NULL,
	FaxNumber varchar(100) NULL,
	State varchar(100) NULL,
	PostalCode varchar(100) NULL,
	Country varchar(2) NULL,
	Latitude decimal(5, 0) NULL,
	Longitude decimal(5, 0) NULL,
	MonOpen varchar(10) NULL,
	MonClose varchar(10) NULL,
	TueOpen varchar(10) NULL,
	TueClose varchar(10) NULL,
	WedOpen varchar(10) NULL,
	WedClose varchar(10) NULL,
	ThuOpen varchar(10) NULL,
	ThuClose varchar(10) NULL,
	FriClose varchar(10) NULL,
	FriOpen varchar(10) NULL,
	SatClose varchar(10) NULL,
	SatOpen varchar(10) NULL,
	SunOpen varchar(10) NULL,
	SunClose varchar(10) NULL,
	CompCode varchar(50) NULL,
	SalesOrg varchar(100) NULL,
	DistributionChannel varchar(100) NULL,
	Division varchar(100) NULL,
	CustomerGroup varchar(100) NULL,
	CommonOwner varchar(100) NULL,
	SubCommonOwner varchar(100) NULL,
	HeadOffice varchar(100) NULL,
	TimeZone varchar(510) NULL,
	CommercialFlag bit NULL,
	ConsumerFlag bit NULL,
	OTRFlag bit NULL,
	QSeriesCode varchar(50) NULL,
	TaxCode varchar(50) NULL,
	g3x bit NULL,
	g3xDunlop bit NULL,
	g3xKelly bit NULL,
	g3xRepublic bit NULL,
	g3xCommercial bit NULL,
	FleetHQ int NULL,
	TrailerTiresInstallation bit NULL,
	StoreInventoryExist bit NULL,
	GoodyearOwnControl bit NULL,
	BayCount varchar(10) NULL,
	StoreManagerPhone varchar(100) NULL,
	StoreEmail varchar(100) NULL,
	StoreManagerName varchar(100) NULL,
	DistrictManagerEmail varchar(100) NULL,
	DistrictManagerName varchar(100) NULL,
	DistrictNumber varchar(100) NULL,
	RegionManagerEmail varchar(100) NULL,
	RegionManagerName varchar(100) NULL,
	RegionNumber varchar(100) NULL,
	iStore varchar(100) NULL,
	POSType varchar(50) NULL,
	PartsProvider varchar(100) NULL,
	TOW365 bit NULL,
	LocationType varchar(510) NULL,
	LocationTypeDescription varchar(510) NULL,
	DWMFIsWarehouse bit NULL,
	TRSOnly bit NULL,
	GeminiFlag bit NULL,
	LCPlantCode varchar(500) NULL,
	ShuttleService bit NULL,
	POSId varchar(100) NULL,
	InstallerType varchar(100) NULL,
	LastUpdatedOn varchar(50) NOT NULL,
	DeActivateOn varchar(50) NULL,
	Status varchar(50) NULL,
	_srcCustomerId uniqueidentifier NULL,
	HubName varchar(50) NULL,
	MarketName varchar(50) NULL,
	MarketActivatedDate datetime NULL,
	IsRealTimeSchedule bit NULL
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