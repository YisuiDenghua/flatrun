#!/usr/bin/env bash

# Version
VERSION="0.1.1"

# Help
show_help() {
    echo "Usage: flatrun [OPTIONS] APP_NAME [ -- SUB_COMMANDS]"
    echo "Run a Flatpak application by matching its name or ID."
    echo ""
    echo "Options:"
    echo "  -c    Case-sensitive matching"
    echo "  -v    Show version information"
    echo "  -h    Show this help message"
    echo ""
    echo "Examples:"
    echo "  flatrun steam              # Runs com.valvesoftware.Steam"
    echo "  flatrun -c Steam           # Case-sensitive match"
    echo "  flatrun vlc -- --version   # Passes --version to VLC"
}

# Default is case-insensitive
case_sensitive=0

# Parsing
while getopts ":chv" opt; do
    case $opt in
        c) case_sensitive=1 ;;
        v)
            echo "flatrun version $VERSION"
            exit 0
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            show_help
            exit 1
            ;;
    esac
done

shift $((OPTIND-1))

# Subcommand
app_query=""
sub_args=()
found_divider=false

for arg in "$@"; do
    if [ "$arg" == "--" ] && [ "$found_divider" = false ]; then
        found_divider=true
        continue
    fi

    if [ "$found_divider" = true ]; then
        sub_args+=("$arg")
    else
        # Search app keywords
        if [ -z "$app_query" ]; then
            app_query="$arg"
        else
            app_query="$app_query $arg"
        fi
    fi
done

# Check if the app's name is provided.
if [ -z "$app_query" ]; then
    echo "Error: No application name provided."
    show_help
    exit 1
fi

# Get Flatpak list
apps=$(flatpak list --columns=application,name 2>/dev/null)

if [ -z "$apps" ]; then
    echo "Error: No Flatpak applications installed or failed to get list."
    exit 1
fi

# Namespace collision
mapfile -t matched_ids < <(
    while IFS= read -r line; do
        id=$(echo "$line" | awk '{print $1}')
        name=$(echo "$line" | cut -f2-)
        
        if [ $case_sensitive -eq 1 ]; then
            if [[ "$name" == *"$app_query"* ]] || [[ "$id" == *"$app_query"* ]]; then
                echo "$id"
            fi
        else
            if [[ "${name,,}" == *"${app_query,,}"* ]] || [[ "${id,,}" == *"${app_query,,}"* ]]; then
                echo "$id"
            fi
        fi
    done <<< "$apps"
)

match_count=${#matched_ids[@]}

# Process match resolt
final_id=""

if [ $match_count -eq 0 ]; then
    echo "Error: No matching Flatpak application found for '$app_query'"
    exit 1
elif [ $match_count -eq 1 ]; then
    final_id="${matched_ids[0]}"
else
    # Check for exact matches (exact matches preferred).
    for id in "${matched_ids[@]}"; do
        if [ "$id" == "$app_query" ]; then
            final_id="$id"
            break
        fi
    done

    # If no exact match is found, proceed to manual selection.
    if [ -z "$final_id" ]; then
        echo "Multiple matches found for '$app_query':"
        PS3="Please select an application (1-$match_count): "
        select opt in "${matched_ids[@]}"; do
            if [ -n "$opt" ]; then
                final_id="$opt"
                break
            else
                echo "Invalid selection."
            fi
        done
    fi
fi

# Run
if [ -n "$final_id" ]; then
    echo "Running: $final_id"
    flatpak run "$final_id" "${sub_args[@]}"
fi