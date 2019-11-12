<!-- README.md is generated from README.Rmd. Please edit that file -->



# kjhnet

<!-- badges: start -->
<!-- badges: end -->

Some network data, for teaching purposes. 

Iliad data are courtesy of Gabriel Rossman (2017) "[Glory and Gore](https://journals.sagepub.com/doi/full/10.1177/1536504217732052)", *Contexts* 16(3):42--47. Original data files available at <https://osf.io/jasf4/>.



## Installation

`kjhnet` is a data package. 

### Install direct from GitHub

You can install the beta version of kjhnet from [GitHub](https://github.com/kjhealy/kjhnet) with:

``` r
devtools::install_github("kjhealy/kjhnet")
```

### Installation using `drat`

While using `install_github()` works just fine, it would be nicer to be able to just type `install.packages("kjhnet")` or `update.packages("kjhnet")` in the ordinary way. We can do this using Dirk Eddelbuettel's [drat](http://eddelbuettel.github.io/drat/DratForPackageUsers.html) package. Drat provides a convenient way to make R aware of package repositories other than CRAN.

First, install `drat`:


```r
if (!require("drat")) {
    install.packages("drat")
    library("drat")
}
```

Then use `drat` to tell R about the repository where `kjhnet` is hosted:


```r
drat::addRepo("kjhealy")
```

You can now install `kjhnet`:


```r
install.packages("kjhnet")
```

To ensure that the `kjhnet` repository is always available, you can add the following line to your `.Rprofile` or `.Rprofile.site` file:


```r
drat::addRepo("kjhealy")
```

With that in place you'll be able to do `install.packages("kjhnet")` or `update.packages("kjhnet")` and have everything work as you'd expect. 

Note that the drat repository only contains data packages that are not on CRAN, so you will never be in danger of grabbing the wrong version of any other package.


## Loading the data

The package works best with the [ggraph](https://github.com/thomasp85/ggraph), [tidygraph](https://github.com/thomasp85/tidygraph), and broader [tidyverse](http://tidyverse.org/) libraries.


```r
library(tidyverse)
library(ggraph)
library(tidygraph)
#> Attaching package: 'tidygraph'
#> The following object is masked from 'package:stats':
#> 
#>     filter
```

Load the data:


```r
library(kjhnet)
```

