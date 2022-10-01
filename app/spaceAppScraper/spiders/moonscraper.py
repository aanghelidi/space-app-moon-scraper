# import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule


class MoonscraperSpider(CrawlSpider):
    name = "moonscraper"
    allowed_domains = ["pds-geosciences.wustl.edu"]
    start_urls = [
        "https://pds-geosciences.wustl.edu/lunar/urn-nasa-pds-apollo_pse/data/xa/",
    ]

    rules = (
        # Brut force match everything
        Rule(LinkExtractor(allow=""), callback=None),
    )

    def parse_item(self, response):
        item = {}
        return item
