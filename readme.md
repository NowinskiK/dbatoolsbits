# Rob & Jess' Magical Bits Training Day Repository

This is the repository we'll be using for our SQLBits Training Day.

We recommend downloading the repo and getting the local demo environment setup on your laptop. This way you can follow along with the demos.

## Prerequisites:

- [git](https://git-scm.com/downloads)
- [VSCode](https://code.visualstudio.com/download)
- [`Remote - Containers` Extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## Setup

1. Download the repo from GitHub
    ```PowerShell
    # change directory to where you'd like the repo to go
    cd C:\GitHub\

    # clone the repo from GitHub
    git clone https://github.com/SQLDBAWithABeard/Bitsdbatools

    # move into the folder
    cd .\Bitsdbatools\

    # open VSCode
    code .
    ```

1. Once code opens, there should be a toast in the bottom right that suggests you 'ReOpen in Container'.
1. The first time you do this it may take a little, and you'll need an internet connection, as it'll download the container images used in our demos
1. Final step is to type `Get-Index` into the pwsh console and start your adventure...