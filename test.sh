#!/bin/bash

export FOOBAR="tests/foobar"

assertEqual() {
    if [[ "$1" == "$2" ]];
        then echo ".";
    else
        echo "$1"
        echo "$2"
        echo "F";
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
    rm -rf tests/foobar/
}

extract_test_repo() {
    pushd tests
    tar -xzf foobar.tar.gz
    popd
}

extract_test_repo
syncdb
assertCheckoutMigration branch1 'CREATE TABLE "baz_foo" ("bar1" varchar(20) NULL, "id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
assertCheckoutMigration master 'CREATE TABLE "baz_foo" ("id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
assertCheckoutMigration branch2 'CREATE TABLE "baz_foo" ("bar2" varchar(20) NULL, "id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
assertCheckoutMigration master 'CREATE TABLE "baz_foo" ("id" integer PRIMARY KEY, "name" varchar(20) NOT NULL);'
clean
