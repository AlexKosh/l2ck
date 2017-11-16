;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

;#include "FastFind.au3"
#include "l2ck.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

SRandom(@MSEC)
Local const $LogFile = "debugtest.log"
;small = 265 / large = 1
$toSmallY = 1
;small = 275 / large 1
$toSmallX = 1

HotKeySet("{F11}", "_Craft")
HotKeySet("{F10}", "_Halt")
HotKeySet("{F9}", "_FollowMe")

HotKeySet("!{Esc}", "_Terminate")

Func IsMyMPUpper30()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 120
    const $PosY = 70

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x005DB8, 10)

    const $MaxX = 160
    const $MinX = 25
    const $MaxY = 100

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY then
            LogWrite("IsTargetExist() - Success, coords = " & $coords[0] & _
                     ", " & $coords[1] & " pixels = " & $coords[2])
					 ;SuccessSound()
            return True
        else
            LogWrite("IsTargetExist() - Fail #1")
			;ErrorSound()
            return False
        endif
    else
        LogWrite("IsTargetExist() - Fail #2")
		;ErrorSound()
        return False
    endif
endfunc

;click craft btn
Func Craft()

	MouseClick("left", 1156, (675 - $toSmallY), 1, 300)
	Sleep(Random(211,1944,1))

EndFunc

Func _Craft()

	While True

		Sleep(1000)

		If	IsMyMPUpper30() Then
			Beep(500, 60)
			Sleep(Random(111,344,1))
			Craft()
		EndIf
	WEnd

EndFunc

func LogWrite($data)
    FileWrite($LogFile, $data & chr(10))
endfunc

Func _Halt()

	$isHalt = True

	Beep(600, 50)
	Beep(500, 50)

	While $isHalt = True

		Sleep(Random(251,444,1))

	WEnd

EndFunc

Func _FollowMe()

   SuccessSound()
   MoveToPartymemberOne()

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
;startALTTABProc()

While True

	Sleep(1000)

WEnd


SuccessSound()
;SuccessSound()
;SuccessSound()

