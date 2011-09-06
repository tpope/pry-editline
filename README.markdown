pry-editline
------------

Whenever I'm using IRB or [Pry][], my editor always feels too far away.
Yes, there are [various gems](http://utilitybelt.rubyforge.org/) out
there that will let me spawn an editor and evaluate the result, but
that's not what I need.  Usually I'm about 80 characters or so into a
hairy one-liner when I think, "you know, I really wish I was in Vim
right about now."  In Bash, one can load the current command line into
an editor with `C-x C-e`.  And now, you can do so in IRB and Pry.

The gem is named after [Pry][] so that it will be automatically loaded
as a Pry plugin (and because, let's face it, that's a good train to
hitch our wagon to).  But it also works in IRB if you add `require
'pry-editline'` to your `.irbrc`.

[Pry]: http://pry.github.com/

FAQ
---

> `C-x C-e` is too hard to type.

You can add an alias for it in `~/.inputrc`.  Observe:

    $if Ruby
      "\C-o": "\C-x\C-e"
    $endif

Actually, I already added `C-o` for you.  So don't add that one.  It
already works.  It stands for "open".

> It's not working on OS X.

By default, readline on OS X uses libedit.  I don't know what that means
exactly other than it leaves you with a horribly crippled readline that
doesn't work with pry-editline.  To link against a different readline,
pass the `--with-readline-dir=` flag to `./configure`.  If you're using
RVM, pass it to `rvm install`.  Or better yet, make it the default:

    echo rvm_configure_flags=--with-readline-dir=/usr/local >> ~/.rvmrc

To *install* a readline to `/usr/local`, you might consider using
Homebrew.  After installing, you need instruct it to link that readline
into `/usr/local`:

    brew install readline
    brew link readline

Actually for me, it went more like:

    $ brew install readline
    ...
    $ brew link readline
    Error: readline has multiple installed versions
    $ brew link readline 6.2.1
    Error: readline has multiple installed versions
    $ brew link readline -v6.2.1
    Error: readline has multiple installed versions
    $ brew link -v6.2.1 readline
    Error: readline has multiple installed versions
    $ brew remove readline
    Error: readline has multiple installed versions
    Use `brew remove --force readline` to remove all versions.
    $ brew remove -v6.1 readline
    Error: readline has multiple installed versions
    Use `brew remove --force readline` to remove all versions.
    $ brew remove --force readline
    Uninstalling readline...
    $ brew install readline
    ...
    $ brew link readline

Yeah, it's a bit of a pain.  Sorry your OS hates you. :(

> It's not working with `rails console`/my Bundler setup.

[Here's one potential workaround][workaround].  You might have to
explicitly `require 'pry-editline'` in your `.pryrc`, too.

[workaround]: https://github.com/carlhuda/bundler/issues/183#issuecomment-1149953

> How does it work?

Well first, it overrides `ENV['INPUTRC']` so it can do some magic.  And
then, it does some magic!

License
-------

Copyright (c) Tim Pope.  MIT License.
