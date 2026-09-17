# Validation status

This source package was recovered and reassembled from the conversation after the earlier
session's temporary workspace was cleared. It preserves the implemented launcher features;
it is not claimed to be a byte-for-byte copy of the earlier build.

The recovered Java source compiles against the Android API 35 library with Java 17.
The earlier unarchived build passed all nine unit tests, lint with no errors, and APK packaging.
The recovered package's Gradle result is recorded below before delivery.

## Device checks still required

- Install and open on the S24 Ultra; select Fluid Home and switch back to One UI Home.
- Exercise Home, Back, Recents, app launch/return, and process restart.
- Check all three pages, search, drawer navigation, keyboard, empty search, and app removal.
- Move/swap/group apps across pages and dock; restart and verify saved positions and folders.
- Bind and configure at least two real widget providers; cancel each setup path and retry.
- Check widget resizing, removal, process death during setup, and native widget gestures.
- Verify status/navigation/cutout insets, font scale, display zoom, and both navigation modes.
- Check sensor tilt, reduced motion, TalkBack, and disabled system animations.
- Inspect shader rendering and measure frame timing/thermals on the phone.
- Verify paused background rendering/sensor behavior and accessible-profile transitions.

No physical phone, Android emulator, or GPU rendering verification was available in this
session. A browser preview could not be visually verified because local-page navigation
was blocked by the browser's security policy. No screenshot is represented as a phone capture.

## Supplied launcher validation — September 16, 2026

- Full Gradle build: **passed** (`testDebugUnitTest lintDebug assembleDebug`).
- Unit tests: **9 passed**, 0 failures, 0 errors.
- Android lint: **0 errors**; 11 warnings.
- Debug APK: successfully packaged and development-signed.
- The supplied source previously passed with Java 17 / compile SDK 35 / Build Tools 35.0.0.
- Clean CI now pins Gradle 8.10.2 and AGP 8.7.3; the next Actions run is authoritative for
  that rebuilt project configuration.
- Source packaged after this fresh build; Android sources are no newer than its APK.
- No physical-device or emulator runtime claim.

Remaining lint warnings concern programmatic custom-view constructors, English UI text,
portrait orientation, the deliberately synchronous pending-widget preference commit, platform
backup guidance, and custom touch/accessibility handling. They have not been blanket-suppressed.
