--***************************  Database Creation   ******************************
create database HospitalBillManagementDB

use HospitalBillManagementDB

--***************************  Tables Creation   ******************************

-- Table to store Patient personal data
create table PatientDetails
(
PatientId int primary key not null identity(1,1),  
PatientName nvarchar(50),  
Gender nvarchar(10),  
DateOfBirth date
)


-- Table to store Patient Address data
create table PatientAddresses
(
AddressId int primary key not null identity(1,1),
PatientId int foreign key references PatientDetails(PatientId),  
Address nvarchar(100),
Email nvarchar(50),
MobileNumber nvarchar(10)  
)

-- Table to store Patient Investigations data
create table PatientInvestigations
(
InvestigationId int primary key not null identity(1,1),
PatientId int foreign key references PatientDetails(PatientId),  
Investigation nvarchar(50),  
)

-- Table to store Patient Bills data
create table PatientBills
(
BillNumber int primary key not null identity(1,1),
PatientId int foreign key references PatientDetails(PatientId),  
Fee int,  
BillDate date not null default getdate()
)