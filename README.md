EmojiOne v2 Installer
---

**Flashable ZIP** to replace Android [emoji set](https://www.google.com/get/noto/help/emoji/) with [EmojiOne](https://www.emojione.com/emoji/v2). This also includes an OTA survival `addon.d` script.

EmojiOne v2 is an emoji set more comprehensible than Android's one [before Marshmallow](http://blog.emojipedia.org/android-6-0-1-emoji-changelog/).  
Version 2 of EmojiOne is the last [open and free](https://github.com/Ranks/emojione/blob/2.2.7/LICENSE.md) version of EmojiOne. EmojiOne v3 and later are **not open** to the public anymore.  
The flashable ZIP saves a copy of the previous installed emoji on your device at `/system/fonts/NotoColorEmoji.ttf.old`.


Build
===

Run:
```
make build
```

This will generate a `emojione.zip` in the `build/` folder.

To make a public release, run:
```
make release
```

This will generate a `emojione_YYYY-MM-DD.zip` file in the `releases/` folder.


Install
===

You'll need a custom recovery installed on your device, such as [TWRP](https://twrp.me/).

Restart your device into recovery and start `ADB sideload`. Then run:
```
adb sideload <flashable-zip-name>
```

Alternatively, copy the resulting ZIP to your device storage, restart your device into recovery and use the GUI `Install` or `Install ZIP` option.
