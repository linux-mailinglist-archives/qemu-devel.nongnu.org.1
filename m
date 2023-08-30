Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB75978D4AD
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:41:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHg1-0001Fr-EE; Wed, 30 Aug 2023 05:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfz-00013m-39
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfw-0000yH-Gl
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2Z3EAY8z3vZk+UhDtIEjjSiO4BLPpQw6MSWMoCKqDg=;
 b=DkrLR3EYPABwf3HipFGUZT+tYTpjW3Ih/+LLUGZGs7oCIXESwo6YMszwC0Dd/IBUnB+1rx
 20b7Qk6Noop7nyOoNBBNbXRqoazPBQ8XttAssMz2xvtJFZsvkjdKfD6CmahJdabzB+r/e9
 4YP1o/Mr5+o/JUlHBLwd+iO5/UeUqZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-8cX3gsHRNWqZ7TtV0BfiVw-1; Wed, 30 Aug 2023 05:39:46 -0400
X-MC-Unique: 8cX3gsHRNWqZ7TtV0BfiVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CD278022E4
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:39:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DEC01121315;
 Wed, 30 Aug 2023 09:39:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 15/67] ui/vc: pass VCCharDev to VC-specific functions
Date: Wed, 30 Aug 2023 13:37:49 +0400
Message-ID: <20230830093843.3531473-16-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

Even though the actually use more QemuConsole at this point, it makes it
clear those functions are only used from the chardev implementation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 70 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index e96f154cc0..8fe39aa5e3 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -440,8 +440,9 @@ static void invalidate_xy(QemuConsole *s, int x, int y)
         s->update_y1 = (y + 1) * FONT_HEIGHT;
 }
 
-static void update_xy(QemuConsole *s, int x, int y)
+static void vc_update_xy(VCChardev *vc, int x, int y)
 {
+    QemuConsole *s = vc->console;
     TextCell *c;
     int y1, y2;
 
@@ -555,8 +556,9 @@ static void console_scroll(QemuConsole *s, int ydelta)
     console_refresh(s);
 }
 
-static void console_put_lf(QemuConsole *s)
+static void vc_put_lf(VCChardev *vc)
 {
+    QemuConsole *s = vc->console;
     TextCell *c;
     int x, y1;
 
@@ -603,8 +605,9 @@ static void console_put_lf(QemuConsole *s)
  * NOTE: I know this code is not very efficient (checking every color for it
  * self) but it is more readable and better maintainable.
  */
-static void console_handle_escape(QemuConsole *s)
+static void vc_handle_escape(VCChardev *vc)
 {
+    QemuConsole *s = vc->console;
     int i;
 
     for (i=0; i<s->nb_esc_params; i++) {
@@ -696,8 +699,9 @@ static void console_handle_escape(QemuConsole *s)
     }
 }
 
-static void console_clear_xy(QemuConsole *s, int x, int y)
+static void vc_clear_xy(VCChardev *vc, int x, int y)
 {
+    QemuConsole *s = vc->console;
     int y1 = (s->y_base + y) % s->total_height;
     if (x >= s->width) {
         x = s->width - 1;
@@ -705,37 +709,40 @@ static void console_clear_xy(QemuConsole *s, int x, int y)
     TextCell *c = &s->cells[y1 * s->width + x];
     c->ch = ' ';
     c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    update_xy(s, x, y);
+    vc_update_xy(vc, x, y);
 }
 
-static void console_put_one(QemuConsole *s, int ch)
+static void vc_put_one(VCChardev *vc, int ch)
 {
+    QemuConsole *s = vc->console;
     TextCell *c;
     int y1;
     if (s->x >= s->width) {
         /* line wrap */
         s->x = 0;
-        console_put_lf(s);
+        vc_put_lf(vc);
     }
     y1 = (s->y_base + s->y) % s->total_height;
     c = &s->cells[y1 * s->width + s->x];
     c->ch = ch;
     c->t_attrib = s->t_attrib;
-    update_xy(s, s->x, s->y);
+    vc_update_xy(vc, s->x, s->y);
     s->x++;
 }
 
-static void console_respond_str(QemuConsole *s, const char *buf)
+static void vc_respond_str(VCChardev *vc, const char *buf)
 {
     while (*buf) {
-        console_put_one(s, *buf);
+        vc_put_one(vc, *buf);
         buf++;
     }
 }
 
 /* set cursor, checking bounds */
-static void set_cursor(QemuConsole *s, int x, int y)
+static void vc_set_cursor(VCChardev *vc, int x, int y)
 {
+    QemuConsole *s = vc->console;
+
     if (x < 0) {
         x = 0;
     }
@@ -753,8 +760,9 @@ static void set_cursor(QemuConsole *s, int x, int y)
     s->y = y;
 }
 
-static void console_putchar(QemuConsole *s, int ch)
+static void vc_putchar(VCChardev *vc, int ch)
 {
+    QemuConsole *s = vc->console;
     int i;
     int x, y;
     char response[40];
@@ -766,7 +774,7 @@ static void console_putchar(QemuConsole *s, int ch)
             s->x = 0;
             break;
         case '\n':  /* newline */
-            console_put_lf(s);
+            vc_put_lf(vc);
             break;
         case '\b':  /* backspace */
             if (s->x > 0)
@@ -775,7 +783,7 @@ static void console_putchar(QemuConsole *s, int ch)
         case '\t':  /* tabspace */
             if (s->x + (8 - (s->x % 8)) > s->width) {
                 s->x = 0;
-                console_put_lf(s);
+                vc_put_lf(vc);
             } else {
                 s->x = s->x + (8 - (s->x % 8));
             }
@@ -793,7 +801,7 @@ static void console_putchar(QemuConsole *s, int ch)
             s->state = TTY_STATE_ESC;
             break;
         default:
-            console_put_one(s, ch);
+            vc_put_one(vc, ch);
             break;
         }
         break;
@@ -831,37 +839,37 @@ static void console_putchar(QemuConsole *s, int ch)
                 if (s->esc_params[0] == 0) {
                     s->esc_params[0] = 1;
                 }
-                set_cursor(s, s->x, s->y - s->esc_params[0]);
+                vc_set_cursor(vc, s->x, s->y - s->esc_params[0]);
                 break;
             case 'B':
                 /* move cursor down */
                 if (s->esc_params[0] == 0) {
                     s->esc_params[0] = 1;
                 }
-                set_cursor(s, s->x, s->y + s->esc_params[0]);
+                vc_set_cursor(vc, s->x, s->y + s->esc_params[0]);
                 break;
             case 'C':
                 /* move cursor right */
                 if (s->esc_params[0] == 0) {
                     s->esc_params[0] = 1;
                 }
-                set_cursor(s, s->x + s->esc_params[0], s->y);
+                vc_set_cursor(vc, s->x + s->esc_params[0], s->y);
                 break;
             case 'D':
                 /* move cursor left */
                 if (s->esc_params[0] == 0) {
                     s->esc_params[0] = 1;
                 }
-                set_cursor(s, s->x - s->esc_params[0], s->y);
+                vc_set_cursor(vc, s->x - s->esc_params[0], s->y);
                 break;
             case 'G':
                 /* move cursor to column */
-                set_cursor(s, s->esc_params[0] - 1, s->y);
+                vc_set_cursor(vc, s->esc_params[0] - 1, s->y);
                 break;
             case 'f':
             case 'H':
                 /* move cursor to row, column */
-                set_cursor(s, s->esc_params[1] - 1, s->esc_params[0] - 1);
+                vc_set_cursor(vc, s->esc_params[1] - 1, s->esc_params[0] - 1);
                 break;
             case 'J':
                 switch (s->esc_params[0]) {
@@ -872,7 +880,7 @@ static void console_putchar(QemuConsole *s, int ch)
                             if (y == s->y && x < s->x) {
                                 continue;
                             }
-                            console_clear_xy(s, x, y);
+                            vc_clear_xy(vc, x, y);
                         }
                     }
                     break;
@@ -883,7 +891,7 @@ static void console_putchar(QemuConsole *s, int ch)
                             if (y == s->y && x > s->x) {
                                 break;
                             }
-                            console_clear_xy(s, x, y);
+                            vc_clear_xy(vc, x, y);
                         }
                     }
                     break;
