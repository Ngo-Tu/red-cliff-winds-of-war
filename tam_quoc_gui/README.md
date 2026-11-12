# Tam Quốc — GUI Godot tích hợp ba phe

## Chạy thử

1. Giải nén và mở `tam_quoc_gui/project.godot` bằng Godot 4 Standard. Bản này đã được kiểm tra trên Godot 4.5.1.
2. Nhấn F5. Chơi ngay → chọn Mưu sĩ và nhập tên → Tiếp tục → chọn Ngụy, Thục hoặc Ngô → Xác nhận.
3. Mỗi phe mở sảnh và hiệu ứng tương ứng. Bấm **Chọn phe** hoặc Esc để quay lại. Ở sảnh Ngụy, nút **Công trình** mở trang riêng.
4. Bấm ô Mưu sĩ nam hoặc Mưu sĩ nữ để xem animation tương ứng (6 giây hoặc 8 giây). Lần đầu vào màn, vùng xem trước để trống. Nút **Gió & thở** dừng và phát tiếp chuyển động. Hai ô hình tượng còn lại đang để trống.
5. F11 bật hoặc tắt toàn màn hình. Đăng nhập Google và Khách vẫn là lựa chọn trong GUI demo, chưa có xác thực tài khoản. Các nút gameplay giữ phạm vi của sảnh nguồn.

`godot --headless --path . -- --verify` kiểm tra luồng, animation, cả ba sảnh và trang Công trình Ngụy.

## Lịch sử các phiên bản trước khi tích hợp

## v9: GUI sảnh được dựng lại bằng thành phần riêng

Không còn dùng ảnh chụp sảnh cắt thành các cụm nút hoặc lọc sáng để lấy chữ. Đã xóa `lobby_atlas.png` và thư mục `lobby_parts/` khỏi project.

- 12 icon độc lập dạng PNG RGBA, nền trong suốt, có khoảng đệm, không chứa chữ hoặc khung. Các icon được tạo thành bộ asset riêng, không lấy từ ảnh chụp màn hình.
- Khung, mặt nút, cạnh vát, viền bạc, hoa văn góc được vẽ bằng hình học Godot; bề mặt dùng texture đá xanh riêng. Có hover, focus, nhấn lún và trạng thái chọn phát sáng.
- Mỗi widget có Control riêng. Nhãn, tên người chơi, cấp, số dư, danh hiệu, bạn bè và chat dùng Label + Trirong thật. Có thể thay nội dung và chỉnh kích thước mà không cắt ảnh.
- Chữ cọ Xuất chinh là asset RGBA riêng, không kèm nền hay nút. Mẫu C là mẫu chữ vẽ, không phải font cài đặt.
- Chân dung dùng ảnh nhân vật alpha riêng và shader giới hạn hình tròn; khung hồ sơ độc lập.
- Nhân vật toàn thân, nền sân và GUI tách lớp. Nền vẫn là tranh 2D, chưa phải mô hình 3D.

## Hiệu ứng

- Sảnh: nhân vật thở/áo lay, 32 lá rụng xoay theo gió, vệt gió nhẹ, tán cây lay. Lá nằm trên nền và dưới GUI.
- Năm cờ treo và ba cờ ngang có vùng shader riêng; phần treo/cán neo cố định, phần tự do dao động. Không có chữ trên cờ.
- Đăng nhập: khói hương tỏa, mây trôi thành lớp riêng, rèm lay.
- Tạo nhân vật: thở và áo lay, lồng đèn đung đưa, lá rơi. Hai ô chân dung mưu sĩ đặt cạnh nhau.
- Chọn phe: ba chất liệu, tranh thành trì riêng, viền sáng/hạt sáng khi chọn.

## Thành phần lập trình

| File | Nội dung |
|---|---|
| `scripts/main.gd` | Luồng bốn màn, giữ tên, co giãn 1600×900, kiểm tra và quay clip |
| `scripts/lobby_screen.gd` | Lắp các widget độc lập của sảnh, dữ liệu demo, menu và popup |
| `scripts/wei_panel.gd` | Khung đá xanh–bạc, hoa văn, viền, bóng và ánh sáng bằng hình học |
| `scripts/wei_button.gd` | Nút thật với hover/focus/nhấn/chọn, lớp nội dung riêng |
| `scripts/circle_portrait.gdshader` | Chân dung tròn từ nhân vật alpha |
| `assets/lobby/icons/*.png` | 12 icon nguyên vẹn, nền trong suốt |
| `assets/lobby/deploy_word.png` | Chữ cọ Xuất chinh riêng |
| `assets/lobby/navy_slate.png` | Texture vật liệu đá xanh |
| `scripts/lobby_wind.gd` | Lá rơi và gió |
| `scripts/lobby_background.gdshader` | Cờ và tán cây |
| `scripts/faction_screen.gd` | Chọn phe |
| `scripts/character.gdshader` | Nhịp thở và áo lay |

