C_PICTURE:C286($vb_picture)
C_POINTER:C301($vp_object)

If (Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Drop:K2:12) | (Form event code:C388=On After Edit:K2:43)
	
	ARRAY TEXT:C222($tt_types; 0)
	$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vb_picture")
	$vb_picture:=$vp_object->
	
	hmFree_GET PICTURE TYPES($vb_picture; $tt_types)
	
	$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_types")
	
	COPY ARRAY:C226($tt_types; $vp_object->)
	
End if 
