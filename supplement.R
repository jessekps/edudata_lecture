
# eventueel een paar minder bekende packages installeren
# devtools::install_github("bergant/datamodelr")
# install.packages("DiagrammeR")

library(datamodelr)
library(RSQLite)
library(dplyr)
library(tibble)

er_plot = function(db)
{
  tbls = dbGetQuery(db,"SELECT name FROM sqlite_master WHERE type='table';")$name
  inf = lapply(tbls, function(tb)
  {
    fk = dbGetQuery(db, paste0("pragma foreign_key_list('", tb, "')")) %>%
      mutate(from = as.character(from))
    
    dbGetQuery(db, paste0("pragma table_info('", tb, "')")) %>%
      left_join(fk, by=c(name='from')) %>%
      mutate(key = as.integer(pk>0), column_order = cid + 1L) %>%
      select(column = 'name', key, ref = 'table', ref_col = 'to', 
             mandatory = 'notnull', type, column_order) %>%
      add_column(table=tb, .before=1)
  }) %>%
    bind_rows() 
  
  dm = as.data_model(inf)
  
  # same column referencing different tables multiplies the columns
  # correct by changing the dm object
  dm$columns = dm$columns %>%
    distinct(table, column, .keep_all=TRUE)
  
  dm$references = dm$references %>%
    group_by(table) %>%
    mutate(ref_id = dense_rank(ref)) %>%
    ungroup() %>%
    group_by(table,ref_id) %>%
    mutate(ref_col_num = row_number()) %>%
    ungroup()
  
  graph = dm_create_graph(dm, rankdir = "BT", col_attr = c("column", "type"))
  dm_render_graph(graph)
}
