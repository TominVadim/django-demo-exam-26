from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('guest/', views.guest_entry, name='guest_entry'),
    path('', views.product_list, name='product_list'),
    path('product/<int:product_id>/', views.product_detail, name='product_detail'),
    path('product/add/', views.product_add, name='product_add'),
    path('product/<int:product_id>/edit/', views.product_edit, name='product_edit'),
    path('product/<int:product_id>/delete/', views.product_delete, name='product_delete'),
]