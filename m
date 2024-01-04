Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B362824A9B
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 23:00:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLVjV-0001aG-Vk; Thu, 04 Jan 2024 16:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjU-0001Zx-9O
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rLVjR-0003Ov-Rp
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 16:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704405509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiLgiU6NaopJ5BO1xNmRBnoDl1SO2F7kA5EA72hKn5Q=;
 b=PfMIYONKkBcZhpsROwLgXQ0Niykgyd6mSwONrPefnUCsMx2Tf6v4vLrYYH2HVfc2w3zsmg
 sf9Yd7mo+/1sWPUqmt4YkdiYq7QMhybRSZphnmdHNaEPbinl8ywM73fSHo9ZvyGB5GuHHf
 MePytiri+38ciLGftetQx0ywR0t9Hjg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257--tIiOTbUPLqKmJ_6ze_ATQ-1; Thu, 04 Jan 2024 16:58:27 -0500
X-MC-Unique: -tIiOTbUPLqKmJ_6ze_ATQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ccaf8667f9so7852391fa.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 13:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704405505; x=1705010305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiLgiU6NaopJ5BO1xNmRBnoDl1SO2F7kA5EA72hKn5Q=;
 b=KGZEfsX0Jp/A6w4tFB83g8H6+nxpD/iCPWrgfz/umHFIJsMFS1LSNLVSnKNUAcpn4M
 WpycZsciztuHbifmVlxJfbCBBQ3NK3BMhqFbSNwfdXjjozmyTvqSZtPT5NuA4F3SvAhi
 MnUe+F/zhZzyVGg1u+wG8Uoi/ABhjfylS6OST5rPo8k35tl6EfkAWHfS+5w5VplQTzG8
 dojSWTFBk+9YOkLWGtdbu0pIb4L9Lh28BiWfKBgprwQ27ywH1uOjMMNDaLaSI4qXK4GF
 AyBo6t7hmKVv9hmpkBnKtpTtPPwUfFEOgnevzJx1X2qbFI4hEzSnhZi+IHA8mRN16lKx
 U8ng==
X-Gm-Message-State: AOJu0YwW9O2nDc/9F62TGr5xnS+Zk9Lt3JqlhLAXdXB3t51xOULi0Gjc
 U36d2D0rM5M+gqMXswhogdMN5LamToX9FR3/LeYOnpHlabaEC8NjWf7HUmKRDm40QWZiJGJVRlw
 wQr4RxFZN4XEePD3pPEx2y5kvN2NgjFCjJTFwhUKBBCw8kPhW9PuoyFYw1x+66p7/RxUwf5rLCG
 37Yux69tY=
X-Received: by 2002:a2e:be83:0:b0:2cc:82ee:287f with SMTP id
 a3-20020a2ebe83000000b002cc82ee287fmr405508ljr.52.1704405505382; 
 Thu, 04 Jan 2024 13:58:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWme5Duo8h475XavMYM2i0g4yB98mjSFUFdzDbN4wf50+ZYaXHIxd/kZODgLXJzvLq3QHOBA==
X-Received: by 2002:a2e:be83:0:b0:2cc:82ee:287f with SMTP id
 a3-20020a2ebe83000000b002cc82ee287fmr405503ljr.52.1704405504939; 
 Thu, 04 Jan 2024 13:58:24 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 cm25-20020a0564020c9900b00556ee10cfe3sm172611edb.92.2024.01.04.13.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 13:58:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v2 4/8] vga: implement horizontal pel panning in graphics modes
Date: Thu,  4 Jan 2024 22:58:07 +0100
Message-ID: <20240104215813.156153-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104215813.156153-1-pbonzini@redhat.com>
References: <20240104215813.156153-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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
index e6d2581d4eb..849eff43898 100644
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
index 296182b0b93..2c7b8e54805 100644
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
@@ -982,8 +989,8 @@ void vga_mem_writeb(VGACommonState *s, hwaddr addr, uint32_t val)
     }
 }
 
-typedef void vga_draw_line_func(VGACommonState *s1, uint8_t *d,
-                                uint32_t srcaddr, int width);
+typedef void *vga_draw_line_func(VGACommonState *s1, uint8_t *d,
+                                 uint32_t srcaddr, int width, int hpel);
 
 #define GET_PLANE(data, p) ((cpu_to_le32(data) >> ((p) * 8)) & 0xff)
 
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


