SetMouseDelay, -1
SetKeyDelay, -1, -1

meteor = 3
amplify = t
stormGust = e
delay = 20
waitForStormGust = 3000
stopKey = F1

Hotkey, $%meteor%, Main
Hotkey, %stopKey%, Stop
Return

Main:
  StartTime := A_TickCount

  Loop {
    if GetKeyState(meteor, "P") == 0 {
      break
    }

    Send, %meteor%
    Sleep, %delay%
    MouseClick, Left
  } Until A_TickCount - StartTime >= waitForStormGust

  if GetKeyState(meteor, "P") == 1 {
    ; wait
    Sleep, 400
    ; send amplify
    Send, %amplify%
    ; wait until amplify is ready
    Sleep, 2000

    ; send storm gust
    if GetKeyState(meteor, "P") == 1 {
      Send, %stormGust%
      Sleep, %delay%
      MouseClick, Left
    }
  }
Return

Stop:
  Suspend, Toggle
Return
