Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EDD7E35CA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:23:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0GOf-0002ca-EH; Tue, 07 Nov 2023 02:21:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0GOP-0001eH-EX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:21:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r0GON-000398-Pk
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699341655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Or88Qnnb1pNKafV+dN1nEsCv88CQRy2MEUGRfMqaD8E=;
 b=BwwB0FvbJHHqWtrekZ17gT/2iJC17sN9CyVRwzWf5w0rX5TnWajvkTbBfxAo0gMtnOj+Np
 eXlxPutljty3ML2niggZ0pvrXx0kaeqq/dGThgoJAY1tQ1++O+WhMi0EZc3KAyyXZsqu68
 CULgduvPtt9g7h6agW1AW5ep7HJUkco=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-WIxxbxgzN8O1lvt_xtdXow-1; Tue, 07 Nov 2023 02:20:51 -0500
X-MC-Unique: WIxxbxgzN8O1lvt_xtdXow-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 817C9185A793;
 Tue,  7 Nov 2023 07:20:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61176492BE0;
 Tue,  7 Nov 2023 07:20:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 stefanha@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v8 21/24] hw/sm501: allow compiling without PIXMAN
Date: Tue,  7 Nov 2023 11:19:11 +0400
Message-ID: <20231107071915.2459115-22-marcandre.lureau@redhat.com>
In-Reply-To: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Change the "x-pixman" property default value and use the fallback path
when PIXMAN support is disabled.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 0eecd00701..33fd08955d 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -438,6 +438,12 @@
 #define SM501_HWC_WIDTH                 64
 #define SM501_HWC_HEIGHT                64
 
+#ifdef CONFIG_PIXMAN
+#define DEFAULT_X_PIXMAN 7
+#else
+#define DEFAULT_X_PIXMAN 0
+#endif
+
 /* SM501 local memory size taken from "linux/drivers/mfd/sm501.c" */
 static const uint32_t sm501_mem_local_size[] = {
     [0] = 4 * MiB,
@@ -730,7 +736,6 @@ static void sm501_2d_operation(SM501State *s)
     switch (cmd) {
     case 0: /* BitBlt */
     {
-        static uint32_t tmp_buf[16384];
         unsigned int src_x = (s->twoD_source >> 16) & 0x01FFF;
         unsigned int src_y = s->twoD_source & 0xFFFF;
         uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
@@ -828,9 +833,11 @@ static void sm501_2d_operation(SM501State *s)
                 de = db + (width + (height - 1) * dst_pitch) * bypp;
                 overlap = (db < se && sb < de);
             }
+#ifdef CONFIG_PIXMAN
             if (overlap && (s->use_pixman & BIT(2))) {
                 /* pixman can't do reverse blit: copy via temporary */
                 int tmp_stride = DIV_ROUND_UP(width * bypp, sizeof(uint32_t));
+                static uint32_t tmp_buf[16384];
                 uint32_t *tmp = tmp_buf;
 
                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
@@ -860,9 +867,12 @@ static void sm501_2d_operation(SM501State *s)
                                        dst_pitch * bypp / sizeof(uint32_t),
                                        8 * bypp, 8 * bypp, src_x, src_y,
                                        dst_x, dst_y, width, height);
-            } else {
+            } else
+#else
+            {
                 fallback = true;
             }
+#endif
             if (fallback) {
                 uint8_t *sp = s->local_mem + src_base;
                 uint8_t *d = s->local_mem + dst_base;
@@ -894,20 +904,23 @@ static void sm501_2d_operation(SM501State *s)
             color = cpu_to_le16(color);
         }
 
+#ifdef CONFIG_PIXMAN
         if (!(s->use_pixman & BIT(0)) || (width == 1 && height == 1) ||
             !pixman_fill((uint32_t *)&s->local_mem[dst_base],
                          dst_pitch * bypp / sizeof(uint32_t), 8 * bypp,
-                         dst_x, dst_y, width, height, color)) {
-            /* fallback when pixman failed or we don't want to call it */
-            uint8_t *d = s->local_mem + dst_base;
-            unsigned int x, y, i;
-            for (y = 0; y < height; y++) {
-                i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
-                for (x = 0; x < width; x++, i += bypp) {
-                    stn_he_p(&d[i], bypp, color);
+                         dst_x, dst_y, width, height, color))
+#endif
+            {
+                /* fallback when pixman failed or we don't want to call it */
+                uint8_t *d = s->local_mem + dst_base;
+                unsigned int x, y, i;
+                for (y = 0; y < height; y++) {
+                    i = (dst_x + (dst_y + y) * dst_pitch) * bypp;
+                    for (x = 0; x < width; x++, i += bypp) {
+                        stn_he_p(&d[i], bypp, color);
+                    }
                 }
             }
-        }
         break;
     }
     default:
@@ -1878,6 +1891,12 @@ static void sm501_reset(SM501State *s)
 static void sm501_init(SM501State *s, DeviceState *dev,
                        uint32_t local_mem_bytes)
 {
+#ifndef CONFIG_PIXMAN
+    if (s->use_pixman != 0) {
+        warn_report("x-pixman != 0, not effective without PIXMAN");
+    }
+#endif
+
     s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
 
     /* local memory */
@@ -2038,7 +2057,8 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
 
 static Property sm501_sysbus_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
-    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, 7),
+    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
+    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, DEFAULT_X_PIXMAN),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2126,7 +2146,7 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
 
 static Property sm501_pci_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
-    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, 7),
+    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, DEFAULT_X_PIXMAN),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


