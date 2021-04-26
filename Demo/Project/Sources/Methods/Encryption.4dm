//%attributes = {}
C_BLOB:C604($vx_key; $vx_input; $vx_output_encrypted; $vx_output_decrypted; $vx_password; $vx_salt)
C_LONGINT:C283($vl_status; $vl_rounds)

//Create key

SET BLOB SIZE:C606($vx_password; 0)
CONVERT FROM TEXT:C1011("myPassword"; "utf-8"; $vx_password)

SET BLOB SIZE:C606($vx_salt; 0)
CONVERT FROM TEXT:C1011("mySalt"; "utf-8"; $vx_salt)

SET BLOB SIZE:C606($vx_key; 32)

$vl_rounds:=30000

$vl_status:=hmFree_DerivationKey(2; $vx_password; $vx_salt; 3; $vl_rounds; $vx_key)

//Encrypt

SET BLOB SIZE:C606($vx_input; 0)
CONVERT FROM TEXT:C1011("Testtext"*100; "utf-8"; $vx_input)

SET BLOB SIZE:C606($vx_output_encrypted; 0)

$vl_status:=hmFree_Encrypt(hmFree_algorithm_AES; $vx_key; $vx_input; $vx_output_encrypted)

//Decrypt

SET BLOB SIZE:C606($vx_output_decrypted; 0)
$vl_status:=hmFree_Decrypt(hmFree_algorithm_AES; $vx_key; $vx_output_encrypted; $vx_output_decrypted)
