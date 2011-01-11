use inc::Module::Install;

name     'Module-Name';
all_from 'lib/Module/Name.pm';
author   q{worldmind <world.mind@yahoo.com>};
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

