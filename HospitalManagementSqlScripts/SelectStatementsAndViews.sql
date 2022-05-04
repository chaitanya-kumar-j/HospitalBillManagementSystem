use HospitalBillManagementDB

select * from PatientDetails;

select * from PatientAddresses;

select * from PatientInvestigations;

select * from PatientBills;

-- for Grid View
exec spLoadGridView
        --or-----
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
ORDER BY dbo.PatientBills.BillDate desc