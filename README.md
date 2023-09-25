## Getting Started

### Clone the Repository

URL : `https://github.com/axlord1234529/python-training.git` 

```bash
git clone https://github.com/axlord1234529/python-training.git
```
### Switch to bokeh-django branch.

```bash
git checkout bokeh-django
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
```
Run migrations:
```bash
python manage.py migrate
```
### Import display_edge data.
 In django/display/data, you can find the SQL dump or the CSV. Use either to import.

### Start server
```bash
python manage.py runserver
```
### Access the graph.
Go to.
URL : `http://127.0.0.1:8000/display/` 
