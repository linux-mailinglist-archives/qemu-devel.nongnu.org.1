Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DADD7E25AF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:34:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzzil-0005nA-MY; Mon, 06 Nov 2023 08:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzii-0005m7-NS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzzig-0003lG-Ux
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mywo8KICVCxbxzpY+mReJFJ1I78UFt3Y9PYuMgZIeBs=;
 b=FzzjEPgGBIU+9wJUGs937AsL+IB+qk9vJpn5682i3sCy1pzTeVL03AhKgGkhMWVHpOJlFK
 2wZzQlsrSh3w060Yk4ZN6JK/jca7X72/q8f+6ttFn4U4kKHS1PI/BALZFDbg2UIFL966YX
 CTVdax9FowigOiTlfZf+n8QmwrIO95k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-KYB8TDfGM1OurNTp5L4s9g-1; Mon, 06 Nov 2023 08:32:44 -0500
X-MC-Unique: KYB8TDfGM1OurNTp5L4s9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55542185A788;
 Mon,  6 Nov 2023 13:32:44 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC74492BE0;
 Mon,  6 Nov 2023 13:32:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 05/10] ati-vga: Implement fallback for pixman routines
Date: Mon,  6 Nov 2023 17:32:14 +0400
Message-ID: <20231106133219.2173660-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Pixman routines can fail if no implementation is available and it will
become optional soon so add fallbacks when pixman does not work.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <ed0fba3f74e48143f02228b83bf8796ca49f3e7d.1698871239.git.balaton@eik.bme.hu>
---
 hw/display/ati_int.h |  1 +
 hw/display/ati.c     |  8 +++++
 hw/display/ati_2d.c  | 75 +++++++++++++++++++++++++++++++-------------
 3 files changed, 62 insertions(+), 22 deletions(-)

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
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 4868f95cf2..9a87a5504a 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -1033,6 +1033,7 @@ static Property ati_vga_properties[] = {
     DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
                        PCI_DEVICE_ID_ATI_RAGE128_PF),
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
+    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -1054,11 +1055,18 @@ static void ati_vga_class_init(ObjectClass *klass, void *data)
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
-- 
2.41.0


