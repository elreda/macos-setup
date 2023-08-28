macos-setup
============


## Why?

Setting up a new machine can be a **time-consuming** process.  This aims to **simplify** the process with **dotfiles/scripts** to **automate the setup** of the following:

* **macOS updates, defaults and Xcode Command Line Tools**
* **Dev tools**: Vim, bash, tab completion, git, Python, R, etc.


Credits: This repo builds on the awesome work from [Donne Martin](https://github.com/elreda/macos-setup)


This repo takes uses a combination of **Homebrew and shell scripts** to do basic system setup.  



## Section 1: Installation

* [Install Script](#single-setup-script)
   * install is an executable script that runs all other scripts
* [bootstrap.sh script](#bootstrapsh-script)
    * Syncs macos-setup to your local home directory `~`
* [macosprep.sh script](#macosprepsh-script)
    * Updates macOS and installs Xcode command line tools
* [brew.sh script](#brewsh-script)
    * Installs Homebrew formulae and apps
* [macos.sh script](#macossh-script)
    * Sets up macOS defaults


## Section 2: General Apps and Tools

* [Terminal Customization](#terminal-customization)
* [Vim](#vim)
* [Git](#git)
* [VirtualBox](#virtualbox)
* [Homebrew](#homebrew)
* [Python](#python)
* [Pip](#pip)


## Section 1: Installation

### Single Setup Script

#### Running with Git

##### Clone the Repo

    $ git clone https://github.com/elreda/macos-setup.git && cd macos-setup

##### Run the install Script with Command Line Arguments

**Since you probably don't want to install every section**, the `install` script supports command line arguments to run only specified sections.  Simply pass in the [scripts](#scripts) that you want to install.  Below are some examples.

**For more customization, you can [clone](#clone-the-repo) or [fork](https://github.com/elreda/macos-setup/fork) the repo and tweak the `install` script and its associated components to suit your needs.**

Run all:

    $ ./install all

Run `bootstrap.sh`, `macosprep.sh`, `brew.sh`, and `macos.sh`:

    $ ./install bootstrap macosprep brew macos


#### Running without Git

    $ curl -O https://raw.githubusercontent.com/elreda/macos-setup/master/install && ./install [Add ARGS Here]

#### Scripts

* [install.sh](https://github.com/elreda/macos-setup/blob/master/install.sh)
    * Runs specified scripts
* [bootstrap.sh](https://github.com/elreda/macos-setup/blob/master/bootstrap.sh)
    * Syncs all dotfiles to the local home directory `~`
* [macosprep.sh](https://github.com/elreda/macos-setup/blob/master/macosprep.sh)
    * Updates macOS and installs Xcode command line tools
* [brew.sh](https://github.com/elreda/macos-setup/blob/master/brew.sh)
    * Installs common Homebrew formulae and apps
* [macos.sh](https://github.com/elreda/macos-setup/blob/master/macos.sh)
    * Sets up macOS defaults geared towards developers


**Notes:**

* `install` will initially prompt you to enter your password.
* `install` might ask you to re-enter your password at certain stages of the installation.
* If macOS updates require a restart, simply run `install` again to resume where you left off.
* When installing the Xcode command line tools, a dialog box will confirm installation.
    * Once Xcode is installed, follow the instructions on the terminal to continue.
* `install` runs `brew.sh`, which takes awhile to complete as some formulae need to be installed from source.
* **When `install` completes, be sure to restart your computer for all updates to take effect.**

The following discussions describe in greater detail what is executed when running the [install](https://github.com/elreda/macos-setup/blob/master/install) script.

### bootstrap.sh script

The `bootstrap.sh` script will sync the macos-setup repo to your local home directory.  This will include customizations for Vim, bash, curl, git, tab completion, aliases, a number of utility functions, etc.  Section 2 of this repo describes some of the customizations.

#### Running with Git

First, fork or [clone the repo](#clone-the-repo).  The `bootstrap.sh` script will pull in the latest version and copy the files to your home folder `~`:

    $ source bootstrap.sh

To update later on, just run that command again.

Alternatively, to update while avoiding the confirmation prompt:

    $ set -- -f; source bootstrap.sh

#### Running without Git

To sync macos-setup to your local home directory without Git, run the following:

    $ cd ~; curl -#L https://github.com/elreda/macos-setup/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,LICENSE}

To update later on, just run that command again.

#### Optional: Specify PATH

If `~/.path` exists, it will be sourced along with the other files before any feature testing (such as detecting which version of `ls` is being used takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

#### Optional: Add Custom Commands

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
GIT_AUTHOR_NAME="Reda"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="git@truly.simplelogin.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# Pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# Install or upgrade a global package
# Usage: gpip install –upgrade pip setuptools virtualenv
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
```

You could also use `~/.extra` to override settings, functions, and aliases from the macos-setup repository, although it’s probably better to [fork the macos-setup repository](https://github.com/elreda/macos-setup/fork).

### macosprep.sh script


Run the `macosprep.sh` script:

    $ ./macosprep.sh

`macosprep.sh` will first install all updates.  If a restart is required, simply run the script again.  Once all updates are installed, `macosprep.sh` will then [Install Xcode Command Line Tools](#install-xcode-command-line-tools).

If you want to go the manual route, you can also install all updates by running "App Store", selecting the "Updates" icon, then updating both the OS and installed apps.

#### Install Xcode Command Line Tools

An important dependency before many tools such as Homebrew can work is the **Command Line Tools for Xcode**. These include compilers like gcc that will allow you to build from source.

You can install the Xcode Command Line Tools directly from the command line with:

    $ xcode-select --install

**Note**: the `macosprep.sh` script executes this command.

Running the command above will display a dialog where you can either:
* Install Xcode and the command line tools
* Install the command line tools only
* Cancel the install



### brew.sh script


When setting up a new Mac, you may want to install [Homebrew](http://brew.sh/), a package manager that simplifies installing and updating applications or libraries.

Some of the apps installed by the `brew.sh` script include: Firefox, Skype, VirtualBox, etc.  **For a full listing of installed formulae and apps, refer to the commented [brew.sh source file](https://github.com/elreda/macos-setup/blob/master/brew.sh) directly and tweak it to suit your needs.**

Run the `brew.sh` script:

    $ ./brew.sh

The `brew.sh` script takes awhile to complete, as some formulae need to be installed from source.

**For your terminal customization to take full effect, quit and re-start the terminal**

### macos.sh script


When setting up a new Mac, you may want to set macOS defaults geared towards developers.  The `macos.sh` script also configures common third-party apps such Sublime Text and Chrome.

**Note**: **I strongly encourage you read through the commented [macos.sh source file](https://github.com/elreda/macos-setup/blob/master/macos.sh) and tweak any settings based on your personal preferences.  The script defaults are intended for you to customize.**  For example, if you are not running an SSD you might want to change some of the settings listed in the SSD section.

Run the `macos.sh` script:

    $ ./macos.sh

**For your terminal customization to take full effect, quit and re-start the terminal.**

## Section 2: General Apps and Tools


### Terminal Customization

Since we spend so much time in the terminal, we should try to make it a more pleasant and colorful place.

#### Configuration

The [bootstrap.sh script](#bootstrapsh-script) and [macos.sh script](#macossh-script) contain terminal customizations.


### Vim

For example, when you run a Git commit, it will open Vim to allow you to type the commit message.

I suggest you read a tutorial on Vim. Grasping the concept of the two "modes" of the editor, **Insert** (by pressing `i`) and **Normal** (by pressing `Esc` to exit Insert mode), will be the part that feels most unnatural. After that it's just remembering a few important keys.

#### Configuration

The [bootstrap.sh script](#bootstrapsh-script) contains Vim customizations.


### Git

#### Installation

Git should have been installed when you ran through the [Install Xcode Command Line Tools](#install-xcode-command-line-tools) section.

#### Configuration

To check your version of Git, run the following command:

    $ git --version

And `$ which git` should output `/usr/local/bin/git`.

Let's set up some basic configuration. Download the [.gitconfig](https://raw.githubusercontent.com/elreda/macos-setup/master/.gitconfig) file to your home directory:

    $ cd ~
    $ curl -O https://raw.githubusercontent.com/elreda/macos-setup/master/.gitconfig

It will add some color to the `status`, `branch`, and `diff` Git commands, as well as a couple aliases. Feel free to take a look at the contents of the file, and add to it to your liking.

Next, we'll define your Git user (should be the same name and email you use for [GitHub](https://github.com/) and [Heroku](http://www.heroku.com/)):

    $ git config --global user.name "Your Name Here"
    $ git config --global user.email "your_email@youremail.com"

They will get added to your `.gitconfig` file.

To push code to your GitHub repositories, we're going to use the recommended HTTPS method (versus SSH). So you don't have to type your username and password everytime, let's enable Git password caching as described [here](https://help.github.com/articles/set-up-git):

    $ git config --global credential.helper osxkeychain

**Note**: On a Mac, it is important to remember to add `.DS_Store` (a hidden macOS system file that's put in folders) to your `.gitignore` files. You can take a look at this repository's [.gitignore](https://github.com/elreda/macos-setup/blob/master/.gitignore) file for inspiration.  Also check out GitHub's [collection of .gitignore templates](https://github.com/github/gitignore).

### Homebrew


Package managers make it so much easier to install and update applications (for Operating Systems) or libraries (for programming languages). The most popular one for macOS is [Homebrew](http://brew.sh/).

#### Installation

The [brew.sh script](#brewsh-script) installs Homebrew and a number of useful Homebrew formulae and apps.

If you prefer to install it separately, run the following command and follow the steps on the screen:

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#### Usage

To install a package (or **Formula** in Homebrew vocabulary) simply type:

    $ brew install <formula>

To update Homebrew's directory of formulae, run:

    $ brew update

**Note**: I've seen that command fail sometimes because of a bug. If that ever happens, run the following (when you have Git installed):

    $ cd /usr/local
    $ git fetch origin
    $ git reset --hard origin/master

To see if any of your packages need to be updated:

    $ brew outdated

To update a package:

    $ brew upgrade <formula>

Homebrew keeps older versions of packages installed, in case you want to roll back. That rarely is necessary, so you can do some cleanup to get rid of those old versions:

    $ brew cleanup

To see what you have installed (with their version numbers):

    $ brew list --versions


### Python


macOS, like Linux, ships with [Python](http://python.org/) already installed. But you don't want to mess with the system Python (some system tools rely on it, etc.), so we'll install our own version with Homebrew. It will also allow us to get the very latest version of Python 2.7 and Python 3.

#### Installation

The [brew.sh script](#brewsh-script) installs the latest versions of Python 2 and Python 3.


## License

This repository contains a variety of content; some from third-parties.  The third-party content is distributed under the license provided by those parties.

The content specific to this repo is distributed under the following license:



    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
