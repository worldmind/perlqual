# Collection of non-functional tests

This utility measures 'quality' of perl code.
Quality here means:
- code must have unit tests
- code must have low cyclomatic complexity
- code must be divided on small pieces
- Perl Best Practice used
- code style
- distribution organized like CPAN module
- code has documentation (POD)
- etc.

These tests can't say: "This code is good", but they can say: "This code is not ugly, not bad".

In the past it was a collection of tests in 'xt' directory,
but now it is a standalone utility.

## Installation

```
git clone git@github.com:worldmind/perlqual.git
cd perlqual
sudo cpanm --installdeps .
# some deps may require force install
sudo make install
```

If you use Debian based system, instead 'make install' you can use:
```
sudo checkinstall
```
For uninstall use:
```
sudo make uninstall
or
dpkg -r perlqual
```

## Using

1. Run in your project dir
```
perlqual
```
2. Outside project dir you can run
```
perlqual <project dir>
```
3. If your libraries not installed run
```
PERL5LIB=./lib perlqual
```

## Configuring

Perlqual has one (not required) command line argument - project directory
(by default it is current dir).
For configuring you must create config file named .perlqual
You can place this file in the home directory or in the project
directory (if some project need special settings).
Example and default config can be copy-pasted from __DATA__
section of perlqual script.
Some tests are disabled in default config!

## Ideas

1. Make copy-paste check based on Code::CutNPaste
2. Variables names spelling?
3. Immutability testing: my -> Readonly my ?
4. Unify test to: test_ok($_) for @perl_files;
