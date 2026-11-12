# Prompt tạo video idle cho 10 nhân vật Tam Quốc

Mỗi nhân vật có hai prompt tiếng Anh độc lập. Dùng trực tiếp **ảnh gốc nền trắng**, mỗi lần đính kèm đúng một ảnh và chọn một trong hai cách sau.

- **Video** — Chọn **Ingredients / Ảnh tham chiếu** trong chế độ Video, thêm ảnh gốc vào ô tham chiếu rồi dán prompt Video.
- **Agent** — Bật Tác nhân, đính kèm ảnh gốc dưới dạng **Ingredient / ảnh tham chiếu** rồi dán prompt Agent.

Ở cả hai cách, để trống **Start frame / Khung đầu**. Flow sẽ được yêu cầu tạo khung mở đầu trên nền chroma đã ghi trong prompt. Bạn dùng nguyên ảnh gốc, không cần làm thêm bản nền màu.

Thiết lập đích là **một clip 8 giây, dọc 9:16, toàn thân, lặp liền mạch**. Dùng mã màu trong từng mục để tách nền khi ghép Godot. Bóng được đặt riêng trong scene. Hai mưu sĩ đã có clip, các prompt trong file dùng khi cần tạo lại. Bản nam đang dùng trước đây dài 6 giây, còn prompt tạo lại được chuẩn hóa lên 8 giây.

| Nền chroma | Nhân vật |
|---|---|
| Xanh lá `#00FF00` | Nam và nữ mưu sĩ, nữ thương nhân, nam và nữ võ tướng |
| Hồng tím `#FF00FF` | Nam thương nhân, nam và nữ nông dân, nam và nữ thợ thủ công |

Đối chiếu dáng, tỷ lệ, độ mở tà áo và đạo cụ với ảnh gốc ngay ở giây 0. Xem lại khoảng giây 2–5 để phát hiện đổi tay, mất hoặc nhân đôi đạo cụ. Kiểm tra nền chroma giữ một màu xuyên suốt. Kiểm tra tóc, áo, ngọc, đạo cụ và cả hai đế giày. Tua chậm đoạn cuối rồi chuyển sang khung đầu để phát hiện giật hoặc chồng hình. Soi kỹ các chi tiết xanh trên những nhân vật quay với nền xanh lá.

## 01. Nam mưu sĩ

**Ảnh tham chiếu** `male_strategist(1).jpg` · **Nền** `#00FF00`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the male strategist's original face, hairstyle, embroidered navy-and-ivory robes, belt ornaments, and ivory feather fan. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

Exactly one open ivory feather fan. The reference hand keeps its fingers around the same handle throughout. The other hand stays in its reference position. Keep the fan's original feather layers, outline, handle and ornament. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He breathes gently and blinks once, with the open fan resting diagonally in front of his torso as in the reference.
2–5 seconds. The same wrist makes one small outward fan stroke. The fan stays below the chin and in front of the robe. The handle and fingers travel together, and the feather tips keep their shape.
5–8 seconds. The wrist brings the fan back to its original angle. The cuff and any existing tassel settle a little later. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nam mưu sĩ - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the male strategist's original face, hairstyle, embroidered navy-and-ivory robes, belt ornaments, and ivory feather fan. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

Exactly one open ivory feather fan. The reference hand keeps its fingers around the same handle throughout. The other hand stays in its reference position. Keep the fan's original feather layers, outline, handle and ornament. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He breathes gently and blinks once, with the open fan resting diagonally in front of his torso as in the reference.
2–5 seconds. The same wrist makes one small outward fan stroke. The fan stays below the chin and in front of the robe. The handle and fingers travel together, and the feather tips keep their shape.
5–8 seconds. The wrist brings the fan back to its original angle. The cuff and any existing tassel settle a little later. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 02. Nữ mưu sĩ

**Ảnh tham chiếu** `female_strategist(1).jpg` · **Nền** `#00FF00`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve her face, long dark hair, gold hairpin, jade earrings and waist pendant, teal robe with gold floral embroidery, ivory and pale blue sleeve layers, burgundy sash, and embroidered boots. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

