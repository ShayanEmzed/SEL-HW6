<img width="646" alt="image" src="https://github.com/ShayanEmzed/SEL-HW6/assets/60621655/354aa140-56f8-40c1-99f9-b3599911f083"># SEL-HW6
## بخش عملی
### نمودار UML
به صورت زیر سه کامپوننت (کانتینر) مدنظر را به هم وصل می‌کنیم. بدین ترتیب ریکوئست از سمت کاربر آمده و به nginx می‌رسد، پس از load_balancing این کامپوننت تشخیص می‌دهد که ریکوئست به کجا رفته و فایل اپلیکیشن کوئری صحیح را به دیتابیس ارسال می‌کند.

<img width="679" alt="image" src="https://github.com/ShayanEmzed/SEL-HW6/assets/60621655/61aea1d0-a0fd-4549-890e-031090737b83">

### فایل‌های docker
برای اپلیکیشن flask فایل داکر زیر را می‌سازیم:

<img width="490" alt="image" src="https://github.com/ShayanEmzed/SEL-HW6/assets/60621655/09b537b9-60d6-4f08-8879-2ad9c11a5f1d">

با این کار پکیج‌های لازم را نصب کرده و اپلیکیشن را بر روی پورت ۵۰۹۰ بالا می‌آوریم. از آنجا که استفاده ما از دو image دیگر (پوستگرس و انجینیکس) در حد ایمیج‌های روی داکرهاب است، برای بالا آوردن آنها و همچنین برقراری اتصال بین این سه کامپوننت از docker-compose کمک می‌گیریم:

<img width="646" alt="image" src="https://github.com/ShayanEmzed/SEL-HW6/assets/60621655/29bc545c-452c-4926-9ead-dc6a84147ad9">

با استفاده از فایل بالا و تعریف network ها کانکشن‌های بین کانتینرها را ایجاد می‌کنیم. همچنین تیبل ایجاد شده در دیتابیس را ذخیره می‌کنیم تا با پایین آمدن کانتینر مرتبط، اطلاعات را از دست ندهیم.  
حال با وارد کردن دستورهای زیر image ها را build کرده و سه کانتینر را بالا می‌آوریم:
```
docker-compose up -d db
```
با دستور بالا دیتابیس پوستگرس را بالا می‌آوریم.
```
docker-compose run --rm flaskapp /bin/bash -c "cd /opt/services/flaskapp/src && python -c  'import database; database.init_db()'"
```
با دستور بالا تیبل مدنظر را می‌سازیم.
```
docker-compose up -d
```
و با دستور بالا تمامی سه کانیتر را ران می‌کنیم.
