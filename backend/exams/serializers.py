from rest_framework import serializers
from .models import Exam

# Definimos un serializer para el modelo Exam. 
# Un serializer convierte un modelo en JSON para la API y valida datos de entrada 
class ExamSerializer(serializers.ModelSerializer):
    model = Exam
    fields = ['id', 'image', 'result_text', 'created_at']
    read_only_fields = ['id', 'result_text', 'created_at']