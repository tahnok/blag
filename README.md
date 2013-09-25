# Blag

A very simple blogging platform written in ruby, designed mostly for journaling

Blag works very simply. It transforms files ending in .md in the posts folder 
into a blog. Filenames correspond to blog post titles, and blog posts are 
sorted by that title. This lends itself to titling blog posts 
like 20130924_title.md

You can create a new post by running `rake blog`

## Help

    rake blog[title]  # combines new and generate
    rake development  # run blag with rerun to reload whenever the code changes
    rake generate     # generate posts.json from markdown files in posts/
    rake new[title]   # make a new post, optionally passing in filename/title
    rake server       # Run the blag platform

## Author

[Wesley Ellis](http://about.tahnok.me)

## License

 GPLv3. See `LICENSE`
