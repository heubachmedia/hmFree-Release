//%attributes = {}
C_REAL:C285($vz_width; $vz_height; $vz_ascent; $vz_descent)
C_TEXT:C284($vt_text)
C_LONGINT:C283($i; $vl_milliseconds; $vl_duration)

$vt_text:="Dies is a Testtext!"

$vz_width:=0
$vz_height:=0
$vz_ascent:=0
$vz_descent:=0

$vl_milliseconds:=Milliseconds:C459

For ($i; 1; 1000)
	
	hmFree_GET TEXT MEASURES($vt_text; "Verdana"; 12; Bold:K14:2; $vz_width; $vz_height; $vz_ascent; $vz_descent)
	
End for 

$vl_duration:=Milliseconds:C459-$vl_milliseconds

ALERT:C41(String:C10($vl_duration))
