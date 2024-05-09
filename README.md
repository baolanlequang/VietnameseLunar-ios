# VietnameseLunar
Library for convert a day to Vietnamese lunar day (Tiếng Việt ở bên dưới)

![GitHub release (release name instead of tag name)](https://img.shields.io/github/v/release/baolanlequang/VietnameseLunar-ios?include_prereleases&label=version)

This library is developed base on Hồ Ngọc Đức's algorithm [https://www.informatik.uni-leipzig.de/~duc/amlich/calrules_en.html](https://www.informatik.uni-leipzig.de/~duc/amlich/calrules_en.html).

If you're using this library, please help me give a thank to Hồ Ngọc Đức.

If you like my works, you can <a href="https://www.buymeacoffee.com/baolanlequang" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 30px !important;width: 117px !important;" ></a>

## How to use
This library is released under MIT license, you are free to use or modify it.

### Install via cocoapods
1. To use in your project, init cocoapods if you haven't yet:

```
pod init
```

2. Add library to your `podfile`:
```
pod 'VietnameseLunar'
```

3. Install libaries
```
pod install
```

### Use it in your project

```swift
import VietnameseLunar
....

let now = Date()
let vietnameseCalendar = VietnameseCalendar(now)

//This will be display a string, eg: "Mùng 1 Tết Nhâm Dần"
print(vietnameseCalendar.vietnameseDate.toString())
```

# VietnameseLunar (Tiếng Việt)
Đây là thư viện để tính toán ngày âm lịch theo lịch Việt Nam

Thư viện này được phát triển dựa trên thuật toán của Hồ Ngọc Đức [https://www.informatik.uni-leipzig.de/~duc/amlich/calrules_en.html](https://www.informatik.uni-leipzig.de/~duc/amlich/calrules_en.html).

Nếu bạn đang sử dụng thư viện này, xin vui lòng giúp tôi gửi một lời cám ơn đến Hồ Ngọc Đức.

## Cách sử dụng
Thư viện này được phát hành dưới giấy phép MIT, do đó bạn có thể tự do sử dụng và chỉnh sửa tuỳ ý.

### Cài đặt thông qua cocoapods
1. Để sử dụng, bạn khởi tạo cocoapods nếu chưa có:

```
pod init
```

2. Thêm thư viện vào file `podfile`:
```
pod 'VietnameseLunar'
```

3. Cài đặt thư viện
```
pod install
```

### Sử dụng trong project của bạn

```swift
import VietnameseLunar
....

let now = Date()
let vietnameseCalendar = VietnameseCalendar(now)

//Dòng này sẽ in ra ngày tương ứng, ví dụ: "Mùng 1 Tết Nhâm Dần"
print(vietnameseCalendar.vietnameseDate.toString())
```
