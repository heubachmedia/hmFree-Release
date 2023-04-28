//%attributes = {}
C_TEXT:C284($vt_text)
C_LONGINT:C283($vl_error)

$vl_error:=hmFree_GetMethodText(0xAAEF430E; $vt_text)

C_TEXT:C284($vt_text)
C_LONGINT:C283($vl_error; $vl_pos)

ARRAY LONGINT:C221($tl_ids; 0)
ARRAY TEXT:C222($tt_methodnames; 0)

hmFree_GET METHOD LIST($tt_methodnames; $tl_ids)

$vl_pos:=Find in array:C230($tt_methodnames; "testcode")

If ($vl_pos>0)
	$vt_text:=""
	$vl_error:=hmFree_GetMethodText($tl_ids{$vl_pos}; $vt_text)
	SET TEXT TO PASTEBOARD:C523($vt_text)
Else 
	SET TEXT TO PASTEBOARD:C523("")
End if 

$vl_error:=hmFree_OpenMethodEditor($tt_methodnames{1}; 1)
