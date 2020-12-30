# EvoRTS-Chobby

EvolutionRTS mutator for Chobby

# Download links

- [Linux](https://content.spring-launcher.com/EvolutionRTS/EvoRTS-Chobby/Evolution%20RTS.AppImage)
- [Windows](https://content.spring-launcher.com/EvolutionRTS/EvoRTS-Chobby/Evolution%20RTS.exe)
- [Windows-Portable](https://content.spring-launcher.com/EvolutionRTS/EvoRTS-Chobby/Evolution%20RTS-portable.exe)

# Development setup

1. Download using one of the links above and start the application.
2. Start the application once using the "Stable" or "Test" version and launch the lobby. This will download the engine and other dependencies.
3. Open the install folder (there's a button for that in the launcher), and clone this repository inside the `games` folder, `git clone https://github.com/EvolutionRTS/EvoRTS-Chobby.git EvoRTS-Chobby.sdd`
4. Choose the "Dev Lobby" config which will run the lobby version on your PC. You can now develop and test any EvoRTS specific lobby functionality.
5. If you want to develop Chobby itself, clone it in the `games` folder similar to step 3: `git clone https://github.com/Spring-Chobby/Chobby.git Chobby.sdd`. You must also change the `depend` table in `EvoRTS-Chobby.sdd/modinfo.lua` to use `Chobby $VERSION` instead of `rapid://chobby:test`.
