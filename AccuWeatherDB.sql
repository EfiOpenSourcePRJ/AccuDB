USE [master]
GO
/****** Object:  Database [AccuWeather]    Script Date: 12/9/2019 1:05:45 PM ******/
CREATE DATABASE [AccuWeather]
 CONTAINMENT = NONE
 
ALTER DATABASE [AccuWeather] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AccuWeather].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AccuWeather] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AccuWeather] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AccuWeather] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AccuWeather] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AccuWeather] SET ARITHABORT OFF 
GO
ALTER DATABASE [AccuWeather] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AccuWeather] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AccuWeather] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AccuWeather] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AccuWeather] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AccuWeather] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AccuWeather] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AccuWeather] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AccuWeather] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AccuWeather] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AccuWeather] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AccuWeather] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AccuWeather] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AccuWeather] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AccuWeather] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AccuWeather] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AccuWeather] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AccuWeather] SET RECOVERY FULL 
GO
ALTER DATABASE [AccuWeather] SET  MULTI_USER 
GO
ALTER DATABASE [AccuWeather] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AccuWeather] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AccuWeather] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AccuWeather] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AccuWeather] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AccuWeather', N'ON'
GO
ALTER DATABASE [AccuWeather] SET QUERY_STORE = OFF
GO
USE [AccuWeather]
GO
/****** Object:  Table [dbo].[CityName]    Script Date: 12/9/2019 1:05:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CityName](
	[CityNameID] [bigint] NOT NULL,
	[CityName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_CityName] PRIMARY KEY CLUSTERED 
(
	[CityNameID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CurrentWeatherData]    Script Date: 12/9/2019 1:05:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CurrentWeatherData](
	[CurrentWeatherID] [bigint] IDENTITY(1,1) NOT NULL,
	[WeatherTypeID] [bigint] NOT NULL,
	[Celcius] [int] NOT NULL,
	[UpdateTime] [datetime] NOT NULL,
	[CityID] [bigint] NOT NULL,
 CONSTRAINT [PK_CurrentWeatherData_1] PRIMARY KEY CLUSTERED 
(
	[CurrentWeatherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WeatherTypes]    Script Date: 12/9/2019 1:05:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WeatherTypes](
	[WeatherTypeID] [bigint] IDENTITY(1,1) NOT NULL,
	[WeatherTypeName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_WeatherTypes] PRIMARY KEY CLUSTERED 
(
	[WeatherTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CityName] ([CityNameID], [CityName]) VALUES (213181, N'Haifa')
INSERT [dbo].[CityName] ([CityNameID], [CityName]) VALUES (215849, N'Ramat Gan')
SET IDENTITY_INSERT [dbo].[CurrentWeatherData] ON 

INSERT [dbo].[CurrentWeatherData] ([CurrentWeatherID], [WeatherTypeID], [Celcius], [UpdateTime], [CityID]) VALUES (6, 1, 20, CAST(N'2019-12-08T17:45:26.490' AS DateTime), 213181)
INSERT [dbo].[CurrentWeatherData] ([CurrentWeatherID], [WeatherTypeID], [Celcius], [UpdateTime], [CityID]) VALUES (8, 2, 19, CAST(N'2019-12-08T17:46:31.450' AS DateTime), 215849)
SET IDENTITY_INSERT [dbo].[CurrentWeatherData] OFF
SET IDENTITY_INSERT [dbo].[WeatherTypes] ON 

INSERT [dbo].[WeatherTypes] ([WeatherTypeID], [WeatherTypeName]) VALUES (1, N'rainy')
INSERT [dbo].[WeatherTypes] ([WeatherTypeID], [WeatherTypeName]) VALUES (2, N'cloudy')
INSERT [dbo].[WeatherTypes] ([WeatherTypeID], [WeatherTypeName]) VALUES (3, N'partly cloudy')
INSERT [dbo].[WeatherTypes] ([WeatherTypeID], [WeatherTypeName]) VALUES (4, N'sunny')
SET IDENTITY_INSERT [dbo].[WeatherTypes] OFF
ALTER TABLE [dbo].[CurrentWeatherData] ADD  CONSTRAINT [DF_CurrentWeatherData_UpdateTime]  DEFAULT (getdate()) FOR [UpdateTime]
GO
ALTER TABLE [dbo].[CurrentWeatherData]  WITH CHECK ADD  CONSTRAINT [FK_CurrentWeatherData_CityName] FOREIGN KEY([CityID])
REFERENCES [dbo].[CityName] ([CityNameID])
GO
ALTER TABLE [dbo].[CurrentWeatherData] CHECK CONSTRAINT [FK_CurrentWeatherData_CityName]
GO
ALTER TABLE [dbo].[CurrentWeatherData]  WITH CHECK ADD  CONSTRAINT [FK_CurrentWeatherData_WeatherTypes] FOREIGN KEY([WeatherTypeID])
REFERENCES [dbo].[WeatherTypes] ([WeatherTypeID])
GO
ALTER TABLE [dbo].[CurrentWeatherData] CHECK CONSTRAINT [FK_CurrentWeatherData_WeatherTypes]
GO
/****** Object:  StoredProcedure [dbo].[GetWeatherDataByCityID]    Script Date: 12/9/2019 1:05:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[GetWeatherDataByCityID]
	@cityID int
AS
BEGIN
	
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from [dbo].[CityName] cn 
	join [dbo].[CurrentWeatherData] cwd on cn.CityNameID = cwd.CityID
	join [dbo].[WeatherTypes] wt on wt.WeatherTypeID = cwd.WeatherTypeID
	where cityID = @cityID
END
GO
USE [master]
GO
ALTER DATABASE [AccuWeather] SET  READ_WRITE 
GO
