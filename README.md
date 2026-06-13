# Antigravity Statusline

A lightweight custom status line for Antigravity CLI.

Displays useful session information directly in the prompt footer:

* Current Git branch
* Dirty repository state
* Context window usage
* Gemini quota usage
* Time until quota reset
* Current agent state

Example output:

```text
⎇ main* / ctx 2% / AI 69% / ↺ 19m / idle
```

## Requirements

* Antigravity CLI
* Bash
* jq
* Git

## Installation

Clone the repository:

```bash
https://github.com/amnotwallas/antigravity-config.git
```

Make the script executable:

```bash
chmod +x statusline.sh
```

Copy the script:

```bash
mkdir -p ~/.gemini/antigravity-cli

cp statusline.sh ~/.gemini/antigravity-cli/
```

Configure Antigravity CLI:

```json
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.gemini/antigravity-cli/statusline.sh",
    "enabled": true
  }
}
```

Reload Antigravity CLI and enable the status line:

```text
/statusline
```

## Color Behavior

### Git

* Green: clean repository
* Red: uncommitted changes

### Context Usage

* Green: under 50%
* Yellow: 50–79%
* Red: 80%+

### AI Quota

* Green: above 50%
* Yellow: 20–50%
* Red: below 20%

### Agent State

* Green: idle
* Yellow: thinking
* Cyan: working
* Magenta: tool_use

## Notes

The current Antigravity CLI payload does not expose Git branch or repository status information. This script retrieves those values directly from Git to provide accurate branch and dirty-state indicators.
