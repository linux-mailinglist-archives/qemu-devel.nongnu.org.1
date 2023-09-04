Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F06791692
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8AP-0004UZ-5l; Mon, 04 Sep 2023 07:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8A0-0003ng-67
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89x-0008W9-0C
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7NUYymtfm45Q9J6UHwQZHTSqfBewE0YOcr1sRCaqdAg=;
 b=d6Sp9DQ993UEgzKsssWTfiLV1EPzyhYepXDoPZR8+/W80XZz4DUlYIT8EbdC9xy/9a7ukk
 csMgAV9Ta9ZWWUxXlDyG9Ov3g48rBdmd83IxH+wXYjA1Gb2R3et6Pp+iUXaymW6WthEys5
 z7v8sot+51MguMQuLkCAKVyv4l481FU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-HdRwvCCiOjuHPtLym7Q9DQ-1; Mon, 04 Sep 2023 07:54:21 -0400
X-MC-Unique: HdRwvCCiOjuHPtLym7Q9DQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BF86811C32
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:21 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7929E2013570;
 Mon,  4 Sep 2023 11:54:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 22/52] ui/console: remove new_console()
Date: Mon,  4 Sep 2023 15:52:19 +0400
Message-ID: <20230904115251.4161397-23-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

The constructor helper isn't of much used now.

"head" is only specified for graphic console (and default to 0), and we
are going to move it to QemuGraphicConsole next.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-23-marcandre.lureau@redhat.com>
---
 ui/console.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 02a24eaf5d..e0e4f980d7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1414,16 +1414,6 @@ qemu_fixed_text_console_init(Object *obj)
 {
 }
 
-static QemuConsole *new_console(const char *typename,
-                                uint32_t head)
-{
-    QemuConsole *c = QEMU_CONSOLE(object_new(typename));
-
-    c->head = head;
-
-    return c;
-}
-
 #ifdef WIN32
 void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
                                           HANDLE h, uint32_t offset)
@@ -2163,7 +2153,7 @@ DisplayState *init_displaystate(void)
     QemuConsole *con;
 
     QTAILQ_FOREACH(con, &consoles, next) {
-        /* Hook up into the qom tree here (not in new_console()), once
+        /* Hook up into the qom tree here (not in object_new()), once
          * all QemuConsoles are created and the order / numbering
          * doesn't change any more */
         name = g_strdup_printf("console[%d]", con->index);
@@ -2201,7 +2191,8 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
         height = qemu_console_get_height(s, 0);
     } else {
         trace_console_gfx_new();
-        s = new_console(TYPE_QEMU_GRAPHIC_CONSOLE, head);
+        s = (QemuConsole *)object_new(TYPE_QEMU_GRAPHIC_CONSOLE);
+        s->head = head;
         s->ui_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
                                    dpy_set_ui_info_timer, s);
     }
@@ -2578,9 +2569,9 @@ static void vc_chr_open(Chardev *chr,
 
     trace_console_txt_new(width, height);
     if (width == 0 || height == 0) {
-        s = new_console(TYPE_QEMU_TEXT_CONSOLE, 0);
+        s = (QemuConsole *)object_new(TYPE_QEMU_TEXT_CONSOLE);
     } else {
-        s = new_console(TYPE_QEMU_FIXED_TEXT_CONSOLE, 0);
+        s = (QemuConsole *)object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE);
         s->scanout.kind = SCANOUT_SURFACE;
         s->surface = qemu_create_displaysurface(width, height);
     }
-- 
2.41.0


