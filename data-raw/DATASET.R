## code to prepare `DATASET` dataset goes here

library(here)
library(tidyverse)
library(ggraph)
library(tidygraph)
library(graphlayouts)
library(janitor)
library(readxl)

library(showtext)
showtext_auto()

library(myriad)
import_myriad_semi()

theme_set(theme_myriad_semi())
set_graph_style(family = "Myriad Pro SemiCondensed")
## Illiad Data via Rossman (2017) https://osf.io/jasf4/

raw_data <- read_csv("data-raw/iliad/iliad_clean.csv")
iliad <- raw_data %>%
  pivot_longer(act:affil_target)


# Nodes
actors <- raw_data %>%
  distinct(actor, affil_actor) %>%
  rename(name = actor)

targets <- raw_data %>%
  distinct(target, affil_target) %>%
  rename(name = target)

nodes <- full_join(actors, targets, by = "name") %>%
  mutate(affil = coalesce(affil_actor, affil_target)) %>%
  select(name, affil) %>%
  rowid_to_column("id")

# Edges
edges <- raw_data %>%
  left_join(nodes, by = c("actor" = "name")) %>%
  rename(from = id)

edges <- edges %>%
  left_join(nodes, by = c("target" = "name")) %>%
  rename(to = id) %>%
  select(from, to, act)

il_tidy<- tbl_graph(nodes = nodes, edges = edges, directed = TRUE)

il_tidy %>%
  activate(nodes) %>%
  mutate(centrality = centrality_degree()) %>%
  arrange(desc(centrality))


il_tidy %>%
  activate(nodes) %>%
  mutate(centrality = centrality_degree(),
         betweenness = centrality_betweenness()) %>%
  arrange(desc(betweenness))

il_tidy %>%
  activate(edges) %>%
  filter(act == "kills") %>%
  reroute(from = to, to = from) %>%
  activate(nodes) %>%
  mutate(alpha = centrality_alpha()) %>%
  arrange(desc(alpha))


#note, edited file is hand-coded to blank out labels for nodes with out-degree < 10
iliadkilled <- igraph::read.graph(here("data-raw/iliad/iliad_killed_edited.net"), c("pajek"))
il_killed <- as_tbl_graph(iliadkilled)

iliadkilledby <- igraph::read.graph(here("data-raw/iliad/iliad_killedby.net"), c("pajek"))
il_killed_by <- as_tbl_graph(iliadkilledby)

il_tidy %>%
  mutate(centrality = centrality_degree(mode = "out"))


il_tidy %>%
  activate(edges) %>%
  filter(act == "kills") %>%
  activate(nodes) %>%
  mutate(centrality = centrality_degree(mode = "out")) %>%
  ggraph(layout = 'graphopt') +
  geom_edge_link(aes(start_cap = label_rect(node1.name),
                     end_cap = label_rect(node2.name)),
                 arrow = arrow(length = unit(1.5, 'mm'))) +
  geom_node_point(aes(color = affil)) +
  scale_color_manual(values = c("blue", "red"), labels = c("Athenian", "Trojan")) +
  guides(color = guide_legend(title = "Side", )) +
  geom_node_label(aes(filter = centrality > 3, label = name), size = rel(2.5)) +
  labs(title = "Killings in The Iliad") +
  theme(plot.title = element_text(size = rel(3)))



iliadedges <- igraph::read.graph(here("data-raw/iliad/iliad_edges.net"), c("pajek"))
il_edges <- as_tbl_graph(iliadedges)

usethis::use_data(il_killed,
                  il_killed_by,
                  il_edges,
                  il_tidy,
                  overwrite = TRUE, compress = "xz")


## Revere
revere <- janitor::clean_names(read.csv(here("data-raw/revere/revere.csv")))

revere_orgs <- colnames(revere)[-1]
revere_names <- separate(revere, person, c("last", "first"))
revere_names <- data.frame(id = 1:length(revere_names$first),
                           full_name = paste(revere_names$first, revere_names$last, sep = "_"),
                          first_name = revere_names$first,
                          last_name = revere_names$last)

revere_persons <- as.matrix(revere[,-1]) %*% t(as.matrix(revere[,-1]))
revere_groups <- t(as.matrix(revere[,-1])) %*% as.matrix(revere[,-1])

colnames(revere_groups) <- revere_orgs
rownames(revere_groups) <- revere_orgs

colnames(revere_persons) <- revere_names$full_name
rownames(revere_persons) <- revere_names$full_name

# persons
nodes <- tibble(name = rownames(revere_persons)) %>%
  rowid_to_column("id")

edges <- revere_persons %>%
  data.frame() %>%
  rowid_to_column("from") %>%
  pivot_longer(John_Adams:Thomas_Young) %>%
  inner_join(nodes) %>%
  mutate(to = id) %>%
  select(from, to, value) %>%
  filter(value != 0)

revere_persons <- tbl_graph(nodes = nodes, edges = edges, directed = FALSE)

# groups
nodes <- tibble(name = rownames(revere_groups)) %>%
          rowid_to_column("id")

edges <- revere_groups %>%
  data.frame() %>%
  rowid_to_column("from") %>%
  pivot_longer(st_andrews_lodge:london_enemies) %>%
  inner_join(nodes) %>%
  mutate(to = id) %>%
  select(from, to, value)

revere_groups <- tbl_graph(nodes = nodes, edges = edges, directed = FALSE)

usethis::use_data(revere,
                  revere_persons,
                  revere_groups,
                  overwrite = TRUE, compress = "xz")

revere_groups %>%
  mutate(centrality = centrality_degree()) %>%
  ggraph(layout = "kk") +
  geom_edge_link(aes(width = value), color = "gray80") +
  geom_node_label(aes(label = name))


revere_persons %>%
  mutate(centrality = centrality_eigen()) %>%
  ggraph(layout = "stress") +
  geom_edge_link0(aes(filter = value > 1, width = value), color = "gray90") +
  geom_node_point() +
  geom_node_label(aes(filter = centrality > 0.9, label = name), size = rel(2.5))



## Socjobs Data from Rob Warren

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



