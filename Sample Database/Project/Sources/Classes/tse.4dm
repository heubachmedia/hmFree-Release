Class constructor($vl_method : Integer; $vt_portID : Text; $vt_tseID : Text)
	
	//0=Using ESC/POS protocol via Serial connection
	//1=Using ESC/POS protocol via Socket (TCP) connection
	//2=Using ePOS-Device XML via Socket (TCP) connection
	This:C1470.method:=$vl_method
	
	This:C1470.portID:=$vt_portID
	This:C1470.tseID:=$vt_tseID
	This:C1470.statusInternal:=Null:C1517
	This:C1470.lastError:=0
	This:C1470.lastErrorText:=0
	This:C1470.beginTransactionLogTime:=0
	This:C1470.endTransactionLogTime:=0
	
Function handleError() : Boolean
	
	If (This:C1470.statusInternal.error=0)
		This:C1470.lastError:=0
		This:C1470.lastErrorText:=""
	Else 
		
		This:C1470.lastError:=This:C1470.statusInternal.error
		This:C1470.lastErrorText:=This:C1470.statusInternal.errorText
		
		This:C1470.statusInternal.error:=0  //clear
		This:C1470.statusInternal.errorText:=""  //clear
	End if 
	
	$0:=(This:C1470.lastError=0)
	
Function getLastError() : Integer
	$0:=This:C1470.lastError
	
Function getLastErrorText() : Text
	$0:=This:C1470.lastErrorText
	
Function connect() : Boolean
	
	This:C1470.statusInternal:=TSE_Connect(This:C1470.method; This:C1470.portID; This:C1470.tseID)
	
	$0:=This:C1470.handleError()
	
Function disconnect() : Boolean
	
	TSE_DISCONNECT(This:C1470.statusInternal)
	
	$0:=This:C1470.handleError()
	
Function openDevice() : Boolean
	
	TSE_OPEN DEVICE(This:C1470.statusInternal)
	
	$0:=This:C1470.handleError()
	
Function closeDevice() : Boolean
	
	TSE_CLOSE DEVICE(This:C1470.statusInternal)
	
	$0:=This:C1470.handleError()
	
	//Admin-PIN: 5-stellig
	//Client-PIN: 5-stellig
	//PUK: 6-stellig
	//Kann nur 1 mal aufgerufen werden
Function setup($vt_adminPIN : Text; $vt_clientPIN : Text; $vt_PUK : Text) : Boolean
	
	TSE_SETUP(This:C1470.statusInternal; $vt_adminPIN; $vt_clientPIN; $vt_PUK)
	
	$0:=This:C1470.handleError()
	
Function authenticateUser($vt_userID : Text; $vt_password : Text; $vt_secretKey : Text) : Boolean
	var $vl_logInLeft : Integer
	
	$vl_logInLeft:=TSE_Authenticate User(This:C1470.statusInternal; $vt_userID; $vt_password; $vt_secretKey)
	$0:=This:C1470.handleError()
	
Function logout($vt_userID : Text) : Boolean
	TSE_LOGOUT(This:C1470.statusInternal; $vt_userID)
	$0:=This:C1470.handleError()
	
Function getRegisteredClients()->$vc_clients : Collection
	
	$vc_clients:=TSE_Get Registered Clients(This:C1470.statusInternal)
	This:C1470.handleError()
	
Function getRAWStorageInfo($vo_file : 4D:C1709.File) : Boolean
	var $vt_rawInfo : Text
	
	$vt_rawInfo:=TSE_Get RAW Storage Info(This:C1470.statusInternal)
	
	$vo_file.setText($vt_rawInfo; "utf-8")
	
	$0:=This:C1470.handleError()
	
Function getStartedTransactions($vt_clientID : Text)->$vc_startedTransactions : Collection
	$vc_startedTransactions:=TSE_Get Started Transactions(This:C1470.statusInternal; $vt_clientID)
	This:C1470.handleError()
	
Function registerClient($vt_clientID : Text) : Boolean
	TSE_REGISTER CLIENT(This:C1470.statusInternal; $vt_clientID)
	$0:=This:C1470.handleError()
	
Function deregisterClient($vt_clientID : Text) : Boolean
	TSE_DEREGISTER CLIENT(This:C1470.statusInternal; $vt_clientID)
	$0:=This:C1470.handleError()
	
