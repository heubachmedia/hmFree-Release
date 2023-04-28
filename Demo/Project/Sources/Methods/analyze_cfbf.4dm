//%attributes = {}
C_TEXT:C284($vt_path; $vt_text; $vt_attachments)
C_POINTER:C301($vp_object)
C_LONGINT:C283($vl_pos)

$vt_path:=$1

ARRAY TEXT:C222($tt_names; 0)
ARRAY BLOB:C1222($tx_content; 0)

hmFree_ANALYZE_CFBF($vt_path; $tt_names; $tx_content)

analyze_set_field(->$tt_names; ->$tx_content; "__substg1.0_0037001F"; "vt_subject")
analyze_set_field(->$tt_names; ->$tx_content; "__substg1.0_1000001F"; "vt_body")
analyze_set_field(->$tt_names; ->$tx_content; "__substg1.0_0042001F"; "vt_from")
analyze_set_field(->$tt_names; ->$tx_content; "__substg1.0_0065001F"; "vt_from_email")
analyze_set_field(->$tt_names; ->$tx_content; "__substg1.0_0076001F"; "vt_to")

$vt_attachments:=""

$vl_pos:=0
Repeat 
	
	$vl_pos:=Find in array:C230($tt_names; "__attach_version1.0_#@__substg1.0_3707001F"; $vl_pos+1)
	
	If ($vl_pos>0)
		
		$vt_text:=Convert to text:C1012($tx_content{$vl_pos}; "utf-16")
		
		If (Length:C16($vt_attachments)>0)
			$vt_attachments:=$vt_attachments+", "
		End if 
		
		$vt_attachments:=$vt_attachments+$vt_text
		
	End if 
	
	
Until ($vl_pos=-1)

$vp_object:=OBJECT Get pointer:C1124(Object named:K67:5; "vt_attachments")
$vp_object->:=$vt_attachments

