SetMouseDelay, -1
SetKeyDelay, -1, -1

fKeys := ["F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"]
numberKeys := ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
firstRowLetterKeys := ["Q", "W", "E", "R", "T", "Y", "U", "I", "O"]
secondRowLetterKeys := ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
thirdRowLetterKeys := ["Z", "X", "C", "V", "B", "N", "M", ",", "."]
startX := 16
startY := 15
isActive := False

getControlVariableName(variableName) {
  postFix := "Activated"

  If (variableName == ",") {
    Return "comma" postFix
  } Else if (variableName == ".") {
    Return "dot" postFix
  }

  Return variableName postFix
}

; display the GUI
Gui, New

; print Fx keys
fsCurrentX := startX
fsCurrentY := startY

for index, keyName in fKeys {
  controlVariableName := getControlVariableName(keyName)

  Gui, Add, Checkbox, x%fsCurrentX% y%fsCurrentY% v%controlVariableName%, %keyName%

  fsCurrentX := fsCurrentX + 40
}

; Print number keys
numbersCurrentX := startX
numbersCurrentY := fsCurrentY + 30

for index, keyName in numberKeys {
  controlVariableName := getControlVariableName(keyName)

  Gui, Add, Checkbox, x%numbersCurrentX% y%numbersCurrentY% v%controlVariableName%, %keyName%

  numbersCurrentX := numbersCurrentX + 40
}

; Print first row letter keys
firstRowLettersCurrentX := startX
firstRowLettersCurrentY := numbersCurrentY + 30

for index, keyName in firstRowLetterKeys {
  controlVariableName := getControlVariableName(keyName)

  Gui, Add, Checkbox, x%firstRowLettersCurrentX% y%firstRowLettersCurrentY% v%controlVariableName%, %keyName%

  firstRowLettersCurrentX := firstRowLettersCurrentX + 40
}

; Print second row letter keys
secondRowLettersCurrentX := startX
secondRowLettersCurrentY := firstRowLettersCurrentY + 30

for index, keyName in secondRowLetterKeys {
  controlVariableName := getControlVariableName(keyName)

  Gui, Add, Checkbox, x%secondRowLettersCurrentX% y%secondRowLettersCurrentY% v%controlVariableName%, %keyName%

  secondRowLettersCurrentX := secondRowLettersCurrentX + 40
}

; Print third row letter keys
thirdRowLettersCurrentX := startX
thirdRowLettersCurrentY := secondRowLettersCurrentY + 30

for index, keyName in thirdRowLetterKeys {
  variableName := keyName

  if (variableName == ",") {
    variableName := "comma"
  } else if (variableName == ".") {
    variableName := "dot"
  }

  Gui, Add, Checkbox, x%thirdRowLettersCurrentX% y%thirdRowLettersCurrentY% v%variableName%Activated, %keyName%

  thirdRowLettersCurrentX := thirdRowLettersCurrentX + 40
}

; Print the button
activateButtonCurrentY := firstRowLettersCurrentY - 3
activateButtonText := "Activate"

Gui, Add, Button, x%firstRowLettersCurrentX% y%activateButtonCurrentY% vActivateButton, Activate

; Display the GUI
Gui, Show, , AHK Spammer
Return

activateKeySpam(keyName) {
  global isActive

  if (isActive) {
    Send, %keyName%
    Sleep, 20
    MouseClick, Left
  }
}

disableKeys(params*) {
  for index, keys in params {
    for index, keyName in keys {
      variableName := getControlVariableName(keyName)

      GuiControl, Disable, %variableName%

      ; run scripts by each checked key
      if (%variableName%) {
        boundFn := Func("activateKeySpam").Bind(keyName)

        Hotkey, $%keyName%, % boundFn
      }
    }
  }
}

enableKeys(params*) {
  for index, keys in params {
    for index, keyName in keys {
      GuiControl, Enable, % getControlVariableName(keyName)

      ; disable key
      if (%variableName%) {
        Hotkey, $%variableName%, Off
      }
    }
  }
}

ButtonActivate:
  Gui, Submit, NoHide

  isActive := !isActive

  GuiControl, , ActivateButton, % isActive ? "Deactivate" : "Activate"

  if (isActive) {
    disableKeys(fKeys, numberKeys, firstRowLetterKeys, secondRowLetterKeys, thirdRowLetterKeys)
  } else {
    enableKeys(fKeys, numberKeys, firstRowLetterKeys, secondRowLetterKeys, thirdRowLetterKeys)
  }
Return
