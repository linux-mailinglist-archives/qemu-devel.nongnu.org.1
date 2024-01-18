Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6091B83191A
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:26:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRSI-0004rp-Pz; Thu, 18 Jan 2024 07:25:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRSB-0004nF-5W
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRS7-0006UI-Vg
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lHKtWY2aIb/G0jxcyX7kG5jqfnNfNv6gtD29X1mXs9k=;
 b=IX8PrzDf121Ebus5dfBeiwftlR1cD+h944a0RB4c5vTvYNsagxAKMzZLOGB3umxn1JvWS1
 UxTVdxTwToxTaZXtzbJcSugE37EmuZ7zX7XAgIygWBomN9M2uqWApS1HDSlPFPjHbTFTw6
 DOMSpBNf4iFq4V99qN+IsZg/B51O9us=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653--9yV4l_7NM21vmqjRPQRrA-1; Thu, 18 Jan 2024 07:24:29 -0500
X-MC-Unique: -9yV4l_7NM21vmqjRPQRrA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2ea2b5e8b9so103512666b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580666; x=1706185466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHKtWY2aIb/G0jxcyX7kG5jqfnNfNv6gtD29X1mXs9k=;
 b=j6WNwWVMs54G8nnlxteiSfxFcRuoaPoreAqbUY+2DpFFRzIpFPJIF8sBd86/flz+Rc
 9NLVIDqf3movJo/cp2DJZYK3bUmckOUtWy9aDyatimnFwDiH4xeXBGg0bc3q3Zyvc9Oz
 JbtCK8S/XC+U8xeUQ/9UU7AJQr4t1N59WZBIQsNOmzURwJj5r8jY3/B3rbv7cMJe7AWd
 isHdKYlXsE5+3HYLYt2AGwCAaWBv8nv5CornWZ6eBS8RF29h/sViAns+fR2KNwE2dtr8
 VqvokI4/L3FBgaHuD4IIjzKXz4JxcEFL/nMJ/XMzunb70Jh8Kfr4SNrmqTNU6ZHlFSug
 fhgA==
X-Gm-Message-State: AOJu0YxriB8kB5v+R4Di1rV/anmLdVtIGO/NnYT2/NJGbmJCYP7+DMd+
 e3UNAUlF7+LWmQVQkiaJRjAUQjR1gpD7z3xVLylJdPbDjdOCrS+9qRYc94dtecGWtLcrth885wl
 ziUatGlre6zuq3C3Ap5qwT3xO1cH2pbCqm9AHlIukcRHBXyvPDbG4iDguis6zYFGHYUHFmBFENv
 UdA7lUZDuZysF3Nh9M/S02yVa6OpPpGMBE1vmo
X-Received: by 2002:a17:906:29cd:b0:a2b:9a38:dcf5 with SMTP id
 y13-20020a17090629cd00b00a2b9a38dcf5mr405455eje.62.1705580665598; 
 Thu, 18 Jan 2024 04:24:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGInhRhFddKeLEFZdB6+/clF5/z/sBBwWBCc9kpX7dJqnAoj7IglpcYy4CBMx63CEzCmWEiRg==
X-Received: by 2002:a17:906:29cd:b0:a2b:9a38:dcf5 with SMTP id
 y13-20020a17090629cd00b00a2b9a38dcf5mr405447eje.62.1705580664981; 
 Thu, 18 Jan 2024 04:24:24 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170906c00400b00a298adde5a1sm9025147ejz.189.2024.01.18.04.24.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] vga: implement horizontal pel panning in graphics modes
Date: Thu, 18 Jan 2024 13:24:04 +0100
Message-ID: <20240118122416.9209-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This implements smooth scrolling, as used for example by Commander Keen
and Second Reality.

Unfortunately, this is not enough to avoid tearing in Commander Keen,
because sometimes the wrong start address is used for a frame.
On real EGA, the panning register is sampled on every line, while
the display start is latched for the next frame at the start of the
vertical retrace.  On real VGA, the panning register is also latched,
but at the end of the vertical retrace.  It looks like Keen exploits
this by only waiting for horizontal retrace when setting the display
start, but implementing it breaks the 256-color Keen games...

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga-helpers.h | 100 ++++++++++++++++++++++++++++-----------
 hw/display/vga_int.h     |   3 ++
 hw/display/cirrus_vga.c  |   4 ++
 hw/display/vga.c         |  36 ++++++++++++--
 4 files changed, 111 insertions(+), 32 deletions(-)

