# import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule

from ..items import MoonDataFileItem


class MoonscraperSpider(CrawlSpider):
    name = "moonscraper"
    allowed_domains = ["pds-geosciences.wustl.edu"]
    start_urls = [
        "https://pds-geosciences.wustl.edu/lunar/urn-nasa-pds-apollo_pse/data/xa/continuous_waveform/s11/",
    ]

    rules = (
        # Brut force match everything
        Rule(
            LinkExtractor(
                allow=".*s11/.*$",
                deny=r".*continuous_waveform$",
                deny_extensions=["csv", "xml", "mseed", "pdf", "tab"],
            ),
            callback=None,
            follow=True,
        ),
        Rule(
            LinkExtractor(allow=".*s11/.*(csv|xml|mseed)$"),
            callback="parse_data_file",
        ),
    )

    def parse_data_file(self, response):
        file_url = response.url
        item = MoonDataFileItem()
        item["file_urls"] = [file_url]
        item["original_file_name"] = file_url.split("/")[-1]
        yield item