Function startTransaction($vt_clientID : Text; $vt_processData : Text; $vt_processType : Text)->$vf_ok : Boolean
	
	TSE_START TRANSACTION(This:C1470.statusInternal; $vt_clientID; $vt_processData; $vt_processType; "")
	
	$vf_ok:=This:C1470.handleError()
	
	If ($vf_ok)
		
		If (This:C1470.statusInternal.transaction.logTime#Null:C1517)
			
			This:C1470.beginTransactionLogTime:=This:C1470.statusInternal.transaction.logTime
			
		End if 
		
	End if 
	
Function updateTransaction($vt_clientID : Text; $vl_transactionID : Integer; $vt_processData : Text; $vt_processType : Text) : Boolean
	
	TSE_UPDATE TRANSACTION(This:C1470.statusInternal; $vt_clientID; $vl_transactionID; $vt_processData; $vt_processType)
	
	$0:=This:C1470.handleError()
	
Function finishTransaction($vt_clientID : Text; $vl_transactionID : Integer; $vt_processData : Text; $vt_processType : Text)->$vo_transaction : cs:C1710.tseTransaction
	var $vo_transactionInternal : Object
	
	TSE_FINISH TRANSACTION(This:C1470.statusInternal; $vt_clientID; $vl_transactionID; $vt_processData; $vt_processType; "")
	This:C1470.handleError()
	
	If (This:C1470.lastError=0)
		
		If (This:C1470.statusInternal.transaction#Null:C1517)
			
			$vo_transactionInternal:=This:C1470.statusInternal.transaction
			
			$vo_transaction:=cs:C1710.tseTransaction.new($vo_transactionInternal.transactionNumber; $vt_clientID)
			$vo_transaction.logTime:=$vo_transactionInternal.logTime
			$vo_transaction.signatureCounter:=$vo_transactionInternal.signatureCounter
			$vo_transaction.signatureValue:=$vo_transactionInternal.signatureValue
			This:C1470.endTransactionLogTime:=$vo_transactionInternal.logTime
			
		End if 
		
	End if 
	
	//role: Only "Admin" or "TimeAdmin" are valid.
Function getAuthenticatedUserList($vt_role : Text)->$vc_list : Collection
	
	$vc_list:=TSE_Get Authenticated User List(This:C1470.statusInternal; $vt_role)
	
	This:C1470.handleError()
	
Function updateDateTime($vt_userID : Text; $vf_updateForFirstTime : Boolean) : Boolean
	var $vl_Days; $vl_Seconds; $vl_UnixDate : Integer
	
	$vl_Days:=Current date:C33-!1970-01-01!
	$vl_Seconds:=Current time:C178-0
	$vl_UnixDate:=($vl_Days*86400)+$vl_Seconds
	
	TSE_UPDATE TIME(This:C1470.statusInternal; $vt_userID; $vl_UnixDate; Num:C11($vf_updateForFirstTime))
	
	$0:=This:C1470.handleError()
	
Function getLastTransaction($vt_clientID : Text)->$vo_transaction : cs:C1710.tseTransaction
	var $vo_transactionInternal : Object
	
	$vo_transactionInternal:=TSE_Get Last Transaction(This:C1470.statusInternal; $vt_clientID)
	This:C1470.handleError()
	
	If (This:C1470.lastError=0) & ($vo_transactionInternal#Null:C1517)
		
		$vo_transaction:=cs:C1710.tseTransaction.new($vo_transactionInternal.transactionNumber; $vo_transactionInternal.clientID)
		$vo_transaction.logTime:=This:C1470.endTransactionLogTime
		$vo_transaction.signatureCounter:=$vo_transactionInternal.signatureCounter
		$vo_transaction.serialNumber:=$vo_transactionInternal.serialNumber
		$vo_transaction.signatureValue:=$vo_transactionInternal.signatureValue
		$vo_transaction.startLogTime:=This:C1470.beginTransactionLogTime
		
	End if 
	
Function exportData()->$vx_export : Blob
	
	SET BLOB SIZE:C606($vx_export; 0)
	
	TSE_EXPORT DATA(This:C1470.statusInternal; $vx_export)
	This:C1470.handleError()
	
Function runSelfTest()
	
	TSE_RUN SELF TEST(This:C1470.statusInternal)
	This:C1470.handleError()
	
Function needToRunSelfTest($vt_clientID : Text)->$vf_needsRetry : Boolean
	var $vf_authUser : Boolean
	
	$vf_needsRetry:=False:C215
	
	If (This:C1470.lastError=-3038)
		
		This:C1470.runSelfTest()
		
		If (This:C1470.lastError=0)
			
			This:C1470.updateDateTime($vt_clientID; True:C214)
			
			$vf_needsRetry:=True:C214
			
		End if 
		
	End if 
	
	If (This:C1470.lastError=-2006) & (Length:C16($vt_clientID)>0)  //A request was received from an unauthenticated (not logged-in) user with TimeAdmin privileges.
		
		$vf_authUser:=This:C1470.authenticateUser($vt_clientID; "12345"; "EPSONKEY")
		
		If (Not:C34($vf_authUser)) & (This:C1470.lastError=-3038)
			If (This:C1470.needToRunSelfTest($vt_clientID))
				$vf_authUser:=This:C1470.authenticateUser($vt_clientID; "12345"; "EPSONKEY")
			End if 
		End if 
		
		If ($vf_authUser)
			This:C1470.updateDateTime($vt_clientID; True:C214)
			Storage:C1525.tse.currentUser:=$vt_clientID
			$vf_needsRetry:=True:C214
		End if 
		
	End if 
	