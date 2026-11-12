# Tiếp tục dự án Tam Quốc bằng Gemini Pro

## 1. Giải nén và mở đúng thư mục

1. Giải nén toàn bộ ZIP vào một thư mục làm việc ngắn, ví dụ `D:\TamQuoc_Gemini_Pro`. Giữ ZIP làm bản gốc để có thể giải nén lại.
2. Cài **Google Antigravity** cho Windows và đăng nhập bằng tài khoản Google có gói **Google AI Pro**. Chọn bản Windows phù hợp với máy. Nếu menu chọn mô hình có Gemini Pro, chọn phiên bản Pro đang khả dụng trên tài khoản.
3. Trong Antigravity, chọn **New Project → Add Folder → Create**, trỏ tới thư mục ngoài cùng **TamQuoc_Gemini_Pro**, nơi có file này. Khi được hỏi chế độ, chọn **Local**. Agent cần thấy cả thư mục Godot, ảnh gốc, MP4 và hướng dẫn.
4. Để chạy game, mở file **`tam_quoc_gui/project.godot`** trong Godot. Dùng Godot **4.5.1 Standard** nếu muốn khớp phiên bản đã kiểm tra bản GUI này. Nhấn **F5**, bấm **Chơi ngay**, rồi thử hai ô mưu sĩ và luồng chọn phe. Bản tích hợp là GUI demo.

- [Tải Google Antigravity](https://antigravity.google/download)
- [Tạo project và làm việc ở chế độ Local](https://antigravity.google/docs/getting-started)
- [Hạn mức các gói Antigravity](https://www.antigravity.google/pricing)

## 2. Kiểm tra công cụ trên máy

Mở PowerShell trong thư mục ngoài cùng và chạy:

```powershell
Get-Item .\tam_quoc_gui\project.godot
ffmpeg -version
ffprobe -version
python --version
```

Nếu thiếu FFmpeg, tải bản Windows từ mục Windows trên trang FFmpeg, giải nén và thêm thư mục chứa `ffmpeg.exe` và `ffprobe.exe` vào Path, sau đó mở lại PowerShell và Antigravity. Nếu thiếu Python, cài bản Python cho Windows rồi kiểm tra lại lệnh. Khi agent cần Pillow, NumPy hoặc SciPy, yêu cầu dùng môi trường Python riêng trong thư mục làm việc. Nếu `godot` chưa có trong Path, đưa cho agent đường dẫn đầy đủ đến file Godot 4.5.1 của bạn.

Lệnh dưới đây dùng **bản console của Godot trên Windows**. Thay đường dẫn ví dụ bằng đường dẫn thật:

```powershell
$GodotExe = 'C:\Tools\Godot\Godot_v4.5.1-stable_win64_console.exe'
& $GodotExe --headless --path .\tam_quoc_gui --editor --import
& $GodotExe --headless --path .\tam_quoc_gui --fixed-fps 60 -- --verify
```

Bản gốc có chế độ `--verify` và in `GUI_VERIFY_OK` khi chạy qua luồng kiểm tra. Kết quả headless cần đi cùng kiểm tra hình ảnh khi nhấn F5.

- [FFmpeg cho Windows](https://ffmpeg.org/download.html)
- [Python cho Windows](https://www.python.org/downloads/windows/)
- [Godot 4.5.1](https://godotengine.org/download/archive/4.5.1-stable/)

## 3. File nào dùng ở bước nào

| Đường dẫn | Dùng để làm gì |
|---|---|
| `tam_quoc_gui/` | Project mới nhất đã tích hợp hai mưu sĩ, màn chọn phe và ba sảnh. |
| `source_art/` | 10 ảnh gốc nền trắng. Đính kèm đúng ảnh vào Ingredients trong Flow. |
| `handoff/Prompt_Idle_10_Nhan_Vat_Tam_Quoc.md` | 20 prompt Video và Agent hiện hành. Dùng ở bước tạo clip trong Flow. |
| `.agents/skills/godot-character-idle/SKILL.md` | Quy trình tách nền, kiểm tra vòng lặp, xuất atlas, ghép scene và kiểm thử cho Antigravity. |
| `source_clips/reference/` | Hai MP4 nguồn của mưu sĩ. Project đã có atlas dùng trong game, trong đó nữ mưu sĩ có đoạn nối vòng lặp đã sửa. |
| `source_clips/incoming/` | Nơi bạn thả MP4 mới đã duyệt trước khi giao agent. |
| `qa_rejected/` | Clip nam thương nhân bị nhân đôi cân và ảnh so sánh. Chỉ dùng để nhận diện lỗi. |
| `handoff/02_PROMPT_GIAO_VIEC_CHO_GEMINI.md` | Ba prompt dán theo thứ tự vào Antigravity. |

Hai mưu sĩ đã được tích hợp. Tám nhân vật còn lại có ảnh gốc và prompt Flow. Hãy tạo và duyệt MP4 cho từng nhân vật trước khi giao bước tách nền. Khi tạo clip, dùng ảnh gốc nền trắng ở **Ingredients**, để trống **Start frame**, rồi kiểm tra màu nền từ khung đầu, góc thân và đầu, tóc, vải, tay và số lượng đạo cụ. Kiểm tra kỹ giây 2–5 khi chuyển động rõ nhất. Với nam thương nhân, tay phải giữ đúng một cân hai đĩa và tay trái giữ cuốn sổ.

Antigravity có thể đọc hướng dẫn từ thư mục `.agents/skills/`. Nếu giao việc trong Gemini chat, bạn có thể đính kèm nội dung hướng dẫn và MP4 để hỏi hoặc nhờ viết script. Để chạy lệnh và sửa trực tiếp bản project trên máy, dùng cửa sổ Antigravity đã mở thư mục ở bước 1.

- [Cách Antigravity đọc SKILL.md](https://antigravity.google/docs/skills)

## 4. Thứ tự làm một nhân vật

1. Dán **Prompt A** để agent đọc bộ bàn giao và xác nhận bản gốc chạy được.
2. Đưa MP4 mới vào `source_clips/incoming/`. Dán **Prompt B** để agent tách nền và cho bạn duyệt bản xem thử trước.
3. Khi bản xem thử đạt, dán **Prompt C** để agent thêm nhân vật vào màn chọn và kiểm tra luồng. Chạy F5 để tự xem màu viền, điểm chạm chân, bóng và ít nhất hai vòng idle.
4. Lặp lại với nhân vật tiếp theo. Bản hiện tại có bốn ô và hai ô đã dùng. Sau khi lấp hai ô trống, giao việc mở rộng lưới cho đủ 10 nhân vật như một bước riêng để dễ kiểm tra.
