# Offene Punkte -- Aktenablage

Stand 20.10.2026 (Umzug in die Organisation franz-bastel-garage)

Neue Adresse: https://franz-bastel-garage.github.io/aktenablage/ (index.html leitet
auf akte.html weiter). Die alte Adresse franzconsbruch.github.io leitet NICHT um.

Manifeste: genau zwei, `manifest-in-akte-ablegen.xml` und
`manifest-anhang-aus-akte.xml`. Beide am 20.10.2026 im Admin Center erfolgreich
aktualisiert (1.0.3.0 bzw. 1.0.1.0).

- [ ] Dropbox-App (dropbox.com/developers/apps -> Settings -> OAuth 2 -> Redirect URIs)
      zusaetzlich eintragen, falls noch nicht geschehen:
      https://franz-bastel-garage.github.io/aktenablage/auth.html
      https://franz-bastel-garage.github.io/aktenablage/akte.html
- [ ] "Anhang aus Akte" hat bisher NIE in Outlook auftauchen wollen. Vermutung:
      Die V1_1-Fassung wurde vom Admin Center abgelehnt, die V1_0-Fassung ist am
      20.10.2026 erstmals sicher drin. Nach der Bereitstellung (bis 24 h) testen:
      neue Mail -> Menueband "Apps" -> "Anhang aus Akte". Taucht es dann immer
      noch nicht auf: Admin Center pruefen (Status, Benutzer zugewiesen) und
      melden, in welchem Outlook getestet wurde (neu/klassisch/Web).
- [ ] Falls das Test-Add-in "Ablage Test" (App-Id 19e4863d-...) im Admin Center
      steht: dort entfernen, die Manifestdatei ist geloescht.
- [ ] Nach der Bereitstellung in Outlook einmal neu bei Dropbox anmelden.
- [ ] Optional: lokales Remote umstellen (die alte Adresse leitet um, eilt nicht):
      git remote set-url origin https://github.com/franz-bastel-garage/aktenablage.git
