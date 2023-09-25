## Instructions for running the django project

### Clone the Repository

URL : `https://github.com/axlord1234529/python-training.git` 

```bash
git clone https://github.com/axlord1234529/python-training.git
```

### Move to projects directory

```bash
cd django
```
### Activate the Virtual Environment
If you don't have it already install pipenv
```bash
pip install pipenv
```
Then run these commands.
```bash
pipenv shell

pipenv install
```
### Create database
Import the sql dump form django/display/data into your mysql client.
### Connect to database
In the <strong>settings.py</strong> edit the database dictionary.
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'graph',
        'HOST': 'localhost',
        'PASSWORD': '',
        'USER': 'root',
        'PORT': '3306'
    }
}
### Start server
```bash
python manage.py runserver
```
### Access the graph.
Go to.
URL : `http://127.0.0.1:8000/display/` 
