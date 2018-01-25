#' Parse gender from first and last name columns
#'
#' @param df Dataframe containing the data
#' @param first_name_col Name of the column containing the first names
#' @param last_name_col Name of the column containing the last names
#' @param tolerance Tolerance for assigning gender based on the frequency of person
#' with particular name with a given gender
#' @export
parse_gender <- function(df,
                         first_name_col = "first_name",
                         last_name_col = "last_names",
                         tolerance = 0.1){
    df$gender <- unlist(purrr::map2(df[[first_name_col]], df[[last_name_col]],
                       function(x, y) listr::parse_person_gender(x, y, tolerance)))
    df
}

#' Parse gender of a single person
#'
#' @param first_name String containing first name
#' @param last_name String containing last name
#' @param tolerance Tolerance for assigning gender based on the frequency of person
#' with particular name with a given gender
#' @export
parse_person_gender <- function(first_name, last_name, tolerance = 0.1){
    PROB_DATA <- listr:::first_names

    tmp_first_names <- strsplit(first_name, "\\s|[-]")
    gender <- NA_character_
    if (any(tmp_first_names %in% PROB_DATA$name &&
        PROB_DATA[PROB_DATA$name == tmp_first_names, ]$prob_male >= (1 - tolerance))){
        gender <- "Male"
    } else if (any(tmp_first_names %in% PROB_DATA$name &&
               PROB_DATA[PROB_DATA$name == tmp_first_names, ]$prob_male <= (0 + tolerance))){
        gender <- "Female"
    }

    if (is.na(gender)){
        if(any(grepl("\u00E1$", last_name))){
            gender <- "Female"
        }else{
            gender <- "Male"
        }
    }

    gender
}
