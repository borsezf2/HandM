"""minor2API URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from main_api import views as api

urlpatterns = [
    path('admin/', admin.site.urls),
    path('register_user_in_DB', api.register_user_in_DB),
    path('is_user_in_DB', api.is_user_in_DB),
    path('update_user_info', api.update_user_info),
    path('start_order', api.start_order),
    path('search_item', api.search_item),
    path('post_item', api.post_item),
    path('add_item_to_cart', api.add_item_to_cart),
    path('getOffer', api.getOffer),
    path('train_data', api.train_data),
    path('checkout_true', api.checkout_true),
    path('send_invoice', api.send_invoice),
    path('ngrok_eg', api.ngrok_eg),
    path('previous_order', api.previous_order),

]
