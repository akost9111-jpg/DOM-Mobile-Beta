# DOM Messenger 1.3 — iOS prepared project

This package is prepared for building the native iPhone version.
It is NOT a web/PWA version.

Version: 1.3.0 (build 1)
Bundle ID: com.dom.messenger

Important:
- The iOS `ios/` folder is intentionally generated on the macOS/Flutter build machine so it matches that machine's Flutter/Xcode toolchain.
- `codemagic.yaml` contains the basic cloud-build configuration.
- Free Apple Account installation on a personal iPhone requires signing through Xcode and has Apple's free-signing limitations.
- TestFlight/App Store distribution requires Apple Developer Program membership.

Next step: upload this project to a macOS build service or open it on a Mac, run:
  flutter create --platforms=ios --org com.dom .
then configure signing for your Apple Account.
