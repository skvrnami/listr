#' Extract titles from string
#'
#' @param x String containing name with academic titles
#' @export
extract_titles <- function(x){
    x <- gsub("D.I.C.", "DIC", x)
    paste(
        unlist(
            stringr::str_extract_all(x, "\\b([A-Za-z]+\\.[D]\\.)|([A-Za-z]+\\.[A-Za-z]+\\b)|([A-Za-z]+\\.)|([A-Z]{2,3}\\b)|(et\\b)|([A-Z]{2}[a-z]{1})")),
        collapse = " ")
}

#' Extract text which is before academic titles
#'
#' @param x String containing name with academic titles (e.g. Karel Novák prof. RNDr.)
#' @export
extract_text_before_titles <- function(x){
    # delete part indicating senior/junior
    tmp <- gsub("\\b(nejml\\.\\s)|(ml\\.\\s)|(st\\.\\s)", "", as.character(x))
    tmp <- unlist(strsplit(tmp, "\\s"))
    first_title <- head(which(grepl("([A-Za-z]+\\.)|([A-Z]{2,3})", tmp)), 1)
    if(length(first_title)){
        rest <- tmp[0:(first_title-1)]
        paste(rest, collapse = " ")
    }else{
        paste(tmp, collapse = " ")
    }
}

#' Extract the highest received academic title
#'
#' @param x String containing titles
#' @export
recode_titles <- function(x){
    x <- tolower(x)
    x <- dplyr::case_when(grepl("\\bprof\\b", x) ~ "Professor", # prof.
                     grepl("\\bdoc\\b", x) ~ "Associate Professor (docent)", # doc.
                     grepl("([a-z]+dr\\.|ph\\.+d|th\\.d|csc|drsc)\\b", x) ~ "Doctor",
                     grepl("\\b(ma|m[a-z]{2}|ing)\\b", x) ~ "Master", #Mgr, MgA, MA
                     grepl("\\b(bc|ba)\\b", x) ~ "Bachelor", #Bc, BcA, BA
                     TRUE ~ "No title")
    factor(x, levels = c("No title", "Bachelor", "Master",
                         "Doctor", "Associate Professor (docent)", "Professor"),
           ordered = TRUE)
}
