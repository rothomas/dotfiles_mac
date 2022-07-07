# rothomas/dotfiles
My dotfiles.  Compatible with OS X and several Linuxes.
Primarily this bootstraps Homebrew on all platforms and uses that for utilities.

## Prerequisites

### Linux
1. Be root or have sudo access.
    - If you are root a `linuxbrew` user will be created for Homebrew.
2. You need a distro with a working package manager (which lightweight containers might not).

### Darwin
1. You're probably already an admin, but if not, you need to be.
2. Set a reasonable hostname if you don't like the default:
    - Rename the computer on the "Sharing" system preference panel.
    - `sudo hostname <name>.mydomain.com` (or possibly `<name>.local`)
    - Verify a couple of times. Sometimes this gets reverted and I don't know why.
3. Be signed in to your iCloud account to access the Mac App Store.
    - Check the "Apple ID" system preference panel. It might require additional steps.
4. XCode Command Line Tools need to be installed first: `xcode-select --install`
    - This cannot yet be done inline because the install runs in the background and the rest of the install doesn't wait on it.
5. We will attempt to install the following (free) utilities, which you should "purchase" in the app store first.
    - XCode       - Apple dev tools.
    - Spark       - an email client
    - Amphetamine - Keeps your Mac from going to sleep.
    - Magnet      - Snap to fullscreen or divided parts of the screen with drag or keystrokes.
    - WireGuard   - VPN Client
    - Notion      - Client for notion.so wikilike site.
6. Other apps installed via Homebrew, which may need configuration:
    - Dropbox - File sharing, needs login
    - Jump Desktop and Jump Desktop Connect - Remote desktop, needs login and security permissions
    - Meslo font with Nerd Fonts - Very good developer font, needs to be configured in your terminal
    - JetBrains Toolbox - Needs login if you use JetBrains tools.
    - ZeroTier One - VPN Client, needs attachment to existing network if desired
    - Flycut - Clipboard Manager
    - Slack - IM Client, needs login
    - Visual Studio Code - Free IDE
    - Docker - Container engine
    - Rectangle - Alternate window position manager
    - Sequel Pro - Database GUI
    - VirtualBox/VB Extension Pack/Vagrant - VMs, Intel only
    - Firefox - Browser
    - Chrome - Browser
    - iTerm2 - Better terminal app
    - 1Password, 1Password CLI - Password manager, needs login
7. After running:
    - Add login items on the "Users & Groups" system preference panel for your account. Recommended:
        - JetBrains Toolbox (if applicable)
        - ZeroTier (if applicable)
        - Docker
        - Flycut
        - Wireguard (if applicable)
        - Jump Desktop Connect (if applicable)
    - Log out and back in after updating login items.
        - You'll be prompted for sign-ins and permissions for many of the new login items.
        - You will also need to approve notifications from apps. This can be done from a first notification, or in the "Notifications & Focus" system preference pane.
    - For all the following steps, you might need to add permissions in the Security & Privacy system preference pane.
        - (Optional) Set up the accounts at the command line as well using `op account add` and answering the prompts.
    - Launch 1Password and sign into one or more accounts. Add browser extensions to all browsers.
    - Launch Amphetamine. Go through the opening panes, then select Preferences from the menu bar icon and select "Launch Amphetamine at Login"
    - Launch iTerm2. This will start tmux.
        - Edit preferences to update font to a Nerd Font (MesloLGS NF recommended)
        - Press `Ctrl+B I` (capital i) to load plugins and reload config. This will get you an improved theme.
    - Open and sign in to Slack
    - Open and sign in to Notion
    - Open Spark and add accounts or sign into an existing one.
        - The first email you add will become an address key for syncing between machines. Sign into that first on another machine and your other accounts will sync in automatically.
    - (Optional) Sign into your JetBrains account in JetBrains Toolbox and install IDE(s).
    - (Optional) Sign in to your DropBox account.
    - (Optional) Configure syncthing (http://localhost:8384)
    - Set up aws-vault according to documentation from your organization.

