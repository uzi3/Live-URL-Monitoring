$servers=Get-Content D:\servers.txt
foreach ($i in $servers) {
try
{
$time=Get-WmiObject -ComputerName $i -Namespace root\cimv2 -Class win32_operatingsystem -ErrorAction Stop | select -expandproperty lastbootuptime
}
catch
{
Write-Output "$i     Error in connecting" `n | Out-File D:\rebootstatus.txt -Append
}
$time
[array]$newtime=$time.Substring(0,14)
$newtimearray=$newtime -split ""
$year=($newtimearray[1]+$newtimearray[2]+$newtimearray[3]+$newtimearray[4])
$month=($newtimearray[5]+$newtimearray[6])
$day=($newtimearray[7]+$newtimearray[8])
$hours=($newtimearray[9]+$newtimearray[10])
$minutes=($newtimearray[11]+$newtimearray[12])
$seconds=($newtimearray[13]+$newtimearray[14])

$complete = "$month-$day-$year $hours`:$minutes`:$seconds"
$bootdate=[datetime]"$complete"

Write-output "$i     $day-$month-$year $hours`:$minutes`:$seconds" `n | Out-File D:\rebootstatus.txt -Append
}



