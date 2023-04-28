//%attributes = {}
var $vb_picture : Picture

READ PICTURE FILE:C678(""; $vb_picture)

If (OK=1)
	
	ARRAY TEXT:C222($tt_types; 0)
	hmFree_GET PICTURE TYPES($vb_picture; $tt_types)
	
End if 