Exactly one ivory paper folding fan, fully open throughout. Her right hand keeps its grip on the original pivot and her left hand rests at her side. Keep the painted blossom branch, dark ribs, paper outline and original jade ornaments. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes softly and blinks once. The open fan rests diagonally across her lower chest as in the reference.
2–5 seconds. Her right wrist makes one small outward fan stroke. Keep the same grip, and keep the fan below her chin and in front of the robe. Her cuff follows the wrist.
5–8 seconds. The fan returns to its starting angle. Existing hair tips, cuff edges and sash make a small delayed settling motion. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nữ mưu sĩ - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve her face, long dark hair, gold hairpin, jade earrings and waist pendant, teal robe with gold floral embroidery, ivory and pale blue sleeve layers, burgundy sash, and embroidered boots. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

Exactly one ivory paper folding fan, fully open throughout. Her right hand keeps its grip on the original pivot and her left hand rests at her side. Keep the painted blossom branch, dark ribs, paper outline and original jade ornaments. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes softly and blinks once. The open fan rests diagonally across her lower chest as in the reference.
2–5 seconds. Her right wrist makes one small outward fan stroke. Keep the same grip, and keep the fan below her chin and in front of the robe. Her cuff follows the wrist.
5–8 seconds. The fan returns to its starting angle. Existing hair tips, cuff edges and sash make a small delayed settling motion. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 03. Nam thương nhân

**Ảnh tham chiếu** `male_merchant.png` · **Nền** `#FF00FF`

Đính kèm ảnh gốc nền trắng làm Ingredient. Giữ nguyên tay phải cầm một cân hai đĩa và tay trái giữ sổ. Cử động chính là liếc xuống, với hai đĩa cân chỉ đung đưa nhẹ.

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image as an Ingredient and the sole visual reference for the character, outfit, props, and starting pose. Generate a new opening frame based on the reference pose, using the chroma background specified below. Do not use the attached image as the first frame or reproduce its white backdrop. Preserve the original face, hairstyle, gold hairpin, embroidered brown and gold robes, olive sash, ivory lining and boots.

Keep exactly two props visible throughout: ONE brass balance scale on SCREEN LEFT and ONE closed brown ledger on SCREEN RIGHT. His right hand (screen left) continuously holds the original scale by its top ring. That scale has one rigid crossbar and exactly two round brass pans hanging on their original chains. His left hand (screen right) continuously holds the same closed ledger upright against his torso. Keep the ledger visible and keep that arm in its starting pose. No second scale, hand swap, lifted ledger, disappearing book, or transformation. Keep the original hairstyle and accessories, with no added ribbons.

0–2 seconds. He holds the reference pose, breathes softly and blinks once. Both hands remain in place.
2–5 seconds. Only his eyes glance down at the existing balance. The two existing pans make one very small sway and settle. The hand holding the ring remains at its original height. The book and the arm holding it remain still.
5–8 seconds. He brings his gaze back forward. Both hands, both props, the pans and the overall silhouette ease into the opening pose for a seamless loop.

