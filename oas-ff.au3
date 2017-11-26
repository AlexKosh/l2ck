;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

$LogFile = "debugtest.log"
;small = 265 / large = 1
$toSmallY = 1
;small = 275 / large 1
$toSmallX = 1

global $targetDetected = False
global $pmOneThreatened = False
global $pmOneIsSafe = True

;schetchik prohoda osnovnogo zikla (nashel moba, nachal bit', ubil, schetchik +1)
global $defeatedMobs = 0

global $lastHealTime = 20001
global $healTimer = 0


global $stunChance = 0

global $firstSWChanged = False
global $secondSWChanged = False

global $lastBuffTime = 1080001
global $BuffTimer = 0

global $lastEEHealTime = 30001
global $healEETimer = 0

global $safePartyDismiss = 0
global $safePDTimer = 0

global $lastWCHealTime = 30001
global $healWCTimer = 0


HotKeySet("^{9}", "_SeekAndDestroy")
HotKeySet("^{0}", "_Halt")
HotKeySet("^{8}", "_FollowMe")
HotKeySet("!{Esc}", "_Terminate")


Func CalculateStunChance()

	$stunChance = 0
	;1 k 30 chance
	If IsMyMPUpper30() Then

		$stunChance = 70

	EndIf
	;1 k 3
	If IsMyHPDamagedOver60() Then

		$stunChance = 98

	EndIf

EndFunc

Func Attack()

   ;F2
   MouseClick("left", 434, (995 - $toSmallY), 2, 300)
   Sleep(Random(211, 394,1))


	While IsTargetExist()

		If isTargetNotMe() Then
			ClearTarget()
		EndIf


		HealMeIfYouCan()
		HealAndBuffUsWarcIfYouCan()
		;ChangeShadowWeapon()

		;BD
		;esli u PMFive HP ne max to proveriaem target s nego
		If IsPMFiveAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMFive()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;SVS
		;esli u PMFour HP ne max to proveriaem target s nego
		If IsPMFourAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMFour()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;Heal
		;esli u PMOne HP ne max to proveriaem target s nego
		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;Warc
		;esli u PMTwo HP ne max to proveriaem target s nego
		If IsPMTwoAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMTwo()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 392, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf
		;CJ
		;esli u PMThree HP ne max to proveriaem target s nego
		If IsPMThreeAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMThree()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 150)
				HealAndBuffUsWarcIfYouCan()
				Sleep(Random(550,995,1))
				ContinueLoop
			EndIf
		EndIf


		CalculateStunChance()
		;stun F5
		If Random($stunChance, 100) > 99 Then
			MouseClick("left", 555, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop
		EndIf

		;spoil F2
		If Random(1, 100) > 94 Then
			MouseClick("left", 434, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop;
		Else
			;attack F1
			MouseClick("left", 392, (995 - $toSmallY), 2, 300)
			Sleep(Random(750,1295,1))
			ContinueLoop;
		EndIf


		HealMeIfYouCan()
		HealAndBuffUsWarcIfYouCan()
		Sleep(Random(250,495,1))


	WEnd

	;Sweep()

EndFunc

local $moveCount = 0;

Func SelectTarget()

	HealMeIfYouCan()
	HealAndBuffUsWarcIfYouCan()

	;ChangeShadowWeapon()
	Sleep(Random(90,120,1))

	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	;esli u PMOne HP ne max to proveriaem target s nego
	;inache proveriaem target na sebe, potom nextTarget()

	If IsPMOneAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMOne()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf


	;proveriaet vzialsia li target po /targetnext
	TargetNext()
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	MakeCameraVerticalAgain()

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))


	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveRightUp()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf


		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveRightDown()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf


		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveLeftDown()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf


		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd

	;dvigaemsiav centr k warc i berem targetNext() ========================
	MoveToPartymemberOne()
	Sleep(Random(1111,1544,1))

	local $moveFwdCount = 0

	While $moveFwdCount < 2

		MoveLeftUp()
		Sleep(Random(911,1544,1))

		;esli u PMOne HP ne max to proveriaem target s nego
		;inache proveriaem target na sebe, potom nextTarget()

		If IsPMOneAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMOne()
			If IsTargetExist() Then
				$targetDetected = True
				Attack()
				Return
			EndIf
		EndIf

		;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMThreeAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMThree()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMTwo HP ne max to proveriaem target s nego
	If IsPMFourAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFour()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;esli u PMFour HP ne max to proveriaem target s nego
	If IsPMFiveAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMFive()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

		;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf


		;proveriaet vzialsia li target po /targetnext
		TargetNext()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf

		$moveFwdCount += 1
		Sleep(Random(611,844,1))

	WEnd



EndFunc

;use healing pot
Func HealMeIfYouCan()

	If	IsMyHPDamagedOver60() and $lastHealTime > 10000 Then

		$healTimer = TimerInit()

		MouseClick("left", 510, (995 - $toSmallY), 2, 200)
		Sleep(Random(111,244,1))

	EndIf

	$lastHealTime = TimerDiff($healTimer)


EndFunc

Func Heal()
	;F9
	MouseClick("left", 707, (995 - $toSmallY), 2, 200)
	Sleep(Random(211,444,1))

EndFunc


Func HealAndBuffUsWarcIfYouCan()

	If	(($lastWCHealTime > 14000 And $lastBuffTime > 13900) And (IsMyHPDamagedOver80() Or IsPMOneAttacked())) Or $lastBuffTime > 960000 Then

		ALTTAB(1)

		BuffOrHeal()

		ALTTAB(1)

	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)
	$lastWCHealTime = TimerDiff($healWCTimer)

EndFunc


Func BuffOrHeal()

	If	($lastWCHealTime > 14000 And $lastBuffTime > 16000) And (IsMyHPDamagedOver80() or IsPMOneAttacked()) Then

		$healWCTimer = TimerInit()
		Sleep(Random(111,244,1))

		;F9
		Heal()

	EndIf

	$lastWCHealTime = TimerDiff($healWCTimer)

	If	$lastBuffTime > 960000 Then

		$BuffTimer = TimerInit()

		;press F7 on second panels
		MouseClick("left", 625, (940 - $toSmallY), 2, 200)
		Sleep(Random(211,344,1))

	EndIf

	Sleep(Random(211,344,1))
	$lastBuffTime = TimerDiff($BuffTimer)

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

Func _SeekAndDestroy()

;script budet ispolniatsa poka kolvo prohodov zika budet menshe
While True

	;poka net targeta probuet vziat target raznimi sposobami
	;kogda moba ubiet, target spadet i ispolnenie poydet dalshe k Sweep
	While $targetDetected = False

		SelectTarget()

	WEnd

	$targetDetected = False

	$defeatedMobs += 1

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
startALTTABProc()

While True

	sleep(1000)

WEnd
