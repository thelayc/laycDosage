#' pos_clean()
#'
#' This function takes a dataframe as input (export from the "[Admin] raw_dosage_report") and conduct some basic data cleaning on it
#' @param df dataframe: the name of the dataframe containing the information.
#' @param att character: Name to be added to identify attendance records
#' @param att_markers character: regex expression used to identify attendance records
#' @return data frame
#' @export
#' @examples
#' pos_clean(df = my_dataframe)

pos_clean <- function(df, att = 'attendance', att_markers = 'attend|^case|^\\[promotor') {
  # Turn everything to lower case
  df[] <- lapply(df, tolower)
  # Retrieve attendance records
  # id attendance records
  df <- id_attendance(df, att, att_markers)
  # keep attendance records
  df <- dplyr::filter(df, pos_type == att)
  # remove pos_value different from yes/no
  df$pos_value[!df$pos_value %in% c('yes', 'no')] <- NA
  # change yes/no to 1/0 values
  df$pos_value[df$pos_value == 'yes'] <- 1
  df$pos_value[df$pos_value == 'no'] <- 0
  # Turn numeric variable to numeric
  num_var <- c('id', 'tp_id', 'pos_id', 'effort_id', 'pos_value', 'time', 'program_id_pos')
  df[num_var] <- lapply(df[num_var], tidyr::extract_numeric)
  # Turn date variable to date
  date_var <- c('date')
  df[date_var] <- lapply(df[date_var], lubridate::mdy)

  return(df)
}
