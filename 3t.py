class Circle(object):
    def __init__(self, radius):
        self._radius = radius

    @property
    def radius(self):
        return self._radius
    
    @radius.setter
    def radius(self, radius):
        self._radius = radius

c = Circle(5)
c.radius = 10
print(c.radius)