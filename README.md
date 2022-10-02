# space-app-moon-scraper

**space-app-moon-scraper** is a web scraper made with `Scrapy` to parse data stored in https://pds-geosciences.wustl.edu/lunar/urn-nasa-pds-apollo_pse/data/xa/continuous_waveform/ for the [Nasa Space Apps Challenge](https://www.spaceappschallenge.org/).

## Environment Variables

You can add the following environment variables, to control the behaviour of the scraper.

`STATION`

Which station to parse, default to s11. Available values are {s11,s12,s14,s15,s16}.

`FILES_STORE`

Where to store the files, default to `tmp/data`.
## Usage/Examples

With `docker`
```bash
docker run \
-e STATION=s12 \
-e FILES_STORE=/var/scraping/data \
-v "$(pwd)"/data:/var/scraping/data \
space-app-scraper moonscraper
```

With `python`

```bash
pip install -r requirements.txt
cd app/spaceAppScraper
STATION=s12 FILES_STORE=/var/scrapy/data crawl moonscraper
```
