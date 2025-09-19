from rest_framework import serializers
from .models import Exam, ExamResult

class ExamResultSerializer(serializers.ModelSerializer):
    class Meta:
        model = ExamResult
        fields = ["id", "test_name", "result", "unit", "reference_range", "method", "created_at"]
        read_only_fields = ["id", "created_at"]

class ExamSerializer(serializers.ModelSerializer):
    # Relación inversa: exam.results.all()
    results = ExamResultSerializer(many=True, read_only=True)

    class Meta:
        model = Exam
        fields = ["id", "image", "result_text", "created_at", "results"]
        read_only_fields = ["id", "result_text", "created_at", "results"]