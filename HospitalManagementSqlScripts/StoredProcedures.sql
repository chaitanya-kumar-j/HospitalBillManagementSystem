--************************   Stored Procedures   *****************************
-- procedure to Load Grid view
create procedure spLoadGridView
as
begin
SELECT	dbo.PatientBills.BillNumber, dbo.PatientDetails.PatientName, 
		dbo.PatientDetails.Gender, dbo.PatientDetails.DateOfBirth, 
		dbo.PatientAddresses.Address, dbo.PatientAddresses.Email, 
		dbo.PatientAddresses.MobileNumber, 
		dbo.PatientInvestigations.Investigation, 
		dbo.PatientBills.BillDate
FROM	dbo.PatientDetails INNER JOIN
		dbo.PatientBills ON dbo.PatientDetails.PatientId = dbo.PatientBills.PatientId INNER JOIN
        dbo.PatientInvestigations ON dbo.PatientDetails.PatientId = dbo.PatientInvestigations.PatientId INNER JOIN
        dbo.PatientAddresses ON dbo.PatientDetails.PatientId = dbo.PatientAddresses.PatientId
end


-- procedure to Add New Bill
create procedure spAddBill
(
@PatientName nvarchar(50),  
@Gender nvarchar(10),  
@DateOfBirth date, 
@Address nvarchar(100),
@Email nvarchar(50), 
@MobileNumber varchar(10),
@Investigation varchar(50),
@Fee bigint
)
as
begin
declare @patientId int

insert into PatientDetails (PatientName, Gender, DateOfBirth) values (@PatientName, @Gender, @DateOfBirth)  
select @patientId = PatientId from PatientDetails where PatientName = @PatientName

insert into PatientAddresses (PatientId, Address, Email, MobileNumber) values (@patientId, @Address, @Email, @MobileNumber)
insert into PatientInvestigations (PatientId, Investigation) values (@patientId, @Investigation)
insert into PatientBills (PatientId, Fee) values (@patientId, @Fee)

end


exec spAddBill 'ChaitanyaKumar','Male', '01-01-2020','Proddatur','chaitanyakumar.jinka@gmail.com','9398459597','Chaitanya@123',5000
