Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 673697E1DA8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:57:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwLi-00071E-He; Mon, 06 Nov 2023 04:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwLP-0006iH-E7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:56:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzwLM-0008QF-Bu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699264587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6TPHZZbPX5YwmR+v8bRhw73QvmNTbMk63utWKnSQejU=;
 b=Jq/pGU30w8PalRbT7G0i8CsxcASxyFfOg0IlsvYMLpTWPqSJFos+9jAmbZ/nl9ByeglmUr
 d208FE8AuKs32GuXmW0bDKWaBMVzfEJ2W45ZMTPsP8yY/faJuwpDSpZ1INILJnhxuaPE1D
 kNqFTjlQp9dKLaeFspUfGErhpjyd890=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-_sT4T1L2NY2aAnlKHVs7JQ-1; Mon, 06 Nov 2023 04:56:26 -0500
X-MC-Unique: _sT4T1L2NY2aAnlKHVs7JQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB11D185A793;
 Mon,  6 Nov 2023 09:56:25 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BBB1492BFA;
 Mon,  6 Nov 2023 09:56:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v2 10/24] ui/vc: console-vc requires PIXMAN
Date: Mon,  6 Nov 2023 13:55:27 +0400
Message-ID: <20231106095542.1852973-11-marcandre.lureau@redhat.com>
In-Reply-To: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Add stubs for the fallback paths.

get_vc() now returns NULL by default if !PIXMAN.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 ui/console-vc-stubs.c | 33 +++++++++++++++++++++++++++++++++
 ui/console.c          |  3 +++
 ui/meson.build        |  2 +-
 3 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 ui/console-vc-stubs.c

diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
new file mode 100644
index 0000000000..2afc52329f
--- /dev/null
+++ b/ui/console-vc-stubs.c
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * QEMU VC stubs
+ */
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/option.h"
+#include "chardev/char.h"
+#include "ui/console-priv.h"
+
+void qemu_text_console_select(QemuTextConsole *c)
+{
+}
+
+const char *
+qemu_text_console_get_label(QemuTextConsole *c)
+{
+    return NULL;
+}
+
+void qemu_text_console_update_cursor(void)
+{
+}
+
+void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
+{
+}
+
+void qemu_console_early_init(void)
+{
+}
diff --git a/ui/console.c b/ui/console.c
index a758ed62ad..a72c495b5a 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1685,8 +1685,11 @@ const char *qemu_display_get_vc(DisplayOptions *opts)
     if (dpys[opts->type]->vc) {
         return dpys[opts->type]->vc;
     } else {
+#ifdef CONFIG_PIXMAN
         return "vc:80Cx24C";
+#endif
     }
+    return NULL;
 }
 
 void qemu_display_help(void)
diff --git a/ui/meson.build b/ui/meson.build
index 0a1e8272a3..3085e10a72 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -6,7 +6,6 @@ system_ss.add(png)
 system_ss.add(files(
   'clipboard.c',
   'console.c',
-  'console-vc.c',
   'cursor.c',
   'input-keymap.c',
   'input-legacy.c',
@@ -19,6 +18,7 @@ system_ss.add(files(
   'ui-qmp-cmds.c',
   'util.c',
 ))
+system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('console-vc-stubs.c'))
 if dbus_display
   system_ss.add(files('dbus-module.c'))
 endif
-- 
2.41.0


