# README

## Listr

[![Build Status](https://travis-ci.org/skvrnami/listr.svg?branch=master)](https://travis-ci.org/skvrnami/listr)
[![codecov](https://codecov.io/gh/skvrnami/listr/branch/master/graph/badge.svg)](https://codecov.io/gh/skvrnami/listr)

R package for parsing names and extracting information from the names. 
The main purpose of this package is to make dealing with the candidates lists 
produced by the Czech Statistical Office easier.  
The functions contain state-of-the-art if-else conditions and very naïve probability assumptions
based on outdated data (for guessing if a name is first name or last name and guessing gender of 
a person). 

### Purpose

The purpose of this package is to simplify several tasks:  

* dividing a string containing a full name and academic titles into two strings
* dividing full name into first names and surnames
* extracting gender from first or last names

All of these tasks are modelled on the Czech data and are designated for dealing with the
data originating in the Czech Republic. Division of names into first names and surnames and
extracting gender is done using data from the [Ministry of Interior of the Czech Republic](http://www.mvcr.cz/clanek/statistika-prijmeni-a-krestnich-jmen.aspx)
so it doesn't translate well into other contexts. 
On the other hand, it does not require calling an API with limited amount of calls such as 
[genderizeR package](https://cran.r-project.org/web/packages/genderizeR/index.html).

### Installation

```
devtools::install_github("skvrnami/listr")
```

### Usage

See [vignette](https://htmlpreview.github.io/?https://github.com/skvrnami/skvrnami.github.io/blob/master/rpkgs/listr.html).

..

![](https://media.giphy.com/media/LlkmMze9qHTNu/giphy.gif)

