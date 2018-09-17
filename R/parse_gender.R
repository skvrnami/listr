find_gender_by_first_name <- function(first_name, tolerance, min_count){
    PROB_DATA <- listr:::first_names
    PROB_DATA <- PROB_DATA[(PROB_DATA$males + PROB_DATA$females) >= min_count, ]

    if(!first_name %in% PROB_DATA$name){
        gender <- NA_character_
    }else if(PROB_DATA[PROB_DATA$name == first_name, ]$prob_male >= (1 - tolerance)){
        gender <- "Male"
    }else if(PROB_DATA[PROB_DATA$name == first_name, ]$prob_male <= (0 + tolerance)){
        gender <- "Female"
    }else{
        gender <- NA_character_
    }

    gender
}


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


#' Parse gender from first and last name columns
#'
#' @param df Dataframe containing the data
#' @param first_name_col Name of the column containing the first names
#' @param last_name_col Name of the column containing the last names
#' @param tolerance Tolerance for assigning gender based on the frequency of person
#' with particular name with a given gender
#' @export
parse_gender2 <- function(df,
                         first_name_col = "first_name",
                         last_name_col = "last_names",
                         tolerance = 0.1,
                         min_count = 50){
    df$gender <- unlist(purrr::map2(df[[first_name_col]], df[[last_name_col]],
                                    function(x, y) listr::parse_person_gender2(x, y, tolerance,
                                                                               min_count)))
    df
}


#' Parse gender of a single person
#'
#' @param first_name String containing first name
#' @param last_name String containing last name
#' @param tolerance Tolerance for assigning gender based on the frequency of person
#' with particular name with a given gender
#' @export
parse_person_gender2 <- function(first_name, last_name, tolerance = 0.1, min_count = 100){

    if(any(grepl("\u00E1$", last_name))){
        gender <- "Female"
    }else{
        tmp_first_names <- unlist(strsplit(first_name, "\\s|[-]"))

        gender <- NA_character_
        if (length(tmp_first_names) == 1){
            gender <- find_gender_by_first_name(tmp_first_names, tolerance = tolerance,
                                                min_count = min_count)
        } else if (length(tmp_first_names) > 1){
            genders <- purrr::map_chr(tmp_first_names,
                                      function(x) find_gender_by_first_name(x, tolerance,
                                                                            min_count))
            if(length(genders[!is.na(genders)]) > 0){
              if(length(unique(genders[!is.na(genders)])) == 1){
                  gender <- genders[!is.na(genders)][1]
              }else{
                  gender <- NA_character_
              }
            } else{
                gender <- NA_character_
            }
        }
    }

    gender
}

#' Parse gender of a single person
#'
#' @param first_name String containing first name
#' @param last_name String containing last name
#' @param tolerance Tolerance for assigning gender based on the frequency of person
#' with particular name with a given gender
#' @export
parse_person_gender <- function(first_name, last_name, tolerance = 0.1,
                                min_count = 100){


    tmp_first_names <- unlist(strsplit(first_name, "\\s|[-]"))

    gender <- NA_character_
    if (length(tmp_first_names) == 1){
        gender <- find_gender_by_first_name(tmp_first_names, tolerance = tolerance,
                                            min_count)
    } else if (length(tmp_first_names) > 1){
        genders <- purrr::map_chr(tmp_first_names,
                                  function(x) find_gender_by_first_name(x, tolerance,
                                                                        min_count))
        if(length(genders[!is.na(genders)]) > 0 &&
           length(genders[!is.na(genders)]) != length(unique(genders[!is.na(genders)]))){
            gender <- genders[1]
        }else{
            gender <- NA_character_
        }
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
