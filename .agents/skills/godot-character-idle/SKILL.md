---
name: godot-character-idle
description: Tách nền clip idle nhân vật từ Google Flow hoặc video tương tự, giữ tóc và đạo cụ, sửa điểm nối vòng lặp, làm atlas RGBA và tích hợp vào màn chọn nhân vật Godot 4. Dùng khi thêm hoặc thay animation, chân dung, bóng tiếp xúc hay sửa viền màu, dáng đứng và điểm nối trong dự án Tam Quốc hoặc UI game tương tự.
---

# Tách clip idle và tích hợp vào Godot

## 1. Xác định đúng đầu vào

- Lấy bản project mới nhất và xác định scene mở đầu, scene chọn nhân vật, dữ liệu ô chọn, nơi phát preview, cơ chế chuyển scene và lệnh kiểm tra. Tìm bằng `rg`. Giữ cấu trúc và tài nguyên đã được duyệt. Dùng mã đang chạy làm chuẩn khi cấu trúc dự án khác hướng dẫn.
- Nhận diện từng clip theo ảnh tham chiếu và đạo cụ. Nam mưu sĩ dùng quạt lông trắng. Nữ mưu sĩ dùng quạt giấy màu ngà, nan gỗ và họa tiết cành hoa. Khi thêm nhân vật, chỉ gán đúng clip và chân dung đã được cung cấp hoặc xác nhận.
- Dùng `ffprobe -v error -select_streams v:0 -show_streams -show_format input.mp4` để lấy kích thước, thời lượng, tốc độ khung, số khung nếu có, pixel format và dấu hiệu alpha. Nếu cần đếm thực tế, dùng thêm `-count_frames`. Kiểm tra ảnh đầu, giữa, cuối, lúc đạo cụ đi xa nhất và mép hình gần khung. Dùng `ffmpeg` trích video với `-an`. Clip 24 fps, 8 giây thường có 192 khung. Giữ thời lượng thật, hoặc nêu rõ nếu đổi. Với VFR, đọc timestamp và chọn CFR có chủ đích hoặc lưu thời lượng khung tương ứng.
- Dùng ảnh thật để xác nhận màu nền thực tế. Chroma trong clip có thể lệch mã hex của prompt. Xác nhận alpha bằng dữ liệu của khung giải mã. Một phông xanh phẳng cần được chuyển thành alpha. Alpha thật đã có thì giữ và chỉ sửa các vùng lỗi có bằng chứng.

## 2. Tách nền và bảo vệ chi tiết

- Dùng FFmpeg để giải mã, Python/Pillow/NumPy và SciPy hoặc công cụ compositing tương đương để xử lý. Chọn một vùng nền sạch ở các góc, lấy màu đại diện bằng trung vị qua khung. Kiểm tra vùng mẫu ở nhiều thời điểm, tránh phụ kiện và tóc.
- Với chroma xanh lá, đo ưu thế kênh G so với R/B. Với chroma hồng tím, đo khoảng cách sắc độ đến nền hoặc ưu thế đồng thời của R và B so với G. Dùng hai ngưỡng để có lõi đục và biên alpha mềm. Ưu tiên vùng chủ thể nối với thân và theo dõi các phần hợp lệ bị rời ở một số khung. Giữ khe tóc, quai giỏ và xích cân trong suốt khi chúng thực sự hở.
- Chroma xanh hợp với hai võ tướng áo đỏ và nữ thương nhân. Bảo vệ ngọc xanh bằng mặt nạ giữ vùng, đặc biệt khuyên tai, mặt ngọc và tua. Chroma hồng tím hợp với nông dân, thợ thủ công và nam thương nhân theo màu trang phục hiện tại. Giới hạn khử ám màu ở rìa và giữ sắc vải, da, kim loại, đá quý trong lõi.
- Với nền trắng, lấy độ sáng và độ bão hòa kết hợp với mặt nạ không gian. Tránh hạ alpha toàn ảnh theo độ sáng. Khôi phục vùng quạt sáng, vải kem hoặc mũi kiếm bằng mặt nạ cục bộ có theo dõi, giữ khe nền thật. Lỗi nam mưu sĩ từng xuất hiện vì lông quạt sáng sát cổ áo bị nhận nhầm là nền khi quạt giơ cao. Đối chiếu khung gốc để phân biệt lỗi tách nền với lỗi đã có trong clip.
- Khi cần khử màu nền trộn vào viền, làm trên biên alpha và chặn giá trị màu ngoài dải. Dùng alpha nhân trước khi nội suy ảnh trong suốt, rồi chuyển về dạng alpha thẳng khi ghi ảnh nếu dùng pha trộn mặc định của dự án. Xem thử trên sảnh và trên nền tương phản để phát hiện viền hồng, xanh hoặc trắng.
- Soi tóc mảnh, hoa văn sáng, lưỡi kiếm, mũi thương, quai giỏ, xích cân và từng bàn chân. Kiểm tra cả khung chớp mắt và đoạn chuyển nhanh. Nếu clip gốc biến dạng mặt, đổi số ngón hoặc làm cong vũ khí, ghi rõ và xử lý ở nguồn hoặc thay đúng đoạn lỗi khi khả thi.

## 3. Nối vòng lặp

