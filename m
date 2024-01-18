Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D430D831922
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:27:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRn-0003Qa-D7; Thu, 18 Jan 2024 07:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRh-0003Ko-72
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRc-0005lH-07
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p9TuRa1z7PtEWzSZQLB3Vva6UD0LuAqQd7e6FQ+xvQ8=;
 b=I48CfGVlRGah44QsVy0hmhUa9Kh+Z81h8kpLkWfEgdFetvXN4r+sXMP/CmWms26C6yLkoK
 0k9p2SLFDejYp9JmkaLuEzsOA3vyR4/anz/Urp+k4KJ1ZIfw9J5WHkzpxirEufuB0HNJHq
 Qguj73lQz0yT6a9P4aqw4iIeIYHMUqw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-tPuL0C6WNNW3nEaCAMlOlg-1; Thu, 18 Jan 2024 07:24:24 -0500
X-MC-Unique: tPuL0C6WNNW3nEaCAMlOlg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2eace36abdso84186966b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580662; x=1706185462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p9TuRa1z7PtEWzSZQLB3Vva6UD0LuAqQd7e6FQ+xvQ8=;
 b=MLxi9uElB1WBfgVkgO0xm9U01+vT1KpkdOIcnYon65HBAt5l8nShG2UNb4wbP774kS
 9bUsE7ZEi/2pHajM5McJYjOzIDP9o144Gi5m6kAF0QLJLaEqpJgcYSW+YE+vVKeWYbWq
 yGMBodx17791qea3k68SIT8DBrJxTdM91of97pYkG/XojOjCez9awqFcHQIcBXDXXVr2
 3uMKceAOlsbuAvtdJmRIq1rlUH5I+RL7EGxrACgk/9ht0aaWTblCEkbaPIQ6WvWpggnf
 AaIjxSW70ucCRljkU/DmZipQ6K81NBpsfH0RppL3IMlgnfgkY7tTvX1LLPNyL5MG6sW0
 SF2w==
X-Gm-Message-State: AOJu0YyvqWAJ/k9m4/FvVe9geK8ztuRno9/oGU+k33zpmo23mD2IzGUG
 aDqlbjp6NuoDeSPvRNnp47ci2Jv0rNUXa9NlNGwaknGw8QCTEH6dCdL08NhEKqhKuqvibjpj11C
 z7mG34vWANEheBEAtj6KD0yPztYZJNy3xd+YCVIk64JI9KO1KMHT/gsSTJSfDqfqfqE8dWcP5AL
 PBbLLex65CJfCD0AYR3QhsA0Lg/cm0ExZLcA7s
X-Received: by 2002:a17:906:5946:b0:a27:a34e:bcd with SMTP id
 g6-20020a170906594600b00a27a34e0bcdmr222629ejr.157.1705580662097; 
 Thu, 18 Jan 2024 04:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK3tbsZ54ZcDthhusSUtdfUxmTPt9Evpg/pjG6EsCObic3jYjyscfJAjXWM3NOEE+aU7i0fQ==
X-Received: by 2002:a17:906:5946:b0:a27:a34e:bcd with SMTP id
 g6-20020a170906594600b00a27a34e0bcdmr222623ejr.157.1705580661487; 
 Thu, 18 Jan 2024 04:24:21 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 un5-20020a170907cb8500b00a2ceaf80bcbsm7470302ejc.204.2024.01.18.04.24.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/16] vga: introduce VGADisplayParams
