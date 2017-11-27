;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

;#include "FastFind.au3"
#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

$LogFile = "debugtest.log"
;small = 265 / large = 1
$toSmallY = 1
;small = 275 / large 1
$toSmallX = 1

HotKeySet("^{9}", "_Craft")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")

HotKeySet("!{Esc}", "_Terminate")

;click craft btn
Func Craft()

	MouseClick("left", 600, 520, 1, 300)
	Sleep(Random(211,1944,1))

EndFunc

Func _Craft()

	While True

		Sleep(1000)

		If	IsMyMPUpper30() Then
			;Beep(500, 60)
			Sleep(Random(111,344,1))
			Craft()
		EndIf
	WEnd

EndFunc

;==============================================================================================
;======================================== execution ===========================================
;==============================================================================================

;altabaet v okno L2
WinActivate("Lineage")

;ojidatet paru sek poka progruzit
Sleep(Random(1911,2544,1))
StartSound()

While True

	Sleep(1000)
WEnd


