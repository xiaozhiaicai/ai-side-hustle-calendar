@echo off
:: fix-and-sync.bat — 专为 ai-side-hustle-calendar 设计｜双击即用
:: 功能：清代理 + 测网 + 自动提交 + 推送 GitHub

echo ?? 正在重置系统代理...
netsh winhttp reset proxy >nul
git config --global --unset http.proxy >nul
git config --global --unset https.proxy >nul

cd /d "D:\ClawWork\ai-side-hustle-calendar"
if errorlevel 1 (
    echo ? 错误：项目目录不存在，请检查路径
    pause
    exit /b
)

echo.
echo ?? 正在测试 GitHub 连接...
ping -n 1 github.com | findstr "TTL=" >nul
if errorlevel 1 (
    echo ?? 警告：无法连接 GitHub — 请检查网络或防火墙
    pause
    exit /b
) else (
    echo ? GitHub 连接正常
)

echo.
echo ?? 开始同步...
git add .
git status -s | findstr "." >nul || (echo ?? 无文件变更，跳过提交 & goto push)
for /f "tokens=1-4 delims=/: " %%a in ('echo %date% %time%') do set "ts=%%c-%%a-%%b %%d"
git commit -m "auto-sync @%ts%"
:push
git push origin main 2>&1 | findstr "remote:" >nul && (echo ? 同步成功：%date% %time%) || (echo ?? 推送失败 — 请检查 Token 或网络)
pause