## Phạm vi

Đây là prototype GUI 2D. Google/Khách chỉ đổi trạng thái lựa chọn; chưa xác thực, tạo hoặc lưu tài khoản. Tên và phe giữ trong phiên chạy, chưa lưu ra đĩa.

Chỉ dựng sảnh Ngụy. Xác nhận Thục/Ngô hiện thông báo sảnh chưa có mẫu. Menu, bạn bè, cài đặt và nút cộng mở popup demo. Đấu thường/Xếp hạng đổi lựa chọn; Xuất chinh mở popup đúng chế độ, chưa kết nối tìm trận hoặc gameplay. Số dư, cấp, danh hiệu và bạn bè là dữ liệu minh họa.

## Kiểm tra

`godot --headless --path . -- --verify`: kiểm tra input chuột, bốn màn, giữ tên, chọn chế độ, popup, quay lại.

`godot --path . -- --lobby-tour`: kiểm tra chuyển động/tạm dừng và chụp hai thời điểm sảnh. Clip giao kèm quay trực tiếp từ Godot.


## v10 — Đối chiếu lại ảnh base

Giữ nguyên 12 file icon đã duyệt của v9. Chỉnh hình dạng và tỷ lệ nút, không đổi bộ icon.

- Nhiệm vụ/Thư/Sự kiện: khung hình thoi, cánh bạc hai bên, caption dưới riêng và chấm báo đỏ.
- Thanh menu dưới: một khung đá–bạc liền, năm vùng bấm trong suốt, ngăn bằng đường mảnh; icon và nhãn lớn hơn.
- Hồ sơ: khung tên dạng vát, rank và badge cấp riêng, không thêm nút Chọn phe dưới hồ sơ; bấm chân dung hoặc Esc để quay lại.
- Bạn bè: một bảng chung có đường phân cách, ba chân dung riêng; không đóng mỗi hàng thành nút vuông.
- Xuất chinh: kiểu khung riêng, góc vát rộng, cánh bạc hai bên, ánh sáng xanh và chữ cọ riêng.
- Hệ tọa độ UI 1672×941 theo ảnh base, co về canvas 1600×900. Các thành phần vẫn là Control độc lập, khung được vẽ bằng hình học, chữ và icon riêng; không cắt GUI từ screenshot.
- Bản này bám bố cục và hình dạng của base; texture và chữ vẽ được tái tạo nên không phải bản trùng từng pixel.


## v11 — Chất liệu và họa tiết bạc theo base

Giữ nguyên bố cục, chữ, nhân vật, 12 icon và ba chân dung của v10. Chỉ chỉnh texture nền đá và phần dựng khung/hoa văn.

Đối chiếu các vùng bề mặt: v10 gần đen (RGB trung vị khoảng 12,27,37), trong khi base là xanh đá khoảng 27,46,63. Bản mới thay texture đá loang hạt bằng đá phiến xanh có lớp vân mịn, bỏ lớp phủ đen 45% và cân chỉnh tint riêng cho nút Xuất chinh.

Họa tiết được dựng bằng các polygon riêng: dải gấp góc ngoài + hai lá trong có khe tối. Góc thanh menu gồm ba miếng bạc theo hình dạng trong base. Bạc có gradient hướng sáng, bóng cạnh và mép sáng mảnh; không còn các mảng xám phẳng viền trắng lớn. Khung có các lớp mép ngoài, mặt vát bạc, rãnh tối và nẹp trong.

Các file thay đổi: `scripts/wei_panel.gd`, `assets/lobby/navy_slate.png` và tint bề mặt bảng bạn bè trong `scripts/lobby_screen.gd`. Không lấy texture hoặc viền bằng cách cắt GUI trong screenshot. Ảnh so sánh chỉ dùng crop cho mục đích đối chiếu, không dùng làm asset trong game.


## v12 — Sáng, hover, được chọn, lá và con trỏ