diff --git a/hw/display/vga-helpers.h b/hw/display/vga-helpers.h
index 83b9a15604a..29933562c45 100644
--- a/hw/display/vga-helpers.h
+++ b/hw/display/vga-helpers.h
@@ -98,14 +98,19 @@ static void vga_draw_glyph9(uint8_t *d, int linesize,
 /*
  * 4 color mode
  */
-static void vga_draw_line2(VGACommonState *vga, uint8_t *d,
-                           uint32_t addr, int width)
+static void *vga_draw_line2(VGACommonState *vga, uint8_t *d,
+                            uint32_t addr, int width, int hpel)
 {
     uint32_t plane_mask, *palette, data, v;
     int x;
 
     palette = vga->last_palette;
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    hpel &= 7;
+    if (hpel) {
+        width += 8;
+        d = vga->panning_buf;
+    }
     width >>= 3;
     for(x = 0; x < width; x++) {
         data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
@@ -126,6 +131,7 @@ static void vga_draw_line2(VGACommonState *vga, uint8_t *d,
         d += 32;
         addr += 4;
     }
+    return hpel ? vga->panning_buf + 4 * hpel : NULL;
 }
 
 #define PUT_PIXEL2(d, n, v) \
@@ -134,14 +140,19 @@ static void vga_draw_line2(VGACommonState *vga, uint8_t *d,
 /*
  * 4 color mode, dup2 horizontal
  */
-static void vga_draw_line2d2(VGACommonState *vga, uint8_t *d,
-                             uint32_t addr, int width)
+static void *vga_draw_line2d2(VGACommonState *vga, uint8_t *d,
+                              uint32_t addr, int width, int hpel)
 {
     uint32_t plane_mask, *palette, data, v;
     int x;
 
     palette = vga->last_palette;
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    hpel &= 7;
+    if (hpel) {
+        width += 8;
+        d = vga->panning_buf;
+    }
     width >>= 3;
     for(x = 0; x < width; x++) {
         data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
@@ -162,19 +173,25 @@ static void vga_draw_line2d2(VGACommonState *vga, uint8_t *d,
         d += 64;
         addr += 4;
     }
+    return hpel ? vga->panning_buf + 8 * hpel : NULL;
 }
 
 /*
  * 16 color mode
  */
-static void vga_draw_line4(VGACommonState *vga, uint8_t *d,
-                           uint32_t addr, int width)
+static void *vga_draw_line4(VGACommonState *vga, uint8_t *d,
+                            uint32_t addr, int width, int hpel)
 {
     uint32_t plane_mask, data, v, *palette;
     int x;
 
     palette = vga->last_palette;
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    hpel &= 7;
+    if (hpel) {
+        width += 8;
+        d = vga->panning_buf;
+    }
     width >>= 3;
     for(x = 0; x < width; x++) {
         data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
@@ -194,19 +211,25 @@ static void vga_draw_line4(VGACommonState *vga, uint8_t *d,
         d += 32;
         addr += 4;
     }
+    return hpel ? vga->panning_buf + 4 * hpel : NULL;
 }
 
 /*
  * 16 color mode, dup2 horizontal
  */
-static void vga_draw_line4d2(VGACommonState *vga, uint8_t *d,
-                             uint32_t addr, int width)
+static void *vga_draw_line4d2(VGACommonState *vga, uint8_t *d,
+                              uint32_t addr, int width, int hpel)
 {
     uint32_t plane_mask, data, v, *palette;
     int x;
 
     palette = vga->last_palette;
     plane_mask = mask16[vga->ar[VGA_ATC_PLANE_ENABLE] & 0xf];
+    hpel &= 7;
+    if (hpel) {
+        width += 8;
+        d = vga->panning_buf;
+    }
     width >>= 3;
     for(x = 0; x < width; x++) {
         data = vga_read_dword_le(vga, addr & (VGA_VRAM_SIZE - 1));
@@ -226,6 +249,7 @@ static void vga_draw_line4d2(VGACommonState *vga, uint8_t *d,
         d += 64;
         addr += 4;
     }
+    return hpel ? vga->panning_buf + 8 * hpel : NULL;
 }
 
 /*
@@ -233,13 +257,18 @@ static void vga_draw_line4d2(VGACommonState *vga, uint8_t *d,
  *
  * XXX: add plane_mask support (never used in standard VGA modes)
  */
-static void vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
-                             uint32_t addr, int width)
+static void *vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
+                              uint32_t addr, int width, int hpel)
 {
     uint32_t *palette;
     int x;
 
     palette = vga->last_palette;
+    hpel = (hpel >> 1) & 3;
+    if (hpel) {
+        width += 8;
+        d = vga->panning_buf;
+    }
     width >>= 3;
     for(x = 0; x < width; x++) {
         addr &= VGA_VRAM_SIZE - 1;
@@ -250,6 +279,7 @@ static void vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
         d += 32;
         addr += 4;
     }
+    return hpel ? vga->panning_buf + 8 * hpel : NULL;
 }
 
 /*
@@ -257,13 +287,18 @@ static void vga_draw_line8d2(VGACommonState *vga, uint8_t *d,
  *
  * XXX: add plane_mask support (never used in standard VGA modes)
  */
-static void vga_draw_line8(VGACommonState *vga, uint8_t *d,
-                           uint32_t addr, int width)
+static void *vga_draw_line8(VGACommonState *vga, uint8_t *d,
+                            uint32_t addr, int width, int hpel)
 {
     uint32_t *palette;
     int x;
 
     palette = vga->last_palette;
+    hpel = (hpel >> 1) & 3;
+    if (hpel) {
+        width += 8;
+        d = vga->panning_buf;
+    }
     width >>= 3;
     for(x = 0; x < width; x++) {
         ((uint32_t *)d)[0] = palette[vga_read_byte(vga, addr + 0)];
@@ -277,13 +312,14 @@ static void vga_draw_line8(VGACommonState *vga, uint8_t *d,
         d += 32;
         addr += 8;
     }
+    return hpel ? vga->panning_buf + 4 * hpel : NULL;
 }
 
 /*
  * 15 bit color
  */
-static void vga_draw_line15_le(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line15_le(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t v, r, g, b;
@@ -298,10 +334,11 @@ static void vga_draw_line15_le(VGACommonState *vga, uint8_t *d,
         addr += 2;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
 
-static void vga_draw_line15_be(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line15_be(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t v, r, g, b;
@@ -316,13 +353,14 @@ static void vga_draw_line15_be(VGACommonState *vga, uint8_t *d,
         addr += 2;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
 
 /*
  * 16 bit color
  */
-static void vga_draw_line16_le(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line16_le(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t v, r, g, b;
@@ -337,10 +375,11 @@ static void vga_draw_line16_le(VGACommonState *vga, uint8_t *d,
         addr += 2;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
 
-static void vga_draw_line16_be(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line16_be(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t v, r, g, b;
@@ -355,13 +394,14 @@ static void vga_draw_line16_be(VGACommonState *vga, uint8_t *d,
         addr += 2;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
 
 /*
  * 24 bit color
  */
-static void vga_draw_line24_le(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line24_le(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t r, g, b;
@@ -375,10 +415,11 @@ static void vga_draw_line24_le(VGACommonState *vga, uint8_t *d,
         addr += 3;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
 
-static void vga_draw_line24_be(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line24_be(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t r, g, b;
@@ -392,13 +433,14 @@ static void vga_draw_line24_be(VGACommonState *vga, uint8_t *d,
         addr += 3;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
 
 /*
  * 32 bit color
  */
-static void vga_draw_line32_le(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line32_le(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t r, g, b;
@@ -412,10 +454,11 @@ static void vga_draw_line32_le(VGACommonState *vga, uint8_t *d,
         addr += 4;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
 
-static void vga_draw_line32_be(VGACommonState *vga, uint8_t *d,
-                               uint32_t addr, int width)
+static void *vga_draw_line32_be(VGACommonState *vga, uint8_t *d,
+                                uint32_t addr, int width, int hpel)
 {
     int w;
     uint32_t r, g, b;
@@ -429,4 +472,5 @@ static void vga_draw_line32_be(VGACommonState *vga, uint8_t *d,
         addr += 4;
         d += 4;
     } while (--w != 0);
+    return NULL;
 }
diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 6be61e04284..876a1d3697b 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -60,6 +60,8 @@ typedef struct VGADisplayParams {
     uint32_t line_offset;
     uint32_t start_addr;
     uint32_t line_compare;
+    uint8_t  hpel;
+    bool     hpel_split;
 } VGADisplayParams;
 
 typedef struct VGACommonState {
@@ -111,6 +113,7 @@ typedef struct VGACommonState {
     /* display refresh support */
     QemuConsole *con;
     uint32_t font_offsets[2];
+    uint8_t *panning_buf;
     int graphic_mode;
     uint8_t shift_control;
     uint8_t double_scan;
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index e637e5a816e..150883a9716 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -43,6 +43,7 @@
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/pixel_ops.h"
+#include "vga_regs.h"
 #include "cirrus_vga_internal.h"
 #include "qom/object.h"
 #include "ui/console.h"
@@ -1121,6 +1122,9 @@ static void cirrus_get_params(VGACommonState *s1,
     params->line_compare = s->vga.cr[0x18] |
         ((s->vga.cr[0x07] & 0x10) << 4) |
         ((s->vga.cr[0x09] & 0x40) << 3);
+
+    params->hpel = s->vga.ar[VGA_ATC_PEL];
+    params->hpel_split = s->vga.ar[VGA_ATC_MODE] & 0x20;
 }
 
 static uint32_t cirrus_get_bpp16_depth(CirrusVGAState * s)
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 5bf4d14f342..a39f802ab7e 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -50,6 +50,13 @@ bool have_vga = true;
 /* Address mask for non-VESA modes.  */
 #define VGA_VRAM_SIZE                   (256 * KiB)
 
+/* This value corresponds to a shift of zero pixels
+ * in 9-dot text mode.  In other modes, bit 3 is undefined;
+ * we just ignore it, so that 8 corresponds to zero pixels
+ * in all modes.
+ */
+#define VGA_HPEL_NEUTRAL		8
+
 /*
  * Video Graphics Array (VGA)
  *
@@ -984,8 +991,8 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
     }
 }
 
-typedef void vga_draw_line_func(VGACommonState *s1, uint8_t *d,
-                                uint32_t srcaddr, int width);
+typedef void *vga_draw_line_func(VGACommonState *s1, uint8_t *d,
+                                 uint32_t srcaddr, int width, int hpel);
 
 #include "vga-access.h"
 #include "vga-helpers.h"
@@ -1052,6 +1059,8 @@ static void vga_get_params(VGACommonState *s,
         params->line_offset = s->vbe_line_offset;
         params->start_addr = s->vbe_start_addr;
         params->line_compare = 65535;
+        params->hpel = VGA_HPEL_NEUTRAL;
+        params->hpel_split = false;
     } else {
         /* compute line_offset in bytes */
         params->line_offset = s->cr[VGA_CRTC_OFFSET] << 3;
@@ -1064,6 +1073,9 @@ static void vga_get_params(VGACommonState *s,
         params->line_compare = s->cr[VGA_CRTC_LINE_COMPARE] |
             ((s->cr[VGA_CRTC_OVERFLOW] & 0x10) << 4) |
             ((s->cr[VGA_CRTC_MAX_SCAN] & 0x40) << 3);
+
+        params->hpel = s->ar[VGA_ATC_PEL];
+        params->hpel_split = s->ar[VGA_ATC_MODE] & 0x20;
     }
 }
 
@@ -1435,6 +1447,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     ram_addr_t page0, page1, region_start, region_end;
     DirtyBitmapSnapshot *snap = NULL;
     int disp_width, multi_scan, multi_run;
+    int hpel;
     uint8_t *d;
     uint32_t v, addr1, addr;
     vga_draw_line_func *vga_draw_line = NULL;
@@ -1534,6 +1547,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         s->last_line_offset = s->params.line_offset;
         s->last_depth = depth;
         s->last_byteswap = byteswap;
+        /* 16 extra pixels are needed for double-width planar modes.  */
+        s->panning_buf = g_realloc(s->panning_buf,
+                                   (disp_width + 16) * sizeof(uint32_t));
         full_update = 1;
     }
     if (surface_data(surface) != s->vram_ptr + (s->params.start_addr * 4)
@@ -1613,8 +1629,12 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
            width, height, v, line_offset, s->cr[9], s->cr[VGA_CRTC_MODE],
            s->params.line_compare, sr(s, VGA_SEQ_CLOCK_MODE));
 #endif
+    hpel = bits <= 8 ? s->params.hpel : 0;
     addr1 = (s->params.start_addr * 4);
     bwidth = DIV_ROUND_UP(width * bits, 8);
+    if (hpel) {
+        bwidth += 4;
+    }
     y_start = -1;
     d = surface_data(surface);
     linesize = surface_stride(surface);
@@ -1662,7 +1682,11 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             if (y_start < 0)
                 y_start = y;
             if (!(is_buffer_shared(surface))) {
-                vga_draw_line(s, d, addr, width);
+                uint8_t *p;
+                p = vga_draw_line(s, d, addr, width, hpel);
+                if (p) {
+                    memcpy(d, p, disp_width * sizeof(uint32_t));
+                }
                 if (s->cursor_draw_line)
                     s->cursor_draw_line(s, d, y);
             }
@@ -1684,8 +1708,12 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
             multi_run--;
         }
         /* line compare acts on the displayed lines */
-        if (y == s->params.line_compare)
+        if (y == s->params.line_compare) {
+            if (s->params.hpel_split) {
+                hpel = VGA_HPEL_NEUTRAL;
+            }
             addr1 = 0;
+        }
         d += linesize;
     }
     if (y_start >= 0) {
-- 
2.43.0


