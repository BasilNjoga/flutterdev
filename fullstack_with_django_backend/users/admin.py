from django.contrib import admin

from users.models import CustomUser

# Registered models here.
admin.site.register(CustomUser)
