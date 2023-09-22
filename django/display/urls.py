from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('get_users_for_table/', views.get_users_for_table, name='data')
]

