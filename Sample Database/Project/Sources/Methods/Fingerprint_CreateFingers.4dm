//%attributes = {}
C_BLOB:C604($vx_blob)
C_LONGINT:C283($vl_error; $vl_seconds_to_wait)

$vl_error:=hmFree_Fingerprint_Init

If ($vl_error=0)
	
	ARRAY TEXT:C222($tt_dev_ids; 0)
	ARRAY TEXT:C222($tt_dev_vendor_name; 0)
	ARRAY TEXT:C222($tt_dev_product_name; 0)
	ARRAY TEXT:C222($tt_dev_serial_num; 0)
	
	hmFree_Fingerprint_GET READERS($tt_dev_ids; $tt_dev_vendor_name; $tt_dev_product_name; $tt_dev_serial_num)
	
	If (Size of array:C274($tt_dev_ids)>0)
		
		$vl_seconds_to_wait:=5
		
		$vx_blob:=hmFree_Fingerprint_Get Capture($tt_dev_ids{1}; $vl_seconds_to_wait)
		BLOB TO DOCUMENT:C526(Get 4D folder:C485(Database folder:K5:14)+"finger1.blob"; $vx_blob)
		
		$vx_blob:=hmFree_Fingerprint_Get Capture($tt_dev_ids{1}; $vl_seconds_to_wait)
		BLOB TO DOCUMENT:C526(Get 4D folder:C485(Database folder:K5:14)+"finger2.blob"; $vx_blob)
		
	End if 
	
	$vl_error:=hmFree_Fingerprint_DeInit
	
End if 
