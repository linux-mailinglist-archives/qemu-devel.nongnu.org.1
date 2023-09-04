Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F186A79168A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8B7-0007Dh-5g; Mon, 04 Sep 2023 07:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Ao-0006zo-RT
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Am-0000ac-LP
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:18 -0400
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-X1iKg2zhOamO9OG2Db_3gA-1; Mon, 04 Sep 2023 07:55:12 -0400
X-MC-Unique: X1iKg2zhOamO9OG2Db_3gA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BFA8910264C1
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:11 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC01A493114;
 Mon,  4 Sep 2023 11:55:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 35/52] ui/console: declare console types in console.h
Date: Mon,  4 Sep 2023 15:52:32 +0400
Message-ID: <20230904115251.4161397-36-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are going to split the console.c unit next, and implement
separately. But we need to check the underlying type in various places.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-36-marcandre.lureau@redhat.com>
---
 include/ui/console.h | 25 +++++++++++++++++++++----
 ui/console.c         | 15 ---------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 465f0f93a0..0f7f50deaf 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -12,6 +12,27 @@
 # include "ui/shader.h"
 #endif
 
+#define TYPE_QEMU_CONSOLE "qemu-console"
+OBJECT_DECLARE_TYPE(QemuConsole, QemuConsoleClass, QEMU_CONSOLE)
+
+#define TYPE_QEMU_GRAPHIC_CONSOLE "qemu-graphic-console"
+OBJECT_DECLARE_SIMPLE_TYPE(QemuGraphicConsole, QEMU_GRAPHIC_CONSOLE)
+
+#define TYPE_QEMU_TEXT_CONSOLE "qemu-text-console"
+OBJECT_DECLARE_SIMPLE_TYPE(QemuTextConsole, QEMU_TEXT_CONSOLE)
+
+#define TYPE_QEMU_FIXED_TEXT_CONSOLE "qemu-fixed-text-console"
+OBJECT_DECLARE_SIMPLE_TYPE(QemuFixedTextConsole, QEMU_FIXED_TEXT_CONSOLE)
+
+#define QEMU_IS_GRAPHIC_CONSOLE(c) \
+    object_dynamic_cast(OBJECT(c), TYPE_QEMU_GRAPHIC_CONSOLE)
+
+#define QEMU_IS_TEXT_CONSOLE(c) \
+    object_dynamic_cast(OBJECT(c), TYPE_QEMU_TEXT_CONSOLE)
+
+#define QEMU_IS_FIXED_TEXT_CONSOLE(c) \
+    object_dynamic_cast(OBJECT(c), TYPE_QEMU_FIXED_TEXT_CONSOLE)
+
 /* keyboard/mouse support */
 
 #define MOUSE_EVENT_LBUTTON 0x01
@@ -112,10 +133,6 @@ void console_handle_touch_event(QemuConsole *con,
                                 Error **errp);
 /* consoles */
 
-#define TYPE_QEMU_CONSOLE "qemu-console"
-OBJECT_DECLARE_TYPE(QemuConsole, QemuConsoleClass, QEMU_CONSOLE)
-
-
 struct QemuConsoleClass {
     ObjectClass parent_class;
 };
diff --git a/ui/console.c b/ui/console.c
index 3d884956b7..ed9e7137b8 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -106,13 +106,8 @@ typedef struct QemuGraphicConsole {
 
 typedef QemuConsoleClass QemuGraphicConsoleClass;
 
-#define TYPE_QEMU_GRAPHIC_CONSOLE "qemu-graphic-console"
-OBJECT_DECLARE_SIMPLE_TYPE(QemuGraphicConsole, QEMU_GRAPHIC_CONSOLE)
 OBJECT_DEFINE_TYPE(QemuGraphicConsole, qemu_graphic_console, QEMU_GRAPHIC_CONSOLE, QEMU_CONSOLE)
 
-#define QEMU_IS_GRAPHIC_CONSOLE(c) \
-    object_dynamic_cast(OBJECT(c), TYPE_QEMU_GRAPHIC_CONSOLE)
-
 typedef struct QemuTextConsole {
     QemuConsole parent;
 
@@ -139,26 +134,16 @@ typedef struct QemuTextConsole {
 
 typedef QemuConsoleClass QemuTextConsoleClass;
 
-#define TYPE_QEMU_TEXT_CONSOLE "qemu-text-console"
-OBJECT_DECLARE_SIMPLE_TYPE(QemuTextConsole, QEMU_TEXT_CONSOLE)
 OBJECT_DEFINE_TYPE(QemuTextConsole, qemu_text_console, QEMU_TEXT_CONSOLE, QEMU_CONSOLE)
 
-#define QEMU_IS_TEXT_CONSOLE(c) \
-    object_dynamic_cast(OBJECT(c), TYPE_QEMU_TEXT_CONSOLE)
-
 typedef struct QemuFixedTextConsole {
     QemuTextConsole parent;
 } QemuFixedTextConsole;
 
 typedef QemuTextConsoleClass QemuFixedTextConsoleClass;
 
-#define TYPE_QEMU_FIXED_TEXT_CONSOLE "qemu-fixed-text-console"
-OBJECT_DECLARE_SIMPLE_TYPE(QemuFixedTextConsole, QEMU_FIXED_TEXT_CONSOLE)
 OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEXT_CONSOLE, QEMU_TEXT_CONSOLE)
 
-#define QEMU_IS_FIXED_TEXT_CONSOLE(c) \
-    object_dynamic_cast(OBJECT(c), TYPE_QEMU_FIXED_TEXT_CONSOLE)
-
 struct VCChardev {
     Chardev parent;
     QemuTextConsole *console;
-- 
2.41.0


