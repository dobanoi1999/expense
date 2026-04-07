# 🚀 API Endpoints — Ứng Dụng Quản Lý Chi Tiêu

> **Base URL:** `https://api.yourapp.com/v1`
> **Auth:** Bearer Token (JWT) — trừ các endpoint công khai
> **Format:** `Content-Type: application/json`

---

## Mục lục

1. [Authentication](#1-authentication)
2. [Users / Profile](#2-users--profile)
3. [Wallets](#3-wallets)
4. [Categories](#4-categories)
5. [Transactions](#5-transactions)
6. [Budgets](#6-budgets)
7. [Recurring Transactions](#7-recurring-transactions)
8. [Reports & Statistics](#8-reports--statistics)
9. [Notifications](#9-notifications)

---

## 1. Authentication

### Email / Password

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `POST` | `/auth/register` | ❌ | Đăng ký tài khoản mới |
| `POST` | `/auth/login` | ❌ | Đăng nhập bằng email + mật khẩu |
| `POST` | `/auth/logout` | ✅ | Đăng xuất, thu hồi session |
| `POST` | `/auth/refresh` | ❌ | Lấy access token mới từ refresh token |

#### `POST /auth/register`
```json
// Request
{
  "email": "user@example.com",
  "password": "Str0ng!Pass",
  "display_name": "Nguyễn Văn A"
}

// Response 201
{
  "message": "Đăng ký thành công. Vui lòng kiểm tra email để xác thực tài khoản."
}
```

#### `POST /auth/login`
```json
// Request
{
  "email": "user@example.com",
  "password": "Str0ng!Pass"
}

// Response 200
{
  "access_token": "eyJ...",
  "refresh_token": "dGhp...",
  "expires_in": 900,
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "display_name": "Nguyễn Văn A",
    "avatar_url": null,
    "email_verified_at": null
  }
}
```

#### `POST /auth/refresh`
```json
// Request
{ "refresh_token": "dGhp..." }

// Response 200
{
  "access_token": "eyJ...",
  "expires_in": 900
}
```

---

### Email Verification

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `POST` | `/auth/verify-email` | ❌ | Xác thực email bằng token |
| `POST` | `/auth/resend-verification` | ❌ | Gửi lại email xác thực |

#### `POST /auth/verify-email`
```json
// Request
{ "token": "abc123xyz" }

// Response 200
{ "message": "Email xác thực thành công." }
```

---

### Quên Mật Khẩu

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `POST` | `/auth/forgot-password` | ❌ | Gửi email link reset mật khẩu |
| `POST` | `/auth/reset-password` | ❌ | Đặt mật khẩu mới bằng token |
| `PUT` | `/auth/change-password` | ✅ | Đổi mật khẩu khi đã đăng nhập |

#### `POST /auth/forgot-password`
```json
// Request
{ "email": "user@example.com" }

// Response 200 (luôn trả 200 để tránh email enumeration)
{ "message": "Nếu email tồn tại, link đặt lại mật khẩu đã được gửi." }
```

#### `POST /auth/reset-password`
```json
// Request
{
  "token": "reset_token_from_email",
  "new_password": "NewStr0ng!Pass"
}

// Response 200
{ "message": "Mật khẩu đã được cập nhật." }
```

#### `PUT /auth/change-password`
```json
// Request
{
  "current_password": "OldPass123",
  "new_password": "NewStr0ng!Pass"
}
```

---

### Social Login

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `POST` | `/auth/social/google` | ❌ | Đăng nhập / đăng ký qua Google |
| `POST` | `/auth/social/facebook` | ❌ | Đăng nhập / đăng ký qua Facebook |
| `POST` | `/auth/social/apple` | ❌ | Đăng nhập / đăng ký qua Apple |
| `POST` | `/auth/social/:provider/link` | ✅ | Liên kết social account vào tài khoản hiện tại |
| `DELETE` | `/auth/social/:provider/unlink` | ✅ | Huỷ liên kết social account |

#### `POST /auth/social/google`
```json
// Request — gửi id_token từ Google SDK phía client
{ "id_token": "google_id_token_here" }

// Response 200
{
  "access_token": "eyJ...",
  "refresh_token": "dGhp...",
  "expires_in": 900,
  "is_new_user": true,
  "user": { "id": "uuid", "email": "user@gmail.com", "display_name": "Nguyen A" }
}
```

---

## 2. Users / Profile

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/users/me` | ✅ | Lấy thông tin profile hiện tại |
| `PUT` | `/users/me` | ✅ | Cập nhật profile |
| `PUT` | `/users/me/avatar` | ✅ | Upload ảnh đại diện |
| `PUT` | `/users/me/email` | ✅ | Yêu cầu đổi email (gửi verify link) |
| `DELETE` | `/users/me` | ✅ | Xoá tài khoản |
| `GET` | `/users/me/sessions` | ✅ | Danh sách thiết bị đang đăng nhập |
| `DELETE` | `/users/me/sessions/:id` | ✅ | Đăng xuất khỏi thiết bị cụ thể |
| `DELETE` | `/users/me/sessions` | ✅ | Đăng xuất tất cả thiết bị |

#### `GET /users/me` — Response 200
```json
{
  "id": "uuid",
  "email": "user@example.com",
  "display_name": "Nguyễn Văn A",
  "avatar_url": "https://cdn.../avatar.jpg",
  "auth_provider": "mixed",
  "email_verified_at": "2024-01-15T08:00:00Z",
  "locale": "vi",
  "currency": "VND",
  "social_accounts": [
    { "provider": "google", "linked_at": "2024-01-10T00:00:00Z" }
  ],
  "created_at": "2024-01-01T00:00:00Z"
}
```

#### `PUT /users/me`
```json
// Request
{
  "display_name": "Nguyễn Văn B",
  "locale": "en",
  "currency": "USD"
}
```

---

## 3. Wallets

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/wallets` | ✅ | Danh sách ví của user |
| `POST` | `/wallets` | ✅ | Tạo ví mới |
| `GET` | `/wallets/:id` | ✅ | Chi tiết 1 ví |
| `PUT` | `/wallets/:id` | ✅ | Cập nhật ví |
| `DELETE` | `/wallets/:id` | ✅ | Xoá ví |
| `PUT` | `/wallets/:id/archive` | ✅ | Lưu trữ ví |
| `GET` | `/wallets/:id/balance-history` | ✅ | Lịch sử số dư ví theo thời gian |
| `GET` | `/wallets/:id/members` | ✅ | Danh sách thành viên ví chung |
| `POST` | `/wallets/:id/members/invite` | ✅ | Mời thành viên vào ví chung |
| `PUT` | `/wallets/:id/members/:userId` | ✅ | Cập nhật quyền thành viên |
| `DELETE` | `/wallets/:id/members/:userId` | ✅ | Xoá thành viên |
| `POST` | `/wallets/:id/members/accept` | ✅ | Chấp nhận lời mời vào ví chung |

#### `POST /wallets` — Request
```json
{
  "name": "Ví tiền mặt",
  "type": "cash",
  "currency": "VND",
  "initial_balance": 5000000,
  "color": "#4CAF50",
  "icon": "wallet"
}
```

#### `GET /wallets` — Response 200
```json
{
  "data": [
    {
      "id": "uuid",
      "name": "Ví tiền mặt",
      "type": "cash",
      "currency": "VND",
      "current_balance": 3500000,
      "color": "#4CAF50",
      "icon": "wallet",
      "is_archived": false,
      "member_count": 1
    }
  ],
  "total_balance_vnd": 12500000
}
```

---

## 4. Categories

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/categories` | ✅ | Danh sách tất cả category (system + custom) |
| `GET` | `/categories/system` | ✅ | Chỉ category hệ thống |
| `POST` | `/categories` | ✅ | Tạo category tùy chỉnh |
| `PUT` | `/categories/:id` | ✅ | Cập nhật category (chỉ custom) |
| `DELETE` | `/categories/:id` | ✅ | Xoá category (chỉ custom) |

#### `GET /categories` — Response 200
```json
{
  "data": [
    {
      "id": "uuid",
      "name": "Ăn uống",
      "type": "expense",
      "icon": "food",
      "color": "#FF5722",
      "is_system": true,
      "parent_id": null,
      "children": [
        { "id": "uuid", "name": "Ăn ngoài", "type": "expense" }
      ]
    }
  ]
}
```

---

## 5. Transactions

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/transactions` | ✅ | Danh sách giao dịch (có filter, phân trang) |
| `POST` | `/transactions` | ✅ | Tạo giao dịch mới |
| `GET` | `/transactions/:id` | ✅ | Chi tiết 1 giao dịch |
| `PUT` | `/transactions/:id` | ✅ | Cập nhật giao dịch |
| `DELETE` | `/transactions/:id` | ✅ | Xoá giao dịch |
| `POST` | `/transactions/bulk` | ✅ | Import nhiều giao dịch cùng lúc |
| `DELETE` | `/transactions/bulk` | ✅ | Xoá nhiều giao dịch |

#### `GET /transactions` — Query Params
| Tham số | Kiểu | Mô tả |
|---------|------|-------|
| `wallet_id` | UUID | Lọc theo ví |
| `category_id` | UUID | Lọc theo danh mục |
| `type` | string | `income` / `expense` / `transfer` |
| `date_from` | date | Từ ngày (YYYY-MM-DD) |
| `date_to` | date | Đến ngày |
| `amount_min` | number | Số tiền tối thiểu |
| `amount_max` | number | Số tiền tối đa |
| `tags` | string | Lọc theo tag, phân cách bởi dấu phẩy |
| `q` | string | Tìm kiếm theo ghi chú |
| `sort` | string | `date_desc` (mặc định) / `date_asc` / `amount_desc` / `amount_asc` |
| `page` | int | Trang hiện tại (default: 1) |
| `limit` | int | Số bản ghi/trang (default: 20, max: 100) |

#### `GET /transactions` — Response 200
```json
{
  "data": [
    {
      "id": "uuid",
      "type": "expense",
      "amount": 85000,
      "currency": "VND",
      "note": "Cơm trưa văn phòng",
      "transaction_date": "2024-03-15",
      "category": { "id": "uuid", "name": "Ăn uống", "icon": "food", "color": "#FF5722" },
      "wallet": { "id": "uuid", "name": "Ví tiền mặt" },
      "tags": ["công việc"],
      "attachments": [],
      "created_at": "2024-03-15T12:30:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 145,
    "total_pages": 8
  }
}
```

#### `POST /transactions` — Request
```json
{
  "wallet_id": "uuid",
  "category_id": "uuid",
  "type": "expense",
  "amount": 85000,
  "note": "Cơm trưa văn phòng",
  "transaction_date": "2024-03-15",
  "transaction_time": "12:30:00",
  "tags": ["công việc"],
  "is_excluded": false
}
```

#### Giao dịch chuyển khoản
```json
// POST /transactions
{
  "type": "transfer",
  "wallet_id": "uuid-source-wallet",
  "to_wallet_id": "uuid-dest-wallet",
  "amount": 1000000,
  "note": "Chuyển sang tài khoản ngân hàng",
  "transaction_date": "2024-03-15"
}
```

---

### Attachments

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `POST` | `/transactions/:id/attachments` | ✅ | Upload hình ảnh/hoá đơn |
| `DELETE` | `/transactions/:id/attachments/:attachmentId` | ✅ | Xoá file đính kèm |

```
// POST /transactions/:id/attachments
Content-Type: multipart/form-data
Body: file (image/jpeg, image/png, application/pdf — max 10MB)
```

---

## 6. Budgets

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/budgets` | ✅ | Danh sách ngân sách |
| `POST` | `/budgets` | ✅ | Tạo ngân sách mới |
| `GET` | `/budgets/:id` | ✅ | Chi tiết ngân sách + tiến độ sử dụng |
| `PUT` | `/budgets/:id` | ✅ | Cập nhật ngân sách |
| `DELETE` | `/budgets/:id` | ✅ | Xoá ngân sách |
| `GET` | `/budgets/overview` | ✅ | Tổng quan tất cả ngân sách tháng hiện tại |

#### `POST /budgets` — Request
```json
{
  "name": "Chi tiêu tháng 3",
  "amount": 10000000,
  "period": "monthly",
  "start_date": "2024-03-01",
  "alert_threshold": 80,
  "category_ids": ["uuid-1", "uuid-2"]
}
```

#### `GET /budgets/:id` — Response 200
```json
{
  "id": "uuid",
  "name": "Chi tiêu tháng 3",
  "amount": 10000000,
  "period": "monthly",
  "start_date": "2024-03-01",
  "end_date": "2024-03-31",
  "alert_threshold": 80,
  "categories": [
    { "id": "uuid", "name": "Ăn uống" }
  ],
  "progress": {
    "spent": 7500000,
    "remaining": 2500000,
    "percentage": 75,
    "is_over_budget": false,
    "alert_triggered": false
  }
}
```

#### `GET /budgets/overview` — Response 200
```json
{
  "period": "2024-03",
  "total_budget": 15000000,
  "total_spent": 9200000,
  "total_remaining": 5800000,
  "budgets": [
    {
      "id": "uuid",
      "name": "Chi tiêu tháng 3",
      "percentage": 75,
      "is_over_budget": false
    }
  ]
}
```

---

## 7. Recurring Transactions

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/recurring` | ✅ | Danh sách giao dịch định kỳ |
| `POST` | `/recurring` | ✅ | Tạo giao dịch định kỳ |
| `GET` | `/recurring/:id` | ✅ | Chi tiết 1 giao dịch định kỳ |
| `PUT` | `/recurring/:id` | ✅ | Cập nhật giao dịch định kỳ |
| `DELETE` | `/recurring/:id` | ✅ | Xoá giao dịch định kỳ |
| `PUT` | `/recurring/:id/pause` | ✅ | Tạm dừng |
| `PUT` | `/recurring/:id/resume` | ✅ | Tiếp tục |
| `POST` | `/recurring/:id/execute` | ✅ | Thực hiện thủ công ngay bây giờ |

#### `POST /recurring` — Request
```json
{
  "wallet_id": "uuid",
  "category_id": "uuid",
  "type": "expense",
  "amount": 299000,
  "note": "Spotify Premium",
  "frequency": "monthly",
  "frequency_interval": 1,
  "start_date": "2024-03-01",
  "end_date": null
}
```

---

## 8. Reports & Statistics

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/reports/summary` | ✅ | Tổng thu/chi theo khoảng thời gian |
| `GET` | `/reports/by-category` | ✅ | Chi tiêu theo danh mục (dùng cho pie chart) |
| `GET` | `/reports/by-day` | ✅ | Thu/chi theo ngày (dùng cho bar/line chart) |
| `GET` | `/reports/by-month` | ✅ | Thu/chi theo tháng (12 tháng gần nhất) |
| `GET` | `/reports/cashflow` | ✅ | Dòng tiền vào/ra |
| `GET` | `/reports/net-worth` | ✅ | Tổng tài sản ròng (tổng tất cả ví) |
| `GET` | `/reports/top-expenses` | ✅ | Các khoản chi lớn nhất |

#### Query Params chung cho reports
| Tham số | Mô tả |
|---------|-------|
| `date_from` | Từ ngày |
| `date_to` | Đến ngày |
| `wallet_id` | Lọc theo ví (tuỳ chọn) |

#### `GET /reports/summary` — Response 200
```json
{
  "period": { "from": "2024-03-01", "to": "2024-03-31" },
  "total_income": 15000000,
  "total_expense": 9200000,
  "net": 5800000,
  "avg_daily_expense": 296774,
  "transaction_count": 47
}
```

#### `GET /reports/by-category` — Response 200
```json
{
  "period": { "from": "2024-03-01", "to": "2024-03-31" },
  "type": "expense",
  "total": 9200000,
  "data": [
    {
      "category": { "id": "uuid", "name": "Ăn uống", "color": "#FF5722" },
      "amount": 3500000,
      "percentage": 38.04,
      "transaction_count": 22
    }
  ]
}
```

#### `GET /reports/by-day` — Response 200
```json
{
  "data": [
    { "date": "2024-03-01", "income": 0, "expense": 250000 },
    { "date": "2024-03-02", "income": 15000000, "expense": 85000 }
  ]
}
```

---

## 9. Notifications

| Method | Endpoint | Auth | Mô tả |
|--------|----------|------|-------|
| `GET` | `/notifications` | ✅ | Danh sách thông báo (có phân trang) |
| `PUT` | `/notifications/:id/read` | ✅ | Đánh dấu 1 thông báo đã đọc |
| `PUT` | `/notifications/read-all` | ✅ | Đánh dấu tất cả đã đọc |
| `DELETE` | `/notifications/:id` | ✅ | Xoá 1 thông báo |
| `GET` | `/notifications/unread-count` | ✅ | Số thông báo chưa đọc (dùng cho badge) |

#### `GET /notifications` — Response 200
```json
{
  "data": [
    {
      "id": "uuid",
      "type": "budget_alert",
      "title": "Sắp vượt ngân sách",
      "body": "Ngân sách 'Chi tiêu tháng 3' đã dùng 80%",
      "is_read": false,
      "created_at": "2024-03-20T09:00:00Z"
    }
  ],
  "pagination": { "page": 1, "limit": 20, "total": 5 }
}
```

---

## 10. Chuẩn lỗi chung

Tất cả lỗi trả về theo format:
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Dữ liệu không hợp lệ",
    "details": [
      { "field": "email", "message": "Email không đúng định dạng" }
    ]
  }
}
```

| HTTP Status | Error Code | Mô tả |
|-------------|------------|-------|
| `400` | `VALIDATION_ERROR` | Dữ liệu request không hợp lệ |
| `401` | `UNAUTHORIZED` | Chưa đăng nhập hoặc token hết hạn |
| `403` | `FORBIDDEN` | Không có quyền truy cập |
| `404` | `NOT_FOUND` | Tài nguyên không tồn tại |
| `409` | `CONFLICT` | Xung đột dữ liệu (email đã tồn tại...) |
| `422` | `UNPROCESSABLE` | Logic nghiệp vụ bị vi phạm |
| `429` | `RATE_LIMITED` | Quá nhiều request |
| `500` | `INTERNAL_ERROR` | Lỗi server |

---

## 11. Ghi chú triển khai

### Phân quyền
- Mọi endpoint có `✅` đều cần header: `Authorization: Bearer <access_token>`
- Access token hết hạn sau **15 phút**, dùng `POST /auth/refresh` để lấy mới
- Refresh token hết hạn sau **30 ngày**

### Pagination
Tất cả endpoint danh sách hỗ trợ `?page=1&limit=20`

### Versioning
API được version qua prefix `/v1/`. Khi có breaking change sẽ nâng lên `/v2/`

### Rate Limiting
| Nhóm endpoint | Giới hạn |
|--------------|---------|
| Auth (login, register, forgot-password) | 10 req / phút / IP |
| API thông thường | 300 req / phút / user |
| Upload file | 20 req / phút / user |
| Reports | 60 req / phút / user |
