C_POINTER:C301($vp_object; $vp_object_value)
C_LONGINT:C283($vl_area)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_scrollbar1")
		$vl_area:=$vp_object->
		
		Scroll_INSTALL CALLBACK($vl_area; "ScrollbackCallback")
		Scroll_SET MAXIMUM($vl_area; 8)
		Scroll_SET VIEWSIZE($vl_area; 12)
		
		$vp_object_value:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_value2")
		$vp_object_value->:=1
		
		//=========
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_scrollbar2")
		$vl_area:=$vp_object->
		
		Scroll_INSTALL CALLBACK($vl_area; "ScrollbackCallback")
		Scroll_SET MAXIMUM($vl_area; 1000)
		Scroll_SET VIEWSIZE($vl_area; 20)
		
		$vp_object_value:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_value")
		$vp_object_value->:=1
		
	: (Form event code:C388=On Outside Call:K2:11)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_scrollbar1")
		$vp_object_value:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_value2")
		
		$vl_area:=$vp_object->
		
		$vp_object_value->:=Scroll_Get Value($vl_area)
		
		//=======
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_scrollbar2")
		$vp_object_value:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_value")
		
		$vl_area:=$vp_object->
		
		$vp_object_value->:=Scroll_Get Value($vl_area)
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
