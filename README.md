## بخش عملی
### نمودار UML
به صورت زیر سه کامپوننت (کانتینر) مدنظر را به هم وصل می‌کنیم. بدین ترتیب ریکوئست از سمت کاربر آمده و به nginx می‌رسد، پس از load_balancing این کامپوننت تشخیص می‌دهد که ریکوئست به کجا رفته و فایل اپلیکیشن کوئری صحیح را به دیتابیس ارسال می‌کند.

<img width="751" alt="image" src="https://github.com/ShayanEmzed/SEL-HW6/assets/60621655/af556b42-f845-4a6a-971c-38b3f515927e">

### فایل‌های docker
برای اپلیکیشن flask فایل داکر زیر را می‌سازیم:

<img width="490" alt="image" src="https://github.com/ShayanEmzed/SEL-HW6/assets/60621655/09b537b9-60d6-4f08-8879-2ad9c11a5f1d">

با این کار پکیج‌های لازم را نصب کرده و اپلیکیشن را بر روی پورت ۵۰۹۰ بالا می‌آوریم. از آنجا که استفاده ما از دو image دیگر (پوستگرس و انجینیکس) در حد ایمیج‌های روی داکرهاب است، برای بالا آوردن آنها و همچنین برقراری اتصال بین این سه کامپوننت از docker-compose کمک می‌گیریم:

<img width="646" alt="image" src="https://github.com/ShayanEmzed/SEL-HW6/assets/60621655/29bc545c-452c-4926-9ead-dc6a84147ad9">

با استفاده از فایل بالا و تعریف network ها کانکشن‌های بین کانتینرها را ایجاد می‌کنیم. همچنین تیبل ایجاد شده در دیتابیس را ذخیره می‌کنیم تا با پایین آمدن کانتینر مرتبط، اطلاعات را از دست ندهیم.
### بالا آوردن سرویس‌های بر روی ابزار رایگان تست داکر
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
با وارد کردن دستور docker ps، کانتینرهای در حال اجرا را بررسی می‌کنیم:

## بخش تئوری
1. از چه نمودار/نمودارهای UML ای برای مدل‌سازی معماری MicroService خود استفاده کرده‌اید؟  
می‌توان از نمودارهای component diagram یا deployment diagram برای مدل‌سازی معماری میکروسرویس استفاده کرد. نشان دادن هز کامپوننت و image و نحوه اتصال آنها در نمودار اول، و نشان دادن نجوه جایگیری کانتینرها بر روی سیستم و تعامل آنها در نمودار دوم ممکن خواهد بود. در بخش عملی از نمودار component diagram استفاده شده است.
2. مفهوم Domain-driven Design یا DDD چه ارتباطی با معماری MicroService دارد؟ در حد دو-سه خط توضیح دهید.  
طراحی Domain Driven به ما این قابلیت را می‌دهد که معماری مایکروسرویس خود را با شکستن سیستم بزرگ‌تر به اجزای قابل توسعه و جامع، بهتر شناخته و همچنین رابطه بین هر سرویس با دیگر اعضا را شناسایی کنیم. از آنجا که در DDD به دنبال شناخت و ایجاد مدل‌هایی هستیم که بهتر منطق بیزینسس مدنظر را پیاده کنیم، در مرحله پیاده‌سازی می‌توان از این مدل‌ها استفاده کرده و در یک معماری microservice مثل استفاده از docker و dockerize کردن، بهترین نحوه وصل کردن image های مختلف به هم را پیدا کنیم.
3. آیا Docker Compose یک ابزار Orchestration است؟ در حد دو-سه خط توضیح دهید.
از آنجا که ابزارهای orchestration برای automate کردن کانفیگوریشن، هماهنگی و پروسس‌هایی مثل data management کاربرد دارند، می‌توان docker-compose را یکی از این ابزارها در نظر گرفت. همانطور که در بخش عملی مشاهده شد، در محیط هایی که از چندین کانتینر استفاده می‌کنیم احتمالا به networking یا ذخیره دیتا نیاز پیدا می‌کنیم که docker-compose ابزار مناسبی برای این کار خواهد بود تا با وارد کردن یک دستور و بدون نیاز به ایجاد کانتینرها به صورت جدا و سپس تعریف نتورکینگ، این کار را با یک دستور به سادگی انجام دهیم.
