from django.contrib import admin
from .models import (
    Role, User, Unit, Provider, Producer, Category, 
    Product, PickupPoint, OrderStatus, Order, ProductInOrder
)

admin.site.register(Role)
admin.site.register(User)
admin.site.register(Unit)
admin.site.register(Provider)
admin.site.register(Producer)
admin.site.register(Category)
admin.site.register(Product)
admin.site.register(PickupPoint)
admin.site.register(OrderStatus)
admin.site.register(Order)
admin.site.register(ProductInOrder)
