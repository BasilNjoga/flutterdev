# Generated by Django 4.2.5 on 2023-10-16 15:35

from django.db import migrations, models


class Migration(migrations.Migration):
    dependencies = [
        ("api", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="note",
            name="body",
            field=models.TextField(blank=True),
        ),
    ]
