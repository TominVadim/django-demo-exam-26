# main/views.py

from django.shortcuts import render, redirect, get_object_or_404
from django.db.models import Q
from django.contrib import messages
from django.http import JsonResponse
from django.core.files.base import ContentFile
from django.conf import settings
from .models import User, Product, Provider, Role, Category, Producer, Unit  # Добавлены Category, Producer, Unit
from .forms import ProductForm
import os
from PIL import Image
from io import BytesIO
import uuid  # Добавлен импорт uuid

# Create your views here.

def login_view(request):
    """
    Страница входа в систему
    """
    # Если пользователь уже залогинен, перенаправляем на список товаров
    if request.session.get('user_id') or request.session.get('is_guest'):
        return redirect('product_list')
    
    error_message = None
    
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        try:
            # Ищем пользователя по email
            user = User.objects.get(email=email)
            
            # Проверяем пароль
            if user.password == password:
                # Очищаем сессию на всякий случай
                request.session.flush()
                # Сохраняем ID пользователя в сессии
                request.session['user_id'] = user.id
                # Сохраняем роль пользователя для быстрого доступа
                request.session['user_role'] = user.role_id if user.role else None
                # Перенаправляем на список товаров
                return redirect('product_list')
            else:
                error_message = "Неверный пароль."
        except User.DoesNotExist:
            error_message = "Пользователь с таким email не найден."
    
    return render(request, 'main/login.html', {'error': error_message})


def logout_view(request):
    """
    Выход из системы
    """
    request.session.flush()  # Очищаем всю сессию
    return redirect('login')


def guest_entry(request):
    """
    Вход как гость
    """
    request.session.flush()  # Очищаем старую сессию
    request.session['is_guest'] = True  # Устанавливаем флаг гостя
    return redirect('product_list')


def product_list(request):
    """
    Страница со списком всех товаров
    Доступна всем с разным уровнем функционала
    """
    if not (request.session.get('user_id') or request.session.get('is_guest')):
        return redirect('login')
    
    # Получаем все товары из БД с связанными данными
    products = Product.objects.select_related(
        'category', 'producer', 'provider', 'unit'
    ).all()
    
    # ПОИСК - применяется первым
    search_query = request.GET.get('search', '')
    if search_query:
        products = products.filter(
            Q(name__icontains=search_query) |           # поиск по названию
            Q(article__icontains=search_query) |        # поиск по артикулу
            Q(description__icontains=search_query) |    # поиск по описанию
            Q(category__name__icontains=search_query) | # поиск по категории
            Q(producer__name__icontains=search_query) | # поиск по производителю
            Q(provider__name__icontains=search_query)   # поиск по поставщику
        )
    
    # ФИЛЬТРАЦИЯ - применяется второй
    provider_id = request.GET.get('provider', '')
    if provider_id and provider_id.isdigit() and int(provider_id) > 0:
        products = products.filter(provider_id=int(provider_id))
    
    # СОРТИРОВКА - применяется последней
    sort_by = request.GET.get('sort', '')
    if sort_by == 'amount_asc':
        products = products.order_by('amount')  # по возрастанию количества
    elif sort_by == 'amount_desc':
        products = products.order_by('-amount')  # по убыванию количества
    
    # Получаем всех поставщиков для выпадающего списка
    providers = Provider.objects.all().order_by('name')
    
    # Определяем роль текущего пользователя для шаблона
    user_role = None
    if request.session.get('user_id'):
        try:
            user = User.objects.get(id=request.session['user_id'])
            user_role = user.role_id if user.role else None
        except User.DoesNotExist:
            pass
    
    return render(request, 'main/product_list.html', {
        'products': products,
        'providers': providers,
        'current_sort': sort_by,
        'current_provider': provider_id,
        'search_query': search_query,
        'user_role': user_role,  # 1 - админ, 2 - менеджер, 3 - клиент
        'is_guest': request.session.get('is_guest', False)
    })


def product_detail(request, product_id):
    """
    Страница детального просмотра товара
    """
    product = get_object_or_404(
        Product.objects.select_related('category', 'producer', 'provider', 'unit'),
        id=product_id
    )
    return render(request, 'main/product_detail.html', {'product': product})


