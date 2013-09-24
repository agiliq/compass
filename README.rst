django-south-compass
====================

.. image:: https://travis-ci.org/agiliq/compass.png?branch=master
   :target: https://travis-ci.org/agiliq/compass
   :alt: Build Status

What is it?
-----------

Django south compass is a tool to guide your south migrations.

It is a git hook that keeps your south migrations in sync with your repository.

Installation
------------

pip install django-south-compass

Usage
-----

Go to your git repo and do:

.. code-block: bash

    $ django-south-compass install

This will setup a git hook so that whenever you checkout a branch, you're
migrations are synced up.

Eg.

.. code-block:: bash

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


License
-------

3 Clause BSD.

Bug report and Help
-------------------

For bug reports open a github ticket. Patches gratefully accepted. Need help? `Contact us here`_

.. _contact us here: http://agiliq.com/contactus

Thanks
------

Django south compass was inspired by `hookup`_ for rails.

.. _hookup: https://github.com/tpope/hookup
