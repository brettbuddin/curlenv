// Usage:
//
//   jsonnet -A now=2024-02-02T00:00:00Z data/example.jsonnet
//
function(now)
  {
    data: {
      now: now,
    },
  }
