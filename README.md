# ⚡ behr\_blackout

A lightweight, easy-to-use FiveM script to toggle full server-wide blackouts – perfect for events, roleplay, or emergencies. This script includes a configurable command, support for multiple notification methods, and a physical power switch location for immersive RP toggles.

---

## ✨ Features

* ✅ Simple `/blackout` toggle command (configurable)
* ✅ Optional power switch location to toggle blackout in RP
* ✅ Supports `chat` or `ox_lib` notifications
* ✅ Debug logging for development/testing
* ✅ Easy to configure and integrate

---

## 🛠️ Installation

1. **Clone or Download** this repository into your `resources` folder:

   ```
   ensure behr_blackout
   ```

2. **Dependencies:**

   * [ox\_lib](https://overextended.dev/)
   * Make sure `ox_lib` is started **before** `behr_blackout` in your `server.cfg`

3. **Configuration:**
   Open `config.lua` and adjust the following:

   ```lua
   Config.BlackoutCommand = "blackout"       -- Command to trigger blackout
   Config.Notify = "oxlib"                   -- Options: "chat", "oxlib"
   Config.PowerSwitchLocation = vector3(...) -- Optional RP toggle location
   Config.Debug = true                       -- Enable/disable debug messages
   ```

---

## ⚡ Usage

### 🔌 Toggling Blackout

* Use `/blackout` to turn power off/on across the entire server.  
* This will:  

  * Disable all street and building lights  
  * Disable traffic signals  
  * Broadcast a server-side blackout status  

### 🗺️ Power Switch Interaction (Optional)

* Go to the configured location (`Config.PowerSwitchLocation`)  
* Trigger blackout in-character for RP immersion *(Currently admin-only)*  

---

## 🔧 Customization

### Notification System

* The script supports different notification systems:  

  * `"chat"`: Uses standard `TriggerEvent("chat:addMessage")`  
  * `"oxlib"`: Uses `lib.notify()`  
* You can extend the notification logic in `client.lua` with your own custom notification method.  

---

## 🔍 Debugging

* Set `Config.Debug = true` to enable helpful logs in the console  
* Logs will indicate when blackout is toggled, when notifications are sent, and if any permissions or values are missing  

---

## 📁 File Structure

```
behr_blackout/  
├── client/  
│   └── client.lua  
├── server/  
│   └── server.lua  
├── shared/  
│   └── config.lua  
├── fxmanifest.lua  
``` 

---

## 🧪 To Do / Roadmap

* Add role-based permissions (e.g., only staff can toggle blackout)  
* Add interaction targeting support for power switch (e.g., with `ox_target`)  
* Add audio/visual effects when blackout is triggered  
* Sync blackout to new players joining mid-session  

---

## 💬 Credits

**Script by:** Behr
**Dependency:** [ox\_lib](https://github.com/overextended/ox_lib)

---

## 📜 License

This script is provided **as-is** with no warranty. You may modify and use it for personal and community use. Please credit the original author when releasing modifications or forks.