C_POINTER:C301($vp_object)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vb_picture")
		$vp_object->:=$vp_object->*0
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