Date: Thu, 18 Jan 2024 13:24:02 +0100
Message-ID: <20240118122416.9209-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The next patches will introduce more parameters that cause a full
refresh.  Instead of adding arguments to get_offsets and lines to
update_basic_params, do everything through a struct.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga_int.h    | 15 ++++----
 hw/display/cirrus_vga.c | 24 +++++-------
 hw/display/vga.c        | 82 +++++++++++++++++------------------------
 3 files changed, 52 insertions(+), 69 deletions(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 7cf0d11201a..6be61e04284 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -56,6 +56,12 @@ struct VGACommonState;
 typedef uint8_t (* vga_retrace_fn)(struct VGACommonState *s);
 typedef void (* vga_update_retrace_info_fn)(struct VGACommonState *s);
 
+typedef struct VGADisplayParams {
+    uint32_t line_offset;
+    uint32_t start_addr;
+    uint32_t line_compare;
+} VGADisplayParams;
+
 typedef struct VGACommonState {
     MemoryRegion *legacy_address_space;
     uint8_t *vram_ptr;
@@ -90,10 +96,7 @@ typedef struct VGACommonState {
     uint8_t palette[768];
     int32_t bank_offset;
     int (*get_bpp)(struct VGACommonState *s);
-    void (*get_offsets)(struct VGACommonState *s,
-                        uint32_t *pline_offset,
-                        uint32_t *pstart_addr,
-                        uint32_t *pline_compare);
+    void (*get_params)(struct VGACommonState *s, VGADisplayParams *params);
     void (*get_resolution)(struct VGACommonState *s,
                         int *pwidth,
                         int *pheight);
@@ -111,9 +114,7 @@ typedef struct VGACommonState {
     int graphic_mode;
     uint8_t shift_control;
     uint8_t double_scan;
-    uint32_t line_offset;
-    uint32_t line_compare;
-    uint32_t start_addr;
+    VGADisplayParams params;
     uint32_t plane_updated;
     uint32_t last_line_offset;
     uint8_t last_cw, last_ch;
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 5dd5136a0cd..e637e5a816e 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -798,9 +798,9 @@ static int cirrus_bitblt_videotovideo_copy(CirrusVGAState * s)
     if (blit_is_unsafe(s, false))
         return 0;
 
-    return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.start_addr,
-            s->cirrus_blt_srcaddr - s->vga.start_addr,
-            s->cirrus_blt_width, s->cirrus_blt_height);
+    return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.params.start_addr,
+                          s->cirrus_blt_srcaddr - s->vga.params.start_addr,
+                          s->cirrus_blt_width, s->cirrus_blt_height);
 }
 
 /***************************************
@@ -1101,30 +1101,26 @@ static void cirrus_write_bitblt(CirrusVGAState * s, unsigned reg_value)
  *
  ***************************************/
 
-static void cirrus_get_offsets(VGACommonState *s1,
-                               uint32_t *pline_offset,
-                               uint32_t *pstart_addr,
-                               uint32_t *pline_compare)
+static void cirrus_get_params(VGACommonState *s1,
+                              VGADisplayParams *params)
 {
     CirrusVGAState * s = container_of(s1, CirrusVGAState, vga);
-    uint32_t start_addr, line_offset, line_compare;
+    uint32_t line_offset;
 
     line_offset = s->vga.cr[0x13]
         | ((s->vga.cr[0x1b] & 0x10) << 4);
     line_offset <<= 3;
-    *pline_offset = line_offset;
+    params->line_offset = line_offset;
 
-    start_addr = (s->vga.cr[0x0c] << 8)
+    params->start_addr = (s->vga.cr[0x0c] << 8)
         | s->vga.cr[0x0d]
         | ((s->vga.cr[0x1b] & 0x01) << 16)
         | ((s->vga.cr[0x1b] & 0x0c) << 15)
         | ((s->vga.cr[0x1d] & 0x80) << 12);
-    *pstart_addr = start_addr;
 
-    line_compare = s->vga.cr[0x18] |
+    params->line_compare = s->vga.cr[0x18] |
         ((s->vga.cr[0x07] & 0x10) << 4) |
         ((s->vga.cr[0x09] & 0x40) << 3);
-    *pline_compare = line_compare;
 }
 
 static uint32_t cirrus_get_bpp16_depth(CirrusVGAState * s)
@@ -2925,7 +2921,7 @@ void cirrus_init_common(CirrusVGAState *s, Object *owner,
     s->linear_mmio_mask = s->real_vram_size - 256;
 
     s->vga.get_bpp = cirrus_get_bpp;
-    s->vga.get_offsets = cirrus_get_offsets;
+    s->vga.get_params = cirrus_get_params;
     s->vga.get_resolution = cirrus_get_resolution;
     s->vga.cursor_invalidate = cirrus_cursor_invalidate;
     s->vga.cursor_draw_line = cirrus_cursor_draw_line;
diff --git a/hw/display/vga.c b/hw/display/vga.c
index a8b5830a30a..fea26f91232 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1042,52 +1042,40 @@ static int update_palette256(VGACommonState *s)
     return full_update;
 }
 
-static void vga_get_offsets(VGACommonState *s,
-                            uint32_t *pline_offset,
-                            uint32_t *pstart_addr,
-                            uint32_t *pline_compare)
+static void vga_get_params(VGACommonState *s,
+                           VGADisplayParams *params)
 {
-    uint32_t start_addr, line_offset, line_compare;
-
     if (vbe_enabled(s)) {
-        line_offset = s->vbe_line_offset;
-        start_addr = s->vbe_start_addr;
-        line_compare = 65535;
+        params->line_offset = s->vbe_line_offset;
+        params->start_addr = s->vbe_start_addr;
+        params->line_compare = 65535;
     } else {
         /* compute line_offset in bytes */
-        line_offset = s->cr[VGA_CRTC_OFFSET];
-        line_offset <<= 3;
+        params->line_offset = s->cr[VGA_CRTC_OFFSET] << 3;
 
         /* starting address */
-        start_addr = s->cr[VGA_CRTC_START_LO] |
+        params->start_addr = s->cr[VGA_CRTC_START_LO] |
             (s->cr[VGA_CRTC_START_HI] << 8);
 
         /* line compare */
-        line_compare = s->cr[VGA_CRTC_LINE_COMPARE] |
+        params->line_compare = s->cr[VGA_CRTC_LINE_COMPARE] |
             ((s->cr[VGA_CRTC_OVERFLOW] & 0x10) << 4) |
             ((s->cr[VGA_CRTC_MAX_SCAN] & 0x40) << 3);
     }
-    *pline_offset = line_offset;
-    *pstart_addr = start_addr;
-    *pline_compare = line_compare;
 }
 
 /* update start_addr and line_offset. Return TRUE if modified */
 static int update_basic_params(VGACommonState *s)
 {
     int full_update;
-    uint32_t start_addr, line_offset, line_compare;
+    VGADisplayParams current;
 
     full_update = 0;
 
-    s->get_offsets(s, &line_offset, &start_addr, &line_compare);
+    s->get_params(s, &current);
 
-    if (line_offset != s->line_offset ||
-        start_addr != s->start_addr ||
-        line_compare != s->line_compare) {
-        s->line_offset = line_offset;
-        s->start_addr = start_addr;
-        s->line_compare = line_compare;
+    if (memcmp(&current, &s->params, sizeof(current))) {
+        s->params = current;
         full_update = 1;
     }
     return full_update;
@@ -1188,7 +1176,7 @@ static void vga_draw_text(VGACommonState *s, int full_update)
     }
     full_update |= update_basic_params(s);
 
-    line_offset = s->line_offset;
+    line_offset = s->params.line_offset;
 
     vga_get_text_resolution(s, &width, &height, &cw, &cheight);
     if ((height * width) <= 1) {
@@ -1227,7 +1215,7 @@ static void vga_draw_text(VGACommonState *s, int full_update)
     }
 
     cursor_offset = ((s->cr[VGA_CRTC_CURSOR_HI] << 8) |
-                     s->cr[VGA_CRTC_CURSOR_LO]) - s->start_addr;
+                     s->cr[VGA_CRTC_CURSOR_LO]) - s->params.start_addr;
     if (cursor_offset != s->cursor_offset ||
         s->cr[VGA_CRTC_CURSOR_START] != s->cursor_start ||
         s->cr[VGA_CRTC_CURSOR_END] != s->cursor_end) {
@@ -1241,7 +1229,7 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         s->cursor_start = s->cr[VGA_CRTC_CURSOR_START];
         s->cursor_end = s->cr[VGA_CRTC_CURSOR_END];
     }
-    cursor_ptr = s->vram_ptr + (s->start_addr + cursor_offset) * 4;
+    cursor_ptr = s->vram_ptr + (s->params.start_addr + cursor_offset) * 4;
     if (now >= s->cursor_blink_time) {
         s->cursor_blink_time = now + VGA_TEXT_CURSOR_PERIOD_MS / 2;
         s->cursor_visible_phase = !s->cursor_visible_phase;
@@ -1251,7 +1239,7 @@ static void vga_draw_text(VGACommonState *s, int full_update)
     linesize = surface_stride(surface);
     ch_attr_ptr = s->last_ch_attr;
     line = 0;
-    offset = s->start_addr * 4;
+    offset = s->params.start_addr * 4;
     for(cy = 0; cy < height; cy++) {
         d1 = dest;
         src = s->vram_ptr + offset;
@@ -1331,7 +1319,7 @@ static void vga_draw_text(VGACommonState *s, int full_update)
         dest += linesize * cheight;
         line1 = line + cheight;
         offset += line_offset;
-        if (line < s->line_compare && line1 >= s->line_compare) {
+        if (line < s->params.line_compare && line1 >= s->params.line_compare) {
             offset = 0;
         }
         line = line1;
@@ -1461,10 +1449,10 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     disp_width = width;
     depth = s->get_bpp(s);
 
-    region_start = (s->start_addr * 4);
-    region_end = region_start + (ram_addr_t)s->line_offset * height;
+    region_start = (s->params.start_addr * 4);
+    region_end = region_start + (ram_addr_t)s->params.line_offset * height;
     region_end += width * depth / 8; /* scanline length */
-    region_end -= s->line_offset;
+    region_end -= s->params.line_offset;
     if (region_end > s->vbe_size || depth == 0 || depth == 15) {
         /*
          * We land here on:
@@ -1529,7 +1517,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         share_surface = false;
     }
 
-    if (s->line_offset != s->last_line_offset ||
+    if (s->params.line_offset != s->last_line_offset ||
         disp_width != s->last_width ||
         height != s->last_height ||
         s->last_depth != depth ||
@@ -1540,12 +1528,12 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         s->last_scr_height = height;
         s->last_width = disp_width;
         s->last_height = height;
-        s->last_line_offset = s->line_offset;
+        s->last_line_offset = s->params.line_offset;
         s->last_depth = depth;
         s->last_byteswap = byteswap;
         full_update = 1;
     }
-    if (surface_data(surface) != s->vram_ptr + (s->start_addr * 4)
+    if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
         && is_buffer_shared(surface)) {
         /* base address changed (page flip) -> shared display surfaces
          * must be updated with the new base address */
@@ -1555,8 +1543,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     if (full_update) {
         if (share_surface) {
             surface = qemu_create_displaysurface_from(disp_width,
-                    height, format, s->line_offset,
-                    s->vram_ptr + (s->start_addr * 4));
+                    height, format, s->params.line_offset,
+                    s->vram_ptr + (s->params.start_addr * 4));
             dpy_gfx_replace_surface(s->con, surface);
         } else {
             qemu_console_resize(s->con, disp_width, height);
@@ -1620,9 +1608,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
 #if 0
     printf("w=%d h=%d v=%d line_offset=%d cr[0x09]=0x%02x cr[0x17]=0x%02x linecmp=%d sr[0x01]=0x%02x\n",
            width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
-           s->line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
+           s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
-    addr1 = (s->start_addr * 4);
+    addr1 = (s->params.start_addr * 4);
     bwidth = DIV_ROUND_UP(width * bits, 8);
     y_start = -1;
     d = surface_data(surface);
@@ -1630,7 +1618,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     y1 = 0;
 
     if (!full_update) {
-        if (s->line_compare < height) {
+        if (s->params.line_compare < height) {
             /* split screen mode */
             region_start = 0;
         }
@@ -1686,14 +1674,14 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         if (!multi_run) {
             mask = (s->cr[VGA_CRTC_MODE] & 3) ^ 3;
             if ((y1 & mask) == mask)
-                addr1 += s->line_offset;
+                addr1 += s->params.line_offset;
             y1++;
             multi_run = multi_scan;
         } else {
             multi_run--;
         }
         /* line compare acts on the displayed lines */
-        if (y == s->line_compare)
+        if (y == s->params.line_compare)
             addr1 = 0;
         d += linesize;
     }
@@ -1810,9 +1798,7 @@ void vga_common_reset(VGACommonState *s)
     s->graphic_mode = -1; /* force full update */
     s->shift_control = 0;
     s->double_scan = 0;
-    s->line_offset = 0;
-    s->line_compare = 0;
-    s->start_addr = 0;
+    memset(&s->params, '\0', sizeof(s->params));
     s->plane_updated = 0;
     s->last_cw = 0;
     s->last_ch = 0;
@@ -1934,7 +1920,7 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
 
         /* Update "hardware" cursor */
         cursor_offset = ((s->cr[VGA_CRTC_CURSOR_HI] << 8) |
-                         s->cr[VGA_CRTC_CURSOR_LO]) - s->start_addr;
+                         s->cr[VGA_CRTC_CURSOR_LO]) - s->params.start_addr;
         if (cursor_offset != s->cursor_offset ||
             s->cr[VGA_CRTC_CURSOR_START] != s->cursor_start ||
             s->cr[VGA_CRTC_CURSOR_END] != s->cursor_end || full_update) {
@@ -1950,7 +1936,7 @@ static void vga_update_text(void *opaque, console_ch_t *chardata)
             s->cursor_end = s->cr[VGA_CRTC_CURSOR_END];
         }
 
-        src = (uint32_t *) s->vram_ptr + s->start_addr;
+        src = (uint32_t *) s->vram_ptr + s->params.start_addr;
         dst = chardata;
 
         if (full_update) {
@@ -2195,7 +2181,7 @@ bool vga_common_init(VGACommonState *s, Object *obj, Error **errp)
     xen_register_framebuffer(&s->vram);
     s->vram_ptr = memory_region_get_ram_ptr(&s->vram);
     s->get_bpp = vga_get_bpp;
-    s->get_offsets = vga_get_offsets;
+    s->get_params = vga_get_params;
     s->get_resolution = vga_get_resolution;
     s->hw_ops = &vga_ops;
     switch (vga_retrace_method) {
-- 
2.43.0