@@ -891,7 +899,7 @@ static void console_putchar(QemuConsole *s, int ch)
                     /* clear entire screen */
                     for (y = 0; y <= s->height; y++) {
                         for (x = 0; x < s->width; x++) {
-                            console_clear_xy(s, x, y);
+                            vc_clear_xy(vc, x, y);
                         }
                     }
                     break;
@@ -902,38 +910,38 @@ static void console_putchar(QemuConsole *s, int ch)
                 case 0:
                     /* clear to eol */
                     for(x = s->x; x < s->width; x++) {
-                        console_clear_xy(s, x, s->y);
+                        vc_clear_xy(vc, x, s->y);
                     }
                     break;
                 case 1:
                     /* clear from beginning of line */
                     for (x = 0; x <= s->x && x < s->width; x++) {
-                        console_clear_xy(s, x, s->y);
+                        vc_clear_xy(vc, x, s->y);
                     }
                     break;
                 case 2:
                     /* clear entire line */
                     for(x = 0; x < s->width; x++) {
-                        console_clear_xy(s, x, s->y);
+                        vc_clear_xy(vc, x, s->y);
                     }
                     break;
                 }
                 break;
             case 'm':
-                console_handle_escape(s);
+                vc_handle_escape(vc);
                 break;
             case 'n':
                 switch (s->esc_params[0]) {
                 case 5:
                     /* report console status (always succeed)*/
-                    console_respond_str(s, "\033[0n");
+                    vc_respond_str(vc, "\033[0n");
                     break;
                 case 6:
                     /* report cursor position */
                     sprintf(response, "\033[%d;%dR",
                            (s->y_base + s->y) % s->total_height + 1,
                             s->x + 1);
-                    console_respond_str(s, response);
+                    vc_respond_str(vc, response);
                     break;
                 }
                 break;
@@ -1072,7 +1080,7 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     s->update_y1 = 0;
     console_show_cursor(s, 0);
     for(i = 0; i < len; i++) {
-        console_putchar(s, buf[i]);
+        vc_putchar(drv, buf[i]);
     }
     console_show_cursor(s, 1);
     if (s->update_x0 < s->update_x1) {
-- 
2.41.0


