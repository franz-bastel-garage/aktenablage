@echo off
setlocal
cd /d "%~dp0"
REM ---------------------------------------------------------------------
REM  Aenderungen zu GitHub schicken. GitHub Pages veroeffentlicht sie in
REM  ein bis zwei Minuten unter https://franz-bastel-garage.github.io/aktenablage/
REM
REM  ACHTUNG: Dieses Repo ist OEFFENTLICH (Absicht, fuer Pages). Nichts
REM  Geheimes hineinlegen -- die Sperre unten faengt nur das Gaengigste ab.
REM
REM      push.cmd "Was geaendert wurde"
REM ---------------------------------------------------------------------

set "REPO=https://github.com/franz-bastel-garage/aktenablage.git"

where git >nul 2>&1
if errorlevel 1 (
  echo Git ist nicht installiert oder nicht im PATH: https://git-scm.com/download/win
  pause
  exit /b 1
)

if not exist ".git" (
  echo Erste Einrichtung: lokales Repository wird angelegt...
  git init
  git branch -M main
  git remote add origin %REPO%
  git fetch origin 2>nul
  git rev-parse --verify origin/main >nul 2>&1
  if not errorlevel 1 (
    echo Vorhandene GitHub-Historie uebernehmen, lokale Dateien behalten...
    git reset --soft origin/main
  )
)

REM Sicherheitsnetz: nie eine .env oder einen privaten Schluessel pushen.
git add -A
for /f "delims=" %%F in ('git --no-pager diff --cached --name-only') do (
  echo %%F | findstr /i /r /c:"\.env$" /c:"^\.env" /c:"/\.env$" /c:"id_ed25519$" /c:"id_rsa$" /c:"konto\.json$" /c:"service_account\.json$" >nul
  if not errorlevel 1 (
    echo.
    echo ABBRUCH: "%%F" sieht nach einem Geheimnis aus und darf nicht ins Repo.
    echo In .gitignore eintragen, dann noch einmal.
    git reset -q
    pause
    exit /b 1
  )
)

set "MSG=%~1"
if "%MSG%"=="" set "MSG=Aktualisierung %DATE% %TIME%"

git diff --cached --quiet
if errorlevel 1 goto commit
echo Keine eigenen Aenderungen - hole nur, was auf GitHub neuer ist ...
git pull --rebase origin main
REM Liegen noch Commits herum, die ein frueherer Push nicht geschafft hat? Dann pushen.
set "VOR=0"
for /f %%N in ('git rev-list --count origin/main..HEAD 2^>nul') do set "VOR=%%N"
if "%VOR%"=="0" (
  pause
  exit /b 0
)
echo %VOR% lokale^(r^) Commit^(s^) noch nicht auf GitHub - pushe jetzt ...
goto push
:commit
echo.
echo Das geht raus:
REM --no-pager: sonst haelt "less" bei langen Listen an und wartet auf q.
git --no-pager diff --cached --name-status
echo.
REM Ohne Name und E-Mail verweigert Git den Commit. Falls global nichts
REM gesetzt ist, fuer dieses Repo die GitHub-Schreibweise nehmen.
git config user.name >nul 2>&1 || git config user.name "FranzConsbruch"
git config user.email >nul 2>&1 || git config user.email "FranzConsbruch@users.noreply.github.com"
echo == Commit ...
git commit -q -m "%MSG%"
if errorlevel 1 (
  echo.
  echo Commit fehlgeschlagen - siehe Meldung oben.
  pause
  exit /b 1
)
REM Erst holen, was auf GitHub neuer ist (z.B. ein gemergter Pull Request von
REM Claude), und die eigenen Commits obendrauf setzen -- sonst lehnt GitHub ab.
echo == Neues von GitHub holen ...
git pull --rebase origin main
if errorlevel 1 (
  echo.
  echo Konflikt beim Zusammenfuehren mit GitHub. Betroffene Dateien: git status
  echo Loesen, dann:  git add -A ^&^& git rebase --continue  und push.cmd erneut.
  echo Oder alles verwerfen:  git rebase --abort
  pause
  exit /b 1
)
:push
echo == Push zu GitHub ...
git push -u origin main
if errorlevel 1 (
  echo.
  echo Push fehlgeschlagen. Beim ersten Mal fragt Git nach der GitHub-Anmeldung
  echo ^(Browserfenster^) - danach push.cmd noch einmal starten.
  pause
  exit /b 1
)
echo.
echo Fertig. GitHub Pages aktualisiert sich in ein bis zwei Minuten.
echo Danach im Outlook das Panel schliessen und neu oeffnen.
echo Geaenderte Manifeste wirken erst nach Hochladen im Admin Center.
pause
