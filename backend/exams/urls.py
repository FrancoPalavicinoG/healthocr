from django.urls import path
from .views import ExamCreateView

urlpatterns = [
    path("exams/", ExamCreateView.as_view(), name="exam-create"),
]