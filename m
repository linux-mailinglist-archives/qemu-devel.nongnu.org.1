Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D778D4AC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgQ-00024G-KT; Wed, 30 Aug 2023 05:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgA-0001yw-0o
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHg6-0000zK-Ld
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fRM25l9RmgUDSi1sOeWrUKzYOQlHUkeJlYn7juQyPs=;
 b=cSeukjP8olFbg3NSfrEovf6fDEZEQHXyg4UxnDYDiasl18RdA8dKmu2YJKsWMPUJ2DwGij
 4tDxkwpVrHV4rMS+XoxnVF6fbsCLozuOQ//PKtlwfZ7Lz3EhZSV2HRnwyXzkTBDezKYOQ6
 apZGqE9AB4izn9H4D3YwYPPplzGYRuE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-5L0QODj3OOyjAL3dhiD8wg-1; Wed, 30 Aug 2023 05:39:54 -0400
X-MC-Unique: 5L0QODj3OOyjAL3dhiD8wg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E149185A791
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:39:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DAC740C2063;
 Wed, 30 Aug 2023 09:39:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 17/67] ui/console: use OBJECT_DEFINE_TYPE for QemuConsole
Date: Wed, 30 Aug 2023 13:37:51 +0400
Message-ID: <20230830093843.3531473-18-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

The following patch will move some object initialization to the
corresponding handlers.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index b9b545fa3d..7d0bb819ac 100644
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
@@ -1314,6 +1316,21 @@ static QemuConsole *new_console(console_type_t console_type,
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
@@ -2647,13 +2664,6 @@ void qemu_chr_parse_vc(QemuOpts *opts, ChardevBackend *backend, Error **errp)
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
@@ -2679,10 +2689,3 @@ void qemu_console_early_init(void)
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


