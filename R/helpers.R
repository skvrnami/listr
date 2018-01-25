#' Capitalize string
#'
#' @param x String
#' @export
capitalize <- function(x){
    tmp <- unlist(strsplit(x, "\\s|[-]"))
    out <- unlist(purrr::map(tmp, function(x)
                            paste0(toupper(substring(x, 1, 1)),
                                   tolower(substring(x, 2, nchar(x))))))
    paste(out, collapse = " ")
}
