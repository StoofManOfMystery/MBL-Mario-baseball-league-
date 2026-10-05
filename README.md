# MBL — Mario Baseball League

A Yahoo-Fantasy-style web app for a six-manager Mario Super Sluggers league.

- `league.html` — the app source, published as a shared claude.ai artifact (live rosters, waivers, scores shared between all managers).
- `index.html` — the same page wrapped so it opens straight from disk. Opened this way it runs in browser-only mode: everything is saved in that browser's local storage and nothing is shared.

## League format

- Two conferences: **Super League** (Connor, Nolan, Stefano) and **Shitter League** (Matas, James, Brodie).
- Each team plays its two conference rivals three times and the other three teams twice: 12 games over 12 weeks, one game a week.
- Rosters hold at most 11 characters (9 starters + 2 bench) and exactly one home stadium, which can only be swapped for another stadium. The home team's stadium hosts the game.
- Dropped players sit on waivers (2 days by default). Claims resolve in waiver-priority order; the winning team moves to the bottom of the order. Unclaimed players become free agents.
- Trades are proposed by one manager and accepted or rejected by the other.

Week 1: Stefano @ Nolan, Connor @ Oakland A's (Brodie), Matas @ James.

## Passcodes

Each manager unlocks their own team with a 6-digit passcode (stored hashed in the shared database). The commissioner sets or changes codes from the League tab and can restart the waiver clock from the same card.

## Hosting on GitHub Pages with a shared Firebase database

`index.html` is built from `league.html` by `build.sh`, and the Pages workflow in `.github/workflows/pages.yml` deploys it on every push to `master`. Without a Firebase config the hosted page runs in browser-only mode (nothing shared). To share:

1. Create a Firebase project at https://console.firebase.google.com (any name, Analytics off).
2. Build → Firestore Database → Create database → start in **production mode**, pick a region.
3. In Firestore → Rules, replace the rules with the block below and publish:

   ```
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /{document=**} {
         allow read, write: if true;
       }
     }
   }
   ```

   This makes the database writable by anyone who has the page URL, which is what a friends league needs. The passcodes in the page keep managers on their own teams.
4. Project settings (gear icon) → Your apps → Web (`</>`) → register the app → copy the `firebaseConfig` object.
5. Paste it into `config.js`:

   ```js
   window.MBL_FIREBASE = { apiKey: "...", authDomain: "...", projectId: "...", storageBucket: "...", messagingSenderId: "...", appId: "..." };
   ```
6. Commit and push. Open the Pages URL, choose a commissioner passcode on the setup screen, then set each manager's passcode on the League tab.
