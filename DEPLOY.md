# BodyTrack — Deployment Guide
## Files to upload to GitHub (all 5 files):
- index.html
- manifest.json
- sw.js
- icon-192.png
- icon-512.png

---

## STEP 1 — Upload to GitHub

1. Go to github.com → Sign in (or create free account)
2. Click the green **"New"** button → Create repository
   - Name: `bodytrack`
   - Set to **Public**
   - Click **Create repository**
3. On the next page click **"uploading an existing file"**
4. Drag all 5 files listed above into the upload area
5. Click **"Commit changes"**

---

## STEP 2 — Enable GitHub Pages

1. In your repo → click **Settings** (top tab)
2. Left menu → **Pages**
3. Under "Branch" select **main** → folder **/ (root)** → click **Save**
4. Wait 1-2 minutes → your site will be live at:
   `https://YOUR-GITHUB-USERNAME.github.io/bodytrack/`

---

## STEP 3 — Fix Supabase Redirect URL (IMPORTANT — fixes the login issue)

This is what caused the localhost redirect problem.

1. Go to your Supabase project → **Authentication → URL Configuration**
2. Under **"Redirect URLs"** click **Add URL** and add:
   `https://YOUR-GITHUB-USERNAME.github.io/bodytrack/`
3. Also add (for local testing):
   `http://localhost:3000`
   `http://127.0.0.1:5500`
4. Under **"Site URL"** set it to:
   `https://YOUR-GITHUB-USERNAME.github.io/bodytrack/`
5. Click **Save**

---

## STEP 4 — Fix Google OAuth Redirect URI

1. Go to console.cloud.google.com
2. APIs & Services → Credentials → click your OAuth Client
3. Under **"Authorized redirect URIs"** make sure you have:
   `https://pmkyzsoxjphnopspnvjf.supabase.co/auth/v1/callback`
4. Click **Save**

---

## STEP 5 — Install on Android as App

1. Open Chrome on your Android phone
2. Go to: `https://YOUR-GITHUB-USERNAME.github.io/bodytrack/`
3. Tap the **3-dot menu** (top right)
4. Tap **"Add to Home screen"**
5. Tap **"Add"** → BodyTrack appears on your home screen like a real app!

---

## STEP 6 — Share with others

Just share this URL:
`https://YOUR-GITHUB-USERNAME.github.io/bodytrack/`

Each person signs in with their own Google account → their data is completely separate.

---

## Troubleshooting

**Login redirects to localhost?**
→ Make sure Step 3 is done and the Site URL is set in Supabase.

**"Unable to exchange external code" error?**
→ Make sure the redirect URL in Supabase exactly matches your GitHub Pages URL (include trailing slash).

**App not updating after you edit files?**
→ Go to Chrome → Settings → Site Settings → find your site → Clear data. The service worker cache needs to be cleared.

**Data not saving?**
→ Make sure you ran the SQL in supabase_setup.sql in the Supabase SQL Editor.
