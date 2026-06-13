# Antigravity Statusline

A lightweight statusline and title bar for [Antigravity CLI](https://github.com/amnotwallas/antigravity-config), written in Bash.

Displays live session context directly in the prompt footer and terminal title — no external services, no dependencies beyond what you already have.

**Statusline** (`statusline.sh`) — shown in the prompt footer:

```text
⎇ main* / ctx 2% / AI 69% / ↺ 19m / idle
```

**Title** (`title.sh`) — shown in the terminal title bar:

```text
antigravity-config | ⎇ main | idle
```

---

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
| `antigravity-config` | Project name (basename of current working directory) |
| `main` | Current Git branch |
| `idle` | Current agent state |

---

## Requirements

- [Antigravity CLI](https://github.com/amnotwallas/antigravity-config)
- Bash
- [`jq`](https://stedman.us/jq/)
- Git

---

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

**4. Configure Antigravity CLI**

Add the following to your Antigravity CLI config file:

```jsonc
{
  "statusLine": {
    "type": "command",
    "command": "bash ~/.gemini/antigravity-cli/statusline.sh",
    "enabled": true
  },
  "title": {
    "type": "command",
    "command": "~/.gemini/antigravity-cli/title.sh",
    "enabled": true
  }
}
```

**5. Reload and enable**

Inside Antigravity CLI, run:

```text
/statusline
/title
```

---

## Color Reference

### Git branch

| Color | Meaning |
|---|---|
| 🟢 Green | Clean repository |
| 🔴 Red | Uncommitted changes |

### Context usage

| Color | Threshold |
|---|---|
| 🟢 Green | < 50% |
| 🟡 Yellow | 50–79% |
| 🔴 Red | ≥ 80% |

### AI quota

| Color | Threshold |
|---|---|
| 🟢 Green | > 50% remaining |
| 🟡 Yellow | 20–50% remaining |
| 🔴 Red | < 20% remaining |

### Agent state

| Color | State |
|---|---|
| 🟢 Green | `idle` |
| 🟡 Yellow | `thinking` |
| 🔵 Cyan | `working` |
| 🟣 Magenta | `tool_use` |

---

## Notes

The Antigravity CLI payload does not expose Git branch or repository status. `statusline.sh` reads those values directly from Git to keep branch and dirty-state indicators accurate.
