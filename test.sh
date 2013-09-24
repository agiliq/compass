#!/bin/bash

export FOOBAR="_build/foobar"

assertEqual() {
    if [[ "$1" == "$2" ]];
        then echo ".";
    else
        echo "$1"
        echo "$2"
        echo "F";
        exit 1;
    fi
}

assertCheckoutMigration() {
    pushd $FOOBAR
    git checkout "$1"
    OUT=`echo ".schema baz_foo" | python manage.py dbshell`
    assertEqual "$OUT" "$2"
    popd
}

syncdb() {
	pushd $FOOBAR
	python manage.py syncdb --migrate --noinput
    popd
}

clean() {
    rm -rf _build/foobar/
}

extract_test_repo() {
    pushd _build
    tar -xzf foobar.tar.gz
    popd
}

install_compass() {
    pip install -e .
    pushd $FOOBAR
    django-south-compass install
    popd
}

clean
extract_test_repo
install_compass
syncdb
# master => id, name
# branch1 => id, name, bar1
# branch2 => id, name, bar1
assertCheckoutMigration branch1 'CREATE TABLE "baz_foo" ("bar1" varchar(20) NULL, "id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
assertCheckoutMigration master 'CREATE TABLE "baz_foo" ("id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
assertCheckoutMigration branch2 'CREATE TABLE "baz_foo" ("bar2" varchar(20) NULL, "id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
assertCheckoutMigration master 'CREATE TABLE "baz_foo" ("id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
clean
