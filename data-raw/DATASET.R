## code to prepare `DATASET` dataset goes here

library(here)
library(tidyverse)
library(ggraph)
library(tidygraph)

## Illiad Data via Rossman (2017) https://osf.io/jasf4/

#note, edited file is hand-coded to blank out labels for nodes with out-degree < 10
iliadkilled <- igraph::read.graph(here("data-raw/iliad/iliad_killed_edited.net"), c("pajek"))
igraph::V(iliadkilled)$label <- igraph::V(iliadkilled)$id

il_killed <- as_tbl_graph(iliadkilled)

iliadkilledby <- igraph::read.graph(here("data-raw/iliad/iliad_killedby.net"), c("pajek"))
igraph::V(iliadkilledby)$label <- igraph::V(iliadkilledby)$id

il_killed_by <- as_tbl_graph(iliadkilledby)


iliadedges <- igraph::read.graph(here("data-raw/iliad/iliad_edges.net"), c("pajek"))
igraph::V(iliadedges)$label <- igraph::V(iliadedges)$id

il_edges <- as_tbl_graph(iliadedges)

usethis::use_data(il_killed,
                  il_killed_by,
                  il_edges, overwrite = TRUE, compress = "xz")


## Revere
revere <- read.csv(here("data-raw/revere/revere.csv"))
revere <- janitor::clean_names(revere)

revere <- separate(revere, person, c("last", "first"))

clean_names <- data.frame(id = 1:length(revere$first), full_name = paste(revere$first, revere$last),
                          first_name = revere$first, last_name = revere$last)

revere <- select(revere, st_andrews_lodge:london_enemies)
revere <- add_column(revere, id = clean_names$full_name, .before = TRUE) %>%
  pivot_longer(st_andrews_lodge:london_enemies) %>%
  as_tbl_graph()

usethis::use_data(revere,
                  overwrite = TRUE, compress = "xz")

