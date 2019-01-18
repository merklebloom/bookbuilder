# bookbuilder

![](https://img.shields.io/github/license/merklebloom/bookbuilder.svg)

A book build system that produces PDF, EPUB and MOBI from asciidoc to Amazon specifications.

# Book structure

The book source is written in Asciidoc markup and stored in the `chapters` folder, under a language sub-folder such as `en` for English. With this structure you can have multiple translations of a book developed in parallel in the same repository:

```
chapters/
├── en
│   ├── ChapterOne.asciidoc
│   ├── master.asciidoc
│   └── title.asciidoc
└── es
    └── master.asciidoc
```

The master file `master.asciidoc` arranges all the book chapters in order, and contains attributes definitions that control the book production features.

# Building books

Books are built as PDF, EPUB or MOBI using the asciidoctor, asciidoctor-pdf and asciidoctor-epub Ruby packages (https://github.com/asciidoctor). To make things easier, all the necessary packages and dependencies are included in a Docker container. You can manually install everything on your computer, or install docker and have it manage all those dependencies for you.

## Docker container

All the necessary dependencies to run bookbuilder are included in a docker container, which makes things a lot easier when operating bookbuilder across different operating systems. First, get [docker](https://docker.com/get-started) for your operating system and install it. Ubuntu instructions are [here](https://docs.docker.com/install/linux/docker-ce/ubuntu/).

Note: You don't have to use the docker container. You can install the necessary tools on your operating system directly. However, this is much more difficult as each operating system uses different installation paths and the versions and capabilities may differ. The bookbuilder Makefile is optimized to work from within the docker container. 

### Pulling the container image from DockerHub

The docker container is published on Docker Hub as `merklebloom/bookbuilder`. Pull the latest version like this:

```
sudo docker pull merklebloom/bookbuilder
```

### Building the container image from this repository

Instead of pulling the docker container from docker hub, you can also build it from this repository, if you've already cloned it:

```
$ cd bookbuilder
$ sudo docker image build $(pwd) -t bookbuilder
```

### Running the bookbuilder container

Run the container, mapping the current directory (pwd = `bookbuilder`) to the container's `/documents/` folder:

```
$ sudo -H docker run -it -v $(pwd):/documents/ bookbuilder
bash-4.4#
```

At the `bash` prompt, you can run the `make` commands, as detailed below, to build book files.

## Building books in PDF. EPUB and MOBI

Use the `make` command to build a book in one of several formats. The `LANG` environmental variable can be used to define a language to build. If ommitted, `LANG` is set to `en`.

Syntax:

```
make [LANG=xx] {all,pdf,epub,kindle}
```

Examples:

```
bash-4.4# make LANG=en pdf
bash-4.4# make LANG=es epub
bash-4.4# make kindle
```

The resulting book files will be saved in the `dist` folder, with the filename composed from the book title (edit `TITLE` in `Makefile`) and the most recent commit tag. In the example below, the book `TITLE` is set to "TheBookTitle" and the most recent tag for the English language builds was `release_example`. If there are more commits since the most recent git tag, the commit ID is appended, as shown in the Spanish-language release `example_tag-6-g777d9f8`:

```
dist/
├── en
│   ├── TheBookTitle_release_example.epub
│   ├── TheBookTitle_release_example.mobi
│   └── TheBookTitle_release_example.pdf
└── es
    └── TheBookTitle_example_tag-6-g777d9f8.pdf
```
The commit ID and tag allow you to keep track of revisions and interim releases, which helps you avoid publishing the wrong version. Not that such a mistake ever happened, ahem.

# Styling and formatting

The styling and formatting is controlled by two different configuration files.

PDF books are styled by a YML-format theme file stored in `conf/theme.yml`. A sample with most possible settings is found in `conf/theme-yml-sample`. Any settings not explicitly set in `conf/theme.yml` will default to the built-in theme as shown in `conf/theme-yml-sample`. Here's a excerpt from the theme configuration file:

```
table_body_stripe_background_color: ffffff
table_font_family: LiberationSansNarrow
table_font_size: 10
```

Details about how to use the theme file are found here:
https://github.com/asciidoctor/asciidoctor-pdf/blob/master/docs/theming-guide.adoc

EPUB and MOBI (Kindle) book styling is controlled by CSS files `conf/epub3.css` and `conf/epub3-css3-only.css`.

# Attribution

The build system (/conf, Makefile) is forked and heavily modified from https://github.com/akosma/eBook-Template, which is public domain. The Dockerfile is from https://github.com/asciidoctor/docker-asciidoctor.

# License

Bookbuilder by Merkle Bloom LLC is licensed under an MIT license.
