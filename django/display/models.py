from django.db import models

class User(models.Model):
    username = models.CharField(max_length=100)
    email = models.EmailField()
    

    def __str__(self):
        return f"{self.username} - {self.email}"
    
class Edge(models.Model):
    user1 = models.ForeignKey(User, on_delete=models.CASCADE, related_name='edges1')
    user2 = models.ForeignKey(User, on_delete=models.CASCADE, related_name='edges2')
    weight = models.IntegerField()

    def __str__(self):
        return f"Edge {self.user1} - {self.user2}, weight:{self.weight}"