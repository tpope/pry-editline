# pry-editline

Whenever I'm using IRB or [Pry][], my editor always feels too far away.
Yes, there are [various gems](http://utilitybelt.rubyforge.org/) out
there that will let me spawn an editor and evaluate the result, but
that's not what I need.  Usually I'm about 80 characters or so into a
hairy one-liner when I think, "you know, I really wish I was in Vim
right about now."  In Bash, one can load the current command line into
an editor with `C-x C-e`.  And now, you can do the same in IRB and Pry.

The gem is named after [Pry][] so that it will be automatically loaded
as a Pry plugin (and because, let's face it, that's a good train to
hitch our wagon to).  But it also works in IRB if you add `require
'pry-editline'` to your `.irbrc`.

[Pry]: http://pry.github.com/

## FAQ

> `C-x C-e` is too hard to type.

You can add an alias for it in `~/.inputrc`.  Observe:

    $if Ruby
      "\C-o": "\C-x\C-e"
    $endif

Actually, I already added `C-o` for you.  So don't add that one.  It
already works.  It stands for "open".

> What about vi Readline bindings?

They're supported, too.  In addition to `C-x C-e` and `C-o` in insert
mode, you can use `o` or `v` in normal mode.

> It's not working in REE.

REE seems to have an incomplete Readline implementation. See [this
issue](https://github.com/tpope/pry-editline/pull/2).

> It's not working on OS X.

OS X ships with the Readline replacement Editline rather than GNU Readline.
It's a horribly crippled replacement, and it won't work with pry-editline.
The simplest way to get a proper Readline is with [Homebrew][]:

    brew install readline

You'll need to tell Ruby to use this Readline when configuring it.  If you're
compiling by hand, give it as an option to `./configure`:

    ./configure --with-readline-dir=$(brew --prefix readline)

If you use rbenv, check out the [rbenv-readline][] plugin to automatically
pass this option when compiling.  If you're using RVM, you can set configure
options in your `.rvmrc`:

    echo rvm_configure_flags=--with-readline-dir=$(brew --prefix readline) \
      >> ~/.rvmrc

[Homebrew]: http://mxcl.github.com/homebrew/
[rbenv-readline]: https://github.com/tpope/rbenv-readline

> It's not working with `rails console`/my Bundler setup.

If you can't/won't add it to your `Gemfile`, try this hack in your `.pryrc`:

    Gem.path.each do |gemset|
      $:.concat(Dir.glob("#{gemset}/gems/pry-*/lib"))
    end if defined?(Bundler)
    $:.uniq!
    require 'pry-editline'

Let me know if you come up with something better.

> How does it work?

Well first, it overrides `ENV['INPUTRC']` so it can do some magic.  And
then, it does some magic!

## Self Promotion

Follow [tpope](http://tpo.pe/) on [GitHub](https://github.com/tpope),
[Twitter](http://twitter.com/tpope), and [Google+](http://tpo.pe/plus).

## License

Copyright (c) Tim Pope.  MIT License.
