Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 832397D33CC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:34:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutAk-0001lp-Eg; Mon, 23 Oct 2023 07:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qutAN-0000nw-86
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qutAL-0003jv-8l
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8DI7JMhQoy9OW0Ax7H7SpHdY1TtHD5KSx9TNrfbjluE=;
 b=iBHT+TyeL5L0Cn/EjVmhZiABYHCcn7sTU0ya0ELnUH2tq67cuhn3OkIOfri9cEMIPzaC6A
 97BeNlTvoYKRuFyLx06E11zX8c/jhcG01y/7jfkhWNiu0OBi93tzIL8QJWW/6DHUtitLzH
 mCRn6HT34zoQ2cQVDgAUyk3Q4mpSiHE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-RjSMZIc0MFWTO4sIk13CcA-1; Mon,
 23 Oct 2023 07:32:08 -0400
X-MC-Unique: RjSMZIc0MFWTO4sIk13CcA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 039443810B00;
 Mon, 23 Oct 2023 11:32:08 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D3CC1C060AE;
 Mon, 23 Oct 2023 11:32:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 17/19] hw/sm501: allow compiling without PIXMAN
Date: Mon, 23 Oct 2023 15:30:44 +0400
Message-ID: <20231023113047.2572137-18-marcandre.lureau@redhat.com>
In-Reply-To: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Drop the "x-pixman" property and use fallback path in such case.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/sm501.c | 59 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 0eecd00701..282671d1b3 100644
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
@@ -1875,9 +1888,15 @@ static void sm501_reset(SM501State *s)
     s->twoD_wrap = 0;
 }
 
-static void sm501_init(SM501State *s, DeviceState *dev,
-                       uint32_t local_mem_bytes)
+static bool sm501_init(SM501State *s, DeviceState *dev,
+                       uint32_t local_mem_bytes, Error **errp)
 {
+#ifndef CONFIG_PIXMAN
+    if (s->use_pixman != 0) {
+        error_setg(&error_warn, "x-pixman != 0, not effective without PIXMAN");
+    }
+#endif
+
     s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
 
     /* local memory */
@@ -1916,6 +1935,7 @@ static void sm501_init(SM501State *s, DeviceState *dev,
 
     /* create qemu graphic console */
     s->con = graphic_console_init(dev, 0, &sm501_ops, s);
+    return true;
 }
 
 static const VMStateDescription vmstate_sm501_state = {
@@ -2014,7 +2034,9 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     MemoryRegion *mr;
 
-    sm501_init(&s->state, dev, s->vram_size);
+    if (!sm501_init(&s->state, dev, s->vram_size, errp)) {
+        return;
+    }
     if (get_local_mem_size(&s->state) != s->vram_size) {
         error_setg(errp, "Invalid VRAM size, nearest valid size is %" PRIu32,
                    get_local_mem_size(&s->state));
@@ -2038,7 +2060,8 @@ static void sm501_realize_sysbus(DeviceState *dev, Error **errp)
 
 static Property sm501_sysbus_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
-    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, 7),
+    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicity */
+    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, DEFAULT_X_PIXMAN),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -2112,7 +2135,9 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
 {
     SM501PCIState *s = PCI_SM501(dev);
 
-    sm501_init(&s->state, DEVICE(dev), s->vram_size);
+    if (!sm501_init(&s->state, DEVICE(dev), s->vram_size, errp)) {
+        return;
+    }
     if (get_local_mem_size(&s->state) != s->vram_size) {
         error_setg(errp, "Invalid VRAM size, nearest valid size is %" PRIu32,
                    get_local_mem_size(&s->state));
@@ -2126,7 +2151,7 @@ static void sm501_realize_pci(PCIDevice *dev, Error **errp)
 
 static Property sm501_pci_properties[] = {
     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB),
-    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, 7),
+    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, DEFAULT_X_PIXMAN),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


