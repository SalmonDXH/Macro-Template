Template for making macro use for Tower Defense game using AutoHotkey.

# Structure
## Code
```
project/
├── main.ahk and main/  (custom code for main)
├── background.ahk
├── webhook.ahk
├── heartbeat.ahk
├── lib/    (Store library ahk that can be reused)
├── data/   (where you store your local data / saved file)
│   ├── debug/      where you save debug logs using Logging)
│   └── screenshot/ (most screenshot will be saved here using Screenshot)
└── assets/ (Optional)
```
### Fundamental
I learn from my mistake that I made for AV 1 and 2 Macro. AutoHotkey run in 1 thread so when ever it send request or anything require internet connection or something require a long time to process it would block the script's next action
So parrelel program running is like **Async** stuff.
1. `main.ahk`
This is where user will see and run macro, it contain UI, function and work. Interface for user
2. `background.ahk`
I would use this for calculating background stuff like timer or storing session data, reward data ,...
3. `webhook.ahk` or can be called Request handler
This is where you would handle most of webhook stuff
4. `heartbeat.ahk`
This will check other program if they are still alive or nah, if the main gone or closed it will also close other program, if some program die mid way it will reopen them