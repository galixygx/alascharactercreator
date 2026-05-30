# ── Alas Character Creator — One-Command Publisher ──────────────
# Usage: Right-click → "Run with PowerShell"  OR  run in terminal:
#   cd "C:\Users\r2d2r\OneDrive\Desktop\Alas\alascharactercreator-site"
#   .\publish.ps1
#
# What it does:
#   1. Copies the latest AlasCharacterCreator_V4.html → index.html
#   2. Commits to git with your message
#   3. Pushes to GitHub (version history)
#   4. Deploys directly to Netlify (live in ~30 seconds)
# ────────────────────────────────────────────────────────────────

Set-Location "C:\Users\r2d2r\OneDrive\Desktop\alascharactercreator-site"

# Step 1 — Copy latest HTML
Write-Host "`n[1/4] Copying latest HTML..." -ForegroundColor Cyan
Copy-Item "C:\Users\r2d2r\OneDrive\Desktop\Alas\Alas\AlasCharacterCreator_V4.html" ".\index.html" -Force
Write-Host "      Done." -ForegroundColor Green

# Step 2 — Commit message
Write-Host "`n[2/4] Enter a short description of what changed:" -ForegroundColor Cyan
$msg = Read-Host "      Patch note"
if (-not $msg) { $msg = "Update" }

# Step 3 — Git commit + push
Write-Host "`n[3/4] Committing and pushing to GitHub..." -ForegroundColor Cyan
git add index.html
git commit -m $msg
git push
Write-Host "      GitHub updated." -ForegroundColor Green

# Step 4 — Deploy to Netlify
Write-Host "`n[4/4] Deploying to Netlify (live in ~30 sec)..." -ForegroundColor Cyan
netlify deploy --prod --dir .

Write-Host "`n✅ DONE — alascharactercreator.netlify.app is live!" -ForegroundColor Green
Write-Host "   Hard-refresh your browser with Ctrl+Shift+R to see changes.`n" -ForegroundColor Yellow
