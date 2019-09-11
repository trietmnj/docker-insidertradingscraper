IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = N'financeData')
CREATE DATABASE financeData;
GO

IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE [name] = 'financeData.insiderTrading')
EXEC('CREATE SCHEMA [financeData.insiderTrading]');
GO