- So khoảng một giây cuối với một giây đầu. So dáng, vị trí tay, góc đạo cụ, mép tóc/vải, chân và hướng vận tốc. Xem lặp ở tốc độ thật và xem chậm. Với clip 192 khung, kiểm tra cả chuỗi đi qua 190 → 191 → 0 → 1.
- Nếu hai dáng và chiều chuyển động đã gần nhau, tìm điểm cắt ở đoạn đang lắng. Nếu chênh rõ, chọn một dáng cuối ổn định rồi nội suy theo chuyển động có căn chỉnh hình, dùng easing và giữ điểm tựa. Đánh giá lại bằng ảnh so sánh và playback. Crossfade toàn nhân vật trong vài khung khi hai dáng còn xa dễ tạo quạt kép, tay kép và cảm giác giật. Tránh ping-pong nếu nó đảo hành động có hướng như dằn thương hoặc gẩy bàn tính.
- Mẫu nữ mưu sĩ đã sửa giữ 192 khung ở 24 fps. Giữ khung 0–171 và dùng khung 172–191 để trở về dáng 0. Căn chỉnh hai đầu bằng trường chuyển động hai chiều và nội suy trên alpha nhân trước. Đây là điểm cắt của clip mẫu, chọn lại dựa trên chuyển động của clip mới. Giữ khung đầu đúng một lần mỗi vòng.

## 4. Tạo atlas và ghép vào scene

- Xuất từng khung cùng kích thước RGBA và cùng mốc đặt chân. Nếu cắt khung theo vùng nhân vật, dùng một khung cắt chung đủ chứa tư thế rộng nhất, hoặc bù offset để chân không trượt. Cắt chân dung từ ảnh đã duyệt hoặc một khung rõ mặt, tránh lúc chớp mắt và tránh cắt phụ kiện quan trọng.
- Dùng atlas WebP/PNG có alpha và tài nguyên `SpriteFrames` gồm các `AtlasTexture`. Có thể theo quy cách cũ 432 × 768 mỗi khung, 5 × 5 khung mỗi trang, 2160 × 3840 mỗi trang. Kiểm tra giới hạn texture và bộ nhớ trên thiết bị mục tiêu trước khi chọn. Bật `filter_clip` và thêm đệm nếu gặp lỗi lem mép. Đọc thử từng atlas trước khi chép vào project, kiểm tra chiều, alpha, số trang và số khung. Ghi file tạm, kiểm tra giải mã thành công, rồi thay bản đích.
- Ví dụ cấu trúc đã dùng trong Tam Quốc là `assets/flow_idle/` cho nam mưu sĩ, `assets/female_flow_idle/` cho nữ mưu sĩ, `scripts/main.gd` xử lý màn tạo nhân vật và `scripts/strategist_contact_shadow.gdshader` vẽ bóng. Khi thêm clip mới, dùng mã định danh ổn định và ánh xạ cùng một ID tới chân dung, sprite, vị trí và cấu hình bóng. Tái sử dụng logic đang có.
- Khi mới vào màn chọn, để vùng xem trước trống nếu dự án đang theo quy ước bấm mới hiện. Khi chọn, hiển thị đúng một sprite và bóng tương ứng. Tắt phát ở sprite ẩn, khi rời màn hoặc khi người dùng tắt chuyển động. Bấm sang ô khác thì đổi ngay, giữ hành vi nút quay lại và nhập tên. Với nhiều atlas nặng, cân nhắc tải theo nhân vật được chọn để tránh dồn toàn bộ vào bộ nhớ.
- Đặt bóng mềm phía sau sprite và sát mặt sàn. Dùng hai điểm bóng nhỏ sát đế và một vùng bóng đổ nhạt, lệch theo ánh sáng của sảnh. Trong sảnh Tam Quốc có ánh sáng từ cửa bên trái, thử lệch bóng sang phải. Cán cuốc và đuôi thương được thêm bóng tiếp xúc khi thực sự chạm sàn. Khi dằn thương, chỉ tăng bóng tiếp xúc lúc chạm. Mũi kiếm trên không chỉ có bóng đổ. Chỉnh riêng theo từng dáng đứng và từng sảnh. Giữ độ tương phản vừa đủ để chân có trọng lượng.

## 5. Kiểm tra và bàn giao

- Mở project bằng đúng phiên bản Godot của dự án. Có thể chạy `godot --headless --path PATH --editor --import`, sau đó chạy lệnh kiểm tra hiện có, ví dụ `godot --headless --path PATH -- --verify` nếu dự án định nghĩa tùy chọn đó. Kiểm tra nhật ký lỗi import và resource bị thiếu. Khi WebP hợp lệ nhưng cache import hỏng, làm mới dữ liệu import liên quan và kiểm tra lại.
- Xem trên scene thật. Bấm lần lượt hai ô hoặc các ô mới, đổi qua lại, bật/tắt chuyển động, quay về màn trước và kiểm tra luồng chọn phe. Chạy qua ít nhất hai vòng ở tốc độ thật. Đối chiếu đoạn nối theo từng khung nếu có giật. Kiểm tra các vùng tóc, đạo cụ và bóng trên ảnh hoặc clip từ màn chọn. Bài test headless xác nhận luồng và chỉ số khung. Chất lượng hình ảnh cần xem trực tiếp.
- Khi được yêu cầu đóng gói, giữ đủ `project.godot`, scene, script và asset; bỏ cache `.godot/`. Kiểm tra archive và bảo toàn file hiện hữu. Giao bản đã kiểm tra và báo rõ thay đổi về thời lượng, các đoạn nội suy hoặc phần hình ảnh chưa xác minh.
