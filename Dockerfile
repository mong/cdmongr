FROM rocker/r-base:4.1.1

LABEL maintainer "Arnfinn Hykkerud Steindal <arnfinn.steindal@gmail.com>"

# system libraries of general use
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    libcurl3-gnutls=7.79.1-3~exp2 \
    libcurl4-gnutls-dev=7.79.\* \
    libssl-dev=1.1.\* \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


WORKDIR /app/R

# hadolint ignore=DL3010
COPY *.tar.gz .

# basic R functionality
RUN R -e 'install.packages(c("methods", "shiny"), repos="https://cloud.r-project.org/")' \
    && R CMD INSTALL --clean ./*.tar.gz && rm ./*.tar.gz

EXPOSE 80
CMD ["R", "-e", "options(shiny.port=80,shiny.host='0.0.0.0'); cdmongr::run_app()"]
