Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A27916C9
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:03:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd89l-0003Ba-2U; Mon, 04 Sep 2023 07:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89e-0002ur-KK
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89c-0008Q0-CW
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:06 -0400
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-xVk3INznOQO5FFsByIbNaA-1; Mon, 04 Sep 2023 07:54:01 -0400
X-MC-Unique: xVk3INznOQO5FFsByIbNaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75FBF8008A4
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9B9940561C3;
 Mon,  4 Sep 2023 11:54:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 17/52] ui/console: use OBJECT_DEFINE_TYPE for QemuConsole
Date: Mon,  4 Sep 2023 15:52:14 +0400
Message-ID: <20230904115251.4161397-18-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

The following patch will move some object initialization to the
corresponding handlers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-18-marcandre.lureau@redhat.com>
---
 ui/console.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 1336a1be6c..14fb38c661 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -125,6 +125,8 @@ struct QemuConsole {
     QTAILQ_ENTRY(QemuConsole) next;
 };
 
+OBJECT_DEFINE_TYPE(QemuConsole, qemu_console, QEMU_CONSOLE, OBJECT)
+
 struct VCChardev {
     Chardev parent;
     QemuConsole *console;
@@ -1313,6 +1315,21 @@ static QemuConsole *new_console(console_type_t console_type, uint32_t head)
     return s;
 }
 
+static void
+qemu_console_finalize(Object *obj)
+{
+}
+
+static void
+qemu_console_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static void
+qemu_console_init(Object *obj)
+{
+}
+
 #ifdef WIN32
 void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
                                           HANDLE h, uint32_t offset)
@@ -2646,13 +2663,6 @@ void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
     }
 }
 
-static const TypeInfo qemu_console_info = {
-    .name = TYPE_QEMU_CONSOLE,
-    .parent = TYPE_OBJECT,
-    .instance_size = sizeof(QemuConsole),
-    .class_size = sizeof(QemuConsoleClass),
-};
-
 static void char_vc_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -2678,10 +2688,3 @@ void qemu_console_early_init(void)
         type_register(&char_vc_type_info);
     }
 }
-
-static void register_types(void)
-{
-    type_register_static(&qemu_console_info);
-}
-
-type_init(register_types);
-- 
2.41.0


