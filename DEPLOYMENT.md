# Alas Character Creator — Deployment Guide
## alascharactercreator.com

This folder is your complete website. Three one-time setup steps, then pushing
updates is a single git command forever after.

---

## ARCHITECTURE

```
Your PC (this folder)
    │  git push
    ▼
GitHub (free, version control)
    │  auto-deploy on every push
    ▼
Netlify (free, hosting + SSL)
    │  custom domain
    ▼
alascharactercreator.com  ←── Wix DNS points here
```

---

## STEP 1 — GitHub (one-time, ~5 minutes)

1. Go to **https://github.com** — sign in or create a free account.

2. Click **"New repository"** (green button, top-right).

3. Fill in:
   - **Repository name:** `alascharactercreator`
   - **Visibility:** Private (recommended) or Public
   - **Do NOT** check "Add a README" or any other checkbox

4. Click **"Create repository"**.

5. GitHub shows you a page with commands. Copy the repo URL — it looks like:
   ```
   https://github.com/YOUR-USERNAME/alascharactercreator.git
   ```

6. Open **PowerShell** and run these commands (paste your URL on the last line):
   ```powershell
   cd "C:\Users\r2d2r\OneDrive\Desktop\Alas\alascharactercreator-site"
   git remote add origin https://github.com/YOUR-USERNAME/alascharactercreator.git
   git branch -M main
   git push -u origin main
   ```

   GitHub will ask for your username and password (or a Personal Access Token
   if you have 2FA enabled — generate one at Settings > Developer settings >
   Personal access tokens > Tokens (classic)).

✅ Your code is now on GitHub.

---

## STEP 2 — Netlify (one-time, ~5 minutes)

1. Go to **https://netlify.com** — sign up free with your GitHub account
   (click "Sign up" → "Continue with GitHub").

2. Click **"Add new site"** → **"Import an existing project"**.

3. Click **"Deploy with GitHub"** → authorize Netlify → find and select
   **alascharactercreator**.

4. Netlify auto-detects settings from netlify.toml. Leave everything as-is.
   Click **"Deploy site"**.

5. Wait ~30 seconds. Netlify gives you a temporary URL like:
   `https://random-name-123.netlify.app`
   — open it and verify the site works perfectly.

6. In Netlify dashboard → **"Domain settings"** → **"Add a custom domain"**:
   - Type: `alascharactercreator.com`  → click **"Verify"** → **"Add domain"**
   - Also add: `www.alascharactercreator.com`

7. Netlify will show you DNS values. Write them down — you need them in Step 3.
   They will look like this:

   | Type  | Name | Value                        |
   |-------|------|------------------------------|
   | A     | @    | 75.2.60.5                    |
   | CNAME | www  | YOUR-SITE-NAME.netlify.app   |

   (The exact Netlify IP and subdomain are shown in your dashboard.)

8. In Netlify dashboard → **"Domain settings"** → scroll to **"HTTPS"** →
   click **"Verify DNS configuration"** → **"Provision certificate"** once DNS
   is live. SSL is free and automatic.

✅ Netlify is configured.

---

## STEP 3 — Wix DNS (one-time, ~10 minutes + up to 48h propagation)

1. Go to **https://manage.wix.com** → **Domains** → click `alascharactercreator.com`.

2. Click **"Manage DNS records"** (or "Advanced" → "DNS Records").

3. **Delete** any existing A records and CNAME records for `@` and `www`
   (Wix adds its own by default — remove them).

4. **Add these records** (use the exact values Netlify gave you in Step 2):

   | Type  | Host/Name | Value / Points To            | TTL  |
   |-------|-----------|------------------------------|------|
   | A     | @         | 75.2.60.5                    | 3600 |
   | CNAME | www       | YOUR-SITE-NAME.netlify.app   | 3600 |

5. Click **Save**.

6. DNS propagation takes **15 minutes to 48 hours**. You can check progress at:
   https://dnschecker.org/#A/alascharactercreator.com

✅ Once DNS propagates, **https://alascharactercreator.com** is live.

---

## PUBLISHING UPDATES (every time, ~30 seconds)

Whenever you update `AlasCharacterCreator_V4.html`, run this workflow:

```powershell
# 1. Copy the updated file to the site folder
Copy-Item "C:\Users\r2d2r\OneDrive\Desktop\Alas\Alas\AlasCharacterCreator_V4.html" `
          "C:\Users\r2d2r\OneDrive\Desktop\Alas\alascharactercreator-site\index.html"

# 2. Navigate to site folder and push
cd "C:\Users\r2d2r\OneDrive\Desktop\Alas\alascharactercreator-site"
git add index.html
git commit -m "Patch: describe what changed here"
git push
```

Netlify detects the push and redeploys automatically within **30–60 seconds**.
The live site at alascharactercreator.com reflects the change immediately
(no cache issues — index.html is set to no-cache in netlify.toml).

---

## QUICK REFERENCE — Useful Links

| Service  | URL                                           | Purpose                    |
|----------|-----------------------------------------------|----------------------------|
| GitHub   | https://github.com/YOUR-USERNAME/alascharactercreator | Source code    |
| Netlify  | https://app.netlify.com                       | Hosting, deploys, SSL      |
| Wix DNS  | https://manage.wix.com → Domains             | Domain DNS management      |
| DNS Check| https://dnschecker.org/#A/alascharactercreator.com | Verify DNS is live   |

---

## TROUBLESHOOTING

**Site shows Netlify's default page, not the app**
→ Make sure index.html is in the root of the repo (not in a subfolder).

**Domain not resolving after 48 hours**
→ Double-check the A record value in Wix matches exactly what Netlify shows.
→ Make sure you deleted Wix's default A records first.

**HTTPS shows "not secure"**
→ In Netlify: Domain settings → HTTPS → click "Renew certificate".

**Wix says "can't edit DNS records"**
→ Wix requires a Premium plan for custom DNS. If you're on free Wix hosting,
  upgrade to any paid plan OR transfer the domain to Namecheap/Cloudflare
  (both free to manage DNS) and point from there.

**Update pushed but site hasn't changed**
→ Netlify dashboard → Deploys — confirm the latest deploy shows "Published".
→ Hard-refresh the browser: Ctrl + Shift + R.

---

## FILE STRUCTURE

```
alascharactercreator-site/
├── index.html       ← The entire app (copy of AlasCharacterCreator_V4.html)
├── netlify.toml     ← Netlify config: cache headers, redirects, security
├── _redirects       ← SPA fallback (all routes → index.html)
├── .gitignore       ← Excludes temp files from git
└── DEPLOYMENT.md    ← This file
```
