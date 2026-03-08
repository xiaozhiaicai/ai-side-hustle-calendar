@echo off
echo ?? 正在检测安全软件...
tasklist /fi "imagename eq QQPCRTP.exe" | findstr "QQPCRTP" >nul && (echo ?? 检测到腾讯电脑管家，请右键托盘图标 → 暂停防护 & echo. & pause)
tasklist /fi "imagename eq 360tray.exe" | findstr "360tray" >nul && (echo ?? 检测到 360 安全卫士，请右键托盘图标 → 暂停防护 & echo. & pause)

cd /d "D:\ClawWork\ai-side-hustle-calendar"
if errorlevel 1 (echo ? 目录不存在 & pause & exit /b)

echo.
echo ?? 正在推送（直连模式）...
git -c http.sslVerify=false -c http.sslVersion=tlsv1.2 push --force-with-lease origin main 2>&1 | findstr "remote:" >nul && (
    echo ? 推送成功！GitHub 已更新
    echo ?? 提示：现在可重新启用安全软件防护
) || (
    echo ?? 仍失败 — 请确认已暂停防护，并检查网络
)
pause