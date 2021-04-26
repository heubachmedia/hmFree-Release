//%attributes = {}
C_LONGINT:C283($i)
C_POINTER:C301($vp_tl_arabic; $vp_tt_roman)

$vp_tl_arabic:=OBJECT Get pointer:C1124(Object named:K67:5; "tl_arabic")
$vp_tt_roman:=OBJECT Get pointer:C1124(Object named:K67:5; "tt_roman")

For ($i; 1; Size of array:C274($vp_tl_arabic->))
	
	$vp_tt_roman->{$i}:=hmFree_Arabic2Roman($vp_tl_arabic->{$i})
	
End for 
