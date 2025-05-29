#!/usr/bin/env fish

if not fish_is_root_user
    echo "Should be run as root"
    exit 1
end

set config_file /etc/nixos/configuration.nix
set log_file /etc/nixos/rebuild.log

# Open config file in editor
hx $config_file

# Show git diff after editing
git diff $config_file

# Run nixos-rebuild and log output
echo "Running nixos-rebuild..."
nixos-rebuild switch &>$log_file

# Check for errors in log (case-insensitive)
set error_lines (grep -i 'error' $log_file)

if test -n "$error_lines"
    echo $error_lines
    exit 1
end

set generation (nixos-rebuild list-generations | grep 'current')

# No errors, commit the config
git add $config_file
git commit -m $generation