def product_add(request):
    """
    Добавление нового товара (только для администратора)
    """
    # Проверяем, что пользователь администратор
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, 'Необходимо авторизоваться')
        return redirect('login')
    
    try:
        user = User.objects.get(id=user_id)
        if user.role_id != 1:  # 1 - администратор
            messages.error(request, 'У вас нет прав для добавления товаров')
            return redirect('product_list')
    except User.DoesNotExist:
        return redirect('login')
    
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            product = form.save(commit=False)
            
            # Обработка фото
            if 'photo' in request.FILES:
                photo = request.FILES['photo']
                # Сохраняем фото с уникальным именем
                product.photo = save_product_image(photo)
            
            product.save()
            messages.success(request, f'Товар "{product.name}" успешно добавлен')
            return redirect('product_list')
        else:
            messages.error(request, 'Проверьте правильность заполнения формы')
    else:
        form = ProductForm()
    
    # Получаем данные для выпадающих списков
    categories = Category.objects.all()
    producers = Producer.objects.all()
    providers = Provider.objects.all()
    units = Unit.objects.all()
    
    return render(request, 'main/product_form.html', {
        'form': form,
        'action': 'add',
        'categories': categories,
        'producers': producers,
        'providers': providers,
        'units': units
    })


def product_edit(request, product_id):
    """
    Редактирование товара (только для администратора)
    """
    # Проверяем, что пользователь администратор
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, 'Необходимо авторизоваться')
        return redirect('login')
    
    try:
        user = User.objects.get(id=user_id)
        if user.role_id != 1:  # 1 - администратор
            messages.error(request, 'У вас нет прав для редактирования товаров')
            return redirect('product_list')
    except User.DoesNotExist:
        return redirect('login')
    
    product = get_object_or_404(Product, id=product_id)
    old_photo = product.photo  # Запоминаем старое фото для возможного удаления
    
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES, instance=product)
        if form.is_valid():
            edited_product = form.save(commit=False)
            
            # Обработка нового фото
            if 'photo' in request.FILES:
                # Удаляем старое фото, если оно есть
                if old_photo and old_photo != 'picture.png':
                    delete_product_image(old_photo)
                
                photo = request.FILES['photo']
                edited_product.photo = save_product_image(photo)
            
            edited_product.save()
            messages.success(request, f'Товар "{edited_product.name}" успешно обновлен')
            return redirect('product_list')
        else:
            messages.error(request, 'Проверьте правильность заполнения формы')
    else:
        form = ProductForm(instance=product)
    
    # Получаем данные для выпадающих списков
    categories = Category.objects.all()
    producers = Producer.objects.all()
    providers = Provider.objects.all()
    units = Unit.objects.all()
    
    return render(request, 'main/product_form.html', {
        'form': form,
        'product': product,
        'action': 'edit',
        'categories': categories,
        'producers': producers,
        'providers': providers,
        'units': units
    })


def product_delete(request, product_id):
    """
    Удаление товара (только для администратора)
    """
    # Проверяем, что пользователь администратор
    user_id = request.session.get('user_id')
    if not user_id:
        messages.error(request, 'Необходимо авторизоваться')
        return redirect('login')
    
    try:
        user = User.objects.get(id=user_id)
        if user.role_id != 1:  # 1 - администратор
            messages.error(request, 'У вас нет прав для удаления товаров')
            return redirect('product_list')
    except User.DoesNotExist:
        return redirect('login')
    
    product = get_object_or_404(Product, id=product_id)
    
    # Проверяем, есть ли товар в заказах
    if product.productinorder_set.exists():
        messages.error(request, f'Товар "{product.name}" нельзя удалить, так как он присутствует в заказах')
        return redirect('product_list')
    
    if request.method == 'POST':
        # Удаляем фото, если оно есть
        if product.photo and product.photo != 'picture.png':
            delete_product_image(product.photo)
        
        product_name = product.name
        product.delete()
        messages.success(request, f'Товар "{product_name}" успешно удален')
        return redirect('product_list')
    
    return render(request, 'main/product_confirm_delete.html', {'product': product})


# Вспомогательные функции для работы с изображениями
def save_product_image(image_file):
    """
    Сохраняет изображение товара с изменением размера до 300x200
    """
    try:
        # Открываем изображение
        img = Image.open(image_file)
        # Изменяем размер до 300x200 (сохраняя пропорции)
        img.thumbnail((300, 200), Image.Resampling.LANCZOS)
        # Создаем уникальное имя файла
        import uuid
        ext = image_file.name.split('.')[-1].lower()
        filename = f"{uuid.uuid4().hex}.{ext}"
        # Путь для сохранения
        relative_path = f"products/{filename}"
        full_path = os.path.join(settings.MEDIA_ROOT, relative_path)
        # Создаем папку, если её нет
        os.makedirs(os.path.dirname(full_path), exist_ok=True)
        # Сохраняем изображение
        img.save(full_path, quality=85, optimize=True)
        return relative_path
    except Exception as e:
        print(f"Ошибка при сохранении изображения: {e}")
        return None


def delete_product_image(image_path):
    """
    Удаляет изображение товара
    """
    try:
        if image_path and image_path != 'picture.png':
            full_path = os.path.join(settings.MEDIA_ROOT, image_path)
            if os.path.exists(full_path):
                os.remove(full_path)
    except Exception as e:
        print(f"Ошибка при удалении изображения: {e}")