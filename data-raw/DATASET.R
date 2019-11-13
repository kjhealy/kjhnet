## code to prepare `DATASET` dataset goes here

library(here)
library(tidyverse)
library(ggraph)
library(tidygraph)
library(janitor)
library(readxl)

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


## Socjobs Data from Rob Warren

library(showtext)
showtext_auto()

library(myriad)
import_myriad_semi()

theme_set(theme_myriad_semi())

clean_dept_names <- function(x){
  x <- stringr::str_replace(x, "California-", "")
  x <- stringr::str_replace(x, "SUNY-", "")
  x <- stringr::str_replace(x, "SUNY-", "")
  x <- stringr::str_replace(x, "Illinois-Chicago", "UIC")
  x <- stringr::str_replace(x, "U of Illinois", "UIUC")
  x <- stringr::str_replace(x, "U of Pennsylvania", "U Penn")
  x <- stringr::str_replace(x, "San Francisco", "UCSF")
  x <- stringr::str_replace(x, "North Carolina", "UNC")
  x <- stringr::str_replace(x, "N.C. State", "NC State")
  x
}


jobs <- read_xlsx(here("data-raw/socjobs/2018.10.02_assistant_professors_data.xlsx"))
jobs <- jobs %>%
  mutate(phd_dept = clean_dept_names(phd_dept))

socjobs <- jobs %>%
  select(sex:gap)

usethis::use_data(socjobs, overwrite = TRUE, compress = "xz")


set_graph_style(family = "Myriad Pro SemiCondensed")

p1 <- jobs %>%
  filter(top25phd == "Yes", phd_dept != "Texas", job_dept != "Texas") %>%
  select(phd_dept, job_dept) %>%
  mutate(phd_dept = clean_dept_names(phd_dept),
         job_dept = clean_dept_names(job_dept)) %>%
  group_by(phd_dept, job_dept) %>%
  tally() %>%
  select(from = phd_dept, to = job_dept, weight = n) %>%
  mutate(scale_weight = scale(weight, center = FALSE)) %>%
  filter(weight > 0) %>%
  as_tbl_graph() %>%
  mutate(centrality = centrality_eigen(weights = weight)) %>%
  ggraph(layout = "graphopt") +
  geom_edge_fan(aes(alpha = weight),
                arrow = arrow(length = unit(3, 'mm'), type = "closed"),
                start_cap = circle(2, 'mm'),
                end_cap = circle(8, 'mm')) +
  geom_node_label(aes(label = name)) +
  scale_edge_alpha_continuous(name = "N Hires") +
  labs(title = "New Assistant Professor Exchanges within the Top 25 Sociology Departments",
       subtitle = "New Ph.D. hires, 1990-2017. Data show absolute number of within-network hires only.\nHires to and from outside the Top 25 are not shown. No adjustments are made for departmental or cohort sizes.",
       caption = "Data: Warren (2019). Data exclude UT Austin.") +
  theme_graph(base_family = "Myriad Pro SemiCondensed") +
  theme(legend.position = "top")

ggsave("figures/exchange_network_p1.pdf", p1, height = 10, width = 15)
ggsave("figures/exchange_network_p1.png", p1, height = 10, width = 15, dpi = 300)



