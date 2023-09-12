Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D27379CECB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vM-0002uR-FB; Tue, 12 Sep 2023 06:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vL-0002uE-08
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vI-0003F0-PS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3bOMOL54my+Z6wYAOPlQ8SoK9BwSXftLjsjq4KCtGRE=;
 b=aIpS6svT+3/So/XhIGkyF2FfZUHzxGqxkQz3MFq3PEdkLtj9Ev1r3q+lPF8K6ocDgKtIzx
 AFSrIij1srhynaFO3PK3mTxh1M0XbajlYRxr8N7Q2qPuNCWjrco7pjIANekACcegkF50fU
 NoGXy4dOO8I9TFJAU1+U4bRYwutJHfc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-1jqcNwdQO_CVK0MumC4j4Q-1; Tue, 12 Sep 2023 06:47:08 -0400
X-MC-Unique: 1jqcNwdQO_CVK0MumC4j4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E9012A59541;
 Tue, 12 Sep 2023 10:47:07 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A261E40C6EBF;
 Tue, 12 Sep 2023 10:47:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 04/14] vmmouse: replace DPRINTF with tracing
Date: Tue, 12 Sep 2023 14:46:38 +0400
Message-ID: <20230912104649.1638640-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/vmmouse.c    | 29 ++++++++++++++---------------
 hw/i386/trace-events | 10 ++++++++++
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 6cd624bd09..99b84a3817 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -32,6 +32,8 @@
 #include "cpu.h"
 #include "qom/object.h"
 
+#include "trace.h"
+
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
 
@@ -50,12 +52,6 @@
 #define VMMOUSE_RIGHT_BUTTON       0x10
 #define VMMOUSE_MIDDLE_BUTTON      0x08
 
-#ifdef DEBUG_VMMOUSE
-#define DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
-
 #define TYPE_VMMOUSE "vmmouse"
 OBJECT_DECLARE_SIMPLE_TYPE(VMMouseState, VMMOUSE)
 
@@ -93,7 +89,8 @@ static void vmmouse_set_data(const uint32_t *data)
 
 static uint32_t vmmouse_get_status(VMMouseState *s)
 {
-    DPRINTF("vmmouse_get_status()\n");
+    trace_vmmouse_get_status();
+
     return (s->status << 16) | s->nb_queue;
 }
 
@@ -105,8 +102,7 @@ static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_
     if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4))
         return;
 
-    DPRINTF("vmmouse_mouse_event(%d, %d, %d, %d)\n",
-            x, y, dz, buttons_state);
+    trace_vmmouse_mouse_event(x, y, dz, buttons_state);
 
     if ((buttons_state & MOUSE_EVENT_LBUTTON))
         buttons |= VMMOUSE_LEFT_BUTTON;
@@ -160,7 +156,7 @@ static void vmmouse_update_handler(VMMouseState *s, int absolute)
 
 static void vmmouse_read_id(VMMouseState *s)
 {
-    DPRINTF("vmmouse_read_id()\n");
+    trace_vmmouse_read_id();
 
     if (s->nb_queue == VMMOUSE_QUEUE_SIZE)
         return;
@@ -172,19 +168,22 @@ static void vmmouse_read_id(VMMouseState *s)
 
 static void vmmouse_request_relative(VMMouseState *s)
 {
-    DPRINTF("vmmouse_request_relative()\n");
+    trace_vmmouse_request_relative();
+
     vmmouse_update_handler(s, 0);
 }
 
 static void vmmouse_request_absolute(VMMouseState *s)
 {
-    DPRINTF("vmmouse_request_absolute()\n");
+    trace_vmmouse_request_absolute();
+
     vmmouse_update_handler(s, 1);
 }
 
 static void vmmouse_disable(VMMouseState *s)
 {
-    DPRINTF("vmmouse_disable()\n");
+    trace_vmmouse_disable();
+
     s->status = 0xffff;
     vmmouse_remove_handler(s);
 }
@@ -193,7 +192,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
 {
     int i;
 
-    DPRINTF("vmmouse_data(%d)\n", size);
+    trace_vmmouse_data(size);
 
     if (size == 0 || size > 6 || size > s->nb_queue) {
         printf("vmmouse: driver requested too much data %d\n", size);
@@ -293,7 +292,7 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
 {
     VMMouseState *s = VMMOUSE(dev);
 
-    DPRINTF("vmmouse_init\n");
+    trace_vmmouse_init();
 
     if (!s->i8042) {
         error_setg(errp, "'i8042' link is not set");
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 04fd71bfc4..53c02d7ac8 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -121,3 +121,13 @@ x86_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
 # port92.c
 port92_read(uint8_t val) "port92: read 0x%02x"
 port92_write(uint8_t val) "port92: write 0x%02x"
+
+# vmmouse.c
+vmmouse_get_status(void) ""
+vmmouse_mouse_event(int x, int y, int dz, int buttons_state) "event: x=%d y=%d dz=%d state=%d"
+vmmouse_init(void) ""
+vmmouse_read_id(void) ""
+vmmouse_request_relative(void) ""
+vmmouse_request_absolute(void) ""
+vmmouse_disable(void) ""
+vmmouse_data(uint32_t size) "data: size=%" PRIu32
-- 
2.41.0


