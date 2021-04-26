C_LONGINT:C283($i)
C_POINTER:C301($vp_tl_arabic; $vp_tt_roman)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vp_tl_arabic:=OBJECT Get pointer:C1124(Object named:K67:5; "tl_arabic")
		$vp_tt_roman:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_roman")
		
		ARRAY LONGINT:C221($vp_tl_arabic->; 0)
		ARRAY TEXT:C222($vp_tt_roman->; 0)
		
		For ($i; 1; 55)
			APPEND TO ARRAY:C911($vp_tl_arabic->; $i)
		End for 
		
		For ($i; 60; 1000; 5)
			APPEND TO ARRAY:C911($vp_tl_arabic->; $i)
		End for 
		
		ARRAY TEXT:C222($vp_tt_roman->; Size of array:C274($vp_tl_arabic->))
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
