Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6184E78D4CB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgx-0006Gg-CO; Wed, 30 Aug 2023 05:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgu-0006EB-T2
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgs-0001RJ-JB
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGdpQ45dpsnTLUE7/iN3xi5K8N7i0y22IQsayhCD/mc=;
 b=J+zZv66RBd2WXtFpOQUZhVXNeM/F97WIIJCJkY5EY7Gd2Bnl8giV2v9M0GhsohqZ8SNATA
 Ly65ciZcoRckn+7cEsho2HFwcmUHaDd3zl+BQuhiza3FlNgJjS9c3AJoXf9fu8wCpNrJL+
 Q4mrgN+yrKYcjEUvH8JmCU0fJv5XVXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-Z8Djof9UM92_kKvMIqlHvg-1; Wed, 30 Aug 2023 05:40:44 -0400
X-MC-Unique: Z8Djof9UM92_kKvMIqlHvg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74B33185A791
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:40:44 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0246466B;
 Wed, 30 Aug 2023 09:40:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 30/67] ui/vc: fold text_console_do_init() in vc_chr_open()
Date: Wed, 30 Aug 2023 13:38:04 +0400
Message-ID: <20230830093843.3531473-31-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 80 ++++++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 49 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 9d884ba02f..22505d093f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -187,7 +187,6 @@ static QTAILQ_HEAD(, QemuConsole) consoles =
 static bool cursor_visible_phase;
 static QEMUTimer *cursor_timer;
 
-static void text_console_do_init(Chardev *chr);
 static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
 static void text_console_update_cursor_timer(void);
@@ -2534,49 +2533,6 @@ static const GraphicHwOps text_console_ops = {
     .text_update = text_console_update,
 };
 
-static void text_console_do_init(Chardev *chr)
-{
-    VCChardev *drv = VC_CHARDEV(chr);
-    QemuTextConsole *s = drv->console;
-    int g_width = 80 * FONT_WIDTH;
-    int g_height = 24 * FONT_HEIGHT;
-
-    fifo8_create(&s->out_fifo, 16);
-
-    s->y_displayed = 0;
-    s->y_base = 0;
-    s->total_height = DEFAULT_BACKSCROLL;
-    s->x = 0;
-    s->y = 0;
-    if (QEMU_CONSOLE(s)->scanout.kind != SCANOUT_SURFACE) {
-        if (active_console && active_console->scanout.kind == SCANOUT_SURFACE) {
-            g_width = qemu_console_get_width(active_console, g_width);
-            g_height = qemu_console_get_height(active_console, g_height);
-        }
-        QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(g_width, g_height);
-        QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
-    }
-
-    QEMU_CONSOLE(s)->hw_ops = &text_console_ops;
-    QEMU_CONSOLE(s)->hw = s;
-
-    /* set current text attributes to default */
-    drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    text_console_resize(s);
-
-    if (chr->label) {
-        char *msg;
-
-        drv->t_attrib.bgcol = QEMU_COLOR_BLUE;
-        msg = g_strdup_printf("%s console\r\n", chr->label);
-        qemu_chr_write(chr, (uint8_t *)msg, strlen(msg), true);
-        g_free(msg);
-        drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    }
-
-    qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-}
-
 static void vc_chr_open(Chardev *chr,
                         ChardevBackend *backend,
                         bool *be_opened,
@@ -2587,6 +2543,8 @@ static void vc_chr_open(Chardev *chr,
     QemuTextConsole *s;
     unsigned width = 0;
     unsigned height = 0;
+    int g_width = 80 * FONT_WIDTH;
+    int g_height = 24 * FONT_HEIGHT;
 
     if (vc->has_width) {
         width = vc->width;
@@ -2612,12 +2570,36 @@ static void vc_chr_open(Chardev *chr,
     s->chr = chr;
     drv->console = s;
 
-    text_console_do_init(chr);
+    fifo8_create(&s->out_fifo, 16);
 
-    /* console/chardev init sometimes completes elsewhere in a 2nd
-     * stage, so defer OPENED events until they are fully initialized
-     */
-    *be_opened = false;
+    s->total_height = DEFAULT_BACKSCROLL;
+    if (QEMU_CONSOLE(s)->scanout.kind != SCANOUT_SURFACE) {
+        if (active_console && active_console->scanout.kind == SCANOUT_SURFACE) {
+            g_width = qemu_console_get_width(active_console, g_width);
+            g_height = qemu_console_get_height(active_console, g_height);
+        }
+        QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(g_width, g_height);
+        QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
+    }
+
+    QEMU_CONSOLE(s)->hw_ops = &text_console_ops;
+    QEMU_CONSOLE(s)->hw = s;
+
+    /* set current text attributes to default */
+    drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    text_console_resize(s);
+
+    if (chr->label) {
+        char *msg;
+
+        drv->t_attrib.bgcol = QEMU_COLOR_BLUE;
+        msg = g_strdup_printf("%s console\r\n", chr->label);
+        qemu_chr_write(chr, (uint8_t *)msg, strlen(msg), true);
+        g_free(msg);
+        drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    }
+
+    *be_opened = true;
 }
 
 void qemu_console_resize(QemuConsole *s, int width, int height)
-- 
2.41.0


