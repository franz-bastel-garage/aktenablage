# Offene Punkte -- Aktenablage

Stand 20.10.2026 (Umzug in die Organisation franz-bastel-garage)

Neue Adresse: https://franz-bastel-garage.github.io/aktenablage/ (index.html leitet
auf akte.html weiter). Die alte Adresse franzconsbruch.github.io leitet NICHT um.

- [ ] Dropbox-App (dropbox.com/developers/apps -> Settings -> OAuth 2 -> Redirect URIs)
      zusaetzlich eintragen:
      https://franz-bastel-garage.github.io/aktenablage/auth.html
      https://franz-bastel-garage.github.io/aktenablage/akte.html
      Die alten Eintraege koennen stehen bleiben, bis alles laeuft.
- [ ] Add-in "In Akte ablegen" im Admin Center (Integrierte Apps) aktualisieren.
      `manifest-fallback-verschachtelt.xml` hochladen (V1_0 aussen, V1_1 innen),
      nicht `manifest.xml` -- die allein stehende V1_1-Form lehnt das Admin Center
      seit Oktober ab (siehe README). Version 1.0.3.0, gleiche App-Id.
      Klappt es, `manifest.xml` durch die verschachtelte Fassung ersetzen.
- [ ] Add-in "Anhang aus Akte": `manifest-anhang.xml` (Version 1.0.1.0) im Admin
      Center aktualisieren.
- [ ] Danach in Outlook (und in Dropbox auf der Aktenseite) einmal neu anmelden --
      der Browser hat unter der neuen Adresse keine gespeicherte Anmeldung.
- [ ] Optional: lokales Remote umstellen (die alte Adresse leitet um, eilt nicht):
      git remote set-url origin https://github.com/franz-bastel-garage/aktenablage.git
