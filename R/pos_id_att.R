#' id_attendance()
#'
#' This function adds a columns to a dataframe that identify attendance records
#' @param df dataframe: the name of the dataframe containing the information.
#' @param att character: Name to be added to identify attendance records
#' @param att_markers character: regex expression used to identify attendance records
#' @return data frame
#' @examples
#' id_attendance(df = my_dataframe)

id_attendance <- function(df, att, att_markers) {
  df$pos_type <- NA
  df$pos_type[grepl(att_markers, df$pos_name)] <- att

  return(df)
}
