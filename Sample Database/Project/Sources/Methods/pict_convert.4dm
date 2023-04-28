//%attributes = {}
C_PICTURE:C286($vb_pict)
C_LONGINT:C283($vl_param1; $vl_param2)

READ PICTURE FILE:C678("Macintosh HD:4D:C-Entwicklung:XCode_hmFree:3_0:Fort-Wayne-Childrens-Zoo-Sumatran-Tiger-300-dpi.jpg"; $vb_pict)
CONVERT PICTURE:C1002($vb_pict; ".jpg")

$vl_param1:=0
$vl_param2:=0

hmFree_GET PICTURE PROPERTIES($vb_pict; 1; $vl_param1; $vl_param2)

ARRAY TEXT:C222($tt_types; 0)
hmFree_GET PICTURE TYPES($vb_pict; $tt_types)

hmFree_SET PICTURE PROPERTIES($vb_pict; 1; 200; 200)

WRITE PICTURE FILE:C680("Macintosh HD:4D:C-Entwicklung:XCode_hmFree:3_0:Testdata:Test.jpg"; $vb_pict)
