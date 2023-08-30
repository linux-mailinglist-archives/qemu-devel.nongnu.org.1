Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2AE78D4D0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgR-0002Ow-JX; Wed, 30 Aug 2023 05:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgE-00024r-Od
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgC-00018y-Di
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zoYg89OwJfG0NluN1/bV+0j5aS05WZHXFM7pIMf1rE=;
 b=embzbSHJV84/AS54PeCDrvqv5iBeTuTaE66o5m4W+mTLz/nRxiMA4xF8WvtNvz+W1Jr6TE
 E/QN1I2jl6jry3n9jH0608qXjPvaEVZE+KItg6CLy1xrGiZOXNQ+gtvoV/xTnOSSNhdvpr
 fJ4TEVX+y01hdFpOkFr0yTHXK4c/LzQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-cTVQl1VaPpuEhtUwi2ZkLw-1; Wed, 30 Aug 2023 05:40:01 -0400
X-MC-Unique: cTVQl1VaPpuEhtUwi2ZkLw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97EEA29ABA1C
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:40:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E75D6492C13;
 Wed, 30 Aug 2023 09:40:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 19/67] ui/console: introduce different console objects
Date: Wed, 30 Aug 2023 13:37:53 +0400
Message-ID: <20230830093843.3531473-20-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Boilerplate code to introduce different object types for the different
console types.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index bdecfe7306..4ca5064cc9 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -128,6 +128,45 @@ struct QemuConsole {
 
 OBJECT_DEFINE_TYPE(QemuConsole, qemu_console, QEMU_CONSOLE, OBJECT)
 
+typedef struct QemuGraphicConsole {
+    QemuConsole parent;
+} QemuGraphicConsole;
+
+typedef QemuConsoleClass QemuGraphicConsoleClass;
+
+#define TYPE_QEMU_GRAPHIC_CONSOLE "qemu-graphic-console"
+OBJECT_DECLARE_SIMPLE_TYPE(QemuGraphicConsole, QEMU_GRAPHIC_CONSOLE)
+OBJECT_DEFINE_TYPE(QemuGraphicConsole, qemu_graphic_console, QEMU_GRAPHIC_CONSOLE, QEMU_CONSOLE)
+
+#define QEMU_IS_GRAPHIC_CONSOLE(c) \
+    object_dynamic_cast(OBJECT(c), TYPE_QEMU_GRAPHIC_CONSOLE)
+
+typedef struct QemuTextConsole {
+    QemuConsole parent;
+} QemuTextConsole;
+
+typedef QemuConsoleClass QemuTextConsoleClass;
+
+#define TYPE_QEMU_TEXT_CONSOLE "qemu-text-console"
+OBJECT_DECLARE_SIMPLE_TYPE(QemuTextConsole, QEMU_TEXT_CONSOLE)
+OBJECT_DEFINE_TYPE(QemuTextConsole, qemu_text_console, QEMU_TEXT_CONSOLE, QEMU_CONSOLE)
+
+#define QEMU_IS_TEXT_CONSOLE(c) \
+    object_dynamic_cast(OBJECT(c), TYPE_QEMU_TEXT_CONSOLE)
+
+typedef struct QemuFixedTextConsole {
+    QemuTextConsole parent;
+} QemuFixedTextConsole;
+
+typedef QemuTextConsoleClass QemuFixedTextConsoleClass;
+
+#define TYPE_QEMU_FIXED_TEXT_CONSOLE "qemu-fixed-text-console"
+OBJECT_DECLARE_SIMPLE_TYPE(QemuFixedTextConsole, QEMU_FIXED_TEXT_CONSOLE)
+OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEXT_CONSOLE, QEMU_TEXT_CONSOLE)
+
+#define QEMU_IS_FIXED_TEXT_CONSOLE(c) \
+    object_dynamic_cast(OBJECT(c), TYPE_QEMU_FIXED_TEXT_CONSOLE)
+
 struct VCChardev {
     Chardev parent;
     QemuConsole *console;
@@ -1338,6 +1377,51 @@ qemu_console_init(Object *obj)
     c->window_id = -1;
 }
 
+static void
+qemu_graphic_console_finalize(Object *obj)
+{
+}
+
+static void
+qemu_graphic_console_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void
+qemu_graphic_console_init(Object *obj)
+{
+}
+
+static void
+qemu_text_console_finalize(Object *obj)
+{
+}
+
+static void
+qemu_text_console_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void
+qemu_text_console_init(Object *obj)
+{
+}
+
+static void
+qemu_fixed_text_console_finalize(Object *obj)
+{
+}
+
+static void
+qemu_fixed_text_console_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void
+qemu_fixed_text_console_init(Object *obj)
+{
+}
+
 static QemuConsole *new_console(console_type_t console_type,
                                 uint32_t head)
 {
-- 
2.41.0


