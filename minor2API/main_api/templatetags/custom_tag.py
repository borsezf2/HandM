from django import template
register = template.Library()

@register.simple_tag()
def multiply(qty, unit_price, *args, **kwargs):
    # you would need to do any localization of the result here
    print("qty = ",type(qty))
    print("unit price = ",type(unit_price))
    return float(qty) * unit_price