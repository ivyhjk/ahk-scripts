Gui, Add, ListView, x2 y0 w350 h500, Name|PID|Owner

processes := ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")

for process in processes {
    LV_Add("", process.Name, process.processId, process.GetOwner(OWNER, DOMAIN))
}
loop, % LV_GetCount("Column")
    LV_ModifyCol(A_Index, "AutoHdr")
Gui, Show,, Process List
