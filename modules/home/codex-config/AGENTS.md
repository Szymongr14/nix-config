# Global instructions for Codex

Behavioral guidelines that apply to every Codex session. Project-specific
instructions go in `AGENTS.md` at the project root and stack on top.

## 1. Think before coding

- State assumptions explicitly. Ask if uncertain.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so.

## 2. Simplicity first

- Minimum code that solves the problem. Nothing speculative.
- No abstractions for single-use code.
- No error handling for impossible scenarios.

## 3. Surgical changes

- Touch only what the task requires.
- Don't refactor adjacent code that isn't broken.
- Match existing style.

## 4. Goal-driven execution

- Define success criteria before starting.
- Convert vague tasks ("fix the bug") into verifiable ones ("write a failing
  test, then make it pass").
