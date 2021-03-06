# AntiApp

A valiant attempt to make an app that will revolutionize the way users think about super-apps. The app does the usual things in reverse (more in [Features](#features)).

## How to build

Just use `flutter build apk` / `futter build ios` / `flutter build web`

Also we are providing pre build releases:
- Android apk on [releases page](https://github.com/AzazKamaz/antiapp/releases/latest)
- Web release on [Github Pages](https://azazkamaz.github.io/antiapp/)

## Screens

- Home screen with a list of anti-apps.

- Screen of **AntiCalculator**.

- Screen of **AntiFlashlight**.

- Screens of **AntiWeather** (search and details).

- Screen of **AntiCamera**.

- Screen of **AntiCalendar**.

- Screen of **AntiNotes**.

- Screen of **AntiText**.

- **Settings** screen.

- **Info** screen.

## Features

Conceptual:

- **AntiCalculator** composes an equation where the entered number is the root.

- **AntiFlashlight** shines screen in black.

- **AntiWeather** shows the weather in units you don't want to see it in. Uses [OpenWeather API](https://openweathermap.org).

- **AntiCamera** deletes the last photo when taking a picture.

- **AntiCalendar** shows in what years and months there was such a number with such a day of the week.

- **AntiNotes** allows you to create notes, but then shows other users' notes.

- **AntiText** inverts the entered text according to the author's NLP technique with use of AI.

Useful for grading:

- `flutter_lints` is used.

- The iOS build is successful.

- The Web build is successful.

- GitHub release is created (using CI/CD).

- CI/CD contains linter check.

- Localization is implemented.

- Dark theme is implemented (switchable in the Settings menu).

- Firebase Crashlytics is added too.

- And additionally some other architectural and design features from the evaluation category Advanced...

## License

AntiApp is available under the [MIT license](https://github.com/AzazKamaz/antiapp/blob/master/LICENSE).

## AntiDev Team

Aleksandr Krotov, Karina Singatullina, Gleb Osotov, Igor Belov.
