FROM hnskde/cdmongr-base-r:1.0.0

LABEL maintainer "Arnfinn Hykkerud Steindal <arnfinn.steindal@gmail.com>"
LABEL no.mongr.cd.enable="true"

WORKDIR /app/R

# hadolint ignore=DL3010
COPY *.tar.gz .

# Install
RUN R CMD INSTALL --clean ./*.tar.gz && rm ./*.tar.gz

EXPOSE 80
CMD ["R", "-e", "options(shiny.port=80,shiny.host='0.0.0.0'); cdmongr::run_app()"]
