This file can be viewed as HTML at:
doc/index.html

----------------------------------------------------------------------

This project uses inline Ruby scripting (ERB) to generate substantial portions
of the NetLinx files. These files end in ***.axi.erb***, and the `.erb` extension
is dropped when the script is compiled.

***MODIFICATIONS*** to the project should be performed in the `.axi.erb` files, as
their `.axi` counterparts are regenerated when the project is compiled.
This means that proficiency in the Ruby programming language is *REQUIRED*
to make changes to this project. There are plenty of online tutorials and
books about Ruby for a programmer to learn the skills required to maintain
this project within several weeks. See the development section below.

***COMPILING*** the project is a simple process with the right
build tools, which are listed below.

----------------------------------------------------------------------

## Build Tools


In addition to the AMX developer tools, the following are required:


### Ruby Installer

> http://rubyinstaller.org/downloads

Ruby 2.0.0-p451 was used for this project.
Higher versions will probably be compatible.

The DEVKIT listed on the download page should
also be installed.


### Ruby Gems

Rake and Bundler are required.

From the command line:

	gem install rake bundler


### Building The Project

From the command line in the project's `amx` directory:

	bundle update
	bundle exec rake

The files will be auto-generated and compiled, at which point
they can be loaded onto the master with the AMX FileTransfer2
utility or NetLinx Studio.



## Development

Although it is possible to maintain this project with a standard text
editor, or possibly NetLinx Studio, it is far easier with a few
additional tools.


### Sublime Text 3

> http://www.sublimetext.com/3


### Sublime Text AMX NetLinx Plugin

> http://sourceforge.net/p/sublime-netlinx/wiki/install-via-version-control
	
This plugin, available for Sublime Text, allows for syntax highlighting of the
`.axi.erb` files and makes the inline Ruby blocks significantly easier to view.

Note: At the time of this writing the syntax highlighting is under development
in the `dev` branch of the plugin repository. However, it will ideally be merged
into `default` by the time this project needs to be maintained.


### Rake

> https://github.com/jimweirich/rake

Installed via `gem install rake`.

This is the program that launches the automated tasks.

	Build system:
	
		`bundle exec rake`
	
	Run tests, generate doc:
	
		`bundle exec test'


### RSpec

> https://relishapp.com/rspec
	
Installed via `bundle update`.

RSpec is a tool used to run tests on Ruby code, as well as serve as documentation.
There are many tutorials on	RSpec online, including their website listed above.


### Pry

> http://pryrepl.org

Installed via:

	gem install pry
	gem install rb-readline

Pry is a handy interactive terminal to manipluate running code.
