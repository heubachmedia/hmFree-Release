//%attributes = {}
//create a blank book with n sheets
$numberOfSheets:=3
$wb:=xls_Create($numberOfSheets)  //min=1, max=10

$sheet:=1
$row:=1
$col:=1
$width:=240*20  //in twips (20th of a point)

$alignment:=XLS H Align General
$rotation:=0
$properties:=XLS Text Default
$top:=XLS Border None
$topColor:=XLS Color Red
$left:=XLS Border None
$leftColor:=XLS Color Red
$right:=XLS Border None
$rightColor:=XLS Color Red
$bottom:=XLS Border None
$bottomColor:=XLS Color Red
$pattern:=XLS Pattern Solid
$patternColor:=XLS Color Red
$patternAltColor:=XLS Color Yellow

xls_SET FORMAT PROPERTY($wb; $sheet; 2; 2; \
$alignment; $rotation; $properties; \
$top; $topColor; \
$left; $leftColor; \
$right; $rightColor; \
$bottom; $bottomColor; \
$pattern; $patternColor; $patternAltColor)

$vt_name:=""
$vl_error:=xls_Get sheet name($wb; $sheet; $vt_name)

xls_Set Real Value($wb; $sheet; 3; 2; 1234.5678)

$vl_error:=xls_Set Text Value($wb; $sheet; 2; 2; "TEST")

$valueType1:=xls_Get Value Type($wb; $sheet; 2; 2)
$rowText1:=xls_Get Text Value($wb; $sheet; 2; 2)

$success:=xls_Set Format String($wb; $sheet; 2; 2; "\"$\"#,##0_);(\"$\"#,##0)")
$success:=xls_Get Format String($wb; $sheet; 2; 2; $format)

$filePath:=System folder:C487(Desktop:K41:16)+"teÄst.xls"
$filePath:=Convert path system to POSIX:C1106($filePath)
$success:=xls_Save as($wb; $filePath)

xls_CLOSE($wb)
