Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C6C76AE91
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:40:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlqz-0001oq-1N; Tue, 01 Aug 2023 05:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qQlqs-0001m3-Kh
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qQlqq-0004mf-6y
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:39:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690882774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WT4cTlq7uCBkI6kFqlKHKjfIuRBw84qAyVIYl676eo4=;
 b=cC3upq9d1/nXlRE59nIWlYSuyRAd0sZzYJqN5ASDcg+5F2n/ogCM0BEof+H8mx51/FdTfo
 yjVY6ToYCIECpxhaP28Wjlk5g3f213j2FzcCCKN5nShfOd0Rm1+yeBberq/tDRDygwE4KI
 n8AhXr5EHn71Wk3lhCbYcEFCbkOYBv4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-yv2LiITvMsCThZhGZ55dxA-1; Tue, 01 Aug 2023 05:39:32 -0400
X-MC-Unique: yv2LiITvMsCThZhGZ55dxA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CAF33813F39;
 Tue,  1 Aug 2023 09:39:32 +0000 (UTC)
Received: from localhost (unknown [10.39.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD94EC57964;
 Tue,  1 Aug 2023 09:39:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: zhouzongmin@kylinos.cn,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 1/2] vmmouse: replace DPRINTF with tracing
Date: Tue,  1 Aug 2023 13:39:27 +0400
Message-ID: <20230801093928.309361-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/i386/vmmouse.c    | 29 ++++++++++++++---------------
 hw/i386/trace-events | 10 ++++++++++
 2 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index a56c185f15..fce13a5cde 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -32,6 +32,8 @@
 #include "cpu.h"
 #include "qom/object.h"
 
+#include "trace.h"
+
 /* debug only vmmouse */
 //#define DEBUG_VMMOUSE
 
@@ -44,12 +46,6 @@
 
 #define VMMOUSE_VERSION		0x3442554a
 
-#ifdef DEBUG_VMMOUSE
-#define DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...) do { } while (0)
-#endif
-
 #define TYPE_VMMOUSE "vmmouse"
 OBJECT_DECLARE_SIMPLE_TYPE(VMMouseState, VMMOUSE)
 
@@ -87,7 +83,8 @@ static void vmmouse_set_data(const uint32_t *data)
 
 static uint32_t vmmouse_get_status(VMMouseState *s)
 {
-    DPRINTF("vmmouse_get_status()\n");
+    trace_vmmouse_get_status();
+
     return (s->status << 16) | s->nb_queue;
 }
 
@@ -99,8 +96,7 @@ static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_
     if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4))
         return;
 
-    DPRINTF("vmmouse_mouse_event(%d, %d, %d, %d)\n",
-            x, y, dz, buttons_state);
+    trace_vmmouse_mouse_event(x, y, dz, buttons_state);
 
     if ((buttons_state & MOUSE_EVENT_LBUTTON))
         buttons |= 0x20;
@@ -151,7 +147,7 @@ static void vmmouse_update_handler(VMMouseState *s, int absolute)
 
 static void vmmouse_read_id(VMMouseState *s)
 {
-    DPRINTF("vmmouse_read_id()\n");
+    trace_vmmouse_read_id();
 
     if (s->nb_queue == VMMOUSE_QUEUE_SIZE)
         return;
@@ -163,19 +159,22 @@ static void vmmouse_read_id(VMMouseState *s)
 
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
@@ -184,7 +183,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
 {
     int i;
 
-    DPRINTF("vmmouse_data(%d)\n", size);
+    trace_vmmouse_data(size);
 
     if (size == 0 || size > 6 || size > s->nb_queue) {
         printf("vmmouse: driver requested too much data %d\n", size);
@@ -284,7 +283,7 @@ static void vmmouse_realizefn(DeviceState *dev, Error **errp)
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


