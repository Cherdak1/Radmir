updurl := "https://raw.githubusercontent.com/Cherdak1/Radmir/main/atools.ahk"
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nНастраиваем систему обновления.
RegRead, put2, HKEY_CURRENT_USER, SoftWare\SAMP, put2
sleep, 5000
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nСкачиваем обновленную версию.
URLDownloadToFile, %updurl%, %put2%
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nЗапускаем обновленную версию.
sleep, 3000
Run, % put2
ExitApp
