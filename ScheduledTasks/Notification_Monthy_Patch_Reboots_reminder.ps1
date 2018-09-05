<#
.Name
    Notification_Monthly_Patch_Reboots_reminder

.Synopsis
    Basic reminder notification for lettings people know which production servers will be rebooted on the up coming weekend.

.Syntax
    None

.Description
    This notifiction will be set up to run on the 3rd Tuesday of the month to remind people of the production server reboots. 
#>

#This calculates patch tuesday of the month which allows us to then calculate the dev and prod patch weekends
$BaseDate = ( Get-Date -Day 12 ).Date
$PatchTuesday = $BaseDate.AddDays( 2 - [int]$BaseDate.DayOfWeek )

$SatDate=$PatchTuesday.AddDays(11)
$SatDate=$SatDate.ToString('MM-dd-yyyy')

$SunDate=$PatchTuesday.AddDays(12)
$SunDate=$SunDate.ToString('MM-dd-yyyy')

#file path for attachments
$loc = "c:\temp"

$messageparameters = @{
subject="PLEASE REVIEW: Microsoft Security Updates for All Production Servers - Scheduled Reboots"
body ="
Hello everyone,
<p>The Infrastructure team will patch all Production Servers over this upcoming weekend to ensure they are fully compliant with Microsoft Security Updates. This will require a REBOOT or possibly multiple reboots until all patches are fully installed. Please reference the below patching schedule and attached files for a full list of servers being patched each day.<br>
<br>
<b> Production Servers</b> $SatDate at 1:00 AM local time and $sundate at 1:00 AM local time.<br>
<br>
<b>**Please review attached spreadsheet for the complete Production Server Patching Schedule**</b><br>
<br>
<p>Thank you for your support! <br>
<br>
</P>"
From = "noreply@corp.com"
TO = "IT@corp.com"
Smtpserver= "smtp.corp.com"
Attachments = "$loc\Production-Saturday.csv","$loc\Production-Sunday.csv"
}
Send-MailMessage @messageparameters -BodyAsHtml