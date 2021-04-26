//%attributes = {}
C_TEXT:C284($vt_path)
C_BLOB:C604($vx_blob)
C_TEXT:C284($vt_output)
C_LONGINT:C283($vl_error)

$vt_path:="Macintosh HD:4D:C-Entwicklung:XCode_hmFree:4_0:Testdata:Documentation_hmFree.pdf"

SET BLOB SIZE:C606($vx_blob; 0)

DOCUMENT TO BLOB:C525($vt_path; $vx_blob)

$vt_output:=""
$vl_error:=hmFree_Extract Text From PDF($vx_blob; $vt_output)

SET TEXT TO PASTEBOARD:C523($vt_output)
BEEP:C151
