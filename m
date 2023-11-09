Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6457E6B78
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:49:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15O6-0002BI-OV; Thu, 09 Nov 2023 08:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ne-0000Gm-GB; Thu, 09 Nov 2023 08:47:35 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15NU-0002Cz-SM; Thu, 09 Nov 2023 08:47:26 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D055631B23;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DF4A3344C9;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461891 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 43/55] ati-vga: Implement fallback for pixman routines
Date: Thu,  9 Nov 2023 16:42:47 +0300
Message-Id: <20231109134300.1461632-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Pixman routines can fail if no implementation is available and it will
become optional soon so add fallbacks when pixman does not work.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <ed0fba3f74e48143f02228b83bf8796ca49f3e7d.1698871239.git.balaton@eik.bme.hu>
(cherry picked from commit 08730ee0cc01c3fceb907a93436d15170a7556c4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 6e38e00502..4f3bebcfd3 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1014,6 +1014,7 @@ static Property ati_vga_properties[] = {
     DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
                        PCI_DEVICE_ID_ATI_RAGE128_PF),
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
+    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1035,11 +1036,18 @@ static void ati_vga_class_init(ObjectClass *klass, void *data)
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
index e8d3c7af75..f03a21ff23 100644
--- a/hw/display/ati_int.h
+++ b/hw/display/ati_int.h
@@ -89,6 +89,7 @@ struct ATIVGAState {
     char *model;
     uint16_t dev_id;
     uint8_t mode;
+    uint8_t use_pixman;
     bool cursor_guest_mode;
     uint16_t cursor_size;
     uint32_t cursor_offset;
-- 
2.39.2


