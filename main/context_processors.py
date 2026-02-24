# main/context_processors.py

from .models import User

def user_context(request):
    """
    Добавляет объект текущего пользователя во все шаблоны
    """
    user_id = request.session.get('user_id')
    is_guest = request.session.get('is_guest', False)
    current_user = None
    
    if user_id:
        try:
            current_user = User.objects.get(id=user_id)
        except User.DoesNotExist:
            # Если пользователь не найден, очищаем сессию
            request.session.flush()
    
    return {
        'current_user': current_user,
        'is_guest': is_guest
    }
