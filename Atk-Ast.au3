;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

$LogFile = "debugtest.log"
;small = 265 / large = 1
$toSmallY = 265
;small = 275 / large 1
$toSmallX = 275

global $targetDetected = False
global $pmOneThreatened = False
global $pmOneIsSafe = True

;schetchik prohoda osnovnogo zikla (nashel moba, nachal bit', ubil, schetchik +1)
global $defeatedMobs = 0

global $lastHealTime = 20001
global $healTimer = 0

global $lastAlacrityTime = 1140001
global $AlacrityTimer = 0

global $lastBuffTime = 1080001
global $BuffTimer = 0

HotKeySet("^{9}", "_Attack")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")

HotKeySet("!{Esc}", "_Terminate")

global $isHalt = True


;F1
Func Attack()

	MouseClick("left", 402, (995 - $toSmallY), 2, 300)
	Sleep(Random(211,344,1))

EndFunc


;F6
Func Frenzy()


	MouseClick("left", 580, (995 - $toSmallY), 2, 300)
	Sleep(Random(111,294,1))

EndFunc

;stoyat na meste
Func StopAttack()

	MouseClick("left", 695, (625 - $toSmallY), 2, 200)
	Sleep(Random(111,244,1))

EndFunc

local $moveCount = 0;

Func startALTTABProc()
	Sleep(Random(211,744,1))

	Beep(400, 300)
	Send("{ALTDOWN}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")

   Sleep(Random(1211,1744,1))

EndFunc


Func FrenzyIfICan()

   If IsMyHPDamagedOver30() Then

	  SuccessSound()

	  Frenzy()
	  ALTTAB(1)
	  Sleep(Random(151,244,1))
	  Frenzy()
	  ALTTAB(1)
	  Sleep(Random(151,244,1))
	  Frenzy()

   EndIf

EndFunc


Func exec()

	While True

		Sleep(100)

	WEnd



EndFunc

Func _Attack()

	$isHalt = False

	While $isHalt = False

		TakeAssistFromPMOne()

		If IsTargetExist() Then
		   Beep(600, 50)
		   Beep(500, 50)
		   Beep(700, 50)
		   Attack()
		 Else
			Sleep(Random(151,244,1))
			ContinueLoop
		 EndIf

		While IsTargetExist()
			Sleep(50)
		WEnd

		Sleep(Random(251,444,1))

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
Sleep(Random(111,344,1))

exec()


