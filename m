Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7F791685
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd89c-0002gt-BC; Mon, 04 Sep 2023 07:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89T-0002Aw-3U
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89N-0008Nv-5g
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/32oFS7TQEmf4bW88aD4JYqrEDtlekpiFzmkgf6R/9s=;
 b=JlOUbV5YqQi8Fj8u+A+JMKHQiTzYQQxInfG0zdCXrAnSVk5MeTBEmYxVlTmcHxsIMWGlCc
 qSMaSHo3cYHninFw0vIn88O43CjhXq4UdtmcYGLmBAYWCLY5i7LdAbeR2KntHyZ1YcvqvF
 cDFWfSztbZiCO+J1sPmA/TQxz1ecrUo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-vziKJJXaPBOPSu5PJYQidA-1; Mon, 04 Sep 2023 07:53:46 -0400
X-MC-Unique: vziKJJXaPBOPSu5PJYQidA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 086EA1C29799
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C568D2026D4B;
 Mon,  4 Sep 2023 11:53:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 13/52] ui/vc: replace variable with static text attributes
 default
Date: Mon,  4 Sep 2023 15:52:10 +0400
Message-ID: <20230904115251.4161397-14-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-14-marcandre.lureau@redhat.com>
---
 ui/console.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 5c8e3ad1df..d1855f3fcf 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -52,6 +52,11 @@ typedef struct TextAttributes {
     uint8_t unvisible:1;
 } TextAttributes;
 
+#define TEXT_ATTRIBUTES_DEFAULT ((TextAttributes) { \
+    .fgcol = QEMU_COLOR_WHITE,                      \
+    .bgcol = QEMU_COLOR_BLACK                       \
+})
+
 typedef struct TextCell {
     uint8_t ch;
     TextAttributes t_attrib;
@@ -104,7 +109,6 @@ struct QemuConsole {
     int x_saved, y_saved;
     int y_displayed;
     int y_base;
-    TextAttributes t_attrib_default; /* default text attributes */
     TextAttributes t_attrib; /* currently active text attributes */
     TextCell *cells;
     int text_x[2], text_y[2], cursor_invalidate;
@@ -413,7 +417,7 @@ static void text_console_resize(QemuConsole *s)
         }
         for(x = w1; x < s->width; x++) {
             c->ch = ' ';
-            c->t_attrib = s->t_attrib_default;
+            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
     }
@@ -486,7 +490,7 @@ static void console_show_cursor(QemuConsole *s, int show)
     if (y < s->height) {
         c = &s->cells[y1 * s->width + x];
         if (show && cursor_visible_phase) {
-            TextAttributes t_attrib = s->t_attrib_default;
+            TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
             vga_putcharxy(s, x, y, c->ch, &t_attrib);
         } else {
@@ -577,7 +581,7 @@ static void console_put_lf(QemuConsole *s)
         c = &s->cells[y1 * s->width];
         for(x = 0; x < s->width; x++) {
             c->ch = ' ';
-            c->t_attrib = s->t_attrib_default;
+            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
         if (s->y_displayed == s->y_base) {
@@ -591,7 +595,7 @@ static void console_put_lf(QemuConsole *s)
                        (s->height - 1) * FONT_HEIGHT);
             vga_fill_rect(s, 0, (s->height - 1) * FONT_HEIGHT,
                           s->width * FONT_WIDTH, FONT_HEIGHT,
-                          color_table_rgb[0][s->t_attrib_default.bgcol]);
+                          color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
             s->update_x0 = 0;
             s->update_y0 = 0;
             s->update_x1 = s->width * FONT_WIDTH;
@@ -611,7 +615,7 @@ static void console_handle_escape(QemuConsole *s)
     for (i=0; i<s->nb_esc_params; i++) {
         switch (s->esc_params[i]) {
             case 0: /* reset all console attributes to default */
-                s->t_attrib = s->t_attrib_default;
+                s->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
                 break;
             case 1:
                 s->t_attrib.bold = 1;
@@ -705,7 +709,7 @@ static void console_clear_xy(QemuConsole *s, int x, int y)
     }
     TextCell *c = &s->cells[y1 * s->width + x];
     c->ch = ' ';
-    c->t_attrib = s->t_attrib_default;
+    c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     update_xy(s, x, y);
 }
 
@@ -2419,16 +2423,8 @@ static void text_console_do_init(Chardev *chr)
     s->hw_ops = &text_console_ops;
     s->hw = s;
 
-    /* Set text attribute defaults */
-    s->t_attrib_default.bold = 0;
-    s->t_attrib_default.uline = 0;
-    s->t_attrib_default.blink = 0;
-    s->t_attrib_default.invers = 0;
-    s->t_attrib_default.unvisible = 0;
-    s->t_attrib_default.fgcol = QEMU_COLOR_WHITE;
-    s->t_attrib_default.bgcol = QEMU_COLOR_BLACK;
     /* set current text attributes to default */
-    s->t_attrib = s->t_attrib_default;
+    s->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     text_console_resize(s);
 
     if (chr->label) {
@@ -2438,7 +2434,7 @@ static void text_console_do_init(Chardev *chr)
         msg = g_strdup_printf("%s console\r\n", chr->label);
         qemu_chr_write(chr, (uint8_t *)msg, strlen(msg), true);
         g_free(msg);
-        s->t_attrib = s->t_attrib_default;
+        s->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-- 
2.41.0


