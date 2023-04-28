//%attributes = {}
var $vo_tse : cs:C1710.tse
var $vx_export : Blob
var $vt_folder : Text
var $vo_folder : 4D:C1709.Folder

$vt_folder:=Select folder:C670("Ordner auswählen")

If (OK=1)
	
	$vo_folder:=Folder:C1567($vt_folder; fk platform path:K87:2)
	
	$vo_tse:=cs:C1710.tse.new(2; "127.0.0.1"; "local_TSE")
	
	If ($vo_tse.connect())
		
		If ($vo_tse.openDevice())
			
			If ($vo_tse.authenticateUser("Administrator"; "12345"; "EPSONKEY"))
				
				$vo_tse.updateDateTime("Administrator"; False:C215)
				$vx_export:=$vo_tse.exportData()
				
				If ($vo_tse.lastError=0) & (BLOB size:C605($vx_export)>0)
					
					$vo_folder.file("export.tar").setContent($vx_export)
					
				End if 
				
			End if 
			
			$vo_tse.closeDevice()
			
		End if 
		
		$vo_tse.disconnect()
		
	End if 
	
End if 
