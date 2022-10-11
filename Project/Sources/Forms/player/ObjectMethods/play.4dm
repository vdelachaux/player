var $file : 4D:C1709.File

$file:=File:C1566(Form:C1466.current.platformPath; fk platform path:K87:2)  // Unsandboxing
Form:C1466.player:=4D:C1709.SystemWorker.new("afplay "+$file.path)