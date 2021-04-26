//%attributes = {}
C_LONGINT:C283($i; $vl_ms)
C_TEXT:C284($vt_uuid)

$vl_ms:=Milliseconds:C459

For ($i; 1; 10000)
	$vt_uuid:=hmFree_GenerateUUID
End for 

ALERT:C41(String:C10(Milliseconds:C459-$vl_ms))
