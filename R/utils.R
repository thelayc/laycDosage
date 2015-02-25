load_txt <- function(file) {
  read.table(file, header = TRUE, sep = '\t', quote = "", comment.char = "")
}


