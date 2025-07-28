# flatrun
A script to run a flatpak app without knowing the full App ID


## Usage
```
Usage: flatrun [OPTIONS] APP_NAME
Run a Flatpak application by matching its name or ID.

Options:
  -c    Case-sensitive matching
  -h    Show this help message

Examples:
  flatrun steam      # Runs com.valvesoftware.Steam
  flatrun blackbox   # Runs com.raggesilver.BlackBox
  flatrun -c Steam   # Only matches 'Steam' exactly (case-sensitive)

```
