source $ZSH_CUSTOM/aliases.zsh

for the_file ($ZSH_CUSTOM/alias/*.zsh); do
  source $the_file
done

for the_file ($ZSH_CUSTOM/config/*.zsh); do
  source $the_file
done
