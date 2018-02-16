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
$toSmallY = 265
;small = 275 / large 1
$toSmallX = 275

HotKeySet("^{9}", "_Attack")
HotKeySet("^{0}", "_HaltPrep")
HotKeySet("^{8}", "_FollowMe")
HotKeySet("^{7}", "_PrepToDestr")
HotKeySet("!{Esc}", "_Terminate")
HotKeySet("^{1}", "_PrepareFirst")
HotKeySet("^{2}", "_PrepareSecond")
HotKeySet("^{3}", "_PrepareThird")

Local $isSSDOff = False


;stoyat na meste
Func StopAttack()

	MouseClick("left", 695, (625 - $toSmallY), 2, 200)
	Sleep(Random(111,244,1))

EndFunc

Func startALTTABProc()
	Sleep(Random(211,744,1))

	Beep(400, 400)
	Send("{ALTDOWN}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")

	 Sleep(Random(2211,2744,1))

	 Beep(400, 400)
	Send("{ALTDOWN}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")

	 Sleep(Random(2211,2744,1))

EndFunc

Func _Attack()

	$isHalt = False

	While $isHalt = False

		TakeAssistFromPMOne()

		If IsTargetExist() Then
		   Beep(600, 50)
		   Beep(500, 50)
		   Beep(700, 50)
			AttackF1()
		 Else
			Sleep(Random(151,244,1))
			ContinueLoop
		 EndIf

		While IsTargetExist()
			Sleep(500)
			TakeAssistFromPMOne()
		WEnd

		Sleep(Random(251,444,1))
	WEnd

EndFunc

Func _PrepToDestr()

	$isHalt = False

	While $isHalt = False

	TargetOnPMTwo()

	While IsPMTwoHPBelow30() = False

		If	IsPMTwoHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf


		Sleep(Random(311,544,1))

		Beep(700, 40)

		AttackForce()
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))
	ToggleSSD()
	$isSSDOff = False

	TargetOnPMThree()

	While IsPMThreeHPBelow30() = False

		If	IsPMThreeHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf

		Sleep(Random(511,844,1))

		Beep(700, 40)

		AttackForce()
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))
	ToggleSSD()
	$isSSDOff = False

	TargetOnPMFour()

	While IsPMFourHPBelow30() = False

		If	IsPMFourHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf

		Sleep(Random(511,844,1))

		Beep(700, 40)

		AttackForce()
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))

	ToggleSSD()
	$isSSDOff = False

	WEnd

EndFunc

;destr1 = pm2
Func _PrepareFirst()

	TargetOnPMTwo()

	If	IsPMTwoHPBelow30() = False Then
		AttackForce()
	EndIf

	While IsPMTwoHPBelow30() = False

		If	IsPMTwoHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf


		Sleep(Random(311,544,1))

		Beep(700, 40)
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))

	If $isSSDOff = True Then
		ToggleSSD()
		$isSSDOff = False
	EndIf

	StartSound()
	SuccessSound()

EndFunc
;destr2 = pm3
Func _PrepareSecond()

	TargetOnPMThree()

	If	IsPMThreeHPBelow30() = False Then
		AttackForce()
	EndIf

	While IsPMThreeHPBelow30() = False

		If	IsPMThreeHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf


		Sleep(Random(311,544,1))

		Beep(700, 40)
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))

	If $isSSDOff = True Then
		ToggleSSD()
		$isSSDOff = False
	EndIf

	StartSound()
	SuccessSound()

EndFunc
;destr3 = pm4
Func _PrepareThird()

	TargetOnPMFour()

	If	IsPMFourHPBelow30() = False Then
		AttackForce()
	EndIf

	While IsPMFourHPBelow30() = False

		If	IsPMFourHPBelow40() And $isSSDOff = False Then
			$isSSDOff = True
			ToggleSSD()
		EndIf


		Sleep(Random(311,544,1))

		Beep(700, 40)
	WEnd

	StopAttack()
	Sleep(Random(511,844,1))

	If $isSSDOff = True Then
		ToggleSSD()
		$isSSDOff = False
	EndIf

	StartSound()
	SuccessSound()

EndFunc

Func _HaltPrep()

	$isHalt = True

	Beep(600, 50)
	Beep(500, 50)

	StopAttack()

	If $isSSDOff = True Then
		$isSSDOff = False
		ToggleSSD()
	EndIf

	While $isHalt = True

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

While True

	Sleep(1000)
	Alert()

WEnd


