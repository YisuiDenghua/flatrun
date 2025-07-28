#!/usr/bin/env bash

# Show help
show_help() {
    echo "Usage: flatrun [OPTIONS] APP_NAME"
    echo "Run a Flatpak application by matching its name or ID."
    echo ""
    echo "Options:"
    echo "  -c    Case-sensitive matching"
    echo "  -h    Show this help message"
    echo ""
    echo "Examples:"
    echo "  flatrun steam      # Runs com.valvesoftware.Steam"
    echo "  flatrun blackbox   # Runs com.raggesilver.BlackBox"
    echo "  flatrun -c Steam   # Only matches 'Steam' exactly (case-sensitive)"
}

# Default is case insensitive
case_sensitive=0

# Parsing parameters
while getopts ":ch" opt; do
    case $opt in
        c)
            case_sensitive=1
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

# Check if an Flatpak app ID is provided
if [ -z "$1" ]; then
    echo "Error: No application name provided."
    show_help
    exit 1
fi

app_name="$*"

# Get the Flatpak list
apps=$(flatpak list --columns=application,name 2>/dev/null)

if [ -z "$apps" ]; then
    echo "Error: No Flatpak applications installed or failed to get list."
    exit 1
fi

# Variables to store matching results
matched_id=""
matched_name=""
exact_match=""

# Read each line information of Flatpak apps
while IFS= read -r line; do
    # Split ID and app name
    id=$(echo "$line" | awk '{print $1}')
    name=$(echo "$line" | cut -f2-)
    
    # Check for matching
    if [ $case_sensitive -eq 1 ]; then
        # Check for case-sensitive matching
        if [[ "$name" == *"$app_name"* ]] || [[ "$id" == *"$app_name"* ]]; then
            # Check for exact match
            if [[ "$name" == "$app_name" ]] || [[ "$id" == "$app_name" ]]; then
                exact_match="$id"
                break
            fi
            matched_id="$id"
            matched_name="$name"
        fi
    else
        # Case-insensitive matching
        if [[ "${name,,}" == *"${app_name,,}"* ]] || [[ "${id,,}" == *"${app_name,,}"* ]]; then
            # Check for exact match
            if [[ "${name,,}" == "${app_name,,}" ]] || [[ "${id,,}" == "${app_name,,}" ]]; then
                exact_match="$id"
                break
            fi
            matched_id="$id"
            matched_name="$name"
        fi
    fi
done <<< "$apps"

# Prefer exact matches to results
if [ -n "$exact_match" ]; then
    echo "Running exact match: $exact_match"
    flatpak run "$exact_match"
elif [ -n "$matched_id" ]; then
    echo "Running best match: $matched_name ($matched_id)"
    flatpak run "$matched_id"
else
    echo "Error: No matching Flatpak application found for '$app_name'"
    echo "Installed applications:"
    echo "$apps" | awk '{printf "  %-30s %s\n", $1, $2}'
    exit 1
fi
