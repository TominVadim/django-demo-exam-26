# main/models.py

from django.db import models

# Create your models here.

class Role(models.Model):
    """
    Роли пользователей (Администратор, Менеджер, Авторизированный клиент)
    Соответствует таблице 'roles' из SQL
    """
    name = models.CharField(max_length=255, verbose_name="Название роли")
    # CharField - строка, max_length - максимальная длина
    # verbose_name - человекочитаемое имя поля (для админки)

    def __str__(self):
        # Это метод, который определяет, как объект будет отображаться в админке
        return self.name

    class Meta:
        # Meta-класс для дополнительной информации о модели
        verbose_name = "Роль"  # название модели в единственном числе (для админки)
        verbose_name_plural = "Роли"  # название модели во множественном числе


class User(models.Model):
    """
    Пользователи системы
    Соответствует таблице 'users' из SQL
    """
    # ForeignKey - связь с другой таблицей (многие к одному)
    # on_delete=models.SET_NULL - если роль удалят, у пользователя поле role станет NULL
    # null=True - разрешаем пустые значения в БД
    # blank=True - разрешаем пустые значения в формах
    role = models.ForeignKey(Role, on_delete=models.SET_NULL, null=True, blank=True, verbose_name="Роль")
    
    surname = models.CharField(max_length=255, verbose_name="Фамилия")
    name = models.CharField(max_length=255, verbose_name="Имя")
    # CharField с null=True, blank=True - необязательное поле
    father_name = models.CharField(max_length=255, blank=True, null=True, verbose_name="Отчество")
    
    # EmailField - специальное поле для email, unique=True - email должен быть уникальным
    email = models.EmailField(unique=True, verbose_name="Email")
    
    password = models.CharField(max_length=255, verbose_name="Пароль")

    def __str__(self):
        return f"{self.surname} {self.name}"

    def get_full_name(self):
        """
        Метод, который возвращает полное ФИО пользователя
        """
        # Собираем все части ФИО в список
        parts = [self.surname, self.name, self.father_name]
        # join объединяет список в строку, пропуская пустые значения
        return " ".join([p for p in parts if p])

    class Meta:
        verbose_name = "Пользователь"
        verbose_name_plural = "Пользователи"


class Unit(models.Model):
    """
    Единицы измерения (например, 'шт.')
    Соответствует таблице 'units'
    """
    name = models.CharField(max_length=255, verbose_name="Единица измерения")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Единица измерения"
        verbose_name_plural = "Единицы измерения"


class Provider(models.Model):
    """
    Поставщики
    Соответствует таблице 'providers'
    """
    name = models.CharField(max_length=255, verbose_name="Поставщик")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Поставщик"
        verbose_name_plural = "Поставщики"


class Producer(models.Model):
    """
    Производители
    Соответствует таблице 'producers'
    """
    name = models.CharField(max_length=255, verbose_name="Производитель")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Производитель"
        verbose_name_plural = "Производители"


class Category(models.Model):
    """
    Категории товаров
    Соответствует таблице 'categories'
    """
    name = models.CharField(max_length=255, verbose_name="Категория")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Категория"
        verbose_name_plural = "Категории"


class Product(models.Model):
    """
    Товары (обувь)
    Соответствует таблице 'products'
    """
    article = models.CharField(max_length=255, unique=True, verbose_name="Артикул")
    name = models.CharField(max_length=255, verbose_name="Наименование")
    
    # ForeignKey - связь с таблицей Unit
    unit = models.ForeignKey(Unit, on_delete=models.SET_NULL, null=True, verbose_name="Единица измерения")
    
    # DecimalField - для денег (max_digits - всего цифр, decimal_places - знаков после запятой)
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="Цена")
    
    provider = models.ForeignKey(Provider, on_delete=models.SET_NULL, null=True, verbose_name="Поставщик")
    producer = models.ForeignKey(Producer, on_delete=models.SET_NULL, null=True, verbose_name="Производитель")
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, verbose_name="Категория")
    
    # PositiveIntegerField - только положительные числа
    discount = models.PositiveIntegerField(default=0, verbose_name="Скидка, %")
    amount = models.PositiveIntegerField(default=0, verbose_name="Количество на складе")
    
    # TextField - для длинного текста
    description = models.TextField(blank=True, null=True, verbose_name="Описание")
    
    # photo - просто строка с путём к файлу
    photo = models.CharField(max_length=255, blank=True, null=True, verbose_name="Путь к фото")

    def __str__(self):
        return f"{self.name} ({self.article})"

    def get_discounted_price(self):
        """
        Вычисляет цену со скидкой
        """
        if self.discount:
            # Формула: цена * (100 - скидка) / 100
            return self.price * (100 - self.discount) / 100
        return self.price

    def get_photo_url(self):
        """
        Возвращает путь к фото товара или к заглушке
        """
        if self.photo:
            # Путь относительно папки static/main/
            return f"products/{self.photo}"
        # Заглушка, если фото нет
        return "products/picture.png"

    class Meta:
        verbose_name = "Товар"
        verbose_name_plural = "Товары"


class PickupPoint(models.Model):
    """
    Пункты выдачи
    Соответствует таблице 'pickup_points'
    """
    index = models.CharField(max_length=10, verbose_name="Индекс")
    city = models.CharField(max_length=255, verbose_name="Город")
    street = models.CharField(max_length=255, verbose_name="Улица")
    building = models.CharField(max_length=10, blank=True, null=True, verbose_name="Строение")

    def __str__(self):
        return f"г. {self.city}, ул. {self.street}, д. {self.building} ({self.index})"

    class Meta:
        verbose_name = "Пункт выдачи"
        verbose_name_plural = "Пункты выдачи"


class OrderStatus(models.Model):
    """
    Статусы заказов
    Соответствует таблице 'order_status'
    """
    name = models.CharField(max_length=255, verbose_name="Статус")

    def __str__(self):
        return self.name

    class Meta:
        verbose_name = "Статус заказа"
        verbose_name_plural = "Статусы заказов"


class Order(models.Model):
    """
    Заказы
    Соответствует таблице 'orders'
    """
    # DateField - поле для даты
    order_date = models.DateField(verbose_name="Дата заказа")
    delivery_date = models.DateField(verbose_name="Дата доставки")
    
    pickup_point = models.ForeignKey(PickupPoint, on_delete=models.SET_NULL, null=True, verbose_name="Пункт выдачи")
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, verbose_name="Пользователь")
    
    delivery_code = models.CharField(max_length=20, verbose_name="Код доставки")
    status = models.ForeignKey(OrderStatus, on_delete=models.SET_NULL, null=True, verbose_name="Статус")

    def __str__(self):
        return f"Заказ №{self.id} от {self.order_date}"

    class Meta:
        verbose_name = "Заказ"
        verbose_name_plural = "Заказы"


class ProductInOrder(models.Model):
    """
    Товары в заказах (связующая таблица многие-ко-многим)
    Соответствует таблице 'products_in_orders'
    """
    # ForeignKey с on_delete=models.CASCADE - если заказ удалят, удалятся и все связанные записи
    order = models.ForeignKey(Order, on_delete=models.CASCADE, verbose_name="Заказ")
    product = models.ForeignKey(Product, on_delete=models.CASCADE, verbose_name="Товар")
    amount = models.PositiveIntegerField(verbose_name="Количество")

    def __str__(self):
        return f"{self.product.name} x {self.amount}"

    class Meta:
        verbose_name = "Товар в заказе"
        verbose_name_plural = "Товары в заказах"
        