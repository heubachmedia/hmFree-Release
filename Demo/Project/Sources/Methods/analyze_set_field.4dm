//%attributes = {}
C_LONGINT:C283($vl_pos)
C_POINTER:C301($vp_names; $vp_content; $vp_object)
C_TEXT:C284($vt_key; $vt_object)

$vp_names:=$1
$vp_content:=$2
$vt_key:=$3
$vt_object:=$4

$vl_pos:=Find in array:C230($vp_names->; $vt_key)
$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; $vt_object)

If ($vl_pos>0)
	
	$vp_object->:=Convert to text:C1012($vp_content->{$vl_pos}; "utf-16")
	
Else 
	
	$vp_object->:=""
	
End if 
