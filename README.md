# Mongui

Mongui is an extremely simple HTTP GUI for Mongo, created with Sinatra.

## Features

Currently Mongui has the following features:

* Show all databases, and their collections
* Present collections with all their rows

### Known bugs

* Error whenever you want to access GridFS
* Embedded document presentation doesn't work too well

# Installation

Simple guide on how to get Mongui running on your system.

## Install dependencies

Install the Mongo Ruby driver, as well as Sinatra:
    gem install mongo bson sinatra

## Fire up Mongui

    git clone git://github.com/Sirupsen/Mongui.git
    cd Mongui
    ruby mongui.rb
    Sinatra has taken the stage on http://localhost:4567..

Now simply direct your browser to [localhost:4567](http://localhost:4567) and a list of your databases, and their collections should show up!
