#RequireAdmin
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

global $stunChance = 0

global $firstSWChanged = False
global $secondSWChanged = False

global $lastBuffTime = 750001
global $BuffTimer = 0

;start: 1, fight:1
global $spolier = 0
;start: 1, fight: 2
global $warc = 0
;start: 2, fight:1
global $healer = 0

global $safePartyDismiss = 0
global $safePDTimer = 0

HotKeySet("^{9}", "_SpoilAndDance")
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

	MouseClick("left", 434, (995 - $toSmallY), 2, 300)
	Sleep(Random(211, 394,1))

	;usaet alacrity pot every 19 min
	;NeedSomeAlacrity()
	;

	While IsTargetExist()

	   If isTargetNotMe() Then
		  ClearTarget()
	  EndIf


		HealMeIfYouCan()
		DanceAndSong()


		;esli u PMTwo HP ne max to proveriaem target s nego
		If IsPMTwoAttacked() Then

			;proveriaem ne sagrilsia li mob na party member one
			TakeAssistFromPMTwo()
			If IsTargetExist() Then
				$targetDetected = True
				MouseClick("left", 434, (995 - $toSmallY), 2, 300)
			EndIf
		EndIf

		HealMeIfYouCan()

		CalculateStunChance()
		;stun F5
		If Random($stunChance, 100) > 99 Then
			MouseClick("left", 555, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop
		EndIf

		;spoil F2
		If Random(1, 100) > 96 Then
			MouseClick("left", 434, (995 - $toSmallY), 2, 300)
			Sleep(Random(550,995,1))
			ContinueLoop;
		Else
			;attack F1
			MouseClick("left", 392, (995 - $toSmallY), 2, 300)
			Sleep(Random(750,1295,1))
			ContinueLoop;
		EndIf

		Sleep(Random(250,495,1))

	WEnd

	Sweep()

EndFunc

Func MakeDS()

	;F7

	MouseClick("left", 620, (995 - $toSmallY), 2, 300)
	Sleep(Random(311,494,1))

EndFunc

local $moveCount = 0;

Func SelectTarget()

	$isHalt = False

	While $isHalt = False

		TakeAssistFromPMOne()
		DanceAndSong()

		If IsTargetExist() Then
		   Beep(600, 50)
		   Beep(500, 50)
		   Beep(700, 50)
		   DanceAndSong()
		   AttackF1()
		 Else
			Sleep(Random(151,244,1))
			DanceAndSong()
			ContinueLoop
		 EndIf

		While IsTargetExist()
			Sleep(200)
			TakeAssistFromPMOne()
			DanceAndSong()
		WEnd

		Sleep(Random(251,444,1))

	WEnd


EndFunc


Func SelectTargetLegacy()

	HealMeIfYouCan()
	DanceAndSong()

	If IsPMTwoAttacked() Then

		;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMTwo()
		If IsTargetExist() Then
			$targetDetected = True
			Attack()
			Return
		EndIf
	EndIf

	;
	Sleep(Random(90,120,1))
	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
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

	;tut idet proverka ne napal li agro-mob i ne vzialsia li target avtomatom
	If IsTargetExist() Then
		$targetDetected = True
		Attack()
		Return
	EndIf

	;proveriaem ne sagrilsia li mob na party member one
		TakeAssistFromPMOne()
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

		 Sleep(550)


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


Func startALTTABProc()
	Sleep(Random(211,744,1))

	Beep(400, 400)
	Send("{ALTDOWN}")
	Sleep(Random(211,344,1))
	Send("{TAB}")
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
	Send("{TAB}")
	Sleep(Random(211,344,1))
	Send("{ALTUP}")
	Sleep(Random(211,344,1))


EndFunc

Func DanceAndSong()

local $index = 2

	If	$lastBuffTime > 123000 Then

		$BuffTimer = TimerInit()

		ALTTAB($index)
		Sleep(1000)

		MakeDS()

		ALTTAB($index)
		Sleep(1000)

		MakeDS()

		ALTTAB($index)

	EndIf

	$lastBuffTime = TimerDiff($BuffTimer)

EndFunc

Func _SpoilAndDance()
   $lastBuffTime = 750001

	SuccessSound()

;script budet ispolniatsa poka kolvo prohodov zika budet menshe
While $defeatedMobs < 9164

	;poka net targeta probuet vziat target raznimi sposobami
	;kogda moba ubiet, target spadet i ispolnenie poydet dalshe k Sweep
	While $targetDetected = False

		SelectTarget()

	WEnd

	;Sweep()

	;MoveToPartymemberOne()

	;PickUp()
	;PickUp()
	;PickUp()
	;PickUp()

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

	Sleep(100)

WEnd

