Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB237E35D7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0GP1-0003AM-Kr; Tue, 07 Nov 2023 02:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0GOn-0002y0-KC
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:21:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0GOl-0003CL-C5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699341677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KqlpcsnIz/mGd2vU8jh0UrFLVWlxoSxGRMh9REUS5lY=;
 b=KhumiChI6IYp5GpmAfsRvwCNi+YAP2AHxuEeFJ3OC1l+TmP+INshYaK2Eafviy7RBM1dSW
 FCpJZz4KhGh45IZwjLkK3HA3hYciCRaof6wt+B9d4vlOX7aN19M7alLce2UuQqWplK6gmh
 L2VU5r8BnBvijdujFIworwTpinajEaI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-7TR_vPz4P_uHyWgZoq2yhg-1; Tue,
 07 Nov 2023 02:21:16 -0500
X-MC-Unique: 7TR_vPz4P_uHyWgZoq2yhg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54A611C2B667;
 Tue,  7 Nov 2023 07:21:00 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8C01492BE0;
 Tue,  7 Nov 2023 07:20:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v8 23/24] hw/display/ati: allow compiling without PIXMAN
Date: Tue,  7 Nov 2023 11:19:13 +0400
Message-ID: <20231107071915.2459115-24-marcandre.lureau@redhat.com>
In-Reply-To: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Change the "x-pixman" property default value and use the fallback path
when PIXMAN support is disabled.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ati.c       | 16 +++++++++++++++-
 hw/display/ati_2d.c    | 11 +++++++----
 hw/display/meson.build |  2 +-
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 9a87a5504a..51a3b156ac 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -32,6 +32,13 @@
 
 #define ATI_DEBUG_HW_CURSOR 0
 
+#ifdef CONFIG_PIXMAN
+#define DEFAULT_X_PIXMAN 3
+#else
+#define DEFAULT_X_PIXMAN 0
+#endif
+
+
 static const struct {
     const char *name;
     uint16_t dev_id;
@@ -946,6 +953,12 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     ATIVGAState *s = ATI_VGA(dev);
     VGACommonState *vga = &s->vga;
 
+#ifndef CONFIG_PIXMAN
+    if (s->use_pixman != 0) {
+        warn_report("x-pixman != 0, not effective without PIXMAN");
+    }
+#endif
+
     if (s->model) {
         int i;
         for (i = 0; i < ARRAY_SIZE(ati_model_aliases); i++) {
@@ -1033,7 +1046,8 @@ static Property ati_vga_properties[] = {
     DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
                        PCI_DEVICE_ID_ATI_RAGE128_PF),
     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, false),
-    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
+    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
+    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIXMAN),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 0e6b8e4367..e58acd0802 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -92,7 +92,7 @@ void ati_2d_blt(ATIVGAState *s)
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
-        bool fallback = false;
+        bool fallback = true;
         unsigned src_x = (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width);
         unsigned src_y = (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
@@ -119,6 +119,7 @@ void ati_2d_blt(ATIVGAState *s)
 
         src_stride /= sizeof(uint32_t);
         dst_stride /= sizeof(uint32_t);
+#ifdef CONFIG_PIXMAN
         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",
                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
                 src_x, src_y, dst_x, dst_y,
@@ -147,9 +148,8 @@ void ati_2d_blt(ATIVGAState *s)
                                        s->regs.dst_width, s->regs.dst_height);
             }
             g_free(tmp);
-        } else {
-            fallback = true;
         }
+#endif
         if (fallback) {
             unsigned int y, i, j, bypp = bpp / 8;
             unsigned int src_pitch = src_stride * sizeof(uint32_t);
@@ -203,12 +203,15 @@ void ati_2d_blt(ATIVGAState *s)
         }
 
         dst_stride /= sizeof(uint32_t);
+#ifdef CONFIG_PIXMAN
         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
                 dst_bits, dst_stride, bpp, dst_x, dst_y,
                 s->regs.dst_width, s->regs.dst_height, filler);
         if (!(s->use_pixman & BIT(0)) ||
             !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, dst_y,
-                    s->regs.dst_width, s->regs.dst_height, filler)) {
+                    s->regs.dst_width, s->regs.dst_height, filler))
+#endif
+        {
             /* fallback when pixman failed or we don't want to call it */
             unsigned int x, y, i, bypp = bpp / 8;
             unsigned int dst_pitch = dst_stride * sizeof(uint32_t);
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 9c06aaee20..344dfe3d8c 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
 
 system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
-system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
+system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
 
 
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
-- 
2.41.0


