

Send-MailMessage -Smtpserver "smtp.abo.fi" -From "adminreport@abo.fi" -To "email@here.fi" -Subject "Error" -Body "Powershell script in <hus> <rum> has failed" -Attachments "C:\Temp\Felix\Ferror.txt"
