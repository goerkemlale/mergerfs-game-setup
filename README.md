# mergerfs-game-setup
If you want to mod a game in Linux but don't want to 'trash' your game directory, you should be looking this script. It is similar to [Skyrim's Mod Organizer 2](https://github.com/ModOrganizer2/modorganizer), which creates virtual overlay file system upon game directory.

This should be working theoretically every situation where file system is supported by *mergerfs*.


![Overlay File System](https://i.sstatic.net/QzaFD.png)

## Installation

### 0. Install [mergerfs](https://github.com/trapexit/mergerfs) (preferably from your distro repository)

### 1. Setup your directories like example below:
```
├── game
│   ├── cfg
│   │   └── main.cfg
│   └── game.exe
├── merged
├── mods
│   ├── 01-mod1
│   │   └── cfg
│   │       ├── mod12.cfg
│   │       └── mod1.cfg
│   └── 02-mod2
│       └── cfg
│           ├── mod12.cfg
│           └── mod2.cfg
```
### 3. Configure the first 4 environment variable: `DIR_BASE`, `DIR_MERGED`, `DIR_GAME`, and `DIR_MODS`
 
### 4. Make this script executable and run
```
chmod +x ./mergerfs-gamename.sh; ./mergerfs-gamename.sh
```
### 5. Unmount the folder and re-run the script everytime you make change.

### (Optional) Permanent mount
Just uncomment fstab lines (`23` and `24`)

## Usage
- `./game` folder is untouched directory (but it is not read-only mode, which is nice)
- All mods are seperated under `./mods` directory. For example `./mods/01-parachute`, `./mods/02-anime_cat_ears`...
- File tree must be same in all folders. (It is pain to do merge different layers from different directories. I'm keeping simple, sane way.)

MergerFS is opposite of "first come, first serve". When executing line `20`, the rightmost directory (also called "upper directory" in other implementations) in `$MERGERFS_DIRS` variable is the top layer. And my script is reordering directories A to Z (line `16`). So;
- When editing same files eg. `01-mod1/foo` and `02-mod2/foo`, **mod2**, which is lower at the mod list, takes precedence. That's why I suggest renaming directories with `01-xx` `02-yy` etc. You sorting mods manually anyway and I prefer sorting via more 'universally' method rather than embed it into script.
- Just change `sort` to `sort -r` in line `16`, if you want to revert this behavior.
- Therefore, this is not fully blown mod organizer. There are no exceptions, sorting rules etc. Because it will be different from game to game. This script just keeps your installation and directories clean. Just read these rules carefully.
- If you edit `/merged/mod12.cfg`, you change uppermost layer, which is **mod2** in this example.
- **But** if you delete `/merged/mod12.cfg`, you delete the file from **all layers**.

## Suggestions
- When there's conflict, create another directory named `00-mymodpacksolversomething` and solve *every conflict* **outside** of modX and modY, rather than implementing *patch/bugfix* inside of that mod. Then document this conflict elsewhere. Mods should be compact, there should not be personalized tweaks in mod folder itself. (if you reverse sort, just rename it to `9999-mymodpacksolversomething`)
- Do not even touch merged directory. Changes will only be made to the mod folder ("upper directories"), which is temporarily.
- If you want to have changes in base game, use game directory ("lowest directory", `$DIR_GAME`) which is permanently even if you delete mods folder.

## Approved (WIP to this list)
- *To be added*

### Games
- 

### Programs
-


## WIP, To Be Tested

### Games
#### Native Linux
- **Counter Strike 1.6:** Dedicated Server (applicable to other HLDS games too)
- **Mount Blade: Warband:** Modules
- **Emulation games:** memory card, images, patches etc.

#### Wine
- **SkyrimSE:** textures, replacement scripts
- **SkyrimSE:** SKSE .dlls
- **Mount Blade: Warband:** .dll modules
- **Grand Theft Auto San Andreas:** CLEO Mods

#### Virtual Runtimes (Java etc.)
- **Minecraft Java Edition:** world transfer
- **Minecraft Java Edition:** modding

### Containerized Games
- **Minecraft Waydroid Bedrock Edition:** world transfer

### Programs
- Any docker/podman applications: `mount image<-->host system<-->desired host folder`

# Credits
[trapexit](https://github.com/trapexit/) for [mergerfs](https://github.com/trapexit/mergerfs)
