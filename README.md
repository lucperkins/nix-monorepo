# Nix Monorepo

> This project has deep debts to Christine Dodrill's [blog](https://christine.website/) and to [Domen Kožar](https://www.domenkozar.com)'s discussion of [Nix anti-patterns](https://nix.dev/anti-patterns/index.html).

This is a somewhat silly project intended to show you how you might use Nix in a larger, multi-language project. It's mostly a learning exercise for your truly. Each of the language directories here contains a simple, "hello world"-style project for that language that provides a Nix shell configuration (`shell.nix`). The current languages:

* [Elixir](./elixir)
* [Go](./golang)
* [Rust](./rust)

A few characteristics of the project worth mentioning:

* This repo uses [Niv](https://github.com/nmattia/niv) to provide "pinned" versions of [nixpkgs](https://github.com/nixos/nixpkgs) and some other repositories. I think that this approach is more declarative and "pure" than relying on the oft-encountered `<nixpkgs>`.
* The [`nix`](./nix) directory provides not just the generated `sources.nix` and `sources.json` files that Niv relies upon, but also a central source of language-specific Nix functions and variables that can be used by the language-specific sub-projects. This reduces the amount of boilerplate that's necessary in project-specific Nix files.
