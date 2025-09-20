from django.urls import path
from .views import ExamCreateView, ExamDetailView

urlpatterns = [
    path("exams/", ExamCreateView.as_view(), name="exam-create"),
    path("exams/<int:pk>/", ExamDetailView.as_view(), name="exam-detail"),
]