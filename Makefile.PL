use inc::Module::Install;

name            ('List-Permutor-LOL');
abstract        ('Permute lists inside a list');
author          ('Kang-min Liu <gugod@gugod.org>');
license         ('perl');
version_from    ('lib/List/Permutor/LOL.pm');
requires        ('List::Permutor');
requires        ('Clone');
build_requires  ('Test::More');

&WriteAll;

