# HealthOCR Project
> This repository contains the backend (Django + PostgreSQL) and frontend (Flutter) for the HealthOCR project, which allows uploading and visualizing exam results via an OCR pipeline.
---
## Backend Setup (MacOS)
1. **Install Django via Homebrew** 
  ```bash
      brew install django
  ```
2. **Setting Up and Activating a Virtual Environment**
   > From the backend directory
  - Create the environment
    ```bash
      python3 -m venv venv
    ```
  - Activate it
    ```bash
      source venv/bin/activate
    ```
  - Install the required dependencies
    ```bash
      pip install -r requirements.txt
    ```
3. **Configure environment variables**
   ```bash
      cp .env.example .env
      # Edit .env to set DATABASE_URL and other variables if needed
    ```
4. **Setting Up PostgreSQL Locally**
  - Install PostgreSQL
    ```bash
      brew install postgresql
    ```
  - Start PostgreSQL service
    ```bash
      brew services start postgresql
    ```
  - Connect to PostgreSQL and create database
    ```bash
      psql postgres
      CREATE DATABASE healthocr_db;
    ```
5. **Running the Backend**
   ```bash
      # From the backend directory
      python manage.py migrate # Run Django migrations
      python manage.py runserver 0.0.0.0:8000 # Run the backend server
    ```
## Frontend Setup (Flutter)
1. **Install Flutter** 
  ```bash
      brew install flutter
  ```
2. **Get packages** 
  ```bash
      flutter pub get
  ```
3. **Run the Flutter app** 
  ```bash
     flutter run
  ```
    
