//%attributes = {}
var $i; $vl_error; $vl_context : Integer
var $vx_input; $vx_output; $vx_cin : Blob
var $vt_cin; $vt_input : Text
var $vz_serial : Real

$vl_error:=SCard_EstablishContext($vl_context)

If ($vl_error=0)
	
	ARRAY TEXT:C222($tt_Readers; 0)
	$vl_error:=SCard_ListReaders($vl_context; $tt_Readers)
	
	If (Size of array:C274($tt_Readers)>0)
		
		$vl_error:=SCard_Connect($vl_context; $tt_Readers{1})
		
		If ($vl_error=0)
			
			//Certificate
			
			If (True:C214)
				
				SET BLOB SIZE:C606($vx_certificate; 0)
				$vz_serial:=0
				
				$vl_error:=SCard_Read Certificate($vl_context; $vx_certificate; $vz_serial)
				
				BLOB TO DOCUMENT:C526("certificate.cer"; $vx_certificate)
				
			End if 
			
			//CIN
			
			If (False:C215)
				
				SET BLOB SIZE:C606($vx_cin; 0)
				$vl_error:=SCard_Read CIN($vl_context; $vx_cin)
				
				If ($vl_error=0)
					
					$vt_cin:=""
					For ($i; 1; BLOB size:C605($vx_cin))
						$vt_cin:=$vt_cin+Delete string:C232(String:C10($vx_cin{$i-1}; "&x"); 1; 4)
					End for 
					
				End if 
				
			End if 
			
			If (True:C214)
				
				$vt_input:="Das ist ein Beispieltext der anstelle eines Registrierkasseneintrags signiert wird... "
				
				SET BLOB SIZE:C606($vx_input; 0)
				SET BLOB SIZE:C606($vx_output; 0)
				
				CONVERT FROM TEXT:C1011($vt_input; "utf-16"; $vx_input)
				
				$vl_error:=SCard_Perform Signature($vl_context; "123456"; $vx_input; $vx_output)
				
			End if 
			
			$vl_error:=SCard_Disconnect($vl_context)
			
		End if 
		
	End if 
	
	$vl_error:=SCard_ReleaseContext($vl_context)
	
End if 
