C_LONGINT:C283($i)
C_POINTER:C301($vp_source; $vp_stemmer)

If (Form event code:C388=On Clicked:K2:4)
	
	$vp_source:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_source")
	$vp_stemmer:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_stemmer")
	
	For ($i; 1; Size of array:C274($vp_source->))
		$vp_stemmer->{$i}:=hmFree_Porter Stemmer($vp_source->{$i})
	End for 
	
End if 
