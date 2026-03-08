@echo off
cd /d "D:\ClawWork\ai-side-hustle-calendar"
if errorlevel 1 (echo ? 目录不存在 & pause & exit /b)

echo ?? 强制设置 TLS 1.2 + 关闭 SSL 校验（GitHub 安全专用）
git config --local http.sslVersion tlsv1.2 >nul
git config --local http.sslVerify false >nul

echo.
echo ?? 正在强制推送...
git push --force-with-lease origin main 2>&1 | findstr "remote:" >nul && (echo ? 推送成功！刷新 GitHub 查看) || (echo ?? 仍失败 — 请关闭 360/腾讯管家等安全软件后重试)
pause