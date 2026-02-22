# Tower Defense Macro - AutoHotkey Template

A comprehensive AutoHotkey template for creating Tower Defense game macros with multi-process architecture, UI management, and webhook integration.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Core Modules](#core-modules)
- [Library Modules](#library-modules)
- [Getting Started](#getting-started)
- [Key Concepts](#key-concepts)

## Overview

This is a **multi-process macro framework** designed to overcome AutoHotkey's single-threaded limitations. It enables parallel execution of independent tasks without blocking the main script, allowing simultaneous network requests, UI updates, and background processing.

**Key Features:**

- Multi-process architecture for parallel execution
- Discord webhook integration
- Advanced screenshot & image recognition
- File and INI configuration management
- Comprehensive logging system
- UI management with coordinate configuration
- Session and reward tracking
- Process heartbeat monitoring

## Architecture

The macro uses a **distributed process model** with 4 main entry points:

```
┌─────────────────────────────────────────────────┐
│           main.ahk (UI & User Interface)        │
│  - Handles user interactions                    │
│  - Displays macro controls and status           │
│  - Coordinates with other processes             │
└──────────────┬──────────────────────────────────┘
               │
     ┌─────────┼─────────┐
     ▼         ▼         ▼
┌─────────┐ ┌─────────┐ ┌──────────┐
│background│ │webhook  │ │heartbeat │
│ .ahk     │ │ .ahk    │ │  .ahk    │
└─────────┘ └─────────┘ └──────────┘
    ▼          ▼            ▼
Logic &    Request      Process
Session    Handler      Monitor
Management
```

## Project Structure

```
template/
├── main.ahk                    # Main entry point (UI & user interface)
├── background.ahk             # Background logic & session management
├── webhook.ahk                # Request handler & API calls
├── heartbeat.ahk              # Process monitor & lifecycle manager
├── developer_tool.ahk         # Development utilities
│
├── main/                       # Main module (custom code)
│   ├── __init__.ahk
│   ├── backend/               # Backend logic
│   │   ├── __init__.ahk
│   │   ├── api/
│   │   │   ├── __init__.ahk
│   │   │   └── webhook/
│   │   │       ├── __init__.ahk
│   │   │       └── discord.ahk        # Discord webhook integration
│   │   ├── model/
│   │   │   ├── __init__.ahk
│   │   │   └── Roblox.ahk            # Roblox data models
│   │   └── path/
│   │
│   └── frontend/              # Frontend & UI layer
│       ├── __init__.ahk
│       ├── coordinate/        # Game coordinate management
│       │   ├── coordinate_config.ahk
│       │   └── coordinate_ui.ahk
│       ├── discord/
│       │   └── discord.ahk
│       ├── home/
│       │   └── home_ui.ahk
│       └── team/
│           ├── team_config.ahk
│           └── team_ui.ahk
│
├── lib/                        # Reusable libraries
│   ├── capture/               # Screen capture utilities
│   │   └── Capture.ahk
│   ├── discord/               # Discord webhook library
│   │   ├── WEBHOOK.ahk
│   │   └── resources/
│   │       ├── AttachmentBuilder.ahk
│   │       ├── EmbedBuilder.ahk
│   │       ├── FormData.ahk
│   │       ├── init.ahk
│       ├── JSON.ahk
│       └── WebHookBuilder.ahk
│   ├── file/                  # File operations
│   │   ├── __init__.ahk
│   │   ├── File.ahk
│   │   ├── IniFile.ahk
│   │   └── JsonFile.ahk
│   ├── findtext/              # Image recognition (FindText)
│   │   ├── CustomFindText.ahk
│   │   └── FindText.ahk
│   ├── logging/               # Logging system
│   │   └── Logging.ahk
│   ├── program/               # Program control
│   │   └── Program.ahk
│   ├── screenshot/            # Screenshot capture
│   │   ├── Screenshot.ahk
│   │   └── Gdip/              # GDI+ graphics library
│   │       ├── Gdip_All.ahk
│   │       ├── Gdip_Toolbox.ahk
│   │       └── Gdip_Toolbox-usage_example.ahk
│   ├── security/              # Security utilities
│   │   └── Scriptguard.ahk
│   ├── ui/                    # UI utilities
│   │   └── func/
│   │       └── UI.ahk
│   └── utilities/             # General utilities
│       ├── __init__.ahk
│       ├── MessageBox.ahk
│       ├── Mouse.ahk
│       ├── Move.ahk
│       ├── Timer.ahk
│       └── Utils.ahk
│
├── data/                       # Local data & storage
│   └── debug/                 # Debug logs
│
├── dll/                        # External DLL files
│
└── README.md                   # This file
```

## Core Modules

### 1. **main.ahk** - Master Control & User Interface

The primary entry point that users interact with.

**Responsibilities:**

- Launch the macro UI
- Handle user input and button clicks
- Display macro status and information
- Coordinate commands to other processes
- Manage the overall macro lifecycle

---

### 2. **background.ahk** - Background Logic & Processing

Handles non-blocking operations and state management.

**Responsibilities:**

- Calculate game logic and timers
- Store session data and rewards
- Track user progress
- Process background events
- Maintain internal state

---

### 3. **webhook.ahk** - Request Handler

Manages all network communications and API calls.

**Responsibilities:**

- Send HTTP requests
- Handle Discord webhook notifications
- Manage API responses
- Process incoming data from external services
- Format and send embed messages

---

### 4. **heartbeat.ahk** - Process Monitor & Lifecycle Manager

Ensures all processes remain alive and healthy.

**Responsibilities:**

- Monitor child process status
- Restart crashed processes
- Detect parent process termination
- Clean up resources on shutdown
- Maintain dependency chain

**Detection:**

- Automatically closes all child processes when main closes
- Restarts any crashed process
- Logs process lifecycle events

---

## Library Modules

### **File Operations** (`lib/file/`)

- `File.ahk` - General file I/O operations
- `IniFile.ahk` - INI configuration file handling
- `JsonFile.ahk` - JSON file parsing and writing

### **Discord Integration** (`lib/discord/`)

Complete Discord webhook support with embed builders.

**Features:**

- `WebHookBuilder.ahk` - Create and structure webhooks
- `EmbedBuilder.ahk` - Build rich embeds
- `AttachmentBuilder.ahk` - Handle file attachments
- `FormData.ahk` - Form data construction
- `JSON.ahk` - JSON utilities

### **Screenshot & Image Recognition** (`lib/screenshot/`, `lib/findtext/`)

- `Screenshot.ahk` - Capture screen regions
- `FindText.ahk` - Advanced image recognition
- `CustomFindText.ahk` - Extended FindText functionality
- `Gdip/Gdip_All.ahk` - GDI+ graphics manipulation

### **Logging** (`lib/logging/`)

- `Logging.ahk` - Create timestamped debug logs
- Output: `data/debug/` directory

### **UI Utilities** (`lib/ui/`)

- `UI.ahk` - GUI creation and management helpers

### **General Utilities** (`lib/utilities/`)

- `Mouse.ahk` - Mouse operations (move, click, etc.)
- `Move.ahk` - Movement utilities
- `Timer.ahk` - Timer and delay management
- `MessageBox.ahk` - Message box helpers
- `Utils.ahk` - General utility functions

### **Program Control** (`lib/program/`)

- `Program.ahk` - Launch and manage external programs

### **Security** (`lib/security/`)

- `Scriptguard.ahk` - Script protection utilities

---

## Getting Started

### Prerequisites

- AutoHotkey v2.0+ (recommended)
- Windows OS
- Game client (Tower Defense)

### Installation

1. Clone or download this template
2. Ensure all `.ahk` files are in the correct directory structure
3. Update game coordinates in `main/frontend/coordinate/`
4. Configure Discord webhook (if using notifications) in `main/backend/api/webhook/discord.ahk`

### Running the Macro

```batch
# Run main process (which spawns others)
AutoHotkey.exe main.ahk
```

The heartbeat process will automatically:

- Launch `background.ahk`
- Launch `webhook.ahk`
- Monitor all processes
- Restart any that crash

---

## Key Concepts

### **Parallel Execution (Async Pattern)**

Unlike traditional single-threaded AutoHotkey scripts, this template uses multiple processes to achieve parallel execution:

```
Problem:     When sending a web request, the entire script blocks until response arrives
Solution:    Use separate process (webhook.ahk) to handle requests asynchronously
Benefit:     UI remains responsive, game can continue running
```

### **Process Communication**

Processes communicate through:

- **Shared file system** (`data/`)
- **Window messages** (via heartbeat)
- **Global variables** (within same process)

### **Session Management**

- Session data stored in `data/` directory
- Persistent JSON/INI files for configuration
- Reward tracking across sessions

### **Error Handling & Logging**

- All errors logged to `data/debug/` via `Logging.ahk`
- Log files include timestamps and stack traces
- Review logs for troubleshooting

### **Configuration Management**

- Game coordinates: `main/frontend/coordinate/coordinate_config.ahk`
- Team settings: `main/frontend/team/team_config.ahk`
- Discord webhook: `main/backend/api/webhook/discord.ahk`

---

## Development Tips

1. **Add new features** in `main/frontend/` (UI) or `main/backend/` (logic)
2. **Use logging** extensively: `Logging.log("Message", "INFO")`
3. **Test independently** - Run individual `.ahk` files to debug
4. **Keep processes light** - Heavy work should happen in `background.ahk`
5. **Monitor heartbeat** - Check `heartbeat.ahk` logs if processes crash
6. **Use utilities** - Leverage `lib/` modules instead of rewriting code

---

## Troubleshooting

**Macro crashes on startup:**

- Check `data/debug/` for error logs
- Verify all library files exist
- Check coordinate configurations

**Processes keep restarting:**

- Review `heartbeat.ahk` logs
- Check for infinite loops or crashes
- Verify file permissions in `data/`

**Network requests fail:**

- Verify Discord webhook URL
- Check internet connection
- Review webhook response in logs

---

## License & Notes

This template was created to learn from previous macro iterations (AV 1 & 2) and improve on single-threaded limitations. The multi-process architecture is the key innovation enabling responsive, non-blocking macro execution.
