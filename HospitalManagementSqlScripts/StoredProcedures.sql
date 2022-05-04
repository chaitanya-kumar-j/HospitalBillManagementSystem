--************************   Stored Procedures   *****************************

use HospitalBillManagementDB

-- procedure to Load Grid view
alter procedure spLoadGridView
as
begin
	SELECT	dbo.PatientBills.BillNumber, dbo.PatientDetails.PatientName, 
			dbo.PatientDetails.Gender, dbo.PatientDetails.DateOfBirth, 
			dbo.PatientAddresses.Address, dbo.PatientAddresses.Email, 
			dbo.PatientAddresses.MobileNumber, 
			dbo.PatientInvestigations.Investigation, dbo.PatientBills.BillDate, 
			dbo.PatientBills.Fee
	FROM	dbo.PatientDetails INNER JOIN
			dbo.PatientBills ON dbo.PatientDetails.PatientId = dbo.PatientBills.PatientId INNER JOIN
			dbo.PatientInvestigations ON dbo.PatientDetails.PatientId = dbo.PatientInvestigations.PatientId INNER JOIN
			dbo.PatientAddresses ON dbo.PatientDetails.PatientId = dbo.PatientAddresses.PatientId
end


-- procedure to Add New Bill
alter procedure spAddBill
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
	select @patientId = PatientId from PatientDetails where PatientName = @PatientName

	if(@patientId<>0)
		begin
			insert into PatientBills (PatientId, Fee) values (@patientId, @Fee)
		end
	else
		begin
			insert into PatientDetails (PatientName, Gender, DateOfBirth) values (@PatientName, @Gender, @DateOfBirth)  
			select @patientId = PatientId from PatientDetails where PatientName = @PatientName
			insert into PatientAddresses (PatientId, Address, Email, MobileNumber) values (@patientId, @Address, @Email, @MobileNumber)
			insert into PatientInvestigations (PatientId, Investigation) values (@patientId, @Investigation)
			insert into PatientBills (PatientId, Fee) values (@patientId, @Fee)
		end
end


exec spAddBill 'ChaitanyaKumar','Male', '01-01-2020','Proddatur','chaitanyakumar.jinka@gmail.com','9398459597','Chaitanya@123',6700


-- procedure to Edit Bill
create procedure spEditBill
(
@PatientId int,
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
	update	PatientDetails 
	set		PatientName = @PatientName, 
			Gender=@Gender, 
			DateOfBirth = @DateOfBirth 
	where	PatientId=@PatientId

	update	PatientAddresses 
	set		Address = @Address, 
			Email=@Email, 
			MobileNumber = @MobileNumber 
	where	PatientId=@PatientId

	update	PatientInvestigations 
	set		Investigation = @Investigation
	where	PatientId=@PatientId

	update	PatientBills 
	set		Fee = @Fee 
	where	PatientId=@PatientId
end


-- procedure to Edit Bill
alter procedure spDeleteBill
(
@BillNumber int
)
as 
begin
	delete from PatientBills where BillNumber = @BillNumber
end

