FROM python:3.7
WORKDIR /src
COPY . /src
ENV PYTHONUNBUFERED=1
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8080
CMD ["python", "app.py"]

