//%attributes = {}
C_TIME:C306($vu_ref)
C_BLOB:C604($vx_blob)
C_TEXT:C284($vt_text)
C_LONGINT:C283($vl_pos; $vl_pages)

$vu_ref:=Open document:C264(""; Get pathname:K24:6)

If (OK=1)
	
	DOCUMENT TO BLOB:C525(document; $vx_blob)
	
	$vt_text:=Convert to text:C1012($vx_blob; "iso-8859-1")
	$vt_text:=Replace string:C233($vt_text; Char:C90(Carriage return:K15:38); ""; *)
	$vt_text:=Replace string:C233($vt_text; Char:C90(Line feed:K15:40); ""; *)
	$vt_text:=Replace string:C233($vt_text; " "; ""; *)
	
	$vl_pos:=0
	$vl_pages:=0
	
	Repeat 
		$vl_pos:=Position:C15("/Type/Page"; $vt_text; $vl_pos+1)
		If ($vl_pos>0)
			
			If (Substring:C12($vt_text; $vl_pos+10; 1)#"s")  //nicht Pages-Tag
				$vl_pages:=$vl_pages+1
			End if 
			
		End if 
	Until ($vl_pos=0)
	
	ALERT:C41(String:C10($vl_pages))
	
End if 
