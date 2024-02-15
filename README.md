# curlenv

**curlenv** set of conventions for managing prepared HTTP requests via [curl](https://curl.se).
Environments are just collections of shell environment variables that are managed by [direnv](https://direnv.net).

It aims to be a simple command-line alternative to [Postman](https://www.postman.com) that directly leverages well known tools.

⚠️  curl v8.6.0 has a bug that prevents curl from failing when it encounters a missing environment variable. I
[reported the bug](https://curl.se/mail/archive-2024-02/0008.html) and it was fixed in [curl/curl@0f0edc2](https://github.com/curl/curl/commit/0f0edc283c340e8ddddc763b48d2f835b2270ab4). A new release hasn't been cut at the time of this writing, but it's recommended you use that new release when it arrives.

⚠️  This project uses direnv's `source_env` and `source_env_if_exists` functions to apply environment files. These functions are [documented](https://direnv.net/man/direnv-stdlib.1.html) as not using direnv's security framework. This is a potential attack vector, and means you must trust repository committers and audit changes to environments in contributions.

## Template

This a template repository and meant to be cloned as a starting point for your own project. In GitHub you can click the
`Use this template` button at the top of this page to get started.

Files within [env](env), [data](data), [request](request), and [workflow](workflow) directories are only examples and
can be deleted to be replaced by our own. They exist as a starting point for your own work.

---

## Directories and Files

| Name              | Description                                                                           |
| ----------------       | -----------------------------------                                                   |
| [env/](env)             | `*.envrc` files for [direnv](https://direnv.net).                                     |
| [data/](data)           | Static and templated data files.                                                      |
| [request/](request)     | Requests defined by [curl configuration files](https://curl.se/docs/manpage.html#-K). |
| [workflow/](workflow) | Compositions using `data` and `request` files.                                        |
| [.envrc](.envrc) | Entrypoint file for [direnv](https://direnv.net). |
| [required-variables.txt](required-variables.txt) | List of environment variables that are considered required for the project. All environments must set these variables. |
| .localrc | Uncommitted, local run commands sourced by [.envrc](.envrc) |
| .curlenv.envrc | Generated by [`bin/curlenv-switch`](bin/curlenv-switch) using `*.envrc` files in [env/](env). This file is sourced by [.envrc](.envrc) by direnv. |

## Environments

Environments are managed by direnv and loaded with the `bin/curlenv-switch` command.

Refer to the [direnv documentation](https://direnv.net/man/direnv.1.html) for `*.envrc` syntax and [stdlib
functions](https://direnv.net/man/direnv-stdlib.1.html).

You can load environments via the [`bin/curlenv-switch`](bin/curlenv-switch) script. The command accepts a single argument for the environment name. References to both the primary environment file (`<name>.envrc`) and optional secrets file (`<name>.secret.envrc`) are placed into a file at the root of the project called `.curlenv.envrc`.

```
; curlenv-switch staging
direnv: loading ~/example/.envrc
direnv: loading ~/example/.curlenv.envrc
direnv: loading ~/example/env/example.envrc
direnv: export +EXAMPLE_HEADER +EXAMPLE_HOSTPORT +EXAMPLE_SCHEME +CURLENV_CURRENT -PS2 ~PATH
```

Environment variables added to `required-variables.txt` are added to the generated `.curlenv.envrc` file so `direnv`
alerts you of missing environment variables across different environments.
