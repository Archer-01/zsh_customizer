#!/bin/zsh

# Colors
NC="\e[1;0m"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
PURPLE="\e[1;35m"

# URLs
OMZ_URL="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
ZSH_SYNTAX="https://github.com/zsh-users/zsh-syntax-highlighting.git"
ZSH_AUTOSUGGEST="https://github.com/zsh-users/zsh-autosuggestions"

# Paths
OMZ_CUSTOM_PLUGIN_DIR="${HOME}/.oh-my-zsh/custom/plugins"
OMZ_SYNTAX="$OMZ_CUSTOM_PLUGIN_DIR/zsh-syntax-highlighting"
OMZ_AUTOSUGGEST="$OMZ_CUSTOM_PLUGIN_DIR/zsh-autosuggestions"

# Functions
add_plugin()
{
	PLUGIN_NAME=$1
	if [ -z "$PLUGIN_NAME" ]; then
		exit
	fi

	OMZ_PLUGINS=`awk "/^plugins/" $HOME/.zshrc`
	echo $OMZ_PLUGINS | grep "$PLUGIN_NAME" > /dev/null
	if [ "$?" -ne 0 ]; then
		OMZ_NEW_PLUGINS=`echo $OMZ_PLUGINS | sed "s/)/ $PLUGIN_NAME)/"`
		cd $HOME
		sed "s/$OMZ_PLUGINS/$OMZ_NEW_PLUGINS/" $HOME/.zshrc > newzshrc
		mv newzshrc $HOME/.zshrc
	fi
}

echo "${PURPLE}zsh_customizer${NC} (by ${BLUE}hhamza${NC})"
echo

# Installing oh-my-zsh
echo "${YELLOW}Verifying dependencies...${NC}"
if [ -d "$HOME/.oh-my-zsh" ]; then
	echo "${BLUE}oh-my-zsh${NC} is already installed"
else
	echo "${BLUE}oh-my-zsh${NC} is not installed"
	echo "Installing ${BLUE}oh-my-zsh${NC}..."
	./omz.sh &> /dev/null
	if [ "$?" -eq "0" ]; then
		echo "${BLUE}oh-my-zsh${NC} installed ${GREEN}successfully${NC}"
	else
		echo "${BLUE}oh-my-zsh${NC} install ${RED}failed${NC}"
		echo "Aborting..."
		return 1
	fi
fi
echo "Dependency check ${GREEN}done!${NC}"
echo

echo "${YELLOW}Installing dependencies...${NC}"
echo

echo "Installing ${GREEN}zsh-syntax-highlighting${NC}..."
if [ -d "$OMZ_SYNTAX" ]; then
	echo "${BLUE}zsh-syntax-highlighting${NC} is already installed"
else
	git clone --quiet "$ZSH_SYNTAX" "$OMZ_SYNTAX"
	if [ "$?" -ne "0" ]; then
		echo "${RED}Error${NC} installing ${RED}zsh-syntax-highlighting${NC}"
		echo "Aborting..."
		return 1
	fi
	add_plugin "zsh-syntax-highlighting"
	if [ "$?" -ne "0" ]; then
		echo "${RED}Error${NC} installing ${RED}zsh-syntax-highlighting${NC}"
		echo "Aborting..."
		return 1
	else
		echo "${BLUE}zsh-syntax-highlighting${NC} installed ${GREEN}successfully${NC}"
	fi
fi
echo

echo "Installing ${GREEN}zsh-autosuggestions${NC}..."
if [ -d "$OMZ_AUTOSUGGEST" ]; then
	echo "${BLUE}zsh-autosuggestions${NC} is already installed"
else
	git clone --quiet "$ZSH_AUTOSUGGEST" "$OMZ_AUTOSUGGEST"
	if [ "$?" -ne "0" ]; then
		echo "${RED}Error${NC} installing ${RED}zsh-autosuggestions${NC}"
		echo "Aborting..."
		return 1
	fi
	add_plugin "zsh-autosuggestions"
	if [ "$?" -ne "0" ]; then
		echo "${RED}Error${NC} installing ${RED}zsh-autosuggestions${NC}"
		echo "Aborting..."
		return 1
	else
		echo "${BLUE}zsh-autosuggestions${NC} installed ${GREEN}successfully${NC}"
	fi
fi
echo

echo "Plugin installing ${GREEN}done!${NC}"
echo

echo "${GREEN}Script complete!${NC}"

zsh
# echo "${YELLOW}Installing plugins...${NC}"
# if [ -d "$OMZ_AUTOSUGGEST" ]; then
# 	echo "${BLUE}zsh-autosuggestions${NC} is already installed"
# fi
# if [ -d "$OMZ_SYNTAX" ]; then
# 	echo "${BLUE}zsh-syntax-highlighting${NC} is already installed"
# fi