Use a locked full-body camera and fixed feet. Leave clear space around the hair, robe, scale and boots. Generate frame one on perfectly flat solid chroma magenta (#FF00FF) and keep the exact same color through the last frame. No white opening frame, background fade, color transition, floor, shadows, gradients, color spill, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nam thương nhân - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image as an Ingredient and the sole visual reference for the character, outfit, props, and starting pose. Generate a new opening frame based on the reference pose, using the chroma background specified below. Do not use the attached image as the first frame or reproduce its white backdrop. Preserve the original face, hairstyle, gold hairpin, embroidered brown and gold robes, olive sash, ivory lining and boots.

Keep exactly two props visible throughout: ONE brass balance scale on SCREEN LEFT and ONE closed brown ledger on SCREEN RIGHT. His right hand (screen left) continuously holds the original scale by its top ring. That scale has one rigid crossbar and exactly two round brass pans hanging on their original chains. His left hand (screen right) continuously holds the same closed ledger upright against his torso. Keep the ledger visible and keep that arm in its starting pose. No second scale, hand swap, lifted ledger, disappearing book, or transformation. Keep the original hairstyle and accessories, with no added ribbons.

0–2 seconds. He holds the reference pose, breathes softly and blinks once. Both hands remain in place.
2–5 seconds. Only his eyes glance down at the existing balance. The two existing pans make one very small sway and settle. The hand holding the ring remains at its original height. The book and the arm holding it remain still.
5–8 seconds. He brings his gaze back forward. Both hands, both props, the pans and the overall silhouette ease into the opening pose for a seamless loop.

Use a locked full-body camera and fixed feet. Leave clear space around the hair, robe, scale and boots. Generate frame one on perfectly flat solid chroma magenta (#FF00FF) and keep the exact same color through the last frame. No white opening frame, background fade, color transition, floor, shadows, gradients, color spill, text or audio.
```

## 04. Nữ thương nhân

**Ảnh tham chiếu** `female_merchant.jpg` · **Nền** `#00FF00`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, high bun, gold pin, jade earrings and waist beads, embroidered burgundy and coral robes, and the wooden abacus with gold corners. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

Exactly one wooden abacus with its original rectangular frame, gold corners, rod count and bead count. The hand beneath the frame keeps supporting it, and the upper hand stays by the same edge. Keep the frame braced at its reference angle and preserve the jade earrings and waist beads. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes gently with the abacus braced and the original hand positions held.
2–5 seconds. She glances down and uses one fingertip to slide a single reachable bead a short distance along its own rod. All other beads, the frame and the supporting hand stay in place.
5–8 seconds. The same fingertip slides that bead back and rests at the frame edge. She looks forward again with the same slight smile. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nữ thương nhân - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, high bun, gold pin, jade earrings and waist beads, embroidered burgundy and coral robes, and the wooden abacus with gold corners. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

Exactly one wooden abacus with its original rectangular frame, gold corners, rod count and bead count. The hand beneath the frame keeps supporting it, and the upper hand stays by the same edge. Keep the frame braced at its reference angle and preserve the jade earrings and waist beads. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes gently with the abacus braced and the original hand positions held.
2–5 seconds. She glances down and uses one fingertip to slide a single reachable bead a short distance along its own rod. All other beads, the frame and the supporting hand stay in place.
5–8 seconds. The same fingertip slides that bead back and rests at the frame edge. She looks forward again with the same slight smile. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 05. Nam nông dân

**Ảnh tham chiếu** `male_farmer.jpg` · **Nền** `#FF00FF`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, olive vest and headband, ivory sleeves, ochre sash, straw hat on his back, golden rice bundle, and long wooden hoe with the original metal blade. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One long wooden hoe on screen left, gripped by his right hand, and one bound rice bundle on screen right, cradled by his left arm. The straw hat remains on his back. Preserve the hoe's one metal blade, straight shaft and ground contact. Keep the stems bound and the fine leaves and grain tips visible. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He breathes gently with both feet and the base of the hoe planted.
2–5 seconds. The left forearm lifts the bound rice bundle slightly toward his chest without releasing it. The rice heads dip softly a moment later. His right hand and hoe stay planted in their original positions.
5–8 seconds. The bundle returns to its starting height. The grain tips and existing headband tails settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nam nông dân - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, olive vest and headband, ivory sleeves, ochre sash, straw hat on his back, golden rice bundle, and long wooden hoe with the original metal blade. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One long wooden hoe on screen left, gripped by his right hand, and one bound rice bundle on screen right, cradled by his left arm. The straw hat remains on his back. Preserve the hoe's one metal blade, straight shaft and ground contact. Keep the stems bound and the fine leaves and grain tips visible. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He breathes gently with both feet and the base of the hoe planted.
2–5 seconds. The left forearm lifts the bound rice bundle slightly toward his chest without releasing it. The rice heads dip softly a moment later. His right hand and hoe stay planted in their original positions.
5–8 seconds. The bundle returns to its starting height. The grain tips and existing headband tails settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 06. Nữ nông dân

**Ảnh tham chiếu** `female_farmer.jpg` · **Nền** `#FF00FF`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, green ribbon, long dark braid, straw hat, olive and ivory clothing, armful of golden rice, and the woven basket with rice and a single continuous handle. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One woven basket with one continuous handle on screen left, held by her right hand, and one rice bundle against her chest on screen right, held by her left arm. Keep the rice inside the basket separate from the chest bundle. Preserve the straw hat, braid and existing ribbon. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes gently with the basket held low and the other bundle braced against her chest.
2–5 seconds. She lifts the basket slightly once, keeping her fingers around the same handle. The basket and its contents move as one load, with a small lag at the grain tips. The left arm and chest bundle stay braced.
5–8 seconds. The basket returns to its original height. The grain tips and braid end settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nữ nông dân - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, green ribbon, long dark braid, straw hat, olive and ivory clothing, armful of golden rice, and the woven basket with rice and a single continuous handle. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One woven basket with one continuous handle on screen left, held by her right hand, and one rice bundle against her chest on screen right, held by her left arm. Keep the rice inside the basket separate from the chest bundle. Preserve the straw hat, braid and existing ribbon. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes gently with the basket held low and the other bundle braced against her chest.
2–5 seconds. She lifts the basket slightly once, keeping her fingers around the same handle. The basket and its contents move as one load, with a small lag at the grain tips. The left arm and chest bundle stay braced.
5–8 seconds. The basket returns to its original height. The grain tips and braid end settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 07. Nam thợ thủ công

**Ảnh tham chiếu** `male_craftsman.jpg` · **Nền** `#FF00FF`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, blue robes and ribbon, brown leather apron, hanging rulers, metal-headed hammer, and the original carved wooden joinery bracket held across his torso. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One metal-headed hammer low on screen left in his right hand and one carved wooden joinery bracket on screen right in his left arm. Preserve the hammer, the bracket's original shape and relief, the hanging rulers and the existing ribbon. Both items remain visible and in contact with the same hands. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He breathes softly with the hammer low and the bracket supported against his torso.
2–5 seconds. He glances at the carving and tilts the bracket a few degrees toward himself using the supporting forearm. The bracket stays rigid and braced. The hammer hand stays low and does not strike.
5–8 seconds. He returns the bracket to its original angle and looks forward. The existing hammer tassel and belt tools settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nam thợ thủ công - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, blue robes and ribbon, brown leather apron, hanging rulers, metal-headed hammer, and the original carved wooden joinery bracket held across his torso. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One metal-headed hammer low on screen left in his right hand and one carved wooden joinery bracket on screen right in his left arm. Preserve the hammer, the bracket's original shape and relief, the hanging rulers and the existing ribbon. Both items remain visible and in contact with the same hands. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He breathes softly with the hammer low and the bracket supported against his torso.
2–5 seconds. He glances at the carving and tilts the bracket a few degrees toward himself using the supporting forearm. The bracket stays rigid and braced. The hammer hand stays low and does not strike.
5–8 seconds. He returns the bracket to its original angle and looks forward. The existing hammer tassel and belt tools settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 08. Nữ thợ thủ công

**Ảnh tham chiếu** `female_craftsman.jpg` · **Nền** `#FF00FF`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, dark ponytail and teal ribbon, teal robe, brown leather apron, carpenter's square, chisel, and the closed carved wooden box with flower and bird relief, clasp and hanging tassel. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One chisel low on screen left in her right hand and one closed carved wooden box on screen right, supported by her left arm. Preserve the box's flower-and-bird relief, clasp and existing tassel. Keep the chisel separate and the box closed and visibly supported in the same grip. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes softly, holding the box against her torso and the chisel low by her side.
2–5 seconds. She raises the box slightly with the supporting forearm and glances at its carved front. The box stays closed and rigid. The chisel stays low at its reference angle.
5–8 seconds. She lowers the box to its opening position and looks forward. The original clasp tassel settles. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nữ thợ thủ công - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the face, dark ponytail and teal ribbon, teal robe, brown leather apron, carpenter's square, chisel, and the closed carved wooden box with flower and bird relief, clasp and hanging tassel. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One chisel low on screen left in her right hand and one closed carved wooden box on screen right, supported by her left arm. Preserve the box's flower-and-bird relief, clasp and existing tassel. Keep the chisel separate and the box closed and visibly supported in the same grip. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She breathes softly, holding the box against her torso and the chisel low by her side.
2–5 seconds. She raises the box slightly with the supporting forearm and glances at its carved front. The box stays closed and rigid. The chisel stays low at its reference angle.
5–8 seconds. She lowers the box to its opening position and looks forward. The original clasp tassel settles. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma magenta background (#FF00FF) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 09. Nam võ tướng

**Ảnh tham chiếu** `male_military_commander.jpg` · **Nền** `#00FF00`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the stern face, long dark hair, rigid silver lamellar armor, burgundy cape, tall straight spear, ornate metal spearhead and red tassel. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One tall straight spear on screen left, held in his right hand with the same grip. His left hand stays at his hip. Preserve the rigid silver armor, burgundy cape, single ornate spearhead and existing red tassel. Frame the full spear with clearance above its tip. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He stands firmly with the spear upright and its butt on the original ground point.
2–5 seconds. He lifts the spear straight up a short distance, then plants its butt once at the same point. The shaft stays vertical, rigid and the same length. His chin dips subtly at contact and the existing tassel responds a beat later.
5–8 seconds. The spear stays planted and his chin returns to the opening angle. The tassel, hair and cape edge settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nam võ tướng - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the stern face, long dark hair, rigid silver lamellar armor, burgundy cape, tall straight spear, ornate metal spearhead and red tassel. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One tall straight spear on screen left, held in his right hand with the same grip. His left hand stays at his hip. Preserve the rigid silver armor, burgundy cape, single ornate spearhead and existing red tassel. Frame the full spear with clearance above its tip. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. He stands firmly with the spear upright and its butt on the original ground point.
2–5 seconds. He lifts the spear straight up a short distance, then plants its butt once at the same point. The shaft stays vertical, rigid and the same length. His chin dips subtly at contact and the existing tassel responds a beat later.
5–8 seconds. The spear stays planted and his chin returns to the opening angle. The tassel, hair and cape edge settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

## 10. Nữ võ tướng

**Ảnh tham chiếu** `female_military_commander.jpg` · **Nền** `#00FF00`

### Video

```text
Generate one 8-second vertical 9:16 seamless idle animation for a 2D character-selection screen.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the stern face, long dark ponytail, jade ornaments, rigid silver armor, burgundy cape, straight silver sword, ornate guard and red hilt tassel. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One straight silver sword in her right hand on screen left. The same fingers stay on its hilt. Her left hand remains on her hip. Preserve the blade length, ornate guard, existing red hilt tassel, rigid armor and burgundy cape. Leave room on the sword side for the full blade. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She holds the original low guard, with the sword pointing down outside her leg and its tip above the ground.
2–5 seconds. She raises the sword once in a controlled outward arc into a diagonal guard beside the body, up to shoulder height as clearance allows. Hold briefly. The blade stays clear of her face, torso and frame edges. Both feet and the off-hand stay fixed.
5–8 seconds. She lowers the sword along the same path to the opening guard without touching the ground. The hilt tassel and cape edge settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

### Agent

```text
Create the finished asset now. Use the attached reference to generate exactly one 8-second vertical 9:16 seamless video named "Nữ võ tướng - Idle" for a 2D character-selection screen. Deliver the video directly in this run. Skip storyboards, still-image outputs, variations and extra clips. Use the following motion and visual requirements.

Use the attached original white-background image only as the character Ingredient. Match its exact body and head angles, full-body proportions, pose, silhouette and hand positions as closely as possible. Preserve the original semi-realistic painted Three Kingdoms game illustration style, fabric volume, layered folds, embroidery, natural shading and existing hair shape. Preserve the stern face, long dark ponytail, jade ornaments, rigid silver armor, burgundy cape, straight silver sword, ornate guard and red hilt tassel. Keep the same angle and scale through the shot, with both boots fully visible. Do not straighten or narrow the reference pose, mirror it, change the outfit, add accessories, or copy the white background.

One straight silver sword in her right hand on screen left. The same fingers stay on its hilt. Her left hand remains on her hip. Preserve the blade length, ornate guard, existing red hilt tassel, rigid armor and burgundy cape. Leave room on the sword side for the full blade. Keep the original grip, shape and count of every prop. No hand swaps, extra props, extra fingers, clipping or changes in prop identity.

0–2 seconds. She holds the original low guard, with the sword pointing down outside her leg and its tip above the ground.
2–5 seconds. She raises the sword once in a controlled outward arc into a diagonal guard beside the body, up to shoulder height as clearance allows. Hold briefly. The blade stays clear of her face, torso and frame edges. Both feet and the off-hand stay fixed.
5–8 seconds. She lowers the sword along the same path to the opening guard without touching the ground. The hilt tassel and cape edge settle. Ease into the opening pose and prop positions for a seamless loop, with no jump or frozen hold.

Use one locked, full-body shot with fixed feet and enough room for the complete movement. Keep secondary motion small and limited to the existing details listed above. Start on a flat solid chroma green background (#00FF00) and keep it constant through the last frame. No white frame, background transition, floor, shadows, gradient, colored spill, particles, text or audio.
```

