C_LONGINT:C283($i)
C_POINTER:C301($vp_object)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_uuids")
		
		ARRAY TEXT:C222($vp_object->; 100)
		
		For ($i; 1; Size of array:C274($vp_object->))
			$vp_object->{$i}:=hmFree_GenerateUUID
		End for 
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
