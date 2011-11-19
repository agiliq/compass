WHAT:
-----

Compass is a tool to guide your south migrations.

It is a git hook that keeps your south migrations in sync with your repository.

INSTALL:
--------

Setup and packaging coming soon

Untill then, just put `bin` in your PATH.

Go to your repository and do

    $ compass install

EXAMPLE:
--------

    $ git branch
        * master
        feature1
        feature2

    $ git checkout feature1
        *Migrates to any new migrations added in feature1*

    $ git checkout master
        *Migrates back to the last migration in master*

    $ git checkout feature2
        *Does the same for feature2*

    $ git checkout feature1
        *Migrates back to the last migration common between feature1 and feature2, then migrates forward to feature1*

THANKS:
-------

Compass was inspired by [hookup](https://github.com/tpope/hookup) for rails.
