from django.db import models
from django.utils.translation import gettext_lazy as _
from django.contrib.postgres import fields as PostgresFields


class Productcategory(models.Model):
    name = models.Charfield(max_length=256)
    icon_url = models.URLField(blank=True)
    description = models.TextField()
    # breadcrumbs
    parent_category = models.ForeignKey(
        "self",
        blank=True,
        null=True,
        related_name="children_categories",
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.name
