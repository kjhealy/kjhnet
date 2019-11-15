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

#' Pre-Revolutionary Boston Clubs: person x person
#'
#' Membership or affiliation in Pre-Revolutionary organizations,
#' from Appendix D of David Hackett Fischer's "Paul Revere's Ride"
#' (Oxford University Press, 1995)
#'
#' @format A tbl_graph object.
#'
#' @docType data
#' @keywords datasets
#' @name revere_persons
#' @source David Hackett Fischer, Paul Reviere's Ride (OUP 1995)
'revere_persons'

#' Pre-Revolutionary Boston Clubs: group x group
#'
#' Membership or affiliation in Pre-Revolutionary organizations,
#' from Appendix D of David Hackett Fischer's "Paul Revere's Ride"
#' (Oxford University Press, 1995)
#'
#' @format A tbl_graph object.
#'
#' @docType data
#' @keywords datasets
#' @name revere_groups
#' @source David Hackett Fischer, Paul Reviere's Ride (OUP 1995)
'revere_groups'


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

#' Deaths in the Iliad 4
#'
#' Deaths in the Iliad: tidy representation
#'
#' @format A tbl_graph object.
#'
#' Tidygraph version of the Iliad data
#'
#'
#' @docType data
#' @keywords datasets
#' @name il_tidy
#' @source Gabriel Rossman, "Glory and Gore", *Contexts* October 2017 https://journals.sagepub.com/doi/full/10.1177/1536504217732052
'il_tidy'



#' Sociology Top 25 Assistant Professor Job Placements 1990-2017
#'
#' Limited Placement data for Sociology (TT AP Jobs in USNWR Top 25 departments only)
#'
#' @format A tibble with 343 rows and 7 columns
#' \describe{
#' \item{\code{sex}}{Sex of individual.}
#' \item{\code{job_yr}}{Year of first Assistant Professor position.}
#' \item{\code{job_dept}}{Hiring department}
#' \item{\code{phd_yr}}{Year of Ph.D.}
#' \item{\code{phd_dept}}{Individual's Ph.D department}
#' \item{\code{top25phd}}{Is PhD Department a Top 25 USNWR Soc program?}
#' \item{\code{gap}}{Years elapsed between PhD and TT Job.}
#' }
#'
#' @docType data
#' @keywords datasets
#' @name socjobs
#' @source  John Robert Warren, (2019) "How Much Do You Have to Publish to Get a Job in a Top Sociology Department? Or to Get Tenure? Trends Over a Generation", *Sociological Science* February 27, 2019 doi://10.15195/v6.a7. Original data files available at <https://www.rob-warren.com/pub_trends.html>.
'socjobs'


