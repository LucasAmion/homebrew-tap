# LucasAmion/homebrew-tap

Homebrew formulae and casks for the [WiZzard](https://github.com/LucasAmion)
projects — tools for controlling Philips WiZ smart bulbs.

```sh
brew install LucasAmion/tap/<name>
```

`brew tap LucasAmion/tap` first is not necessary; the fully qualified name taps
it implicitly.

## Contents

| Formula | Project | Notes |
| --- | --- | --- |
| `wizlight` | [wizlight-rs](https://github.com/LucasAmion/wizlight-rs) | The CLI. Arrives with the first release built by `dist` |

A cask for the WiZzard desktop app will live here too, once the app has
releases to point at.

## This repository is generated

**Do not edit `Formula/*.rb` by hand.** Each formula is produced by
[`dist`](https://opensource.axo.dev/cargo-dist/) during the source project's
release workflow and committed here automatically, authored by "axo bot" —
that name is hardcoded in dist's template and is expected.

To change a formula, change the source project and cut a release. An edit made
here is overwritten by the next tag.

## Prereleases

Homebrew has no concept of a prerelease: a formula pins exactly one version, and
`brew install` takes whatever it currently says. While a project is still
publishing alphas, that is what you will get — deliberately, so the release
path is exercised before it matters.
