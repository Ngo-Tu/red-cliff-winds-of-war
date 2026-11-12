# Ba prompt giao việc cho Gemini trong Antigravity

## Prompt A — Đọc dự án và kiểm tra bản gốc

```text
Đọc README_BAT_DAU.md và .agents/skills/godot-character-idle/SKILL.md.
Đọc project Godot hiện tại trong tam_quoc_gui. Xác định chỗ tạo ô chọn, chỗ
phát idle, cách lưu vị trí chân và bóng, và các kiểm tra hiện có.

Kiểm tra ffmpeg, ffprobe, Python và đường dẫn Godot. Nếu có đủ công cụ,
chạy import và chế độ --verify của project. Giữ nguyên source và báo kết
quả. Tóm tắt hai nhân vật đang có, số ô trống và những gì cần để thêm một
nhân vật. Đợi tôi đưa clip mới trước khi sửa project.
```

## Prompt B — Duyệt nguồn và tách nền

Thay các trường trong ngoặc vuông bằng tên thật.

```text
Dùng hướng dẫn .agents/skills/godot-character-idle/SKILL.md.
Nhân vật [tên]. Clip [source_clips/incoming/tên_clip.mp4].
Ảnh gốc [source_art/tên_ảnh]. Chỉ dùng đúng hai đầu vào tôi chỉ định.

Dùng ffprobe lấy thông số thực tế. So sánh ảnh gốc với đầu, giữa và cuối
clip. Nếu có lỗi đổi dáng rõ rệt, mất hoặc nhân đôi đạo cụ, biến dạng tay,
cắt chân hoặc đổi nền giữa clip, ghi mốc và gửi ảnh minh họa trước khi xử
lý tiếp. Các mẫu trong qa_rejected chỉ để đối chiếu lỗi.

Nếu nguồn đạt, tách nền thành alpha theo màu thực tế của từng đoạn ổn
định. Giữ tóc, tay, ngọc, mép vải, toàn bộ giày và chi tiết mảnh trên đạo
cụ. Khử ám màu ở viền và giữ chi tiết màu thật trong nhân vật. Kiểm tra
vòng lặp, căn mốc chân giữa các frame và xử lý đoạn nối nếu cần.

Xuất ảnh hoặc video xem thử trên nền sáng và tối, có đoạn đi qua điểm
nối ít nhất hai lần. Ghi thư mục đầu ra, FPS và số frame. Dừng để tôi
duyệt trước khi sửa scene Godot.
```

## Prompt C — Tích hợp bản tách nền đã duyệt

```text
Tích hợp bản đã duyệt của [tên nhân vật] tại [đường dẫn đầu ra] vào
tam_quoc_gui. Dùng một ô chọn trống nếu còn. Nếu hết ô, xác định cách
mở rộng lưới với tên và chân dung rõ, giữ bố cục và luồng hiện có.

Tạo atlas RGBA, SpriteFrames theo FPS đã xác nhận, và chân dung từ ảnh
gốc. Căn đúng vị trí chân, đặt bóng tiếp xúc riêng phía sau sprite.
Khi bấm ô mới, chỉ phát preview của nhân vật tương ứng. Giữ hai mưu sĩ,
nút Gió & thở, nhập tên, quay lại và luồng vào sảnh Ngụy, Thục, Ngô.

Cập nhật kiểm tra hiện có để hỗ trợ nhân vật mới. Chạy import và --verify
bằng Godot đang dùng. Nếu có thể, mở giao diện thực để xem vòng lặp,
viền alpha và bóng. Báo file đã thay, đầu ra, kiểm tra đã chạy và phần
còn cần tôi xem bằng F5. Giữ nguyên clip gốc.
```
