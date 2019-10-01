# Toi

This is an implementation of [Toi](https://esolangs.org/wiki/Toi), a language by esolangs user oklopol, in Dyalog APL.

This implementation does not implement base-10 numbers to represent their respective von Neumann numerals, and does not implement the error set. Any invalid character is ignored. Docs can be found in the esolangs page.

```shell
./toi /path/to/dyalog/folder/ program input [options]
```

where `options` can be empty, `j` for json output, or `d` for APL fancy boxed display of the final context. The `d` command prints in APL's boxed display by default unless specified otherwise.
