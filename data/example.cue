package example

// Usage:
//
//   cue export -t now=2024-02-02T00:00:00Z data/example.cue
//
data: now: string @tag(now)
