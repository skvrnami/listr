#' Split name
#'
#' Split name into first and last name
#' @param x String containing full name
#' @param reversed Logical indicating whether the full name is
#' in reversed order (first name at the end)
#' @param tolerance The first and last name are assigned by the probability counted as
#' probability of a name being a first name = how many times is this name used as first name /
#' (how many times is this name used as first name + how many times is this name used as last name)
#' based on data from the Ministry of Interior. If tolerance is 0, only names that are used
#' only as first names will be labeled as first names etc.
#' @importFrom utils head tail
#' @export
split_full_name <- function(x, reversed = TRUE, tolerance = 0.1){
    full_name <- listr::capitalize(x)
    names <- unlist(strsplit(as.character(full_name), "\\s"))

    if (length(names) == 2){
        if (reversed) {
            first_names <- names[2]
            last_names <- names[1]
        }else{
            first_names <- names[1]
            last_names <- names[2]
        }
    } else {
        first_names <- unlist(purrr::map(names, function(x)
            listr::find_first_name(x, tolerance)))
        last_names <- unlist(purrr::map(names, function(x)
            listr::find_last_name(x, tolerance)))
    }

    if (!length(last_names)) {
        if (reversed){
            first_names <- first_names[first_names != head(names, 1)]
            last_names <- head(names, 1)
        }else{
            first_names <- first_names[first_names != tail(names, 1)]
            last_names <- tail(names, 1)
        }
    }

    if (!length(first_names)) {
        if (reversed){
            last_names <- last_names[last_names != tail(names, 1)]
            first_names <- tail(names, 1)
        }else{
            last_names <- last_names[last_names != head(names, 1)]
            first_names <- head(names, 1)
        }
    }

    if (length(c(first_names, last_names)) < length(names)){
        listr::decide_unknown_names(names, first_names, last_names)
        listr::decide_unknown_names(names, first_names, last_names)
    } else {
        list(paste(first_names, collapse = " "),
             paste(last_names, collapse = " "))
    }
}

#' Find first name
#'
#' @param x String with a name
#' @param tolerance the first and last name are assigned by the probability counted as
#' probability of a name being a first name = how many times is this name used as first name /
#' (how many times is this name used as first name + how many times is this name used as last name)
#' based on data from the Ministry of Interior. If tolerance is 0, only names that are used
#' only as first names will be labeled as first names etc.
#' @export
find_first_name <- function(x, tolerance){
    NAMES_DIVISION <- listr:::names_division
    if (x %in% names_division$name &&
        NAMES_DIVISION$prob_first_name[NAMES_DIVISION$name == x] >= (1 - tolerance)){
        x
    }else{
        c()
    }
}

#' Find last name
#'
#' @param x String with a name
#' @param tolerance the first and last name are assigned by the probability counted as
#' probability of a name being a first name = how many times is this name used as first name /
#' (how many times is this name used as first name + how many times is this name used as last name)
#' based on data from the Ministry of Interior. If tolerance is 0, only names that are used
#' only as first names will be labeled as first names etc.
#' @export
find_last_name <- function(x, tolerance){
    NAMES_DIVISION <- listr:::names_division
    if (x %in% names_division$name &&
        NAMES_DIVISION$prob_first_name[NAMES_DIVISION$name == x] <= (0 + tolerance)){
        x
    }else{
        c()
    }
}

#' Decide unknown names
#'
#' @param names Names
#' @param first_names Vector of first names
#' @param last_names Vector of last names
#' @export
decide_unknown_names <- function(names, first_names, last_names){
    tmp <- data.frame(
        name = names,
        type = ifelse(names %in% first_names, "First",
                      ifelse(names %in% last_names, "Last", NA)),
        stringsAsFactors = FALSE
    )

    tmp$type <- zoo::na.locf(tmp$type, na.rm = FALSE)
    tmp$type <- zoo::na.locf(tmp$type, na.rm = FALSE, fromLast = TRUE)
    list(paste(tmp$name[tmp$type == "First"], collapse = " "),
         paste(tmp$name[tmp$type == "Last"], collapse = " "))
}

#' Split full name into first and last name and add them to data.frame
#'
#' @param df dataframe with the data
#' @param full_name name of the column containing full name
#' @param keep logical indicating if the column containing full name should be kept
#' @param ... additional params passed to split_full_name function
#' @export
add_names_to_df <- function(df, full_name, keep = TRUE, ...){
    df$full_name <- as.character(df$full_name)
    full_names <- purrr::map(df[[full_name]], listr::split_full_name, ...)
    tmp <- as.data.frame(do.call(rbind, full_names))
    colnames(tmp) <- c("first_name", "last_name")
    tmp$first_name <- unlist(tmp$first_name)
    tmp$last_name <- unlist(tmp$last_name)
    if (!keep){
        df[[full_name]] <- NULL
    }
    cbind(df, tmp)
}
