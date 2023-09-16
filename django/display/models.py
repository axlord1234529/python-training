from django.db import models

class Edge(models.Model):
    id1 = models.IntegerField()
    id2 = models.IntegerField()
    weight = models.IntegerField()

    def __str__(self):
        return f"Edge {self.id1} - {self.id2}"