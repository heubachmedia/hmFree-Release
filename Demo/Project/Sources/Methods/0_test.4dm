//%attributes = {}

Select document:C905(""; "*"; "Select document"; 0)
If (Test path name:C476(Document)=Is a document:K24:1)
	
	
	$vt_path:=Convert path system to POSIX:C1106(Document)
	
	//$vlPages:=hmFree_PDF Split ($vt_path)
	
	ARRAY REAL:C219($tz_rotation; 0)
	
	$vlPages:=hmFree_PDF Split Rotation($vt_path; $tz_rotation)
	
End if 
