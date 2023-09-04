Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4582C7916D5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8AO-00047j-Fc; Mon, 04 Sep 2023 07:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89n-0003P5-BG
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89j-0008RV-Nm
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmY070B/n2DOto2tRIvH64si/eJQ3LRxeV69qiBlBAE=;
 b=Pko+nmZRWWrnSq7wpe0D03tT3PexyUXUUL1Wx5ZCsjhulQ6qdUsmMkVv8/GqJRqm/pjDJ7
 ZYVk98Hu1kzwWrI2i2z+KAVUhzZU/JVOx9A7D1wyy1Q2zhsZFGK0fX1JrJmOC7u9Tbc+AK
 DjRM57EEgsvB+s1lhT0SRBkVLkknznA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-z0hhG3kTNhuHcVb7uFUoeg-1; Mon, 04 Sep 2023 07:54:09 -0400
X-MC-Unique: z0hhG3kTNhuHcVb7uFUoeg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ED2F1C2979A
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61E5B400F5F;
 Mon,  4 Sep 2023 11:54:08 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 19/52] ui/console: introduce different console objects
Date: Mon,  4 Sep 2023 15:52:16 +0400
Message-ID: <20230904115251.4161397-20-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-20-marcandre.lureau@redhat.com>
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


