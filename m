Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CE67916D0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8AR-0004kP-ME; Mon, 04 Sep 2023 07:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AL-0004Nr-Kz
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8AI-0000IC-MN
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y6wwnPZZJQ4gfCAMJ0lW4JSTVJuLwQHSYqyf0Q1vzN4=;
 b=e3CmhYeJWN8/0DPsv+Yd207Rnjw8+9Gjb1MbWQ0CODrsrSbT/a1dXC9+r5VbyBXu3hy23k
 Hxvp1w/mVgKbiqaYBteliIVbYEJGYIfsdr/pSNH88kAD3UutKW/79TocMjLrlOstrzoWCL
 r/isJpIytksFRxUSDCtCcThcl040AZU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-REepFEZeM0eEjMLBsKzORg-1; Mon, 04 Sep 2023 07:54:44 -0400
X-MC-Unique: REepFEZeM0eEjMLBsKzORg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C5B92999B38
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:54:44 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A798140E963;
 Mon,  4 Sep 2023 11:54:42 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 28/52] ui/vc: move text fields to QemuTextConsole
Date: Mon,  4 Sep 2023 15:52:25 +0400
Message-ID: <20230904115251.4161397-29-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
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

Now we can instantiate the specific console with its own fields. Pass
the most appropriate type to the various functions, and cast up to
QEMU_CONSOLE as necessary.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230830093843.3531473-29-marcandre.lureau@redhat.com>
---
 ui/console.c | 177 ++++++++++++++++++++++++++-------------------------
 1 file changed, 91 insertions(+), 86 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 3cd4c74eec..335d7ba841 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -94,26 +94,6 @@ struct QemuConsole {
     const GraphicHwOps *hw_ops;
     void *hw;
 
-    /* Text console state */
-    int width;
-    int height;
-    int total_height;
-    int backscroll_height;
-    int x, y;
-    int y_displayed;
-    int y_base;
-    TextCell *cells;
-    int text_x[2], text_y[2], cursor_invalidate;
-    int echo;
-
-    int update_x0;
-    int update_y0;
-    int update_x1;
-    int update_y1;
-
-    Chardev *chr;
-    /* fifo for key pressed */
-    Fifo8 out_fifo;
     CoQueue dump_queue;
 
     QTAILQ_ENTRY(QemuConsole) next;
@@ -136,6 +116,26 @@ OBJECT_DEFINE_TYPE(QemuGraphicConsole, qemu_graphic_console, QEMU_GRAPHIC_CONSOL
 
 typedef struct QemuTextConsole {
     QemuConsole parent;
+
+    int width;
+    int height;
+    int total_height;
+    int backscroll_height;
+    int x, y;
+    int y_displayed;
+    int y_base;
+    TextCell *cells;
+    int text_x[2], text_y[2], cursor_invalidate;
+    int echo;
+
+    int update_x0;
+    int update_y0;
+    int update_x1;
+    int update_y1;
+
+    Chardev *chr;
+    /* fifo for key pressed */
+    Fifo8 out_fifo;
 } QemuTextConsole;
 
 typedef QemuConsoleClass QemuTextConsoleClass;
@@ -162,7 +162,7 @@ OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEX
 
 struct VCChardev {
     Chardev parent;
-    QemuConsole *console;
+    QemuTextConsole *console;
 
     enum TTYState state;
     int esc_params[MAX_ESC_PARAMS];
@@ -428,43 +428,44 @@ static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
                              &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
 }
 
-static void text_console_resize(QemuConsole *s)
+static void text_console_resize(QemuTextConsole *t)
 {
+    QemuConsole *s = QEMU_CONSOLE(t);
     TextCell *cells, *c, *c1;
     int w1, x, y, last_width;
 
     assert(s->scanout.kind == SCANOUT_SURFACE);
 
-    last_width = s->width;
-    s->width = surface_width(s->surface) / FONT_WIDTH;
-    s->height = surface_height(s->surface) / FONT_HEIGHT;
+    last_width = t->width;
+    t->width = surface_width(s->surface) / FONT_WIDTH;
+    t->height = surface_height(s->surface) / FONT_HEIGHT;
 
     w1 = last_width;
-    if (s->width < w1)
-        w1 = s->width;
+    if (t->width < w1)
+        w1 = t->width;
 
-    cells = g_new(TextCell, s->width * s->total_height + 1);
-    for(y = 0; y < s->total_height; y++) {
-        c = &cells[y * s->width];
+    cells = g_new(TextCell, t->width * t->total_height + 1);
+    for(y = 0; y < t->total_height; y++) {
+        c = &cells[y * t->width];
         if (w1 > 0) {
-            c1 = &s->cells[y * last_width];
+            c1 = &t->cells[y * last_width];
             for(x = 0; x < w1; x++) {
                 *c++ = *c1++;
             }
         }
-        for(x = w1; x < s->width; x++) {
+        for(x = w1; x < t->width; x++) {
             c->ch = ' ';
             c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             c++;
         }
     }
-    g_free(s->cells);
-    s->cells = cells;
+    g_free(t->cells);
+    t->cells = cells;
 }
 
-static void invalidate_xy(QemuConsole *s, int x, int y)
+static void invalidate_xy(QemuTextConsole *s, int x, int y)
 {
-    if (!qemu_console_is_visible(s)) {
+    if (!qemu_console_is_visible(QEMU_CONSOLE(s))) {
         return;
     }
     if (s->update_x0 > x * FONT_WIDTH)
@@ -479,7 +480,7 @@ static void invalidate_xy(QemuConsole *s, int x, int y)
 
 static void vc_update_xy(VCChardev *vc, int x, int y)
 {
-    QemuConsole *s = vc->console;
+    QemuTextConsole *s = vc->console;
     TextCell *c;
     int y1, y2;
 
@@ -498,13 +499,13 @@ static void vc_update_xy(VCChardev *vc, int x, int y)
             x = s->width - 1;
         }
         c = &s->cells[y1 * s->width + x];
-        vga_putcharxy(s, x, y2, c->ch,
+        vga_putcharxy(QEMU_CONSOLE(s), x, y2, c->ch,
                       &(c->t_attrib));
         invalidate_xy(s, x, y2);
     }
 }
 
-static void console_show_cursor(QemuConsole *s, int show)
+static void console_show_cursor(QemuTextConsole *s, int show)
 {
     TextCell *c;
     int y, y1;
@@ -525,17 +526,17 @@ static void console_show_cursor(QemuConsole *s, int show)
         if (show && cursor_visible_phase) {
             TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
             t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
-            vga_putcharxy(s, x, y, c->ch, &t_attrib);
+            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &t_attrib);
         } else {
-            vga_putcharxy(s, x, y, c->ch, &(c->t_attrib));
+            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &(c->t_attrib));
         }
         invalidate_xy(s, x, y);
     }
 }
 
-static void console_refresh(QemuConsole *s)
+static void console_refresh(QemuTextConsole *s)
 {
-    DisplaySurface *surface = qemu_console_surface(s);
+    DisplaySurface *surface = qemu_console_surface(QEMU_CONSOLE(s));
     TextCell *c;
     int x, y, y1;
 
@@ -545,13 +546,13 @@ static void console_refresh(QemuConsole *s)
     s->text_y[1] = s->height - 1;
     s->cursor_invalidate = 1;
 
-    vga_fill_rect(s, 0, 0, surface_width(surface), surface_height(surface),
+    vga_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
                   color_table_rgb[0][QEMU_COLOR_BLACK]);
     y1 = s->y_displayed;
     for (y = 0; y < s->height; y++) {
         c = s->cells + y1 * s->width;
         for (x = 0; x < s->width; x++) {
-            vga_putcharxy(s, x, y, c->ch,
+            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
                           &(c->t_attrib));
             c++;
         }
@@ -560,11 +561,11 @@ static void console_refresh(QemuConsole *s)
         }
     }
     console_show_cursor(s, 1);
-    dpy_gfx_update(s, 0, 0,
+    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0,
                    surface_width(surface), surface_height(surface));
 }
 
-static void console_scroll(QemuConsole *s, int ydelta)
+static void console_scroll(QemuTextConsole *s, int ydelta)
 {
     int i, y1;
 
@@ -595,7 +596,7 @@ static void console_scroll(QemuConsole *s, int ydelta)
 
 static void vc_put_lf(VCChardev *vc)
 {
-    QemuConsole *s = vc->console;
+    QemuTextConsole *s = vc->console;
     TextCell *c;
     int x, y1;
 
@@ -624,10 +625,10 @@ static void vc_put_lf(VCChardev *vc)
             s->text_x[1] = s->width - 1;
             s->text_y[1] = s->height - 1;
 
-            vga_bitblt(s, 0, FONT_HEIGHT, 0, 0,
+            vga_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
                        s->width * FONT_WIDTH,
                        (s->height - 1) * FONT_HEIGHT);
-            vga_fill_rect(s, 0, (s->height - 1) * FONT_HEIGHT,
+            vga_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
                           s->width * FONT_WIDTH, FONT_HEIGHT,
                           color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
             s->update_x0 = 0;
@@ -737,7 +738,7 @@ static void vc_handle_escape(VCChardev *vc)
 
 static void vc_clear_xy(VCChardev *vc, int x, int y)
 {
-    QemuConsole *s = vc->console;
+    QemuTextConsole *s = vc->console;
     int y1 = (s->y_base + y) % s->total_height;
     if (x >= s->width) {
         x = s->width - 1;
@@ -750,7 +751,7 @@ static void vc_clear_xy(VCChardev *vc, int x, int y)
 
 static void vc_put_one(VCChardev *vc, int ch)
 {
-    QemuConsole *s = vc->console;
+    QemuTextConsole *s = vc->console;
     TextCell *c;
     int y1;
     if (s->x >= s->width) {
@@ -777,7 +778,7 @@ static void vc_respond_str(VCChardev *vc, const char *buf)
 /* set cursor, checking bounds */
 static void vc_set_cursor(VCChardev *vc, int x, int y)
 {
-    QemuConsole *s = vc->console;
+    QemuTextConsole *s = vc->console;
 
     if (x < 0) {
         x = 0;
@@ -798,7 +799,7 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
 
 static void vc_putchar(VCChardev *vc, int ch)
 {
-    QemuConsole *s = vc->console;
+    QemuTextConsole *s = vc->console;
     int i;
     int x, y;
     char response[40];
@@ -1095,8 +1096,11 @@ void console_select(unsigned int index)
             }
             displaychangelistener_display_console(dcl, s, NULL);
         }
-        dpy_text_resize(s, s->width, s->height);
-        text_console_update_cursor(NULL);
+
+        if (QEMU_IS_TEXT_CONSOLE(s)) {
+            dpy_text_resize(s, QEMU_TEXT_CONSOLE(s)->width, QEMU_TEXT_CONSOLE(s)->height);
+            text_console_update_cursor(NULL);
+        }
     }
 }
 
@@ -1107,7 +1111,7 @@ DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
 static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     VCChardev *drv = VC_CHARDEV(chr);
-    QemuConsole *s = drv->console;
+    QemuTextConsole *s = drv->console;
     int i;
 
     s->update_x0 = s->width * FONT_WIDTH;
@@ -1120,14 +1124,14 @@ static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
     }
     console_show_cursor(s, 1);
     if (s->update_x0 < s->update_x1) {
-        dpy_gfx_update(s, s->update_x0, s->update_y0,
+        dpy_gfx_update(QEMU_CONSOLE(s), s->update_x0, s->update_y0,
                        s->update_x1 - s->update_x0,
                        s->update_y1 - s->update_y0);
     }
     return len;
 }
 
-static void kbd_send_chars(QemuConsole *s)
+static void kbd_send_chars(QemuTextConsole *s)
 {
     uint32_t len, avail;
 
@@ -1145,13 +1149,14 @@ static void kbd_send_chars(QemuConsole *s)
 }
 
 /* called when an ascii key is pressed */
-void kbd_put_keysym_console(QemuConsole *s, int keysym)
+void kbd_put_keysym_console(QemuConsole *con, int keysym)
 {
+    QemuTextConsole *s = (QemuTextConsole *)object_dynamic_cast(OBJECT(con), TYPE_QEMU_TEXT_CONSOLE);
     uint8_t buf[16], *q;
     int c;
     uint32_t num_free;
 
-    if (!s || QEMU_IS_GRAPHIC_CONSOLE(s))
+    if (!s)
         return;
 
     switch(keysym) {
@@ -1251,17 +1256,17 @@ void kbd_put_keysym(int keysym)
 
 static void text_console_invalidate(void *opaque)
 {
-    QemuConsole *s = (QemuConsole *) opaque;
+    QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
 
-    if (QEMU_IS_TEXT_CONSOLE(s) && !QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
-        text_console_resize(s);
+    if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
+        text_console_resize(QEMU_TEXT_CONSOLE(s));
     }
     console_refresh(s);
 }
 
 static void text_console_update(void *opaque, console_ch_t *chardata)
 {
-    QemuConsole *s = (QemuConsole *) opaque;
+    QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
     int i, j, src;
 
     if (s->text_x[0] <= s->text_x[1]) {
@@ -1275,7 +1280,7 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
                                              s->cells[src].t_attrib.bgcol,
                                              s->cells[src].t_attrib.bold));
             }
-        dpy_text_update(s, s->text_x[0], s->text_y[0],
+        dpy_text_update(QEMU_CONSOLE(s), s->text_x[0], s->text_y[0],
                         s->text_x[1] - s->text_x[0], i - s->text_y[0]);
         s->text_x[0] = s->width;
         s->text_y[0] = s->height;
@@ -1283,7 +1288,7 @@ static void text_console_update(void *opaque, console_ch_t *chardata)
         s->text_y[1] = 0;
     }
     if (s->cursor_invalidate) {
-        dpy_text_cursor(s, s->x, s->y);
+        dpy_text_cursor(QEMU_CONSOLE(s), s->x, s->y);
         s->cursor_invalidate = 0;
     }
 }
@@ -2399,12 +2404,14 @@ char *qemu_console_get_label(QemuConsole *con)
             }
         }
         return g_strdup("VGA");
-    } else {
-        if (con->chr && con->chr->label) {
-            return g_strdup(con->chr->label);
+    } else if (QEMU_IS_TEXT_CONSOLE(con)) {
+        QemuTextConsole *c = QEMU_TEXT_CONSOLE(con);
+        if (c->chr && c->chr->label) {
+            return g_strdup(c->chr->label);
         }
-        return g_strdup_printf("vc%d", con->index);
     }
+
+    return g_strdup_printf("vc%d", con->index);
 }
 
 int qemu_console_get_index(QemuConsole *con)
@@ -2466,17 +2473,15 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
 static void vc_chr_accept_input(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
-    QemuConsole *s = drv->console;
 
-    kbd_send_chars(s);
+    kbd_send_chars(drv->console);
 }
 
 static void vc_chr_set_echo(Chardev *chr, bool echo)
 {
     VCChardev *drv = VC_CHARDEV(chr);
-    QemuConsole *s = drv->console;
 
-    s->echo = echo;
+    drv->console->echo = echo;
 }
 
 static void text_console_update_cursor_timer(void)
@@ -2514,7 +2519,7 @@ static const GraphicHwOps text_console_ops = {
 static void text_console_do_init(Chardev *chr)
 {
     VCChardev *drv = VC_CHARDEV(chr);
-    QemuConsole *s = drv->console;
+    QemuTextConsole *s = drv->console;
     int g_width = 80 * FONT_WIDTH;
     int g_height = 24 * FONT_HEIGHT;
 
@@ -2525,17 +2530,17 @@ static void text_console_do_init(Chardev *chr)
     s->total_height = DEFAULT_BACKSCROLL;
     s->x = 0;
     s->y = 0;
-    if (s->scanout.kind != SCANOUT_SURFACE) {
+    if (QEMU_CONSOLE(s)->scanout.kind != SCANOUT_SURFACE) {
         if (active_console && active_console->scanout.kind == SCANOUT_SURFACE) {
             g_width = qemu_console_get_width(active_console, g_width);
             g_height = qemu_console_get_height(active_console, g_height);
         }
-        s->surface = qemu_create_displaysurface(g_width, g_height);
-        s->scanout.kind = SCANOUT_SURFACE;
+        QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(g_width, g_height);
+        QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
     }
 
-    s->hw_ops = &text_console_ops;
-    s->hw = s;
+    QEMU_CONSOLE(s)->hw_ops = &text_console_ops;
+    QEMU_CONSOLE(s)->hw = s;
 
     /* set current text attributes to default */
     drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
@@ -2561,7 +2566,7 @@ static void vc_chr_open(Chardev *chr,
 {
     ChardevVC *vc = backend->u.vc.data;
     VCChardev *drv = VC_CHARDEV(chr);
-    QemuConsole *s;
+    QemuTextConsole *s;
     unsigned width = 0;
     unsigned height = 0;
 
@@ -2579,11 +2584,11 @@ static void vc_chr_open(Chardev *chr,
 
     trace_console_txt_new(width, height);
     if (width == 0 || height == 0) {
-        s = (QemuConsole *)object_new(TYPE_QEMU_TEXT_CONSOLE);
+        s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_TEXT_CONSOLE));
     } else {
-        s = (QemuConsole *)object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE);
-        s->scanout.kind = SCANOUT_SURFACE;
-        s->surface = qemu_create_displaysurface(width, height);
+        s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
+        QEMU_CONSOLE(s)->scanout.kind = SCANOUT_SURFACE;
+        QEMU_CONSOLE(s)->surface = qemu_create_displaysurface(width, height);
     }
 
     s->chr = chr;
-- 
2.41.0


