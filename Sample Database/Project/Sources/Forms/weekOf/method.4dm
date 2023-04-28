C_DATE:C307($vd_date)
C_LONGINT:C283($i; $vl_size)
C_POINTER:C301($vp_date; $vp_weekno)

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		$vp_date:=OBJECT Get pointer:C1124(Object named:K67:5; "td_date")
		$vp_weekno:=OBJECT Get pointer:C1124(Object named:K67:5; "tl_weekno")
		
		ARRAY DATE:C224($vp_date->; 0)
		ARRAY LONGINT:C221($vp_weekno->; 0)
		
		$vl_size:=100
		
		ARRAY DATE:C224($vp_date->; $vl_size)
		ARRAY INTEGER:C220($vp_weekno->; $vl_size)
		
		$vd_date:=Current date:C33
		
		For ($i; 1; $vl_size)
			
			If ($i=1) | (Day number:C114($vd_date)=2)
				
				$vp_weekno->{$i}:=hmFree_Week Of($vd_date)
				
			End if 
			
			$vp_date->{$i}:=$vd_date
			
			$vd_date:=$vd_date+1
			
		End for 
		
	: (Form event code:C388=On Close Box:K2:21)
		CANCEL:C270
		
End case 
