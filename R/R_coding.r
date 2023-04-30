library("tidyverse")

master_dir <- "/Users/binhvo/Library/CloudStorage/OneDrive-Personal/Documents_Mac/Ebooks/Python/Learning_myself/Python_practice/Programming_learning"
data_collection <- "/Users/binhvo/Library/CloudStorage/OneDrive-Personal/Documents_Mac/Ebooks/Python/Learning_myself/Python_practice"
data_R <- "/Users/binhvo/Library/CloudStorage/OneDrive-Personal/Documents_Mac/Ebooks/R_Learning/data"
setwd(master_dir)
list.files(master_dir)
df <- read.csv(paste0(data_collection, "/metadata.csv"))
head(df)
summarise(df,
            mean_age_dys = mean(age_dys),
            sd_age_dys = sd(age_dys))

#### Exercise dyplr

# 1. Create a new column for total sequences in million 'total_seq_million'
# based on 'total_seq'

df <- mutate(df, total_seq_million = total_seq/1E6) # or can use with 1000000
head(df)

# 2. What is another way to end up with only the Media rows
# instead of 'condition == "Media"'?
    df %>%
        filter(condition == 'Media')

# 3. Try calculating the mean total number of sequences
# for the Media and Mtb conditions
    # Method 1
        df %>% 
            filter(condition == 'Media') %>% 
            summarise(mean_total_seq_Media = mean(total_seq))

        df %>% 
            filter(condition == 'Mtb') %>% 
            summarise(mean_total_seq_Mtb = mean(total_seq))
    
    # Method 2
        df %>% 
            group_by(condition) %>%
            summarise(mean_total_seq = mean(total_seq))

# 4. show all columns expect 'libID' column
    df %>%
        select(-libID)


head(df)
test <- pivot_wider(df, 
            names_from = condition,
            values_from = total_seq,
            )
head(test)

load(paste0(data_R, "/dat_voom.RData"))
names(dat)
dat$E[1:5, 1:5]
dim(dat$E)

dat$targets
colnames(dat$E)
data_E <- as.data.frame(dat$E)
head(data_E)

data_E <- as.data.frame(dat$E) %>%
                    rownames_to_column("gene") %>%
                    pivot_longer(-gene, 
                                names_to = 'libID',
                                values_to = 'log2CPM'
                                )

head(data_E)

data_full <- dat$targets %>%
                        inner_join(data_E, by = "libID") 

# or we can specify the exact column name of left and right dataframes
# which matching together.
# for example:
    # data_full <- dat$targets %>%
    #                         inner_join(data_E,
    #                                     by = c("left_name" = "right_name")
    #                                     )

head(data_full)

#### Exercise tidyr

# 1. Filter the metadata to just Media samples, then perform inner_join
# the long expression data 'data_E'.

df_media <- df %>%
                filter(condition == "Media")
head(df_media)

df_exer <- df_media %>%
                    inner_join(data_E, by = 'libID')
dim(df_exer)
dim(df_media)
head(df_exer, 30)
dim(df)
dim(data_E)
head(data_E)
dim(data_full)
table(is.na(df_exer))

ggplot(data = dat$targets,
    aes(
        x = condition,
        y = total_seq,
        color = condition,
    )
) +
    geom_violin() +
    geom_jitter()


dat.pca <- prcomp(t(dat$E), scale. = TRUE, center = TRUE)
class(dat.pca)
str(dat.pca$x)
df_pca <- as.data.frame(dat.pca$x) %>%
            rownames_to_column('libID') %>%
            inner_join(dat$targets, by = 'libID')
head(df_pca)
df_pca %>% 
    ggplot() +
        aes(
            x = PC1,
            y = PC2,
            color = condition
        ) +
        geom_point()

summary(dat.pca)


# exercise: ggplot2
# Using the combined expression and metadata you made in the last session, 
# plot the expression of one gene in Media vs Mtb. The plot type is up to you!
# As a reminder, here is how we made the combined data:
    full_data <- as.data.frame(dat$E) %>% 
                    rownames_to_column("gene") %>% 
                    pivot_longer(-gene, names_to = "libID", values_to = "log2CPM") %>% 
                    inner_join(dat$targets)
    head(full_data)

    names(full_data)

    full_data %>%
        ggplot() +
            aes(
                x = condition,
                y = log2CPM,
                color = condition
            ) +
            geom_point()

##################################################################################################################################
df <- gss_cat
colnames(df)
rownames(df)
str(df)
ggplot(data = gss_cat,
    aes(
        x = race)
    ) +
    geom_bar()

ggplot(data = gss_cat,
    aes(
        x = race)
    ) +
    geom_bar() +
    scale_x_discrete(drop = FALSE)

ggplot(data = gss_cat,
    aes(
        x = fct_infreq(rincome),
        fill = rincome)
    ) +
    geom_bar() +
    scale_x_discrete(drop = FALSE) +
    theme(
            axis.text.x = element_text(angle = 45)
    )
unique(df$rincome)

levels(df$rincome)
test <- reorder(df$rincome, df$rincome, FUN = length)
levels(test)
sort(table(test))
