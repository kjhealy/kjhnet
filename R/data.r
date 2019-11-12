#' Pre-Revolutionary Boston Clubs
#'
#' Membership or affiliation in Pre-Revolutionary organizations,
#' from Appendix D of David Hackett Fischer's "Paul Revere's Ride"
#' (Oxford University Press, 1995)
#'
#' @format A tbl_graph object.
#'
#' @docType data
#' @keywords datasets
#' @name revere
#' @source David Hackett Fischer, Paul Reviere's Ride (OUP 1995)
'revere'

#' Deaths in the Iliad 1
#'
#' Deaths in the Iliad: winner -> loser and only names of top warriors
#'
#' @format A tbl_graph object.
#' 
#' In this version of the data, arcs signify winner to loser links. Only the names of the top warriors
#' (nodes with out-degree >= 10) are labeled.
#'
#'
#' @docType data
#' @keywords datasets
#' @name il_killed
#' @source Gabriel Rossman, "Glory and Gore", *Contexts* October 2017
#'     https://journals.sagepub.com/doi/full/10.1177/1536504217732052
'il_killed'

#' Deaths in the Iliad 2
#'
#' Deaths in the Iliad: loser -> winner, and all labels
#'
#' @format A tbl_graph object.
#' 
#' In this version of the data, arcs signify loser to winner
#'
#'
#' @docType data
#' @keywords datasets
#' @name il_killed_by
#' @source Gabriel Rossman, "Glory and Gore", *Contexts* October 2017 https://journals.sagepub.com/doi/full/10.1177/1536504217732052
'il_killed_by'

#' Deaths in the Iliad 3
#'
#' Deaths in the Iliad: undirected
#'
#' @format A tbl_graph object.
#' 
#' In this version of the data, arcs are undirected ties between killer and killed
#'
#'
#' @docType data
#' @keywords datasets
#' @name il_edges
#' @source Gabriel Rossman, "Glory and Gore", *Contexts* October 2017 https://journals.sagepub.com/doi/full/10.1177/1536504217732052
'il_edges'




