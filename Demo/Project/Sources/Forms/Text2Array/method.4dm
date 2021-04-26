C_LONGINT:C283($vl_pos; $vl_platform)
C_POINTER:C301($vp_object; $vp_fonts; $vp_sizes; $vp_styles; $vp_width)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vp_fonts:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_fonts")
		
		ARRAY TEXT:C222($vp_fonts->; 0)
		FONT LIST:C460($vp_fonts->)
		
		$vl_platform:=0
		_O_PLATFORM PROPERTIES:C365($vl_platform)
		
		If ($vl_platform=Windows:K25:3)
			$vl_pos:=Find in array:C230($vp_fonts->; "Arial Unicode MS")
		Else 
			$vl_pos:=Find in array:C230($vp_fonts->; "Times New Roman")
		End if 
		
		If ($vl_pos=-1)
			$vl_pos:=Find in array:C230($vp_fonts->; "Arial")
		End if 
		
		If ($vl_pos>0)
			$vp_fonts->:=$vl_pos
		Else 
			If (Size of array:C274($vp_fonts->)>0)
				$vp_fonts->:=1
			End if 
		End if 
		
		$vp_styles:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_styles")
		
		ARRAY TEXT:C222($vp_styles->; 4)
		$vp_styles->{1}:="Plain"
		$vp_styles->{2}:="Bold"
		$vp_styles->{3}:="Italic"
		$vp_styles->{4}:="Bold+Italic"
		
		$vp_styles->:=1
		
		$vp_sizes:=OBJECT Get pointer:C1124(Object named:K67:5; "tz_sizes")
		
		ARRAY REAL:C219($vp_sizes->; 9)
		$vp_sizes->{1}:=9
		$vp_sizes->{2}:=10
		$vp_sizes->{3}:=12
		$vp_sizes->{4}:=14
		$vp_sizes->{5}:=16
		$vp_sizes->{6}:=18
		$vp_sizes->{7}:=24
		$vp_sizes->{8}:=36
		$vp_sizes->{9}:=48
		$vp_sizes->{0}:=12
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vt_inputtext")
		$vp_object->:=Document to text:C1236(Get 4D folder:C485(Current resources folder:K5:16)+"Demotext.txt"; "utf-8")
		
		$vp_width:=OBJECT Get pointer:C1124(Object named:K67:5; "tl_width")
		
		ARRAY LONGINT:C221($vp_width->; 6)
		$vp_width->{1}:=50
		$vp_width->{2}:=100
		$vp_width->{3}:=150
		$vp_width->{4}:=200
		$vp_width->{5}:=250
		$vp_width->{6}:=300
		$vp_width->:=3
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_output")
		ARRAY TEXT:C222($vp_object->; 0)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "tl_output")
		ARRAY LONGINT:C221($vp_object->; 0)
		
		$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vl_MaxWidth")
		$vp_object->:=0
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
