# main/forms.py
from django import forms
from .models import Product, Category, Producer, Provider, Unit

class ProductForm(forms.ModelForm):
    """
    Форма для добавления и редактирования товаров
    """
    class Meta:
        model = Product
        fields = [
            'article', 'name', 'category', 'producer', 'provider',
            'unit', 'price', 'discount', 'amount', 'description', 'photo'
        ]
        widgets = {
            'article': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Артикул'}),
            'name': forms.TextInput(attrs={'class': 'form-control', 'placeholder': 'Наименование'}),
            'description': forms.Textarea(attrs={'class': 'form-control', 'rows': 4, 'placeholder': 'Описание товара'}),
            'price': forms.NumberInput(attrs={'class': 'form-control', 'step': '0.01', 'min': '0'}),
            'discount': forms.NumberInput(attrs={'class': 'form-control', 'min': '0', 'max': '100'}),
            'amount': forms.NumberInput(attrs={'class': 'form-control', 'min': '0'}),
            'category': forms.Select(attrs={'class': 'form-control'}),
            'producer': forms.Select(attrs={'class': 'form-control'}),
            'provider': forms.Select(attrs={'class': 'form-control'}),
            'unit': forms.Select(attrs={'class': 'form-control'}),
            'photo': forms.FileInput(attrs={'class': 'form-control', 'accept': 'image/*'}),
        }
        labels = {
            'article': 'Артикул',
            'name': 'Наименование',
            'category': 'Категория',
            'producer': 'Производитель',
            'provider': 'Поставщик',
            'unit': 'Единица измерения',
            'price': 'Цена (₽)',
            'discount': 'Скидка (%)',
            'amount': 'Количество на складе',
            'description': 'Описание',
            'photo': 'Фото товара',
        }
    
    def clean_price(self):
        """Проверка, что цена не отрицательная"""
        price = self.cleaned_data.get('price')
        if price < 0:
            raise forms.ValidationError('Цена не может быть отрицательной')
        return price
    
    def clean_amount(self):
        """Проверка, что количество не отрицательное"""
        amount = self.cleaned_data.get('amount')
        if amount < 0:
            raise forms.ValidationError('Количество не может быть отрицательным')
        return amount
    
    def clean_discount(self):
        """Проверка, что скидка в пределах 0-100"""
        discount = self.cleaned_data.get('discount')
        if discount < 0 or discount > 100:
            raise forms.ValidationError('Скидка должна быть от 0 до 100%')
        return discount
    