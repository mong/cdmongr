FROM rocker/r-base:4.1.1

LABEL maintainer "Arnfinn Hykkerud Steindal <arnfinn.steindal@gmail.com>"

# system libraries of general use
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcurl4-gnutls-dev=7.74.\* \
    libssl-dev=1.1.\* \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# basic R functionality
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site \
    && R -e "install.packages(c('remotes'), repos='https://cloud.r-project.org/')" \
    && Rscript -e 'remotes::install_version("attempt",upgrade="never", version = "0.3.1")' \
    && Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3.1")' \
    && Rscript -e 'remotes::install_version("DT",upgrade="never", version = "0.20")' \
    && Rscript -e 'remotes::install_version("glue",upgrade="never", version = "1.4.2")' \
    && Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.3.1")' \
    && Rscript -e 'remotes::install_version("htmltools",upgrade="never", version = "0.5.2")' \
    && Rscript -e 'remotes::install_version("processx",upgrade="never", version = "3.5.2")' \
    && Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.7.1")' \
    && mkdir /build_zone

WORKDIR /app/R

COPY *.tar.gz .
RUN R CMD INSTALL --clean ./*.tar.gz && rm ./*.tar.gz

EXPOSE 80
CMD ["R", "-e", "options(shiny.port=80,shiny.host='0.0.0.0'); cdmongr::run_app()"]
