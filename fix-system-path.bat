@echo off
setlocal
title Fix system PATH
echo ==========================================================
echo  Repair the Windows system PATH
echo   - removes the junk "python-3.14.7-amd64.exe" entry
echo   - restores the standard Windows folders
echo   - keeps everything else as it is
echo ==========================================================
echo.

set "PSFILE=%TEMP%\fix-system-path.ps1"

> "%PSFILE%" echo $ErrorActionPreference = 'Stop'
>> "%PSFILE%" echo $key = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
>> "%PSFILE%" echo $item = Get-Item $key
>> "%PSFILE%" echo $old = [string]$item.GetValue('Path', $null, 'DoNotExpandEnvironmentNames')
>> "%PSFILE%" echo $entries = New-Object System.Collections.ArrayList
>> "%PSFILE%" echo foreach ($e in $old.Split(';')) { $t = $e.Trim(); if ($t -ne '') { if ($t -notlike '*python-3.14.7-amd64.exe*') { [void]$entries.Add($t) } } }
>> "%PSFILE%" echo $standard = @('%%SystemRoot%%\system32', '%%SystemRoot%%', '%%SystemRoot%%\System32\Wbem', '%%SystemRoot%%\System32\WindowsPowerShell\v1.0\', '%%SystemRoot%%\System32\OpenSSH\')
>> "%PSFILE%" echo $final = New-Object System.Collections.ArrayList
>> "%PSFILE%" echo foreach ($s in $standard) { $have = $false; foreach ($e in $entries) { if ($e.TrimEnd('\').ToLower() -eq $s.TrimEnd('\').ToLower()) { $have = $true } }; if (-not $have) { [void]$final.Add($s) } }
>> "%PSFILE%" echo foreach ($e in $entries) { [void]$final.Add($e) }
>> "%PSFILE%" echo $new = $final -join ';'
>> "%PSFILE%" echo Write-Output 'OLD SYSTEM PATH:'
>> "%PSFILE%" echo Write-Output $old
>> "%PSFILE%" echo Write-Output ''
>> "%PSFILE%" echo Write-Output 'NEW SYSTEM PATH:'
>> "%PSFILE%" echo Write-Output $new
>> "%PSFILE%" echo Write-Output ''
>> "%PSFILE%" echo try {
>> "%PSFILE%" echo   $stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
>> "%PSFILE%" echo   $backup = Join-Path $env:USERPROFILE ('system-path-backup-' + $stamp + '.txt')
>> "%PSFILE%" echo   [System.IO.File]::WriteAllText($backup, $old)
>> "%PSFILE%" echo   Set-ItemProperty -Path $key -Name Path -Value $new -Type ExpandString
>> "%PSFILE%" echo   $sig = '[DllImport("user32.dll", CharSet = CharSet.Auto)] public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, string lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);'
>> "%PSFILE%" echo   $t2 = Add-Type -MemberDefinition $sig -Name NativeMethods -Namespace Win32 -PassThru
>> "%PSFILE%" echo   $res = [UIntPtr]::Zero
>> "%PSFILE%" echo   [void]$t2::SendMessageTimeout([IntPtr]0xffff, 0x1A, [UIntPtr]::Zero, 'Environment', 2, 5000, [ref]$res)
>> "%PSFILE%" echo   Write-Output 'SUCCESS: the system PATH was updated.'
>> "%PSFILE%" echo   Write-Output ('Old value saved to: ' + $backup)
>> "%PSFILE%" echo   Write-Output 'Close every open cmd window and open a new one.'
>> "%PSFILE%" echo } catch {
>> "%PSFILE%" echo   Write-Output ('NOT APPLIED: ' + $_.Exception.Message)
>> "%PSFILE%" echo   Write-Output 'Right click this file and choose "Run as administrator".'
>> "%PSFILE%" echo }

"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -ExecutionPolicy Bypass -File "%PSFILE%"

del "%PSFILE%" >nul 2>&1
echo.
pause
