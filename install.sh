#!/bin/zsh

OMZ_URL="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
OMZ_CUSTOM_PLUGIN_DIR="${HOME}/.oh-my-zsh/custom/plugins"

# * oh-my-zsh install
echo "Verifying dependencies..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "oh-my-zsh is not installed"
	echo "Installing oh-my-zsh"
	sh -c "$(curl -fsSL $OMZ_URL)"
fi
echo "oh-my-zsh Installed successfully"

# * Getting plugins

cd "$OMZ_CUSTOM_PLUGIN_DIR"
if [ ! -d "$OMZ_CUSTOM_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
	git clone --quiet "https://github.com/zsh-users/zsh-syntax-highlighting.git" \
		"$OMZ_CUSTOM_PLUGIN_DIR/zsh-syntax-highlighting"
fi
if [ ! -d "$OMZ_CUSTOM_PLUGIN_DIR/zsh-autosuggestions" ]; then
	git clone --quiet "https://github.com/zsh-users/zsh-autosuggestions"\
		"$OMZ_CUSTOM_PLUGIN_DIR/zsh-autosuggestions"
fi

# * Updating .zshrc
add_plugin()
{
	PLUGIN_NAME=$1
	if [ -z "$PLUGIN_NAME" ]; then
		exit
	fi

	OMZ_PLUGINS=`awk "/^plugins/" $HOME/.zshrc`
	echo $OMZ_PLUGINS | grep "$PLUGIN_NAME"
	if [ "$?" -ne 0 ]; then
		OMZ_NEW_PLUGINS=`echo $OMZ_PLUGINS | sed "s/)/ $PLUGIN_NAME)/"`
		cd $HOME
		sed "s/$OMZ_PLUGINS/$OMZ_NEW_PLUGINS/" $HOME/.zshrc > newzshrc
		mv newzshrc $HOME/.zshrc
	fi
}

add_plugin "zsh-autosuggestions"
add_plugin "zsh-syntax-highlighting"