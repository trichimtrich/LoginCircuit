# README (VN)
## Mạch khóa và Thay đổi thông tin (trên Altera DE2_Board)

### INFO
* NAME     : Login-Circuit
* AUTHOR   : Group 4
* BOARD    : DE2
* LANG     : Verilog
* IDE      : Quartus II
* DATE     : 6/7/2013

### FILES
1. LoginCircuit.csv : AssignPIN
2. LoginCircuit.qpf : Project
3. LoginCircuit.v   : VerilogCode

### Các thành phần cơ bản
* Switch 0 - 5 nối trực tiếp đến LED RED 0 - 5
* KEY[3], KEY[2], KEY[0] nối trực tiếp đến LED GREEN [8],[6] và [2]
* Màn hình LCD hiện thông báo

### Hoạt động: Gồm 9 trạng thái

#### STAGE 1(welcome)
LCD: "Xin chao!"
Delay 3s tự chuyển sang Login(STAGE 2)

#### STAGE 2(login)
LCD: 
  + Dòng 1: "Mat khau?" 
  + Dòng 2: "    xxxxxx"
 (xxxxxx là pass cần nhập vào từ các Switch 0 - 5)

KEY[3]: Đăng nhập
  + Nếu Đúng: Chuyển sang Success(STAGE 5)
  + Nếu Sai:
      ++ Sai dưới 3 lần: sang FAILED1(STAGE 3)
      ++ Sai 3 lần liên tiếp: sang FAILED2(STAGE 4)

#### STAGE 3(FAILED1)
LCD: "Sai MK!!!"
Delay 3s tự chuyển sang Login(STAGE 2)

#### STAGE 4(FAILED2)
LCD: 
  + Dòng 1: "Sai!!! Login CD"
  + Dòng 2: "     xxxxxx s" (xxxxxx = thời gian chạy ngược)

Delay (time)s tự chuyển sang Login(STAGE 2)
(vì người dùng đăng nhập sai quá nhiều nên bắt phải chờ (time)s để đăng nhập tiếp)

#### STAGE 5(SUCCESS)
LCD: "DN Thanh Cong!!!"
Delay 3s tự chuyển sang ADMIN(STAGE 6)

#### STAGE 6(ADMIN)
LCD: "Admin"

KEY[3]: Đổi Password, qua PASSWORD(STAGE 7)
KEY[2]: Đổi TimeCD, qua TIMECD(STAGE 8) (đổi lại time(s) ở STAGE 4)
KEY[0]: Đăng xuất, qua LOGIN(STAGE 2)

#### STAGE 7(PASSWORD)
LCD: 
  + Dòng 1: "Doi Pass:"
  + Dòng 2: "      xxxxxx"
  (xxxxxx giá trị thay đổi theo Switch 0 - 5)

KEY[3]: Đổi Password, qua CHANGING(STAGE 9)
KEY[0]: Không đổi, về lại ADMIN(STAGE 6)

#### STAGE 8(TIMECD)
LCD: 
  + Dòng 1: "Doi Time:"
  + Dòng 2: "      xxxxxx"
  (xxxxxx giá trị thay đổi theo Switch 0 - 5)

KEY[3]: Đổi TimeCD, qua CHANGING(STAGE 9)
KEY[0]: Không đổi, về lại ADMIN(STAGE 6)

#### STAGE 9(CHANGING)
LCD: "Changing..."
Delay 3s tự chuyển sang ADMIN(STAGE 6)

### Ý tưởng
* Sử dụng CLOCK_50MHZ để tính toán thời gian nhảy
* Flip-Flop để lưu biến
* FullAdder để cộng từ (nhiều biến)
* Mạch Selector để chọn trạng thái
* Sử dụng ngôn ngữ Verilog để mô phỏng

### Cấu trúc chương trình: theo trình tự (LoginCircuit.v)
- Khai báo hằng
- Khai báo Pin và biến
- Initial: thiết lập giá trị cơ bản của biến
- 2 mạch chạy song song:
  - Mạch đếm thời gian 50 Mhz
  - Mạch xử lí trạng thái của chương trình
    - Đếm thời gian 1000Hz
    - Xác định trạng thái hiện hành
      - Điều khiển LCD
      - Bắt tín hiệu các phím bấm để chuyển trạng thái

### Tham khảo:
1. DE2_LCĐ_DataSheet
2. Digital Design - Principles and Practices
3. Verilog HDL A guide to Digital Design and Synthesis
4. dientuvietnam.com
5. Wikipedia
