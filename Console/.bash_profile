# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,aliases,functions,inputrc}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

# added by Anaconda2 4.0.0 installer
export PATH="/Users/niccolomarcon/anaconda2/bin:$PATH"
