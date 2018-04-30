library(nycflights13) # load the built-in data
dim(flights)
head(flights)
dplyr::filter(flights, month == 1, day == 1)
dplyr::filter(flights, month ==1 | month ==2)
dplyr::select(flights, 1:10) # select rows
dplyr::arrange(flights, year, month, day)
dplyr::select(flights, year, month, day)  # select colomn
dplyr::select(flights, year:dep_time)
dplyr::select(flights, -(year:day))
dplyr::select(flights, tail_num = tailnum) # rename. change tailnum to tail_num. not too useful. dropped other variables
dplyr::rename(flights, tail_num = tailnum)
dplyr::distinct(flights, tailnum) # find unique values in a table
dplyr::mutate(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60) # add a new variable
dplyr::summarise(flights, delay = mean(dep_delay, na.rm = TRUE)) ## summarise. collapses a data frame to a single row

dplyr::sample_n(flights, 10) #take a random sample of 10 rows
dplyr::sample_frac(flights, 0.01) # take a random sample of 0.01=1% rows

# Commonalities:let's chain them togethor. 
# in five useful ways: you can reorder the rows (arrange()), pick observations and variables of interest (filter() and select()), add new variables that are functions of existing variables (mutate()), or collapse many values to a summary (summarise()).

# Example 1
by_tailnum <- dplyr::group_by(flights, tailnum)
delay <- dplyr::summarise(by_tailnum,
                          count = n(),
                          dist = mean(distance, na.rm = TRUE),
                          delay = mean(arr_delay, na.rm = TRUE))
delay <- dplyr::filter(delay, count > 20, dist < 2000)
# chaining
flights %>%
  dplyr::group_by(year, month, day)%>%
  dplyr::select(arr_delay, dep_delay)%>%
  dplyr::summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  )%>%
  dplyr::filter(arr > 30 | dep > 30)


