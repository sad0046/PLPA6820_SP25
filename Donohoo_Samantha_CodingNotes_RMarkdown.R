### Sam Donohoo
### Date: 2/26/2025
### Coding Homework Notes R Markdown - PLPA 6820

##### Packages to Install: knitr, rmarkdown, pandoc, tinytex
install.packages('pandoc')
install.packages('knitr')
install.packages('rmarkdown')
install.packages('tinytex')

## Run tinytex
tinytex::install_tinytex()

##### YAML Headers + Initial R Markdown ######

# Includes Title, Author, Date, and Output
## Output can be edited for different output file types i.e. html, pdf, wordoc etc.
### Table of Contents can be added under each output format using toc: true or toc_float: true
#### To add to Github use md_document: variant: gfm

##### Knitting #####

# Knitting generates a markdown formatted document.
## Provided there's no errors, it will output to the chosen output formats.

##### Code Chunks #####

# Embed R code chunks using the insert code chunk: located near the Run button.
# Control output

{r chunk_name, ...}

Global parameters
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
## Use of echo=TRUE/FALSE will either print or not print the code out before running
## Use of include=TRUE/FASLSE will either print or not print the code after running

##### Formatting Options #####

# First-level header
## Second-level header
### Third-level header

`*italic*` # Italic
`_italic_`  # Italic
`**bold**` # Bold
`__bold__` # Bold

### Block Quotes occur after >
> "I thoroughly disapprove of duels. If a man should challenge me,
  I would take him kindly and forgivingly by the hand and lead him
  to a quiet place and kill him."
>
  > --- Mark Twain

### Unordered list items start with *, -, or +
### You can nest one list within another list by indenting the sub-list
### Ordered list items start with numbers (you can also nest lists within lists)

#Use plain address either as an actual link, within the text or linked to a word:
  
https://agriculture.auburn.edu/about/directory/faculty/zachary-noel/
<https://agriculture.auburn.edu/about/directory/faculty/zachary-noel/>
[Noel Lab](https://agriculture.auburn.edu/about/directory/faculty/zachary-noel/)

### You can embed images into the output. 
### You will need to provide a file path to the image from the current rmd file. 
### For ease just put the file in the same directory as your rmd file.

### If you forgot the exclamation mark (!), it will become just a link
![shrek and ggplot](IMG_8889-Copy.jpg)

# Tables can also be formated using Rmarkdown.

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

### You can make this process simpler using knitr with kable:

kable(head(mtcars, n = 5), digits = 3, format = "markdown")
# When you click the Knit, it will render the document using the existing syntax.

##### Organize a Repository + readme using Markdown #####

# Add Clickable links to Analyses, Scripts etc.
## Use Relative Paths or full http paths

##### File Tree #####

# Install the package fs
## Use the command fs::dir_tree() to generate a list of files associated with the GitHub
### Copy in the File Tree using R Markdown