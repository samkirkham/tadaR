
# tadaR

# R functions for processing and plotting output from TADA (TAsk Dynamics Application)

Sam Kirkham

### Preliminaries

The code works directly on the exported `.mat` MATLAB objects from TADA.
It requires the following packages.

``` r
library(R.matlab)
library(tidyverse)
```

You can load the tadaR functions as follows:

``` r
source("readTADA.R")
source("unnestTADA.R")
source("getAudioLong.R")
```

### Loading data and accessing variables

Load a TADA file using `readTADA` function. As an example, we use a TADA
synthesis of the word ‘pipe’.

``` r
d <- readTADA("~/Dropbox/projects/tardis/tada_modelling/tada_test/pipe_traj_mv.mat")
```

Now we can access columns as follows.

``` r
d$audio # all columns of 'audio' list
d$audio$SIGNAL # just the 'signal' column of 'audio'
plot(d$audio$SIGNAL, type = "l") # plot audio signal
```

### Plotting signals and wide data

We can plot tract variable signals (across the whole file).

``` r
plot(d$TBCD$SIGNAL, type = "l") # TBCD
plot(d$TBCL$SIGNAL, type = "l") # TBCL
```

Generally though, it’s much easier to use the data in an unnested form,
with one column for each variable.

``` r
d.wide <- unnestTADA(d)
```

The above plots are now much easier to do using the unnested data, as we
can refer directly to variables.

``` r
plot(d.wide$TBCL, type = "l") 
```

### Long formant data

We can also convert the data to long format. This allows us to easily
show multiple variables on a single plot, which is very useful for
generating something that looks comparable to a gestural score.

First we can create a long data object.

``` r
d.long <- gather(d.wide, "Variable", "Value", -Sample, -Time)
d.long <- bind_rows(d.long, getAudioLong(d))
```

The following code shows us which articulators/variables are available
to us.

``` r
unique(d.long$Variable)
```

We can then plot selected variables over time using ggplot. The below
code plots the following: Audio, Lip Aperture (LA), TBCL, TBCD, Glottis
(GLO).

``` r
d.long %>% 
  filter(Variable %in% c("Audio", "LA", "TBCL", "TBCD", "GLO")) %>% 
  ggplot(aes(x = Time, y = Value)) +
  geom_path() +
  facet_wrap(~Variable, ncol = 1, scales = "free_y") + # let *only* y-scaling be free
  theme_minimal()
```

### Further notes

It would be nice to have segmental boundaries. However, TADA is not
segmental, as it synthesises output based on overlapping gestures.
Instead, we would need to force-align the synthesised acoustic signal
and obtain temporal landmarks from the force-alignment.
