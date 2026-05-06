# 员工资薪管理系统

这是一个前后端分离的员工薪资管理系统：

- 前端：Vue 3 + Vite + Element Plus
- 后端：Spring Boot 3 + Spring JDBC + MySQL

## 数据库初始化

后端默认连接本机 MySQL 的 `money` 数据库，连接信息可以通过环境变量覆盖：

```yaml
url: jdbc:mysql://127.0.0.1:3306/money
username: root
password: root
```

可用环境变量：

| 变量 | 默认值 |
| --- | --- |
| `DB_HOST` | `127.0.0.1` |
| `DB_PORT` | `3306` |
| `DB_NAME` | `money` |
| `DB_USERNAME` | `root` |
| `DB_PASSWORD` | `root` |

首次运行前，先导入初始化脚本：

```powershell
cd C:\dev\salary-system
mysql --default-character-set=utf8mb4 -u root -p -e "source C:/dev/salary-system/backend/src/main/resources/db/init.sql"
```

脚本会创建：

- `money` 数据库
- `department`、`employee`、`checking_in`、`salary_record` 表
- 后端当前调用的存储过程：
  - `getRecordsBetweenDates`
  - `getRecordsBetweenDatesById`
  - `GetEmployeeInfoById`
  - `GetCheckingInfoById`
  - `CalculateYearlyBonus`
  - `UpdateEmployeeInfo`
  - `UpdateCheckingIn`
  - `SetDefaultPassword`

演示账号：

| 工号 | 密码 | 权限 |
| --- | --- | --- |
| `1001` | `123456` | 员工 |
| `2001` | `123456` | 财务 |
| `3001` | `123456` | 人事 |

## 运行后端

需要 Java 17。

```powershell
cd C:\dev\salary-system\backend
.\mvnw.cmd spring-boot:run
```

后端默认地址：

```text
http://localhost:8080
```

## 运行前端

需要 Node.js 和 npm。

```powershell
cd C:\dev\salary-system\frontend
npm install
npm run dev
```

前端默认地址：

```text
http://localhost:5173
```

本地开发时，前端请求统一走 `/api`，Vite 会把请求代理到本机后端：

```text
浏览器 -> http://localhost:5173/api/... -> http://127.0.0.1:8080/...
```

代理配置在 `frontend/vite.config.js`。

## 服务器部署

生产环境推荐使用 Nginx 反向代理。前端仍然只请求 `/api`，不需要写服务器 IP，也不需要为每台服务器重新打包前端。

示例 Nginx 配置：

```nginx
server {
    listen 80;
    server_name your-domain.com;

    root /usr/share/nginx/html/salary-system;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location /api/ {
        proxy_pass http://127.0.0.1:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

其中：

- `/usr/share/nginx/html/salary-system` 放前端 `dist` 目录里的文件
- Spring Boot 后端在服务器本机监听 `8080`
- 浏览器访问 `/api/login/loginToSystem`
- Nginx 转发到 `http://127.0.0.1:8080/login/loginToSystem`
