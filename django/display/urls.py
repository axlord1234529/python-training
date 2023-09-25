from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('get_edge_info_for_table/', views.get_edge_info_for_table, name='edge_data'),
    path('get_user_info_for_table/', views.get_user_info_for_table, name='user_data')
]

