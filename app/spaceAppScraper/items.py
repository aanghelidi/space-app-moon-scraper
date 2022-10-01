# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

from scrapy import Field, Item


class MoonDataFileItem(Item):
    file_urls = Field()
    original_file_name = Field()
    files = Field()