- Ánh sáng Xuất chinh có tâm xanh trắng sáng, quầng xanh mềm và độ sáng giảm dần về hai đầu. Hover lên mềm trong khoảng 0,2 giây, mặt đá có vệt phản sáng nhẹ; nhấn lún và có gợn sáng ngắn. Không hiện tooltip lặp lại tên nút.
- Menu dưới, nhóm nút trái và chế độ đấu có trạng thái chọn riêng, loại trừ trong từng nhóm. Giữ viền/chân sáng và dấu hình thoi sau khi con trỏ rời nút, không dùng hover giả làm selected. Các popup vẫn là demo.
- Họa tiết hồ sơ nhỏ lại và hạ xuống sát mép dưới; ba miếng bạc có tọa độ riêng theo base. Viền tên/danh hiệu mảnh hơn, bớt các lớp đường song song dày.
- Chỉ 7 lá, tốc độ tổng khoảng 21–27 pixel thiết kế/giây. Góc rơi trung bình 30° so với phương thẳng đứng, chéo xuống phải; chỉ rung nhẹ quanh quỹ đạo. Phím M tạm dừng môi trường, tương tác GUI vẫn phản hồi.
- Con trỏ bạc–xanh SVG riêng, đầu mũi là điểm bấm chính xác; các hình thường/hover/nhấn và con trỏ nhập văn bản. Lớp con trỏ không nhận input, hiện trong clip Godot; khôi phục con trỏ hệ thống khi mất focus hoặc thoát.
- `wei_button.gd`: các hệ số fade hover/press/selection và vệt phản sáng. `wei_panel.gd`: ánh sáng và họa tiết. `lobby_wind.gd`: lá. `gui_pointer.gd`, `assets/cursor/`: con trỏ.

Đã kiểm tra input bốn màn, lựa chọn menu/chế độ, giữ selected sau mouse-out, mật độ/góc/tốc độ lá, chuyển động và tạm dừng. Clip v12 trình diễn các trạng thái bằng input chuột trong Godot.


## v13 — Con trỏ dùng chung, cảm giác 3D

Chỉ thay bộ con trỏ và hiệu ứng của con trỏ; GUI, icon, nhân vật, nền và các hiệu ứng khác giữ nguyên v12.

- Con trỏ chung cho mọi màn và mọi phe, không đổi theo Ngụy/Thục/Ngô. Mặt ngà nổi, cạnh vát đồng champagne tiết chế và mặt bên xám than tạo cảm giác khối 3D. Không có màu hay biểu tượng phe.
- Đây là sprite RGBA có hình khối 3D được vẽ sẵn, không phải model 3D thời gian thực.
- Một ảnh gốc dùng cho thường/hover/nhấn; shader chỉ đổi ánh sáng và độ tối, không đổi silhouette hoặc vị trí đầu mũi.
- Metadata `assets/cursor/common_arrow_3d.json` lưu điểm bấm chuẩn hóa. Cỡ hiển thị 40×40, ảnh 256×256 có khoảng đệm trong suốt.
- Con trỏ nhập tên cũng đổi sang ngà–đồng trung tính; vòng phản hồi click dùng màu đồng nhạt, bỏ màu xanh phe Ngụy.
- File mới: `common_arrow_3d.png`, `common_arrow_3d.json`, `common_text.svg`, `scripts/cursor_surface.gdshader`. `gui_pointer.gd` dùng chung toàn bộ, không đọc biến phe. Bộ SVG con trỏ Wei cũ đã bỏ.


## v14
Nút quay lại trung tính được vẽ riêng, viền đồng mảnh và mũi tên rõ. Cụm Mời bạn căn giữa theo kích thước chữ Trirong thực. Con trỏ chung tăng từ 40 lên 56 px, giữ đúng điểm bấm.

## v15
Khôi phục nguyên khung Back trước v14, chỉ thay icon quay lại bằng mũi tên ngà vát sáng. Nút Mời bạn có nền đá xanh và viền bạc riêng, giữ căn giữa. Con trỏ vẫn 56 px.

## v16
Sảnh Ngụy: 20 lá, phát so le cách 2.2–2.8 giây, chu kỳ 50 giây, hướng rơi 30 độ và chuyển động chậm. Bỏ huy hiệu Đô Úy, căn giữa chữ; cách hai nút chế độ 14 px. Base Ngô đang ở bước duyệt hình, chưa tích hợp sảnh Ngô.
