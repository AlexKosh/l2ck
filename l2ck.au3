;==============================================================================================
;======================================== declaration =========================================
;==============================================================================================

#include "FastFind.au3"
#include <Date.au3>
#include <MsgBoxConstants.au3>
#RequireAdmin

;small = 265 / large = 1
Global $toSmallY = 1
;small = 275 / large 1
Global $toSmallX = 1

SRandom(@MSEC)

Func ErrorSound()
	Beep(1200, 100)
	Beep(900, 100)
EndFunc

Func SuccessSound()
	Beep(400, 100)
	Beep(500, 100)
EndFunc

Func StartSound()
	Beep(200, 100)
	Beep(300, 100)
EndFunc

Func _Terminate()

	Beep(600, 400)
	Beep(500, 400)
	Beep(350, 500)
	Beep(200, 700)

	Exit

EndFunc

;proveriaet nalichie pixela krasnogo zveta kak hp v oblasti gde target
;true if >1hp na target, false if targeta net ili u targeta net hp ili hp polosi
Func IsTargetExist()
    const $SizeSearch = 80
    const $MinNbPixel = 2
    const $OptNbPixel = 7
    const $PosX = 420
    const $PosY = 59

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0xD61841, 10)

    const $MaxX = 690
    const $MinX = 410
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

Func IsTargetNotMe()
    const $SizeSearch = 80
    const $MinNbPixel = 2
    const $OptNbPixel = 7
    const $PosX = 420
    const $PosY = 59

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x009ADE, 10)

    const $MaxX = 690
    const $MinX = 410
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
;===============DESTROPREP====================

Func IsPMTwoHPBelow30()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 48
    const $PosY = 340

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 65
    const $MinX = 15
    const $MaxY = 360
	const $MinY = 320

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

Func IsPMThreeHPBelow30()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 55
    const $PosY = 390

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 65
    const $MinX = 15
    const $MaxY = 410
	const $MinY = 370

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

Func IsPMFourHPBelow30()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 48
    const $PosY = 430

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 65
    const $MinX = 15
    const $MaxY = 450
	const $MinY = 410

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

Func IsPMFiveHPBelow30()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 48
    const $PosY = 470

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 65
    const $MinX = 15
    const $MaxY = 490
	const $MinY = 460

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

;============================================

Func IsPMTwoHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 48
    const $PosY = 340

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 80
    const $MinX = 15
    const $MaxY = 360
	const $MinY = 320

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

Func IsPMThreeHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 48
    const $PosY = 390

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 80
    const $MinX = 15
    const $MaxY = 410
	const $MinY = 370

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

Func IsPMFourHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 2
    const $OptNbPixel = 5
    const $PosX = 48
    const $PosY = 430

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 80
    const $MinX = 15
    const $MaxY = 450
	const $MinY = 410

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

 Func IsPMFiveHPBelow40()
    const $SizeSearch = 40
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 48
    const $PosY = 470

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x5E2936, 10)

    const $MaxX = 80
    const $MinX = 15
    const $MaxY = 490
	const $MinY = 460

    if not @error then
        if $MinX < $coords[0] and $coords[0] < $MaxX and $coords[1] < $MaxY  and $MinY < $coords[1] then
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

;============================================

Func IsMyHPDamaged()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 160
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 180
    const $MinX = 10
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

Func IsMyHPDamagedOver30()

    const $SizeSearch = 80
    const $MinNbPixel = 3
    const $OptNbPixel = 10
    const $PosX = 50
    const $PosY = 75

    $coords = FFBestSpot($SizeSearch, $MinNbPixel, $OptNbPixel, $PosX, $PosY, _
                         0x421010, 10)

    const $MaxX = 79
    const $MinX = 5
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

Func Alert()

	If	IsMyHPDamagedOver30() Then

		Beep(400, 300)
		Sleep(100)
		Beep(400, 300)
		Sleep(100)
		Beep(400, 300)
		Sleep(100)

	EndIf

EndFunc

;second panel F5
Func MoveToPartymemberOne()

	MouseClick("left", 550, (940 - $toSmallY), 2, 200)
	Sleep(Random(111,344,1))


EndFunc

Func TakeAssistFromPMOne()

	MouseClick("right", 85, 303, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMOne()

	MouseClick("left", 85, 303, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMTwo()

	MouseClick("right", 100, 352, 2, 200)
	Sleep(Random(111,344,1))

EndFunc

Func TargetOnPMTwo()

	MouseClick("left", 85, 352, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMThree()

	MouseClick("right", 85, 390, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMThree()

	MouseClick("left", 85, 390, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMFour()

	MouseClick("right", 85, 430, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMFour()

	MouseClick("left", 85, 430, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TakeAssistFromPMFive()

	MouseClick("right", 85, 470, 2, 300)
	Sleep(Random(211,344,1))

EndFunc

Func TargetOnPMFive()

	MouseClick("left", 85, 470, 2, 300)
	Sleep(Random(211,344,1))

EndFunc