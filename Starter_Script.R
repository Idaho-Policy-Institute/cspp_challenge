#Building a basic exploratory script for folks to start with
library(tidyverse)

#Run this line to install the CSPP package,
#for working with Correlates of State Policy Project data
install.packages("cspp")

#Load in the cspp package we just installed:
library(cspp)

#The two main functions in this package are:
?get_var_info #(You can run this line to get the help documentation for this function)
#and
?get_cspp_data #(Run this line to get the help documentation for this function)

#Taking our arguments from the help page, we can build our get_var_info function:
all_variable_data <- get_var_info() 
#Using the get_var_info function with no arguments will give us
#ALL the variable information

#Getting a list of all the categories that we can look at,
#with a number of the variables in each category
all_variable_data %>%
  count(category)

#Knowing the categories can also help us narrow down the variables we want to look at:
election_and_econ_variables <- get_var_info(categories = c("elections", "economic-fiscal"))

#Now that we have an idea of which variables we're interested in, we can use
#get_cspp_data to actually get the data associated with them.

#If we have a specific list of variables from our variable table, we could use that:
variable_list <- c("exp_education", "exp_public_welfare", "ranney4_control")

#I'm also going to make a list of mountain west states that we want data for:
mtn_states <- c("ID", "MT",
                "WY", "NV", #R doesn't care that I'm putting these in new lines
                "UT", "CO", #As long as it's all within the parentheses
                "AZ", "NM")


specific_data <- get_cspp_data(vars = variable_list,
                               states = mtn_states)
#If you look at this data, you'll note that there are a lot of empty cells.
#That's because the 'ranney4_control' data is available for a lot more years than
#the expenditure data. We can remove rows with missing expenditure data like this:
specific_data <- specific_data %>%
                  drop_na(exp_education, exp_public_welfare)


#We could also pull in variables using our variable table, like this:
election_and_econ_data <- get_cspp_data(vars = election_and_econ_variables$variable,
                              states = mtn_states)
#The election_and_econ_variables$variable part lets us pull that column from its table.

#You'll notice that this dataset also has a LOT of NA's - that's due to the different
#time ranges in which different variables are available




