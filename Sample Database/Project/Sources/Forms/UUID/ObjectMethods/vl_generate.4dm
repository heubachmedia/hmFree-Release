C_LONGINT:C283($i)
C_POINTER:C301($vp_object)

If (Form event code:C388=On Clicked:K2:4)
	
	$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_uuids")
	
	For ($i; 1; Size of array:C274($vp_object->))
		$vp_object->{$i}:=hmFree_GenerateUUID
	End for 
	
End if 
