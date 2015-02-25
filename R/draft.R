options(stringsAsFactors = FALSE)
library(dplyr)
library(stringr)

# Load data
file <- './temp_data/raw_dosage_report.txt'
df <- load_txt(file)
ptype <- load_txt('./temp_data/program_type.txt')
ptype[] <- lapply(ptype, tolower)

# Clean data
df <- pos_clean(df)
df <- dplyr::left_join(df, ptype)


# Do some calculation
df %>%
  select(id, intervention_type) %>%
  distinct() %>%
  count(intervention_type)























##########################################################################
## Clean raw data
# Pass to lower case
df$pos_name <- tolower(df$pos_name)
# I want to identify pos that track attendance / score from other pos
attendance_pos <- 'attend|^case|^\\[promotor'
score_pos <- 'score|level'


df$pos_type <- NA
df$pos_type[str_detect(df$pos_name, attendance_pos)] <- 'attendance'
df$pos_type[str_detect(df$pos_name, score_pos)] <- 'score'

#df$pos_type[str_detect(df$pos_name, level_pos)] <- 'level'


df %>%
  select(program_name, pos_name, pos_type) %>%
  unique() %>%
  arrange(pos_type) ->
  test

write.csv(test, file = 'pos_review.csv', row.names = FALSE, na = "")

