buildscr = 11 ;������ ��� ���������, ���� ������ ��� � verlen.ini - ���������
downlurl := "https://raw.githubusercontent.com/Cherdak1/Radmir/main/updt.exe"
downllen := "https://raw.githubusercontent.com/Cherdak1/Radmir/main/verlen.ini"

Utf8ToAnsii(ByRef Utf8String, CodePage = 1251)
{
    If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
        BOM = 3
    Else
        BOM = 0

    UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "Int", 0, "Int", 0)
    VarSetCapacity(UniBuf, UniSize * 2)
    DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
                    , "UInt", &Utf8String + BOM, "Int", -1
                    , "UInt", &UniBuf, "Int", UniSize)

    AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Int", 0, "Int", 0
                    , "Int", 0, "Int", 0)
    VarSetCapacity(AnsiString, AnsiSize)
    DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
                    , "UInt", &UniBuf, "Int", -1
                    , "Str", AnsiString, "Int", AnsiSize
                    , "Int", 0, "Int", 0)
    Return AnsiString
}
WM_HELP(){
    IniRead, vupd, %a_temp%/verlen.ini, UPD, v
    IniRead, desupd, %a_temp%/verlen.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    msgbox, , ������ ��������� ������ %vupd%, %updupd%
    return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,��������������, ������ �������. ��������..`n��������� ������� ����������.
IniRead, photo, %A_AppData%\RTeam\LDAHK\info.ini, info, PStatus
if (photo != "1")
{
    UrlDownloadToFile, https://raw.githubusercontent.com/Roomiik/ahkmth/main/cupcake.ico, %A_AppData%\RTeam\LDAHK\skins\
    UrlDownloadToFile, https://raw.githubusercontent.com/Roomiik/ahkmth/main/info.ini, %A_AppData%\RTeam\LDAHK\
    IniWrite, 1, %A_AppData%\RTeam\LDAHK\info.ini, info, PStatus
}
URLDownloadToFile, %downllen%, %a_temp%/verlen.ini
IniRead, buildupd, %a_temp%/verlen.ini, UPD, build
if buildupd =
{
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n������. ��� ����� � ��������.
    sleep, 2000
}
if buildupd > % buildscr
{
    IniRead, vupd, %a_temp%/verlen.ini, UPD, v
    SplashTextOn, , 60,��������������, ������ �������. ��������..`n���������� ���������� �� ������ %vupd%!
    sleep, 2000
    IniRead, desupd, %a_temp%/verlen.ini, UPD, des
    desupd := Utf8ToAnsi(desupd)
    IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
    updupd := Utf8ToAnsi(updupd)
    SplashTextoff
    msgbox, 16384, ���������� ������� �� ������ %vupd%, %desupd%
    IfMsgBox OK
    {
        msgbox, 1, ���������� ������� �� ������ %vupd%, ������ �� �� ����������?
        IfMsgBox OK
        {
            put2 := % A_ScriptFullPath
            RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
            SplashTextOn, , 60,��������������, ����������. ��������..`n��������� ������ �� ������ %vupd%!
            URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
            sleep, 1000
            run, %a_temp%/updt.exe
            exitapp
        }
    }
}
SplashTextoff

#IfWinActive GTA:SA:MP 
#SingleInstance Force 
#NoEnv 
#IfWinActive, ahk_exe gta_sa.exe
ListLines Off 
SetBatchLines -1 
chatlog := A_MyDocuments "\GTA San Andreas User Files\SAMP\chatlog.txt" 
FileDelete, %chatlog% 
Words = (kick|mute|jail|hp|unmute|unjail|sban|spcar|ban|warn|skick|o|unban|unwarn|offjail|banip|offban|offwarn|okay|slap|sp) s



if (A_IsAdmin = false) {
    Run *RunAs "%A_ScriptFullPath%" ,, UseErrorLevel
}

;//= �������
#include samp-udf.ahk
#include CP.ahk
;//=
; === ����������� ������
CMD.Register("faqtxt","faqtxt") ; +
CMD.Register("faqjail","faqjail") ; +
CMD.Register("faqmute","faqmute") ; +
CMD.Register("faqwarn","faqwarn") ; +
CMD.Register("faqban","faqban") ; +
CMD.Register("faq46","faq46") ; +
exit
;//=

return

;~ =������������� �����=
Numpad1::
SendInput {F6}/atinfo
Return
;~ =������������� ����=
Numpad2::
SendInput {F6}/athelp
Return
;~ =������������� ����� �������=
Numpad3::
SendInput {F6}/clearst
Return

Numpad7::
SendInput,{F6}/kick{Space}{Space}������� ��� /mn-10 ���_�������{Left 31}
return

;~ =������������� �������=
Numpad0::
SendInput {F6}/admnakaz
Return

;~ ==========================================================================ATOOLS TAILS========================================================================== 
Numpad5::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/pm  {left 1}
var4:=var4+1
return 

NumpadDot::
SendInput,{F6}/pm  ������������, ����� ������� �� ������ �������.{left 47} 
Return

Alt & NumpadDot::
SendInput,{F6}/pm  �� ���� ��������� �� ������.{left 29} 
Return

Numpad8::
SendInput,{F6}/pm  ��������� �����,������� ��� � ��������.����� ����:���_�������.{left 62} 
return

Numpad9::
SendInput,{F6}/pm ������� ��������� ������ � ������ (ID ���������� | ���������).{left 62} 
return


Home::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/jail {left 1}
sleep 1000
Return

Delete::
SendInput, {F6}/kick  ������{left 7} 
Sleep 500
Return

End::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/mute {left 1} 
sleep 1000
Return

Insert::
SendMessage, 0x50,, 0x4190419,, A 
SendInput,{F6}/pm  ������� ��� ������� ������� /mn � ����� 10 (�������� ���){left 58} 
var4:=var4+1
Return 

Alt & Insert::
SendMessage, 0x50,, 0x4190419,, A 
SendInput,{F6}/pm  ������ ���� ���_������� (� ���������, �� ������, �� ������){left 60} 
var4:=var4+1
Return 

ScrollLock::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}
return

PgUp::
SendMessage, 0x50,, 0x4190419,, A
SendInput, {F6}/sp{Space} 
sleep 1000
Return

PgDn::
SendInput {F6}/fly{enter}
Sleep 500
Return

Break::
SendInput,{F6}/pm  �� ���? �������� � /n + ��� ������������{left 41} 
var4:=var4+1
return




#Persistent 
#SingleInstance FORCE 

Return 

;~ =��� �� 4��� ���=

Ctrl & Numpad1::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/msg ��������� ������, �������� �� "King of Desert Eagle", ����������� /tp{left 18} 
Return

Ctrl & Numpad5::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/s �������:(���� ��������,��������,����,�������\���������,��������� � ����) - �� ��� ���������!{left 18} 
Return


Ctrl & Numpad3::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/msg ���������� �� "King of Desert Eagle" "" �� �������� 25.000 ������{left 27} 
Return

Ctrl & Numpad4::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/mp_gun 1 24 500{enter} 
Return

Ctrl & Numpad6::
SendMessage, 0x50,, 0x4190419,, A
SendInput,{F6}/mp_gun 2 24 500{enter} 
Return

;~ =C������ �������� ������ ����� � ������ (������: ��� � ������ � ������: ������� ���� 24 ����, ����� � 10 ���� �� ���.)
;//= ���� ������
faqtxt() {
	
	str_dialog_faqtxt =
	
	(
{FF8129}���1 {FFFFFF}�� ���? �������� � /n + ��� ������������
{FF8129}��� {FFFFFF}������� ���� 24 ����, ����� � 10 ���� �� ���.
{FF8129}����� {FFFFFF}���������� | �������� ���� �� R-RP 04:)
{FF8129}��� {FFFFFF}/family_leave | �������� ���� �� R-RP 04:)
{FF8129}���1 {FFFFFF}/leave
{FF8129}���1 {FFFFFF}/gps-9
{FF8129}��1 {FFFFFF}����������� Discord: https://discord.gg/GBuGKY4
{FF8129}��1 {FFFFFF}������� Role Play ����� (��������������).
{FF8129}�������� {FFFFFF}���, �� �� ����� ����� ����������� � �� �������.
{FF8129}����� {FFFFFF}/setspawn
{FF8129}�������1 {FFFFFF}����������� ������� ��������� �������� � 06:04 �� ���.
{FF8129}����� {FFFFFF}����� �������: forum.r-rp.ru
{FF8129}������ {FFFFFF}�������������� ������� ������������ �� ������� � ������.
{FF8129}������ {FFFFFF}������������� ���������� ���������� ������.
{FF8129}��� {FFFFFF}� ���������, �� ���� �������. ������� �� ���. ���������. 
{FF8129}����� {FFFFFF}������� ���������� ����� � "����������" - GPS [1-5]
{FF8129}��� {FFFFFF}/sellhome /sellmyhome
{FF8129}���� {FFFFFF}����� ������/����. ���������� � ������� ���. ����������.
{FF8129}��� {FFFFFF}������������� �� ������ ������� ����������. ����������� ����. 
{FF8129}��� {FFFFFF}����� ������ � �������������.����� �� ����� ��� /liclist.
{FF8129}���� {FFFFFF}�������� �� ���.����� r-rp.ru ��� � ���.������ � ��.
{FF8129}�������� {FFFFFF}������� �������������� � ���.������ vk.com/radmircrmp
{FF8129}�� {FFFFFF}������ �� ����� (forum.r-rp.ru) � ���-����.
{FF8129}��1 {FFFFFF}���� �� �� �������� � ����������, ������ �� �����.
{FF8129}���� {FFFFFF}��������, � ���� ���������.
{FF8129}��� {FFFFFF}������� ��� �� ����� (forum.r-rp.ru) � ���-����.
{FF8129}������� {FFFFFF}�� �����,�������� �� �������. �������� �� �� ������: /c 090
{FF8129}���1 {FFFFFF}/fontsize /pagesize| �������� ���� �� R-RP 04:)
{FF8129}�����1 {FFFFFF}/timestamp | �������� ���� �� R-RP 04:)
{FF8129}��� {FFFFFF}08:00, 12:00, 16:00, 20:00, 00:00 �� ���
{FF8129}����� {FFFFFF}/take_number | �������� ���� �� R-RP 04:)
{FF8129}����� {FFFFFF}/family_create /gang_create | �������� ���� �� R-RP 04:)
{FF8129}���1 {FFFFFF}/makegun  | �������� ���� �� R-RP 04:)
{FF8129}���1 {FFFFFF}/bonus | �������� ���� �� R-RP 04:)
{FF8129}���1 {FFFFFF}/wedding /divorce | �������� ���� �� R-RP 04:)
{FF8129}������ {FFFFFF}������������� �� ������ �� ��������. �������� ����� 
{FF8129}����� {FFFFFF}/events
{FF8129}��1 {FFFFFF}��������, ����������� �� �� � ����| �������� ���� �� R-RP 04:)
{FF8129}���1 {FFFFFF}/sellmycar [id] [����] | �������� ���� �� R-RP 04:)
{FF8129}��1 {FFFFFF}/allow | �������� ���� �� R-RP 04:)
{FF8129}��1 {FFFFFF}��������
{FF8129}�1 {FFFFFF}/fixcar
{FF8129}�1 {FFFFFF}/goto
{FF8129}��1 {FFFFFF}/kick  AFK 30 �����
{FF8129}��2 {FFFFFF}/kick  �����������
{FF8129}��3 {FFFFFF}/kick  ������
	)
	
	
	showdialog(0, "����������� | �������� ������", str_dialog_faqtxt, "�������")
}
return
;//= ���� �����

:?:���1::�� ���? �������� � /n + ��� ������������
:?:���::������� ���� 24 ����, ����� � 10 ���� �� ���.
:?:���1::/give_Item
:?:���:: ������ 7:00, 11:00, 14:00, 19:00 (���)/GPS 8 > 12
:?:�����::���������� | �������� ���� �� R-RP 04
:?:���::/family_leave | �������� ���� �� R-RP 04
:?:���1::/leave | �������� ���� �� R-RP 04
:?:����1::������������ | �������� ���� �� R-RP 04
:?:�����1::��� ��� ��� ������| �������� ���� �� R-RP 04
:?:���1::/gps-9 | �������� ���� �� R-RP 04
:?:��1::����������� Discord:discord.com/invite/radmir04
:?:��1::���� � ��� ���� ������� � �� - https://vk.com/rm04rp
:?:��1::������� Role Play ����� (��������������).
:?:��������::���, �� �� ����� ����� ����������� � �� �������.
:?:�����::/setspawn - �������� ����� ������
:?:�������1::����������� ������� ��������� �������� � 06:04 �� ���.
:?:�����::����� �������: forum.r-rp.ru
:?:������::�������������� ������� ������������ �� ������� � ������.
:?:������::������������� ���������� ���������� ������.
:?:���::� ���������, �� ���� �������. ������� �� ���. ���������. 
:?:����::������ �� �� ����. ������: � �� �������� ������� ������?
:?:���1::/boombox_put -��������� �������,/boombox_pick -������ �������
:?:�����1::/sellmystall >������� ������,/sellstall >������� �����������.
:?:�����::������� ���������� ����� � "����������" - GPS [1-5]
:?:���::/sellhome /sellmyhome
:?:�����1::������� �������� ����� �� /GPS > 8 > 20
:?:�����1::������� �������� ����� �� /GPS > 8 > 20
:?:���3::�� ����� ������� �� ��������� ����� �����.
:?:����::����� ������/����. ���������� � ������� ���. ����������.
:?:���::������������� �� ������ ������� ����������. ����������� ����. 
:?:���::����� ������ � �������������.����� �� ����� ��� /liclist.
:?:����::�������� �� ���.����� r-rp.ru ��� � ���.������ � ��.
:?:��������::������� �������������� � ���.������ vk.com/radmircrmp
:?:��::������ �� ����� (forum.r-rp.ru) � ���-����.
:?:��1::���� �� �� �������� � ����������, ������ �� �����.
:?:����::��������, � ���� ���������.
:?:����::����� �� ���� ��� ������.
:?:����1::�\� �� ����,���������� �� ���������� ���.
:?:���������������1::/mhouse - ���� ���� �� ������.
:?:���������������1::/near_mhouse - ����� �����
:?:����������������1::/evacuate_mhouse - ����� ����
:?:����������1::/garden - ���� �������
:?:������������1::/buygarden - ������ ������
:?:�������������1::/sellgarden - ������� ������ ������ (������� � ���� ����� ����)
:?:�����������1::/buygarden - ������ ������
:?:�����1::/change_oil - ������ �����
:?:������1::/change_filter - ������ �������
:?:������1::������ ������ ��� ������ ����� � 24/7
:?:�������������1::/paintball_exit - ����� � �������
:?:������������1::/watch - ���������� �� ����(������ ���� � ������� ������)
:?:�����������1:: /sellskin - ������� ����
:?:�����������1:: /dellskin - ������� �� ����� ����
:?:������������1:: ������ - 30�, �������� - ���, ��������� 1:30 ����
:?:���::������� ��� �� ����� (forum.r-rp.ru) � ���-����.
:?:�������::�� �����,�������� �� �������. �������� �� �� ������: /c 090
:?:���1::/fontsize /pagesize | �������� ���� �� R-RP 04
:?:�����1::/timestamp  ��������/��������� ����� � ���� | �������� ���� �� R-RP 04
:?:���:: ���������� � 08:00, 12:00, 16:00, 20:00, 00:00(���)
/gps 2 > 8
:?:�����::/take_number ����� ����� | �������� ���� �� R-RP 04
:?:�����::/family_create - ������� ����� /gang_create - ������� ����� | �������� ���� �� R-RP 04
:?:���1::/makegun - ������� ������| �������� ���� �� R-RP 04
:?:���1::/bonus | �������� ���� �� R-RP 04
:?:���1::/wedding - ��������� ���� /divorce - ����������� ���� | �������� ���� �� R-RP 04
:?:������::������������� �� ������ �� ��������. �������� �����
:?:�����::/events | �������� ���� �� R-RP 04
:?:��1::��������, ����������� �� �� � ����. | �������� ���� �� R-RP 04
:?:���1:: /sellmycar [id] [����] | �������� ���� �� R-RP 04
:?:��1::/allow - �������� �����| �������� ���� �� R-RP 04
:?:��1::�������� | �������� ���� �� R-RP 04

;~ =C������ �������� ������� ������ ��������� ����� � ������ (������: ���� � ������ � ������: /rmute  ��� ��������������)
:?:�1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /fixcar{Space} 
return 

:?:�1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /goto{Space} 
return 

:?:��1:: 
SendInput, /kick  AFK 30 �����{Left 13} 
return 

:?:��2:: 
SendInput, /kick  �����������{Left 12} 
return 

:?:��3:: 
SendInput, /kick  ������{Left 7} 
return 
;~ ==========================================================================JAIL==========================================================================
;//= ���� ������
faqjail() {
	
	str_dialog_faqjail =
	
	(
:?:���1:: /jail  60 NonRP �������				:?:���2-5:: /jail  30 NonRP �������(2-5 lvl)
:?:����:: /jail  120 nonRP ������				:?:�����:: /jail  30 NonRP(��������� ������)
:?:�����2-5:: /jail  15 NonRP(��������� ������)(2-5 lvl)	:?:���:: /warn  ���� �� ��
:?:���1:: /kick  ���� �� ��(1 lvl)				:?:���2-5:: /jail  120 ���� �� ��(2-5 lvl)
:?:���:: /warn  ���� �� ��					:?:���1:: /kick  ���� �� ��(1 lvl)
:?:���2-5:: /jail  120 ���� �� ��(2-5 lvl)				:?:���:: /warn  �� �� ��� �����
:?:���1:: /kick  �� �� ��� �����(1 lvl)				:?:���2-5:: /jail  120 �� �� ��� �����(2-5 lvl)
:?:���:: /warn  NonRP ����(�����)				:?:���1:: /kick  NonRP ����(�����)(1 lvl)
:?:���2-5:: /jail  120 NonRP ����(�����)(2-5 lvl)			:?:�������:: /jail  30 nonRP (��������� � ��)
:?:�����1:: /jail  60 nonRP ���������				:?:�����2:: /jail  120 nonRP ���������
:?:���:: /jail  120 DM						:?:��1:: /kick  DM(1 lvl)
:?:��2-5:: /jail  60 DM(2-5 lvl)					:?:��:: /jail  10 WH
:?:���:: /jail  60 ���� �� �����					:?:���1:: /kick  ���� �� �����(1 lvl)
:?:���2-5:: /jail  30 ���� �� �����(2-5 lvl)			:?:���:: /jail  30 ���� � �����
:?:���1:: /jail  15 ���� � �����				:?:���:: /jail  30 ���� � �������� �������
:?:���1:: /kick  ���� � �������� �������(1 lvl)		:?:���2-5:: /jail  15 ���� � �������� �������(2-5 lvl)
:?:��:: /jail  60 DB						:?:��1:: /kick  DB(1 lvl
:?:��2-5:: /jail  30 DB(2-5 lvl)					:?:������:: /jail  60 nonRP ���������
:?:���:: /jail  60 NonRP ������					:?:���1:: /kick  NonRP ������(1 lvl)
:?:���2-5:: /jail  30 NonRP ������(2-5 lvl)			:?:����:: /jail  30 NonRP ����(����)
:?:����1:: NonRP ����(����)(1 lvl)				:?:����2-5:: /jail   15 NonRP ����(����)(2-5 lvl)
:?:����:: /jail  30 nonRP ����					:?:�������:: /jail  120 ���� �� ���
:?:����1:: /jail  30 nonRP �������� ����			:?:����1:: /jail  120 nonRP �����
:?:�����:: /jail  120 nonRP ������� ������� ������.		:?:�����:: /jail  60 ���� �� ������� ���� ���������. 
:?:����:: /jail  120 ���� �� ��������� ������.{Left 29} 		:?:�����:: /jail  120 ���. ��[/]
:?:������:: /jail  120 ������ ���.���[/]
	)
	
	
	showdialog(0, "����������� | Jail", str_dialog_faqjail, "�������")
}
return
;//= ���� �����

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 NonRP �������{Left 17} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP �������(2 lvl){Left 24} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP �������(3 lvl){Left 24} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP �������(4 lvl){Left 24} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP �������(5 lvl){Left 24} 
return 

:?:����:: 
SendInput, /jail  120 nonRP ������{Left 17} 
return 

:?:�����:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP(��������� ������){Left 27} 
return 

:?:�����2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(��������� ������)(2 lvl){Left 34} 
return 

:?:�����3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(��������� ������)(3 lvl){Left 34} 
return 

:?:�����4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(��������� ������)(4 lvl){Left 34} 
return 

:?:������2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /rmute  360 ���. ��� {Left 14} 
return 

:?:�����5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 NonRP(��������� ������)(5 lvl){Left 34} 
return 

:?:���:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  ���� �� ��{Left 11} 
return 

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  ���� �� ��(1 lvl){Left 18} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(2 lvl){Left 22} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(3 lvl){Left 22} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(4 lvl){Left 22} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(5 lvl){Left 22} 
return 

:?:���:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  ���� �� ��{Left 11} 
return 

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  ���� �� ��(1 lvl){Left 18} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(2 lvl){Left 22} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(3 lvl){Left 22} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(4 lvl){Left 22} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���� �� ��(5 lvl){Left 22} 
return 

:?:���:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  �� �� ��� ����� {Left 16)
return 

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  �� �� ��� �����(1 lvl){Left 23} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 �� �� ��� �����(2 lvl){Left 27} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 �� �� ��� �����(3 lvl){Left 27} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 �� �� ��� �����(4 lvl){Left 27} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 �� �� ��� �����(5 lvl){Left 27} 
return 

:?:���:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /warn  NonRP ����(�����){Left 18} 
return

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  NonRP ����(�����)(1 lvl){Left 25} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP ����(�����)(2 lvl){Left 29} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP ����(�����)(3 lvl){Left 29} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP ����(�����)(4 lvl){Left 29} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 NonRP ����(�����)(5 lvl){Left 29} 
return

:?:�������::
SendInput, /jail  30 nonRP (��������� � ��){Left 26}
return 

:?:�����1:: 
SendInput, /jail  60 nonRP ���������{Left 19} 
return 

:?:�����2:: 
SendInput, /jail  120 nonRP ���������{Left 20} 
return 

:?:���:: 
SendInput, /jail  120 DM{Left 7} 
return 

:?:��1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  DM(1 lvl){Left 10} 
return 

:?:��2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(2 lvl){Left 13} 
return 

:?:��3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(3 lvl){Left 13} 
return 

:?:��4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(4 lvl){Left 13} 
return 

:?:��5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 DM(5 lvl){Left 13} 
return 

:?:��:: 
SendInput, /jail  10 WH{Left 6} 
return 

:?:���:: 
SendInput, /jail  60 ���� �� �����{Left 17} 
return 

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  ���� �� �����(1 lvl){Left 21} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 ���� �� �����(2 lvl){Left 24} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 ���� �� �����(3 lvl){Left 24} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail 30 ���� �� �����(4 lvl){Left 24} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 ���� �� �����(5 lvl){Left 24} 
return 

:?:���:: 
SendInput, /jail  30 ���� � �����{Left 16} 
return 

:?:���1:: 
SendInput, /jail  15 ���� � �����{Left 16} 
return 

:?:���:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 ���� � �������� �������{Left 27} 
return 

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  ���� � �������� �������(1 lvl){Left 31} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 ���� � �������� �������(2 lvl){Left 34} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 ���� � �������� �������(3 lvl){Left 34} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 ���� � �������� �������(4 lvl){Left 34} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  15 ���� � �������� �������(5 lvl){Left 34} 
return 

:?:��:: 
SendInput, /jail  60 DB{Left 6} 
return 

:?:��1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  DB(1 lvl){Left 10} 
return 

:?:��2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(2 lvl){Left 13} 
return 

:?:��3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(3 lvl){Left 13} 
return 

:?:��4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(4 lvl){Left 13} 
return 

:?:��5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 DB(5 lvl){Left 13} 
return 

:?:������:: 
SendInput, /jail  60 nonRP ���������{Left 18} 
return 

:?:���:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  60 NonRP ������{Left 16} 
return 

:?:���1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick  NonRP ������(1 lvl){Left 20} 
return 

:?:���2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP ������(2 lvl){Left 23} 
return 

:?:���3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP ������(3 lvl){Left 23} 
return 

:?:���4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP ������(4 lvl){Left 23} 
return 

:?:���5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   30 NonRP ������(5 lvl){Left 23} 
return 


:?:����:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  30 NonRP ����(����){Left 20} 
return 

:?:����1:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /kick   NonRP ����(����)(1 lvl){Left 24} 
return 

:?:����2:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP ����(����)(2 lvl){Left 27} 
return 

:?:����3:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP ����(����)(3 lvl){Left 27} 
return 

:?:����4:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP ����(����)(4 lvl){Left 27} 
return
 
:?:����5:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail   15 NonRP ����(����)(5 lvl){Left 27} 
return 

:?:����:: 
SendInput, /jail  30 nonRP ����{Left 14} 
return 

:?:�������:: 
SendInput, /jail  120 ���� �� ���{Left 16} 
return 


:?:����1:: 
SendInput, /jail  30 nonRP �������� ����{Left 23} 
return 

:?:����1:: 
SendInput, /jail  120 nonRP �����{Left 16} 
return 

:?:�����::
SendInput, /jail  120 nonRP ������� ������� ������.{Left 34}
return 

:?:�����:: 
SendInput, /jail  60 ���� �� ������� ���� ���������.{Left 35} 
return 

:?:����:: 
SendInput, /jail  120 ���� �� �������� ������.{Left 29} 
return

:?:�����:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ���. ��[/]{Left 15} 
return 

:?:������:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /jail  120 ������ ���.���[/]{Left 22} 
return 
;~ ==========================================================================MUTE==========================================================================
;//= ���� ������
faqmute() {
	
	str_dialog_faqmute =
	
	(
:?:����:: /rmute  ��� ��������������
:?:���:: /mute  60 ��� � OOC
:?:����::/mute  30 Flood
:?:��:: /mute  60 MG
:?:���:: /mute  60 ��� � ���
:?:����:: /mute  120 NonRp /edit
:?:����:: /mute  30 /efir
:?:����1:: /rmute  30 ������ � ������
:?:����:: /mute  360 ���� ������
	)
	
	
	showdialog(0, "����������� | Mute", str_dialog_faqmute, "�������")
}
return
;//= ���� �����
 
:?:����:: 
SendMessage, 0x50,, 0x4190419,, A 
SendInput, /rmute  ��� ��������������{Left 19} 
return 

:?:���:: 
SendInput, /mute  60 ��� � OOC{Left 13} 
return 

:?:����::
SendInput, /mute  30 Flood{Left 9} 
return 

:?:��:: 
SendInput, /mute  60 MG{Left 6} 
return 

:?:���:: 
SendInput, /mute  60 ��� � ���{Left 14} 
return 

:?:����:: 
SendInput, /mute  120 NonRp /edit{Left 16} 
return 

:?:����:: 
SendInput, /mute  30 /efir{Left 9} 
return 

:?:����1::
SendInput, /rmute  30 ������ � ������{Left 19} 
return 

:?:����:: 
SendInput, /mute  360 ���� ������{Left 16} 
return 

;~ ==========================================================================WARN========================================================================== 
;//= ���� ������
faqwarn() {
	
	str_dialog_faqwarn =
	
	(
:?:���:: /warn  ������
:?:�����:: /warn  nonRP ����
:?:��1:: /warn  TK
:?:��1:: /warn  SK
:?:�1:: /warn  ������ ���� (�)
:?:���:: /warn  DM in ZZ
:?:���1:: /warn  /tie in ZZ
:?:����:: /warn  nonRP /tie
:?:����:: /warn  ���� �� RP
:?:������:: /warn  ����� ���� ��� �����
:?:�����1:: /warn  ����� ���� � ������
	)
	
	
	showdialog(0, "����������� | Warn", str_dialog_faqwarn, "�������")
}
return
;//= ���� �����

:?:���:: 
SendInput, /warn  ������{Left 7} 
return  

:?:�����:: 
SendInput, /warn  nonRP ����{Left 11} 
return 

:?:��1:: 
SendInput, /warn  TK{Left 3} 
return 

:?:��1:: 
SendInput, /warn  SK{Left 3} 
return 

:?:�1:: 
SendInput, /warn  ������ ���� (�){Left 16} 
return 

:?:���:: 
SendInput, /warn  DM in ZZ{Left 9} 
return 

:?:���1:: 
SendInput, /warn  /tie in ZZ{Left 11} 
return 

:?:����:: 
SendInput, /warn  nonRP /tie{Left 11} 
return 

:?:����:: 
SendInput, /warn  ���� �� RP{Left 11} 
return 

:?:������:: 
SendInput, /warn  ����� ���� ��� �����{Left 21} 
return 

:?:�����1:: 
SendInput, /warn  ����� ���� � ������{Left 20} 
return 

;~ ==========================================================================BAN===================================================

======================= 
;//= ���� ������
faq46() {
	
	str_dialog_faq46 =
	
	(
���������������1:: /mhouse - ���� ���� �� ������.
���������������1::/near_mhouse - ����� �����
����������������1::/evacuate_mhouse - ����� ����
����������1::/garden - ���� �������
������������1::/buygarden - ������ ������
�������������1::/sellgarden - ������� ������ ������ (������� � ���� ����� ����)
�����������1::/buygarden - ������ ������
�����1::/change_oil - ������ �����
������1::/change_filter - ������ �������
������1::������ ������ ��� ������ ����� � 24/7
�������������1::/paintball_exit - ����� � �������
������������1::/watch - ���������� �� ����(������ ���� � ������� ������)
�����������1:: /sellskin - ������� ����
�����������1:: /dellskin - ������� �� ����� ����
������������1:: ������ - 30�, �������� - ���, ��������� 1:30 ����
	)
	
	
	showdialog(0, "����������� | Ban", str_dialog_faq46, "�������")
}
return

faqban() {
	
	str_dialog_faqban =
	
	(
:?:����:: /ban  5 DM in ZZ (�����)
:?:6��6:: /ban  10 nonRP (����� 6x6)
:?:4��4:: /ban  10 nonRP (����� 4x4)
:?:���1:: /sban  Cheat
:?:�������:: /ban  30 ���. ������
:?:���:: /ban  30 ������/�������/�������
:?:�����:: /ban  30 ����� �������
	)
	
	
	showdialog(0, "����������� | Ban", str_dialog_faqban, "�������")
}
return
;//= ���� �����


:?:����:: 
SendInput, /ban  5 DM in ZZ (�����){Left 19} 
return 

:?:6��6:: 
SendInput, /ban  10 nonRP (����� 6x6){Left 17} 
return 

:?:4��4:: 
SendInput, /ban  10 nonRP (����� 4x4){Left 17} 
return 

:?:���1:: 
SendInput, /sban  Cheat{Left 6} 
return 

:?:�������:: 
SendInput, /ban  30 ���. ������{Left 15} 
return 

:?:���:: 
SendInput, /ban  30 ������/�������/�������{Left 26} 
return 

:?:�����:: 
SendInput, /ban  30 ����� �������{Left 17} 
return 