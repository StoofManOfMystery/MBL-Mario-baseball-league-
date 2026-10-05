# MBL — Mario Baseball League

A Yahoo-Fantasy-style web app for a six-manager Mario Super Sluggers league.

- `league.html` — the app source, published as a shared claude.ai artifact (live rosters, waivers, scores shared between all managers).
- `index.html` — the same page wrapped so it opens straight from disk. Opened this way it runs in browser-only mode: everything is saved in that browser's local storage and nothing is shared.

## League format

- Two conferences: **Super League** (Connor, Nolan, Stefano) and **Shitter League** (Matas, James, Brodie).
- Each team plays its two conference rivals three times and the other three teams twice: 12 games over 12 weeks, one game a week.
- Rosters hold 12 characters (9 starters + 3 bench) and one home stadium. The home team's stadium hosts the game.
- Dropped players sit on waivers (2 days by default). Claims resolve in waiver-priority order; the winning team moves to the bottom of the order. Unclaimed players become free agents.
- Trades are proposed by one manager and accepted or rejected by the other.

Week 1: Stefano @ Nolan, Connor @ Oakland A's (Brodie), Matas @ James.
