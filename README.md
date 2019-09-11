# docker-insidertradingscraper

Out-of-the-box environment setup using docker-compose


First, setup credentials in copy/settings.ini, copy/entrypoint.sh, and docker-compose.yml. Then to setup the required environments, simply run:  

    docker-compose up

To attach screen to the interactive scraper shell:

    docker exec -it insider-scraper bash