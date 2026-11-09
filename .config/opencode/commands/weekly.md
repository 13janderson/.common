---
description: Complete this week's weekly reflection using last week's note
---

Help me complete this week's weekly note in `./weekly`. The vault root is the
directory containing `./weekly`; run commands from there.

Do not write to the note until you have asked me the questions in step 2 and I
have answered. Additional context from me: $ARGUMENTS

## Steps

### 1. Locate the notes

- Work out the current week's Monday and the previous week's Monday from today's
  date.
- The note filename format is `Mon-DD-Mon-YYYY.md` (e.g.
  `Mon-19-Oct-2026.md`). Use the previous Monday as **last week's note** and the
  current Monday as **this week's note**.
- Each weekly note is split into two top level sections: (1) reflections from last week and (2) 
  any thoughts accrued throughout this week as we go and what the goal(s) for this week are.
- Goal(s) are drafted at the start of the week and might have additional notes
  around them with are accumulated during that week.
- If the exact previous-Monday file does not exist, use the most recent weekly
  note dated before this week's Monday.
- If this week's note does not exist, create it from `./templates/weekly.md`,
  replacing `{{wc}}` with the current Monday and `{{lwc}}` with last week's
  Monday. Match the existing frontmatter convention used by other notes:
  `id` and an `aliases` entry of the same name, `tags: [weekly]`.
- Read last week's note in full. Also read this week's note and the template.

### 2. Ask questions before writing anything

Ask a small batch of questions at a time (roughly 2-4 related questions), wait
for the answers, then ask the next batch. Adapt follow-ups to what I say. 
For all questions, you must use the question skill

Cover, in roughly this order:

1. **Last week's goal and stretch goals**: how did it go? What actually happened, what progress
   was made, what got in the way? Ask for concrete detail and evidence. If a 
   goal is marked complete then take this as concrete evidence of that completion.
   In which case all you really need to ask me is if I have any thoughts around
   that goal.
2. **Topics raised in last week's Thoughts** anything unresolved, a decision, a worry, or a plan. Do not ask generic questions
   that ignore last week's content.
3. **This week's goal**: what should the goal be for the upcoming week? Push
   for a concrete, measurable goal and 1-3 sub-steps. Ask what "done" looks
   like.
4. **This week's stretch aim(s)**: optional stretch goal and its sub-steps, or
   confirm there is none.
5. **Reminders and weekends**: anything to remember for the week, and any
   planned weekend events. Pick up any reminders from last week which don't
   appear to be addressed and raise these with me. For adding new reminders,
   these aren't life events that I need to be reminded of as such but this is
   instead more of a dumping ground for things which I would like to defer
   thinking about or exploring properly until next weeks reflection.

Reflect my own words and first-person voice back; do not invent events,
feelings, or progress.

### 3. Write this week's note

Fill the existing template. The structure must not change:

- Keep the frontmatter keys and values.
- Keep `Week Commencing: [[<current Monday>]]`.
- Keep `# Reflections for [[<last Monday>]]:` followed by `General:`, `Dating:`,
  `Career:`, `Extra:`, `Thoughts:` in that order.
- Keep `# Weekly aims:` with the `Revisit [[time_bucketing]]` checkbox, then
  `Goal:` with nested sub-bullets, then `Stretch:` with nested sub-bullets.
- Keep `# Reminders:`.
- Do not add, remove, rename, or reorder sections. Do not add new headings.
- Leave a section blank if I had nothing to say for it rather than inventing
  content.

Formatting conventions:

- Use first-person bullets, like the existing notes.
- Use Markdown checkboxes only where the template has them.
- Use existing status markers when reporting progress: `- [x]` done,
  `- [~]` partial, `- [!]` blocked/not done, `- [ ]` not started.
- Use `[[wiki links]]` for note references I make.
- Date thoughts as `YYYY-MM-DD: ...` at the start of the bullet (for example
  `2026-10-19: ...`).
- Under `Goal:` and `Stretch:`, restate the aim as `Goal: <aim>` and
  `Stretch: <aim>`, then add the concrete sub-steps as nested `- [ ]` bullets.

If my answers clearly contradict the checkbox states in last week's note,
update those checkboxes to match and tell me. Do not otherwise rewrite last
week's note.

### 4. Finish

After writing, show me a short summary of what was filled in, flag any sections
left blank, and ask whether anything needs adjusting. Do not commit the note
unless I ask.
