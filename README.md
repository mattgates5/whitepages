whitepages
==========

Super simple directory service using Sinatra, yaml, and erb.

To run:

    $ ruby whitepages.rb

You can access the whitepages at [localhost:4567](http://localhost:4567/).
The server requires a `directory.yaml` to exist in the same directory.

Entries can be written thus:

    testgroup:
      - name: Bob Person
        email: person@email.tld
        sms: +12345678910
      - name: Xavier Ample
        email: xample@example.com
        sms: +4455555555

Usage
-----

    /                   default page (shows help)
    /help               help page
    /groups             list available groups
    /methods            list available contact methods
    /[method]/[group]   show contact information for group with method

Requirements
------------

* sinatra
* yaml
