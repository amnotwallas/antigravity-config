# Antigravity Statusline
A lightweight statusline and title bar for [Antigravity CLI](https://antigravity.google/product/antigravity-cli), written in Bash.

**Statusline** (`statusline.sh`) — shown in the prompt footer:
```text
⎇ main* / ctx 2% / AI 69% / ↺ 19m / idle
```

**Title** (`title.sh`) — shown in the terminal title bar:
```text
antigravity-config | ⎇ main | idle
```

## Features

### `statusline.sh`
| Indicator | Description |
|---|---|
| `⎇ main*` | Current Git branch + dirty state |
| `ctx 2%` | Context window usage |
| `AI 69%` | Gemini quota remaining |
| `↺ 19m` | Time until quota reset |
| `idle` | Current agent state |

### `title.sh`
| Field | Description |
|---|---|
| `antigravity-config` | Project name (basename of cwd) |
| `⎇ main` | Current Git branch |
| `idle` | Current agent state |

## Requirements
- [Antigravity CLI](https://antigravity.google/product/antigravity-cli)
- Bash
- [`jq`](https://jqlang.org)
- Git

## Installation

**1. Clone the repository**
```bash
git clone https://github.com/amnotwallas/antigravity-config.git
```

**2. Copy scripts to the config directory**
```bash
mkdir -p ~/.gemini/antigravity-cli
cp statusline.sh title.sh ~/.gemini/antigravity-cli/
```

**3. Make scripts executable**
```bash
chmod +x ~/.gemini/antigravity-cli/statusline.sh
chmod +x ~/.gemini/antigravity-cli/title.sh
```

> [!IMPORTANT]
> Without this step, Antigravity CLI will silently fail to render the statusline or title.

**4. Configure Antigravity CLI**

Add to `~/.gemini/antigravity-cli/settings.json`:
```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.gemini/antigravity-cli/statusline.sh"
  },
  "title": {
    "type": "command",
    "command": "~/.gemini/antigravity-cli/title.sh"
  }
}
```

**5. Reload and enable**

Inside Antigravity CLI, run:
```
/statusline
/title
```

> [!NOTE]
> `vcs.branch` and `vcs.dirty` may not be available in all installations — the script falls back to reading Git directly.
