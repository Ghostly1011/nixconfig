#!/usr/bin/env fish

if not fish_is_root_user
    echo "Should be run as root"
    exit 1
end

set nixdir /home/oliverk/nixconfig/
set config_file "configuration.nix"
set log_file "rebuild.log"

pushd $nixdir

# Open config file in editor
hx $config_file

# Show git diff after editing
git diff

# Run nixos-rebuild and log output
echo "Running nixos-rebuild..."
nixos-rebuild switch &>$log_file

# Check for errors in log (case-insensitive)
set error_lines (grep -i 'error' $log_file)

if test -n "$error_lines"
    echo $error_lines
    exit 1
end

# No errors, commit the config
set generation (nixos-rebuild list-generations | grep 'current')

git add .
git commit -m $generation

popd
