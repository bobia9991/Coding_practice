#!/opt/homebrew/bin/Rscript

# Written by BinhVo.
# This script will automatically create a Word file by R, highlighting the inputted variables used for testing.
# To create an actual file for applying, use 'motivation_letter_Word_file.R'
# for more details: https://ardata-fr.github.io/officeverse/index.html

# Usage:
# feed this file with 4 arguments:
# ./motivation_letter_Word_file.R $supervisor $project_name $reason_1 $reason_2


library(officer) # to create a Word file
library(readr) # to read input file
library(tidyverse) # to use map_chr() function
library(doconv) # convert docx to pdf

# store all input arguments in the terminal.
args <- commandArgs(trailingOnly = TRUE)

# input arguments from terminal ----
supervisor <- args[1]
first_name <- map_chr(str_split(supervisor, "\\. "), 2)
project <- args[2]
reason_1 <- args[3]
reason_2 <- args[4]


###### Step1: create a folder storing the information of a PhD advertisement. ----

Jobs <- "./Jobs"
system(paste0("mkdir -p ", Jobs, "/", first_name)) # must have a single space after -p
setwd(paste0(Jobs, "/", first_name))

###### Step2: initial formatting in Word.app

# setting title's properties
title_prop <- fp_text(
        bold = TRUE,
        font.size = 14,
        font.family = "Times New Roman"
)

# setting text's properties
text_prop <- fp_text(
        font.size = 12,
        font.family = "Times New Roman"
)

# setting variable's properties, i.e. highlight it in red colour.
# when creating actual files, comment this part out to set black colour for text.
variable_prop <- fp_text(
        color = "#C32900",
        bold = TRUE
)


###### Step3: create Lines or Paragraph
#       ftext: create a line/string.
#       fpar: create a paragraph.
#       text.align: align text by center, left, right, or justify
#       padding: add space around a paragraph.

# Motivation Letter ----
type_of_letter <- ftext("Motivation Letter", title_prop)
paragraph_0_0 <- fpar(type_of_letter,
        fp_p = fp_par(text.align = "center")
)


# Dear Supervisor, ----
# str1 <- paste0("Dear ", supervisor, ",")
# p_0_1 <- ftext(str1, text_prop)
# paragraph_0_1 <- fpar(p_0_1,
ins_sup <- ftext(supervisor, variable_prop)
paragraph_0_1 <- fpar("Dear ", ins_sup, ",",
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

# Paragraph 1 ----
p1 <- ftext("Paragraph 1: My name is Binh Vo and I am writing to express my interest in your research.", text_prop)
paragraph_1 <- fpar(p1,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

# Paragraph 2 ----
str2_1 <- "Paragraph 2: Here is your introduction to your background or whatever you want."
str2_2 <- "If you want add more sentences, just create new variables like str2_2, str2_3, and so on."
# this line below will concatenate several str2_x variables above into the str2 variable.
# so, comment out this line below if you have 1 line in your paragraph.
str2 <- paste(str2_1, str2_2) 
p2 <- ftext(str2, text_prop)
paragraph_2 <- fpar(p2,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

# Paragraph 3 ----
str3 <- "Paragraph 3: Here is your answers for the question: why do you want to pursue a PhD degree?"
p3 <- ftext(str3, text_prop)
paragraph_3 <- fpar(p3,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)


# Paragraph 4 ----
str4 <- "Paragraph 4: What did you prepare for it?"
p4 <- ftext(str4, text_prop)
paragraph_4 <- fpar(p4,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)


# Paragraph 5 ----

str5_1 <- "Paragraph 5: Why do you want to join our project? "
str5_1_1 <- ftext(str5_1, text_prop)
str5_2 <- "I am really interested in your research on the "
str5_2_2 <- ftext(str5_2, text_prop)
ins_proj <- ftext(project, variable_prop)
str5_3 <- "Here is the first reason "
str5_3_3 <- ftext(str5_3, text_prop)
ins_r1 <- ftext(reason_1, variable_prop)
str5_4 <- "Here is the second reason "
str5_4_4 <- ftext(str5_4, text_prop)
ins_r2 <- ftext(reason_2, variable_prop)
# str5 <- paste(str5_1, str5_2, str5_3, str5_4, str5_5, str5_6, str5_7)
# p5 <- ftext(str5, text_prop)
# paragraph_5 <- fpar(p5,
paragraph_5 <- fpar(str5_1_1,
                    str5_2_2,
                    ins_proj, " project for two reasons. ",
                    str5_3_3,
                    ins_r1, ". ",
                    str5_4_4,
                    ins_r2, ".",
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

# Paragraph 6 ----
str6 <- "Paragraph 6: Your conclusion."
p6 <- ftext(str6, text_prop)
paragraph_6 <- fpar(p6,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

# Paragraph 7 ----
str7 <- "Paragraph 7: I have also attached my resume which provides more details of my skills and experience for your reference."
p7 <- ftext(str7, text_prop)
paragraph_7 <- fpar(p7,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

# Paragraph 8 ----
p8 <- ftext("Yours sincerely,", text_prop)
paragraph_8 <- fpar(p8,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

# Paragraph 9 ----
p9 <- ftext("Binh Vo", text_prop)
paragraph_9 <- fpar(p9,
        fp_p = fp_par(
                text.align = "justify",
                padding.bottom = 10,
                padding.top = 10,
                padding.left = 5,
                padding.right = 5
        )
)

###### Step4: create a Word file ----
# naming file
supervisor_mod <- sub(". ", "_", supervisor) # replace '.'' to '_' in the supervisor's value.
name <- paste0("Motivation_letter_", supervisor_mod, "_BinhVo.docx")
read_docx() %>%
        body_add_fpar(paragraph_0_0) %>%
        body_add_fpar(paragraph_0_1) %>%
        body_add_fpar(paragraph_1) %>%
        body_add_fpar(paragraph_2) %>%
        body_add_fpar(paragraph_3) %>%
        body_add_fpar(paragraph_4) %>%
        body_add_fpar(paragraph_5) %>%
        body_add_fpar(paragraph_6) %>%
        body_add_fpar(paragraph_7) %>%
        body_add_fpar(paragraph_8) %>%
        body_add_fpar(paragraph_9) %>%
        print(target = name)

###### Step5: convert output Word file to PDF ----
to_pdf(name, output = gsub("\\.docx$", ".pdf", name))
