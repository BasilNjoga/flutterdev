from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from users.models import CustomUser
from django.contrib.auth.password_validation import validate_password


class CustomUserRegisterSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
        required=True, validators=[UniqueValidator(queryset=CustomUser.objects.all())]
    )
    password = serializers.CharField(
        write_only=True,
        required=True,
        validators=[validate_password],
    )
