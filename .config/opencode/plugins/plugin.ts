import type { Plugin } from "@opencode-ai/plugin"
import { $ } from "bun"

async function sendWslNotification(title: string, msg: string) {
  try {
    // XML escape special characters
    const safeTitle = title.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
    const safeMsg = msg.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")

    const psScript = [
      "[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null",
      "[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null",
      `$template = '<toast><visual><binding template="ToastText02"><text id="1">${safeTitle}</text><text id="2">${safeMsg}</text></binding></visual></toast>'`,
      "$xml = New-Object Windows.Data.Xml.Dom.XmlDocument",
      "$xml.LoadXml($template)",
      "$toast = New-Object Windows.UI.Notifications.ToastNotification $xml",
      "[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('OpenCode').Show($toast)",
    ].join("; ")

    const encodedCommand = Buffer.from(psScript, "utf16le").toString("base64")
    await $`powershell.exe -NoProfile -NonInteractive -EncodedCommand ${encodedCommand}`.quiet()
  } catch {
    const hasNotifySend = await $`which notify-send`.text().then(() => true).catch(() => false)
    if (hasNotifySend) {
      await $`notify-send "${title}" "${msg}"`.quiet()
    }
  }
}

async function sendNotification(title: string, msg: string) {
  try {
    const isWsl = await $`uname -r | grep -i WSL`.text().then(() => true).catch(() => false)

    if (isWsl) {
      await sendWslNotification(title, msg)
      return
    }

    const hasNotifySend = await $`which notify-send`.text().then(() => true).catch(() => false)
    if (hasNotifySend) {
      await $`notify-send "${title}" "${msg}" --app-name=opencode`.quiet()
    }
  } catch (err) {
    // Silently fail
  }
}

const APP_NAME = "OpenCode"
const IDLE_SETTLE_MS = 2000

const MESSAGE_EVENTS = new Set([
  "message.part.delta",
  "message.part.updated",
  "message.updated",
])

export const NotificationPlugin: Plugin = async ({ client, directory, worktree }) => {
  let idleTimer: ReturnType<typeof setTimeout> | null = null
  let hadMessages = false
  let hadError = false
  let awaitingPermission = false

  const home = process.env.HOME || ""
  const stripHome = (p: string) => p.startsWith(home + "/") ? "~" + p.slice(home.length) : p
  const displayDir = directory ? stripHome(directory) : null
  const displayWork = worktree ? stripHome(worktree) : null

  function formatIdleMessage() {
    const parts: string[] = []
    if (displayDir) parts.push(displayDir)
    if (displayWork && displayWork !== displayDir) parts.push(`worktree: ${displayWork}`)
    parts.push("ready for your next input")
    return parts.join(" — ")
  }

  function scheduleIdleNotification() {
    if (idleTimer) clearTimeout(idleTimer)
    idleTimer = setTimeout(() => {
      idleTimer = null
      if (!hadMessages) return
      hadMessages = false
      sendNotification(APP_NAME, formatIdleMessage())
    }, IDLE_SETTLE_MS)
  }

  function cancelIdleNotification() {
    if (idleTimer) {
      clearTimeout(idleTimer)
      idleTimer = null
    }
  }

  return {
    event: async ({ event }) => {
      if (MESSAGE_EVENTS.has(event.type)) {
        hadMessages = true
        return
      }

      switch (event.type) {
        case "session.idle":
          if (awaitingPermission || hadError) {
            cancelIdleNotification()
          } else {
            scheduleIdleNotification()
          }
          break
        case "session.active":
          hadMessages = false
          hadError = false
          awaitingPermission = false
          cancelIdleNotification()
          break
        case "session.error":
          hadError = true
          cancelIdleNotification()
          sendNotification(APP_NAME, "An error occurred during generation — check the session for details")
          break
        case "permission.updated": {
          awaitingPermission = true
          cancelIdleNotification()
          const perm = event.properties
          const label = perm.title || perm.type
          sendNotification(APP_NAME, `Permission needed: ${label} — awaiting your approval`)
          break
        }
      }
    },
  }
}
