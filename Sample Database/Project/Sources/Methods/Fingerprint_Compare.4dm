//%attributes = {}
C_BLOB:C604($vx_blob1; $vx_blob2)
C_LONGINT:C283($vl_result; $vl_error)

DOCUMENT TO BLOB:C525(Get 4D folder:C485(Database folder:K5:14)+"finger1.blob"; $vx_blob1)
DOCUMENT TO BLOB:C525(Get 4D folder:C485(Database folder:K5:14)+"finger2.blob"; $vx_blob2)

$vl_error:=hmFree_Fingerprint_Init

If ($vl_error=0)
	
	$vl_result:=hmFree_Fingerprint_Get Verific($vx_blob1; $vx_blob2)
	
	$vl_error:=hmFree_Fingerprint_DeInit
	
End if 
