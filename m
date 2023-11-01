Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6DF7DE6E6
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:46:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyI5z-0002p3-6C; Wed, 01 Nov 2023 16:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5p-0002Ev-2Q
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:37 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qyI5m-0001U0-Nl
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:45:36 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1574D7560AF;
 Wed,  1 Nov 2023 21:45:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D127975608E; Wed,  1 Nov 2023 21:45:39 +0100 (CET)
Message-Id: <ed0fba3f74e48143f02228b83bf8796ca49f3e7d.1698871239.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698871239.git.balaton@eik.bme.hu>
References: <cover.1698871239.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 4/4] ati-vga: Implement fallback for pixman routines
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
    marcandre.lureau@redhat.com
Date: Wed,  1 Nov 2023 21:45:39 +0100 (CET)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pixman routines can fail if no implementation is available and it will
become optional soon so add fallbacks when pixman does not work.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c     |  8 +++++
 hw/display/ati_2d.c  | 75 +++++++++++++++++++++++++++++++-------------
 hw/display/ati_int.h |  1 +
 3 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 5e38d2c3de..f911fbc327 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1047,6 +1047,7 @@ static Property ati_vga_properties[] = {
     DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
                        PCI_DEVICE_ID_ATI_RAGE128_PF),
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
+    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1068,11 +1069,18 @@ static void ati_vga_class_init(ObjectClass *klass, void *data)
     k->exit = ati_vga_exit;
 }
 
+static void ati_vga_init(Object *o)
+{
+    object_property_set_description(o, "x-pixman", "Use pixman for: "
+                                    "1: fill, 2: blit");
+}
+
 static const TypeInfo ati_vga_info = {
     .name = TYPE_ATI_VGA,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(ATIVGAState),
     .class_init = ati_vga_class_init,
+    .instance_init = ati_vga_init,
     .interfaces = (InterfaceInfo[]) {
           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
           { },
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 7d786653e8..0e6b8e4367 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -92,6 +92,7 @@ void ati_2d_blt(ATIVGAState *s)
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
+        bool fallback = false;
         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
@@ -122,27 +123,50 @@ void ati_2d_blt(ATIVGAState *s)
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
                 src_x, src_y, dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height);
-        if (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
+        if ((s->use_pixman & BIT(1)) &&
+            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
             s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
-            pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
-                       src_stride, dst_stride, bpp, bpp,
-                       src_x, src_y, dst_x, dst_y,
-                       s->regs.dst_width, s->regs.dst_height);
-        } else {
+            fallback = !pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
+                                   src_stride, dst_stride, bpp, bpp,
+                                   src_x, src_y, dst_x, dst_y,
+                                   s->regs.dst_width, s->regs.dst_height);
+        } else if (s->use_pixman & BIT(1)) {
             /* FIXME: We only really need a temporary if src and dst overlap */
             int llb = s->regs.dst_width * (bpp / 8);
             int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
             uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
                                      s->regs.dst_height);
-            pixman_blt((uint32_t *)src_bits, tmp,
-                       src_stride, tmp_stride, bpp, bpp,
-                       src_x, src_y, 0, 0,
-                       s->regs.dst_width, s->regs.dst_height);
-            pixman_blt(tmp, (uint32_t *)dst_bits,
-                       tmp_stride, dst_stride, bpp, bpp,
-                       0, 0, dst_x, dst_y,
-                       s->regs.dst_width, s->regs.dst_height);
+            fallback = !pixman_blt((uint32_t *)src_bits, tmp,
+                                   src_stride, tmp_stride, bpp, bpp,
+                                   src_x, src_y, 0, 0,
+                                   s->regs.dst_width, s->regs.dst_height);
+            if (!fallback) {
+                fallback = !pixman_blt(tmp, (uint32_t *)dst_bits,
+                                       tmp_stride, dst_stride, bpp, bpp,
+                                       0, 0, dst_x, dst_y,
+                                       s->regs.dst_width, s->regs.dst_height);
+            }
             g_free(tmp);
+        } else {
+            fallback = true;
+        }
+        if (fallback) {
+            unsigned int y, i, j, bypp = bpp / 8;
+            unsigned int src_pitch = src_stride * sizeof(uint32_t);
+            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
+
+            for (y = 0; y < s->regs.dst_height; y++) {
+                i = dst_x * bypp;
+                j = src_x * bypp;
+                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
+                    i += (dst_y + y) * dst_pitch;
+                    j += (src_y + y) * src_pitch;
+                } else {
+                    i += (dst_y + s->regs.dst_height - 1 - y) * dst_pitch;
+                    j += (src_y + s->regs.dst_height - 1 - y) * src_pitch;
+                }
+                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * bypp);
+            }
         }
         if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
             dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
@@ -180,14 +204,21 @@ void ati_2d_blt(ATIVGAState *s)
 
         dst_stride /= sizeof(uint32_t);
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
-                dst_bits, dst_stride, bpp,
-                dst_x, dst_y,
-                s->regs.dst_width, s->regs.dst_height,
-                filler);
-        pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
-                    dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height,
-                    filler);
+                dst_bits, dst_stride, bpp, dst_x, dst_y,
+                s->regs.dst_width, s->regs.dst_height, filler);
+        if (!(s->use_pixman & BIT(0)) ||
+            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
+                    s->regs.dst_width, s->regs.dst_height, filler)) {
+            /* fallback when pixman failed or we don't want to call it */
+            unsigned int x, y, i, bypp = bpp / 8;
+            unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
+            for (y = 0; y < s->regs.dst_height; y++) {
+                i = dst_x * bypp + (dst_y + y) * dst_pitch;
+                for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
+                    stn_he_p(&dst_bits[i], bypp, filler);
+                }
+            }
+        }
         if (dst_bits >= s->vga.vram_ptr + s->vga.vbe_start_addr &&
             dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
             s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offset) {
diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
index 8abb873f01..f5a47b82b0 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -90,6 +90,7 @@ struct ATIVGAState {
     char *model;
     uint16_t dev_id;
     uint8_t mode;
+    uint8_t use_pixman;
     bool cursor_guest_mode;
     uint16_t cursor_size;
     uint32_t cursor_offset;
-- 
2.30.9


