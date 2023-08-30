Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6C78D4E2
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:46:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHhb-0000Jx-FZ; Wed, 30 Aug 2023 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhF-0008VP-LA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhD-0001Tf-H2
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6X7vAMagRhJo2WUw26kDDjrIxpoTT6nK6oaTa2aRhs4=;
 b=E4iKNzbqLU+qh16NgBDLO55NlKzdd+xpHjwG0g9FboEwsBYNGFSgTZhqN6NhSyzk5C+j3T
 TVHoiOe/0+gWAckwcNtzwR/Mm5l+wfQ/5LHbKYobEy3dyyWFAXEPl92cUglO+EsVQEuvAY
 mXYpxxg92Pm8yBxdbJEAw8pF5zizz3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-1hiqTk1NOy2qzgskJEKmcQ-1; Wed, 30 Aug 2023 05:41:05 -0400
X-MC-Unique: 1hiqTk1NOy2qzgskJEKmcQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 051B98022E4
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:41:05 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF6E1140E96E;
 Wed, 30 Aug 2023 09:41:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 35/67] ui/console: declare console types in console.h
Date: Wed, 30 Aug 2023 13:38:09 +0400
Message-ID: <20230830093843.3531473-36-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
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

We are going to split the console.c unit next, and implement
separately. But we need to check the underlying type in various places.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


