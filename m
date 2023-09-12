Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64F79CECC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vl-0003uX-Hy; Tue, 12 Sep 2023 06:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vi-0003gE-LC
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vd-0003It-VE
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etjFkTda+TPc6OXFFHh2VnlfAWeRQge5EG+gbLcBw+M=;
 b=I67AwXGsmghPP/6twAsb4qsYG1N27JtsEkW+IqeT/r6Y2PZQPVnK0M0/Mw7YrCRmfkz2wE
 9eO75dQ9nFcxJI6Ps5BFYdQTo2eF+SQ4ZqKLQiGTBb9yGu/g3yF35rJErbE7BoOD9goSNf
 g8FClBKGU28+q2aCEgvRjjCMR9GVB+c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-8nR8KPayNgSrql5s1M7D_A-1; Tue, 12 Sep 2023 06:47:31 -0400
X-MC-Unique: 8nR8KPayNgSrql5s1M7D_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC2F13806707
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:47:31 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E74B10F1BE7;
 Tue, 12 Sep 2023 10:47:28 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 10/14] ui/vc: split off the VC part from console.c
Date: Tue, 12 Sep 2023 14:46:44 +0400
Message-ID: <20230912104649.1638640-11-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move common declarations to console-priv.h, and add a new unit
console-vc.c which will handle VC/chardev rendering, when pixman is
available.

(if necessary, the move could be done chunk by chunks)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 ui/console-priv.h |   43 ++
 ui/console-vc.c   | 1079 ++++++++++++++++++++++++++++++++++++++++++++
 ui/console.c      | 1096 +--------------------------------------------
 ui/meson.build    |    1 +
 4 files changed, 1126 insertions(+), 1093 deletions(-)
 create mode 100644 ui/console-priv.h
 create mode 100644 ui/console-vc.c

diff --git a/ui/console-priv.h b/ui/console-priv.h
new file mode 100644
index 0000000000..88569ed2cc
--- /dev/null
+++ b/ui/console-priv.h
@@ -0,0 +1,43 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * QEMU UI Console
+ */
+#ifndef CONSOLE_PRIV_H
+#define CONSOLE_PRIV_H
+
+#include "ui/console.h"
+#include "qemu/coroutine.h"
+#include "qemu/timer.h"
+
+#include "vgafont.h"
+
+#define FONT_HEIGHT 16
+#define FONT_WIDTH 8
+
+struct QemuConsole {
+    Object parent;
+
+    int index;
+    DisplayState *ds;
+    DisplaySurface *surface;
+    DisplayScanout scanout;
+    int dcls;
+    DisplayGLCtx *gl;
+    int gl_block;
+    QEMUTimer *gl_unblock_timer;
+    int window_id;
+    QemuUIInfo ui_info;
+    QEMUTimer *ui_timer;
+    const GraphicHwOps *hw_ops;
+    void *hw;
+    CoQueue dump_queue;
+
+    QTAILQ_ENTRY(QemuConsole) next;
+};
+
+void qemu_text_console_select(QemuTextConsole *c);
+const char * qemu_text_console_get_label(QemuTextConsole *c);
+void qemu_text_console_update_cursor(void);
+void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym);
+
+#endif
diff --git a/ui/console-vc.c b/ui/console-vc.c
new file mode 100644
index 0000000000..9c13cc2981
--- /dev/null
+++ b/ui/console-vc.c
@@ -0,0 +1,1079 @@
+/*
+ * SPDX-License-Identifier: MIT
+ * QEMU VC
+ */
+#include "qemu/osdep.h"
+
+#include "chardev/char.h"
+#include "qapi/error.h"
+#include "qemu/fifo8.h"
+#include "qemu/option.h"
+#include "ui/console.h"
+
+#include "trace.h"
+#include "console-priv.h"
+
+#define DEFAULT_BACKSCROLL 512
+#define CONSOLE_CURSOR_PERIOD 500
+
+typedef struct TextAttributes {
+    uint8_t fgcol:4;
+    uint8_t bgcol:4;
+    uint8_t bold:1;
+    uint8_t uline:1;
+    uint8_t blink:1;
+    uint8_t invers:1;
+    uint8_t unvisible:1;
+} TextAttributes;
+
+#define TEXT_ATTRIBUTES_DEFAULT ((TextAttributes) { \
+    .fgcol = QEMU_COLOR_WHITE,                      \
+    .bgcol = QEMU_COLOR_BLACK                       \
+})
+
+typedef struct TextCell {
+    uint8_t ch;
+    TextAttributes t_attrib;
+} TextCell;
+
+#define MAX_ESC_PARAMS 3
+
+enum TTYState {
+    TTY_STATE_NORM,
+    TTY_STATE_ESC,
+    TTY_STATE_CSI,
+};
+
+typedef struct QemuTextConsole {
+    QemuConsole parent;
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
+} QemuTextConsole;
+
+typedef QemuConsoleClass QemuTextConsoleClass;
+
+OBJECT_DEFINE_TYPE(QemuTextConsole, qemu_text_console, QEMU_TEXT_CONSOLE, QEMU_CONSOLE)
+
+typedef struct QemuFixedTextConsole {
+    QemuTextConsole parent;
+} QemuFixedTextConsole;
+
+typedef QemuTextConsoleClass QemuFixedTextConsoleClass;
+
+OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEXT_CONSOLE, QEMU_TEXT_CONSOLE)
+
+struct VCChardev {
+    Chardev parent;
+    QemuTextConsole *console;
+
+    enum TTYState state;
+    int esc_params[MAX_ESC_PARAMS];
+    int nb_esc_params;
+    TextAttributes t_attrib; /* currently active text attributes */
+    int x_saved, y_saved;
+};
+typedef struct VCChardev VCChardev;
+
+static const pixman_color_t color_table_rgb[2][8] = {
+    {   /* dark */
+        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
+        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xaa),  /* blue */
+        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0x00),  /* green */
+        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0xaa),  /* cyan */
+        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0x00),  /* red */
+        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0xaa),  /* magenta */
+        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xaa, 0xaa, 0x00),  /* yellow */
+        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR_GRAY,
+    },
+    {   /* bright */
+        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
+        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xff),  /* blue */
+        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xff, 0x00),  /* green */
+        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xff, 0xff),  /* cyan */
+        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xff, 0x00, 0x00),  /* red */
+        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xff, 0x00, 0xff),  /* magenta */
+        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xff, 0xff, 0x00),  /* yellow */
+        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR(0xff, 0xff, 0xff),  /* white */
+    }
+};
+
+static bool cursor_visible_phase;
+static QEMUTimer *cursor_timer;
+
+const char *
+qemu_text_console_get_label(QemuTextConsole *c)
+{
+    return c->chr ? c->chr->label : NULL;
+}
+
+static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
+                                   int width, int height, pixman_color_t color)
+{
+    DisplaySurface *surface = qemu_console_surface(con);
+    pixman_rectangle16_t rect = {
+        .x = posx, .y = posy, .width = width, .height = height
+    };
+
+    assert(surface);
+    pixman_image_fill_rectangles(PIXMAN_OP_SRC, surface->image,
+                                 &color, 1, &rect);
+}
+
+/* copy from (xs, ys) to (xd, yd) a rectangle of size (w, h) */
+static void qemu_console_bitblt(QemuConsole *con,
+                                int xs, int ys, int xd, int yd, int w, int h)
+{
+    DisplaySurface *surface = qemu_console_surface(con);
+
+    assert(surface);
+    pixman_image_composite(PIXMAN_OP_SRC,
+                           surface->image, NULL, surface->image,
+                           xs, ys, 0, 0, xd, yd, w, h);
+}
+
+static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
+                          TextAttributes *t_attrib)
+{
+    static pixman_image_t *glyphs[256];
+    DisplaySurface *surface = qemu_console_surface(s);
+    pixman_color_t fgcol, bgcol;
+
+    assert(surface);
+    if (t_attrib->invers) {
+        bgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
+        fgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
+    } else {
+        fgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
+        bgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
+    }
+
+    if (!glyphs[ch]) {
+        glyphs[ch] = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, ch);
+    }
+    qemu_pixman_glyph_render(glyphs[ch], surface->image,
+                             &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
+}
+
+static void invalidate_xy(QemuTextConsole *s, int x, int y)
+{
+    if (!qemu_console_is_visible(QEMU_CONSOLE(s))) {
+        return;
+    }
+    if (s->update_x0 > x * FONT_WIDTH)
+        s->update_x0 = x * FONT_WIDTH;
+    if (s->update_y0 > y * FONT_HEIGHT)
+        s->update_y0 = y * FONT_HEIGHT;
+    if (s->update_x1 < (x + 1) * FONT_WIDTH)
+        s->update_x1 = (x + 1) * FONT_WIDTH;
+    if (s->update_y1 < (y + 1) * FONT_HEIGHT)
+        s->update_y1 = (y + 1) * FONT_HEIGHT;
+}
+
+static void console_show_cursor(QemuTextConsole *s, int show)
+{
+    TextCell *c;
+    int y, y1;
+    int x = s->x;
+
+    s->cursor_invalidate = 1;
+
+    if (x >= s->width) {
+        x = s->width - 1;
+    }
+    y1 = (s->y_base + s->y) % s->total_height;
+    y = y1 - s->y_displayed;
+    if (y < 0) {
+        y += s->total_height;
+    }
+    if (y < s->height) {
+        c = &s->cells[y1 * s->width + x];
+        if (show && cursor_visible_phase) {
+            TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+            t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
+            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &t_attrib);
+        } else {
+            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &(c->t_attrib));
+        }
+        invalidate_xy(s, x, y);
+    }
+}
+
+static void console_refresh(QemuTextConsole *s)
+{
+    DisplaySurface *surface = qemu_console_surface(QEMU_CONSOLE(s));
+    TextCell *c;
+    int x, y, y1;
+
+    assert(surface);
+    s->text_x[0] = 0;
+    s->text_y[0] = 0;
+    s->text_x[1] = s->width - 1;
+    s->text_y[1] = s->height - 1;
+    s->cursor_invalidate = 1;
+
+    qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
+                           color_table_rgb[0][QEMU_COLOR_BLACK]);
+    y1 = s->y_displayed;
+    for (y = 0; y < s->height; y++) {
+        c = s->cells + y1 * s->width;
+        for (x = 0; x < s->width; x++) {
+            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
+                          &(c->t_attrib));
+            c++;
+        }
+        if (++y1 == s->total_height) {
+            y1 = 0;
+        }
+    }
+    console_show_cursor(s, 1);
+    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0,
+                   surface_width(surface), surface_height(surface));
+}
+
+static void console_scroll(QemuTextConsole *s, int ydelta)
+{
+    int i, y1;
+
+    if (ydelta > 0) {
+        for(i = 0; i < ydelta; i++) {
+            if (s->y_displayed == s->y_base)
+                break;
+            if (++s->y_displayed == s->total_height)
+                s->y_displayed = 0;
+        }
+    } else {
+        ydelta = -ydelta;
+        i = s->backscroll_height;
+        if (i > s->total_height - s->height)
+            i = s->total_height - s->height;
+        y1 = s->y_base - i;
+        if (y1 < 0)
+            y1 += s->total_height;
+        for(i = 0; i < ydelta; i++) {
+            if (s->y_displayed == y1)
+                break;
+            if (--s->y_displayed < 0)
+                s->y_displayed = s->total_height - 1;
+        }
+    }
+    console_refresh(s);
+}
+
+static void kbd_send_chars(QemuTextConsole *s)
+{
+    uint32_t len, avail;
+
+    len = qemu_chr_be_can_write(s->chr);
+    avail = fifo8_num_used(&s->out_fifo);
+    while (len > 0 && avail > 0) {
+        const uint8_t *buf;
+        uint32_t size;
+
+        buf = fifo8_pop_buf(&s->out_fifo, MIN(len, avail), &size);
+        qemu_chr_be_write(s->chr, buf, size);
+        len = qemu_chr_be_can_write(s->chr);
+        avail -= size;
+    }
+}
+
+/* called when an ascii key is pressed */
+void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
+{
+    uint8_t buf[16], *q;
+    int c;
+    uint32_t num_free;
+
+    switch(keysym) {
+    case QEMU_KEY_CTRL_UP:
+        console_scroll(s, -1);
+        break;
+    case QEMU_KEY_CTRL_DOWN:
+        console_scroll(s, 1);
+        break;
+    case QEMU_KEY_CTRL_PAGEUP:
+        console_scroll(s, -10);
+        break;
+    case QEMU_KEY_CTRL_PAGEDOWN:
+        console_scroll(s, 10);
+        break;
+    default:
+        /* convert the QEMU keysym to VT100 key string */
+        q = buf;
+        if (keysym >= 0xe100 && keysym <= 0xe11f) {
+            *q++ = '\033';
+            *q++ = '[';
+            c = keysym - 0xe100;
+            if (c >= 10)
+                *q++ = '0' + (c / 10);
+            *q++ = '0' + (c % 10);
+            *q++ = '~';
+        } else if (keysym >= 0xe120 && keysym <= 0xe17f) {
+            *q++ = '\033';
+            *q++ = '[';
+            *q++ = keysym & 0xff;
+        } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
+            qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
+            *q++ = '\n';
+        } else {
+            *q++ = keysym;
+        }
+        if (s->echo) {
+            qemu_chr_write(s->chr, buf, q - buf, true);
+        }
+        num_free = fifo8_num_free(&s->out_fifo);
+        fifo8_push_all(&s->out_fifo, buf, MIN(num_free, q - buf));
+        kbd_send_chars(s);
+        break;
+    }
+}
+
+static void text_console_update(void *opaque, console_ch_t *chardata)
+{
+    QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
+    int i, j, src;
+
+    if (s->text_x[0] <= s->text_x[1]) {
+        src = (s->y_base + s->text_y[0]) * s->width;
+        chardata += s->text_y[0] * s->width;
+        for (i = s->text_y[0]; i <= s->text_y[1]; i ++)
+            for (j = 0; j < s->width; j++, src++) {
+                console_write_ch(chardata ++,
+                                 ATTR2CHTYPE(s->cells[src].ch,
+                                             s->cells[src].t_attrib.fgcol,
+                                             s->cells[src].t_attrib.bgcol,
+                                             s->cells[src].t_attrib.bold));
+            }
+        dpy_text_update(QEMU_CONSOLE(s), s->text_x[0], s->text_y[0],
+                        s->text_x[1] - s->text_x[0], i - s->text_y[0]);
+        s->text_x[0] = s->width;
+        s->text_y[0] = s->height;
+        s->text_x[1] = 0;
+        s->text_y[1] = 0;
+    }
+    if (s->cursor_invalidate) {
+        dpy_text_cursor(QEMU_CONSOLE(s), s->x, s->y);
+        s->cursor_invalidate = 0;
+    }
+}
+
+static void text_console_resize(QemuTextConsole *t)
+{
+    QemuConsole *s = QEMU_CONSOLE(t);
+    TextCell *cells, *c, *c1;
+    int w1, x, y, last_width, w, h;
+
+    assert(s->scanout.kind == SCANOUT_SURFACE);
+
+    w = surface_width(s->surface) / FONT_WIDTH;
+    h = surface_height(s->surface) / FONT_HEIGHT;
+    if (w == t->width && h == t->height) {
+        return;
+    }
+
+    last_width = t->width;
+    t->width = w;
+    t->height = h;
+
+    w1 = MIN(t->width, last_width);
+
+    cells = g_new(TextCell, t->width * t->total_height + 1);
+    for (y = 0; y < t->total_height; y++) {
+        c = &cells[y * t->width];
+        if (w1 > 0) {
+            c1 = &t->cells[y * last_width];
+            for (x = 0; x < w1; x++) {
+                *c++ = *c1++;
+            }
+        }
+        for (x = w1; x < t->width; x++) {
+            c->ch = ' ';
+            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+            c++;
+        }
+    }
+    g_free(t->cells);
+    t->cells = cells;
+}
+
+static void vc_put_lf(VCChardev *vc)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c;
+    int x, y1;
+
+    s->y++;
+    if (s->y >= s->height) {
+        s->y = s->height - 1;
+
+        if (s->y_displayed == s->y_base) {
+            if (++s->y_displayed == s->total_height)
+                s->y_displayed = 0;
+        }
+        if (++s->y_base == s->total_height)
+            s->y_base = 0;
+        if (s->backscroll_height < s->total_height)
+            s->backscroll_height++;
+        y1 = (s->y_base + s->height - 1) % s->total_height;
+        c = &s->cells[y1 * s->width];
+        for(x = 0; x < s->width; x++) {
+            c->ch = ' ';
+            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+            c++;
+        }
+        if (s->y_displayed == s->y_base) {
+            s->text_x[0] = 0;
+            s->text_y[0] = 0;
+            s->text_x[1] = s->width - 1;
+            s->text_y[1] = s->height - 1;
+
+            qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
+                                s->width * FONT_WIDTH,
+                                (s->height - 1) * FONT_HEIGHT);
+            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
+                                   s->width * FONT_WIDTH, FONT_HEIGHT,
+                                   color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
+            s->update_x0 = 0;
+            s->update_y0 = 0;
+            s->update_x1 = s->width * FONT_WIDTH;
+            s->update_y1 = s->height * FONT_HEIGHT;
+        }
+    }
+}
+
+/* Set console attributes depending on the current escape codes.
+ * NOTE: I know this code is not very efficient (checking every color for it
+ * self) but it is more readable and better maintainable.
+ */
+static void vc_handle_escape(VCChardev *vc)
+{
+    int i;
+
+    for (i = 0; i < vc->nb_esc_params; i++) {
+        switch (vc->esc_params[i]) {
+            case 0: /* reset all console attributes to default */
+                vc->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+                break;
+            case 1:
+                vc->t_attrib.bold = 1;
+                break;
+            case 4:
+                vc->t_attrib.uline = 1;
+                break;
+            case 5:
+                vc->t_attrib.blink = 1;
+                break;
+            case 7:
+                vc->t_attrib.invers = 1;
+                break;
+            case 8:
+                vc->t_attrib.unvisible = 1;
+                break;
+            case 22:
+                vc->t_attrib.bold = 0;
+                break;
+            case 24:
+                vc->t_attrib.uline = 0;
+                break;
+            case 25:
+                vc->t_attrib.blink = 0;
+                break;
+            case 27:
+                vc->t_attrib.invers = 0;
+                break;
+            case 28:
+                vc->t_attrib.unvisible = 0;
+                break;
+            /* set foreground color */
+            case 30:
+                vc->t_attrib.fgcol = QEMU_COLOR_BLACK;
+                break;
+            case 31:
+                vc->t_attrib.fgcol = QEMU_COLOR_RED;
+                break;
+            case 32:
+                vc->t_attrib.fgcol = QEMU_COLOR_GREEN;
+                break;
+            case 33:
+                vc->t_attrib.fgcol = QEMU_COLOR_YELLOW;
+                break;
+            case 34:
+                vc->t_attrib.fgcol = QEMU_COLOR_BLUE;
+                break;
+            case 35:
+                vc->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
+                break;
+            case 36:
+                vc->t_attrib.fgcol = QEMU_COLOR_CYAN;
+                break;
+            case 37:
+                vc->t_attrib.fgcol = QEMU_COLOR_WHITE;
+                break;
+            /* set background color */
+            case 40:
+                vc->t_attrib.bgcol = QEMU_COLOR_BLACK;
+                break;
+            case 41:
+                vc->t_attrib.bgcol = QEMU_COLOR_RED;
+                break;
+            case 42:
+                vc->t_attrib.bgcol = QEMU_COLOR_GREEN;
+                break;
+            case 43:
+                vc->t_attrib.bgcol = QEMU_COLOR_YELLOW;
+                break;
+            case 44:
+                vc->t_attrib.bgcol = QEMU_COLOR_BLUE;
+                break;
+            case 45:
+                vc->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
+                break;
+            case 46:
+                vc->t_attrib.bgcol = QEMU_COLOR_CYAN;
+                break;
+            case 47:
+                vc->t_attrib.bgcol = QEMU_COLOR_WHITE;
+                break;
+        }
+    }
+}
+
+static void vc_update_xy(VCChardev *vc, int x, int y)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c;
+    int y1, y2;
+
+    s->text_x[0] = MIN(s->text_x[0], x);
+    s->text_x[1] = MAX(s->text_x[1], x);
+    s->text_y[0] = MIN(s->text_y[0], y);
+    s->text_y[1] = MAX(s->text_y[1], y);
+
+    y1 = (s->y_base + y) % s->total_height;
+    y2 = y1 - s->y_displayed;
+    if (y2 < 0) {
+        y2 += s->total_height;
+    }
+    if (y2 < s->height) {
+        if (x >= s->width) {
+            x = s->width - 1;
+        }
+        c = &s->cells[y1 * s->width + x];
+        vga_putcharxy(QEMU_CONSOLE(s), x, y2, c->ch,
+                      &(c->t_attrib));
+        invalidate_xy(s, x, y2);
+    }
+}
+
+static void vc_clear_xy(VCChardev *vc, int x, int y)
+{
+    QemuTextConsole *s = vc->console;
+    int y1 = (s->y_base + y) % s->total_height;
+    if (x >= s->width) {
+        x = s->width - 1;
+    }
+    TextCell *c = &s->cells[y1 * s->width + x];
+    c->ch = ' ';
+    c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    vc_update_xy(vc, x, y);
+}
+
+static void vc_put_one(VCChardev *vc, int ch)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c;
+    int y1;
+    if (s->x >= s->width) {
+        /* line wrap */
+        s->x = 0;
+        vc_put_lf(vc);
+    }
+    y1 = (s->y_base + s->y) % s->total_height;
+    c = &s->cells[y1 * s->width + s->x];
+    c->ch = ch;
+    c->t_attrib = vc->t_attrib;
+    vc_update_xy(vc, s->x, s->y);
+    s->x++;
+}
+
+static void vc_respond_str(VCChardev *vc, const char *buf)
+{
+    while (*buf) {
+        vc_put_one(vc, *buf);
+        buf++;
+    }
+}
+
+/* set cursor, checking bounds */
+static void vc_set_cursor(VCChardev *vc, int x, int y)
+{
+    QemuTextConsole *s = vc->console;
+
+    if (x < 0) {
+        x = 0;
+    }
+    if (y < 0) {
+        y = 0;
+    }
+    if (y >= s->height) {
+        y = s->height - 1;
+    }
+    if (x >= s->width) {
+        x = s->width - 1;
+    }
+
+    s->x = x;
+    s->y = y;
+}
+
+static void vc_putchar(VCChardev *vc, int ch)
+{
+    QemuTextConsole *s = vc->console;
+    int i;
+    int x, y;
+    char response[40];
+
+    switch(vc->state) {
+    case TTY_STATE_NORM:
+        switch(ch) {
+        case '\r':  /* carriage return */
+            s->x = 0;
+            break;
+        case '\n':  /* newline */
+            vc_put_lf(vc);
+            break;
+        case '\b':  /* backspace */
+            if (s->x > 0)
+                s->x--;
+            break;
+        case '\t':  /* tabspace */
+            if (s->x + (8 - (s->x % 8)) > s->width) {
+                s->x = 0;
+                vc_put_lf(vc);
+            } else {
+                s->x = s->x + (8 - (s->x % 8));
+            }
+            break;
+        case '\a':  /* alert aka. bell */
+            /* TODO: has to be implemented */
+            break;
+        case 14:
+            /* SI (shift in), character set 0 (ignored) */
+            break;
+        case 15:
+            /* SO (shift out), character set 1 (ignored) */
+            break;
+        case 27:    /* esc (introducing an escape sequence) */
+            vc->state = TTY_STATE_ESC;
+            break;
+        default:
+            vc_put_one(vc, ch);
+            break;
+        }
+        break;
+    case TTY_STATE_ESC: /* check if it is a terminal escape sequence */
+        if (ch == '[') {
+            for(i=0;i<MAX_ESC_PARAMS;i++)
+                vc->esc_params[i] = 0;
+            vc->nb_esc_params = 0;
+            vc->state = TTY_STATE_CSI;
+        } else {
+            vc->state = TTY_STATE_NORM;
+        }
+        break;
+    case TTY_STATE_CSI: /* handle escape sequence parameters */
+        if (ch >= '0' && ch <= '9') {
+            if (vc->nb_esc_params < MAX_ESC_PARAMS) {
+                int *param = &vc->esc_params[vc->nb_esc_params];
+                int digit = (ch - '0');
+
+                *param = (*param <= (INT_MAX - digit) / 10) ?
+                         *param * 10 + digit : INT_MAX;
+            }
+        } else {
+            if (vc->nb_esc_params < MAX_ESC_PARAMS)
+                vc->nb_esc_params++;
+            if (ch == ';' || ch == '?') {
+                break;
+            }
+            trace_console_putchar_csi(vc->esc_params[0], vc->esc_params[1],
+                                      ch, vc->nb_esc_params);
+            vc->state = TTY_STATE_NORM;
+            switch(ch) {
+            case 'A':
+                /* move cursor up */
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
+                }
+                vc_set_cursor(vc, s->x, s->y - vc->esc_params[0]);
+                break;
+            case 'B':
+                /* move cursor down */
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
+                }
+                vc_set_cursor(vc, s->x, s->y + vc->esc_params[0]);
+                break;
+            case 'C':
+                /* move cursor right */
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
+                }
+                vc_set_cursor(vc, s->x + vc->esc_params[0], s->y);
+                break;
+            case 'D':
+                /* move cursor left */
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
+                }
+                vc_set_cursor(vc, s->x - vc->esc_params[0], s->y);
+                break;
+            case 'G':
+                /* move cursor to column */
+                vc_set_cursor(vc, vc->esc_params[0] - 1, s->y);
+                break;
+            case 'f':
+            case 'H':
+                /* move cursor to row, column */
+                vc_set_cursor(vc, vc->esc_params[1] - 1, vc->esc_params[0] - 1);
+                break;
+            case 'J':
+                switch (vc->esc_params[0]) {
+                case 0:
+                    /* clear to end of screen */
+                    for (y = s->y; y < s->height; y++) {
+                        for (x = 0; x < s->width; x++) {
+                            if (y == s->y && x < s->x) {
+                                continue;
+                            }
+                            vc_clear_xy(vc, x, y);
+                        }
+                    }
+                    break;
+                case 1:
+                    /* clear from beginning of screen */
+                    for (y = 0; y <= s->y; y++) {
+                        for (x = 0; x < s->width; x++) {
+                            if (y == s->y && x > s->x) {
+                                break;
+                            }
+                            vc_clear_xy(vc, x, y);
+                        }
+                    }
+                    break;
+                case 2:
+                    /* clear entire screen */
+                    for (y = 0; y <= s->height; y++) {
+                        for (x = 0; x < s->width; x++) {
+                            vc_clear_xy(vc, x, y);
+                        }
+                    }
+                    break;
+                }
+                break;
+            case 'K':
+                switch (vc->esc_params[0]) {
+                case 0:
+                    /* clear to eol */
+                    for(x = s->x; x < s->width; x++) {
+                        vc_clear_xy(vc, x, s->y);
+                    }
+                    break;
+                case 1:
+                    /* clear from beginning of line */
+                    for (x = 0; x <= s->x && x < s->width; x++) {
+                        vc_clear_xy(vc, x, s->y);
+                    }
+                    break;
+                case 2:
+                    /* clear entire line */
+                    for(x = 0; x < s->width; x++) {
+                        vc_clear_xy(vc, x, s->y);
+                    }
+                    break;
+                }
+                break;
+            case 'm':
+                vc_handle_escape(vc);
+                break;
+            case 'n':
+                switch (vc->esc_params[0]) {
+                case 5:
+                    /* report console status (always succeed)*/
+                    vc_respond_str(vc, "\033[0n");
+                    break;
+                case 6:
+                    /* report cursor position */
+                    sprintf(response, "\033[%d;%dR",
+                           (s->y_base + s->y) % s->total_height + 1,
+                            s->x + 1);
+                    vc_respond_str(vc, response);
+                    break;
+                }
+                break;
+            case 's':
+                /* save cursor position */
+                vc->x_saved = s->x;
+                vc->y_saved = s->y;
+                break;
+            case 'u':
+                /* restore cursor position */
+                s->x = vc->x_saved;
+                s->y = vc->y_saved;
+                break;
+            default:
+                trace_console_putchar_unhandled(ch);
+                break;
+            }
+            break;
+        }
+    }
+}
+
+#define TYPE_CHARDEV_VC "chardev-vc"
+DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
+                         TYPE_CHARDEV_VC)
+
+static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    VCChardev *drv = VC_CHARDEV(chr);
+    QemuTextConsole *s = drv->console;
+    int i;
+
+    s->update_x0 = s->width * FONT_WIDTH;
+    s->update_y0 = s->height * FONT_HEIGHT;
+    s->update_x1 = 0;
+    s->update_y1 = 0;
+    console_show_cursor(s, 0);
+    for(i = 0; i < len; i++) {
+        vc_putchar(drv, buf[i]);
+    }
+    console_show_cursor(s, 1);
+    if (s->update_x0 < s->update_x1) {
+        dpy_gfx_update(QEMU_CONSOLE(s), s->update_x0, s->update_y0,
+                       s->update_x1 - s->update_x0,
+                       s->update_y1 - s->update_y0);
+    }
+    return len;
+}
+
+void qemu_text_console_update_cursor(void)
+{
+    cursor_visible_phase = !cursor_visible_phase;
+
+    if (qemu_invalidate_text_consoles()) {
+        timer_mod(cursor_timer,
+                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
+    }
+}
+
+static void
+cursor_timer_cb(void *opaque)
+{
+    qemu_text_console_update_cursor();
+}
+
+static void text_console_invalidate(void *opaque)
+{
+    QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
+
+    if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
+        text_console_resize(QEMU_TEXT_CONSOLE(s));
+    }
+    console_refresh(s);
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
+    if (!cursor_timer) {
+        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME, cursor_timer_cb, NULL);
+    }
+}
+
+static const GraphicHwOps text_console_ops = {
+    .invalidate  = text_console_invalidate,
+    .text_update = text_console_update,
+};
+
+static void
+qemu_text_console_init(Object *obj)
+{
+    QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
+
+    fifo8_create(&c->out_fifo, 16);
+    c->total_height = DEFAULT_BACKSCROLL;
+    QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
+    QEMU_CONSOLE(c)->hw = c;
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
+static void vc_chr_accept_input(Chardev *chr)
+{
+    VCChardev *drv = VC_CHARDEV(chr);
+
+    kbd_send_chars(drv->console);
+}
+
+static void vc_chr_set_echo(Chardev *chr, bool echo)
+{
+    VCChardev *drv = VC_CHARDEV(chr);
+
+    drv->console->echo = echo;
+}
+
+void qemu_text_console_select(QemuTextConsole *c)
+{
+    dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
+    qemu_text_console_update_cursor();
+}
+
+static void vc_chr_open(Chardev *chr,
+                        ChardevBackend *backend,
+                        bool *be_opened,
+                        Error **errp)
+{
+    ChardevVC *vc = backend->u.vc.data;
+    VCChardev *drv = VC_CHARDEV(chr);
+    QemuTextConsole *s;
+    unsigned width = 0;
+    unsigned height = 0;
+
+    if (vc->has_width) {
+        width = vc->width;
+    } else if (vc->has_cols) {
+        width = vc->cols * FONT_WIDTH;
+    }
+
+    if (vc->has_height) {
+        height = vc->height;
+    } else if (vc->has_rows) {
+        height = vc->rows * FONT_HEIGHT;
+    }
+
+    trace_console_txt_new(width, height);
+    if (width == 0 || height == 0) {
+        s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_TEXT_CONSOLE));
+        width = qemu_console_get_width(NULL, 80 * FONT_WIDTH);
+        height = qemu_console_get_height(NULL, 24 * FONT_HEIGHT);
+    } else {
+        s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
+    }
+
+    dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
+
+    s->chr = chr;
+    drv->console = s;
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
+}
+
+static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
+{
+    int val;
+    ChardevVC *vc;
+
+    backend->type = CHARDEV_BACKEND_KIND_VC;
+    vc = backend->u.vc.data = g_new0(ChardevVC, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevVC_base(vc));
+
+    val = qemu_opt_get_number(opts, "width", 0);
+    if (val != 0) {
+        vc->has_width = true;
+        vc->width = val;
+    }
+
+    val = qemu_opt_get_number(opts, "height", 0);
+    if (val != 0) {
+        vc->has_height = true;
+        vc->height = val;
+    }
+
+    val = qemu_opt_get_number(opts, "cols", 0);
+    if (val != 0) {
+        vc->has_cols = true;
+        vc->cols = val;
+    }
+
+    val = qemu_opt_get_number(opts, "rows", 0);
+    if (val != 0) {
+        vc->has_rows = true;
+        vc->rows = val;
+    }
+}
+
+static void char_vc_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->parse = vc_chr_parse;
+    cc->open = vc_chr_open;
+    cc->chr_write = vc_chr_write;
+    cc->chr_accept_input = vc_chr_accept_input;
+    cc->chr_set_echo = vc_chr_set_echo;
+}
+
+static const TypeInfo char_vc_type_info = {
+    .name = TYPE_CHARDEV_VC,
+    .parent = TYPE_CHARDEV,
+    .instance_size = sizeof(VCChardev),
+    .class_init = char_vc_class_init,
+};
+
+void qemu_console_early_init(void)
+{
+    /* set the default vc driver */
+    if (!object_class_by_name(TYPE_CHARDEV_VC)) {
+        type_register(&char_vc_type_info);
+    }
+}
diff --git a/ui/console.c b/ui/console.c
index d9ac3717ff..da341f08da 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -29,68 +29,16 @@
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/visitor.h"
 #include "qemu/coroutine.h"
-#include "qemu/fifo8.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qemu/timer.h"
 #include "chardev/char.h"
 #include "trace.h"
 #include "exec/memory.h"
 #include "qom/object.h"
 
-#define DEFAULT_BACKSCROLL 512
-#define CONSOLE_CURSOR_PERIOD 500
-
-typedef struct TextAttributes {
-    uint8_t fgcol:4;
-    uint8_t bgcol:4;
-    uint8_t bold:1;
-    uint8_t uline:1;
-    uint8_t blink:1;
-    uint8_t invers:1;
-    uint8_t unvisible:1;
-} TextAttributes;
-
-#define TEXT_ATTRIBUTES_DEFAULT ((TextAttributes) { \
-    .fgcol = QEMU_COLOR_WHITE,                      \
-    .bgcol = QEMU_COLOR_BLACK                       \
-})
-
-typedef struct TextCell {
-    uint8_t ch;
-    TextAttributes t_attrib;
-} TextCell;
-
-#define MAX_ESC_PARAMS 3
-
-enum TTYState {
-    TTY_STATE_NORM,
-    TTY_STATE_ESC,
-    TTY_STATE_CSI,
-};
-
-struct QemuConsole {
-    Object parent;
-
-    int index;
-    DisplayState *ds;
-    DisplaySurface *surface;
-    DisplayScanout scanout;
-    int dcls;
-    DisplayGLCtx *gl;
-    int gl_block;
-    QEMUTimer *gl_unblock_timer;
-    int window_id;
-    QemuUIInfo ui_info;
-    QEMUTimer *ui_timer;
-    const GraphicHwOps *hw_ops;
-    void *hw;
-    CoQueue dump_queue;
-
-    QTAILQ_ENTRY(QemuConsole) next;
-};
+#include "console-priv.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(QemuConsole, qemu_console, QEMU_CONSOLE, OBJECT)
 
@@ -108,54 +56,6 @@ typedef QemuConsoleClass QemuGraphicConsoleClass;
 
 OBJECT_DEFINE_TYPE(QemuGraphicConsole, qemu_graphic_console, QEMU_GRAPHIC_CONSOLE, QEMU_CONSOLE)
 
-typedef struct QemuTextConsole {
-    QemuConsole parent;
-
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
-} QemuTextConsole;
-
-typedef QemuConsoleClass QemuTextConsoleClass;
-
-OBJECT_DEFINE_TYPE(QemuTextConsole, qemu_text_console, QEMU_TEXT_CONSOLE, QEMU_CONSOLE)
-
-typedef struct QemuFixedTextConsole {
-    QemuTextConsole parent;
-} QemuFixedTextConsole;
-
-typedef QemuTextConsoleClass QemuFixedTextConsoleClass;
-
-OBJECT_DEFINE_TYPE(QemuFixedTextConsole, qemu_fixed_text_console, QEMU_FIXED_TEXT_CONSOLE, QEMU_TEXT_CONSOLE)
-
-struct VCChardev {
-    Chardev parent;
-    QemuTextConsole *console;
-
-    enum TTYState state;
-    int esc_params[MAX_ESC_PARAMS];
-    int nb_esc_params;
-    TextAttributes t_attrib; /* currently active text attributes */
-    int x_saved, y_saved;
-};
-typedef struct VCChardev VCChardev;
-
 struct DisplayState {
     QEMUTimer *gui_timer;
     uint64_t last_update;
@@ -169,12 +69,9 @@ static DisplayState *display_state;
 static QemuConsole *active_console;
 static QTAILQ_HEAD(, QemuConsole) consoles =
     QTAILQ_HEAD_INITIALIZER(consoles);
-static bool cursor_visible_phase;
-static QEMUTimer *cursor_timer;
 
 static void dpy_refresh(DisplayState *s);
 static DisplayState *get_alloc_displaystate(void);
-static void qemu_text_console_update_cursor(void *opaque);
 static bool displaychangelistener_has_dmabuf(DisplayChangeListener *dcl);
 static bool console_compatible_with(QemuConsole *con,
                                     DisplayChangeListener *dcl, Error **errp);
@@ -330,663 +227,6 @@ void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
     }
 }
 
-static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
-                                   int width, int height, pixman_color_t color)
-{
-    DisplaySurface *surface = qemu_console_surface(con);
-    pixman_rectangle16_t rect = {
-        .x = posx, .y = posy, .width = width, .height = height
-    };
-
-    assert(surface);
-    pixman_image_fill_rectangles(PIXMAN_OP_SRC, surface->image,
-                                 &color, 1, &rect);
-}
-
-/* copy from (xs, ys) to (xd, yd) a rectangle of size (w, h) */
-static void qemu_console_bitblt(QemuConsole *con,
-                                int xs, int ys, int xd, int yd, int w, int h)
-{
-    DisplaySurface *surface = qemu_console_surface(con);
-
-    assert(surface);
-    pixman_image_composite(PIXMAN_OP_SRC,
-                           surface->image, NULL, surface->image,
-                           xs, ys, 0, 0, xd, yd, w, h);
-}
-
-/***********************************************************/
-/* basic char display */
-
-#define FONT_HEIGHT 16
-#define FONT_WIDTH 8
-
-#include "vgafont.h"
-
-static const pixman_color_t color_table_rgb[2][8] = {
-    {   /* dark */
-        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
-        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xaa),  /* blue */
-        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0x00),  /* green */
-        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0xaa),  /* cyan */
-        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0x00),  /* red */
-        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0xaa),  /* magenta */
-        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xaa, 0xaa, 0x00),  /* yellow */
-        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR_GRAY,
-    },
-    {   /* bright */
-        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
-        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xff),  /* blue */
-        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xff, 0x00),  /* green */
-        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xff, 0xff),  /* cyan */
-        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xff, 0x00, 0x00),  /* red */
-        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xff, 0x00, 0xff),  /* magenta */
-        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xff, 0xff, 0x00),  /* yellow */
-        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR(0xff, 0xff, 0xff),  /* white */
-    }
-};
-
-static void vga_putcharxy(QemuConsole *s, int x, int y, int ch,
-                          TextAttributes *t_attrib)
-{
-    static pixman_image_t *glyphs[256];
-    DisplaySurface *surface = qemu_console_surface(s);
-    pixman_color_t fgcol, bgcol;
-
-    assert(surface);
-    if (t_attrib->invers) {
-        bgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
-        fgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
-    } else {
-        fgcol = color_table_rgb[t_attrib->bold][t_attrib->fgcol];
-        bgcol = color_table_rgb[t_attrib->bold][t_attrib->bgcol];
-    }
-
-    if (!glyphs[ch]) {
-        glyphs[ch] = qemu_pixman_glyph_from_vgafont(FONT_HEIGHT, vgafont16, ch);
-    }
-    qemu_pixman_glyph_render(glyphs[ch], surface->image,
-                             &fgcol, &bgcol, x, y, FONT_WIDTH, FONT_HEIGHT);
-}
-
-static void text_console_resize(QemuTextConsole *t)
-{
-    QemuConsole *s = QEMU_CONSOLE(t);
-    TextCell *cells, *c, *c1;
-    int w1, x, y, last_width, w, h;
-
-    assert(s->scanout.kind == SCANOUT_SURFACE);
-
-    w = surface_width(s->surface) / FONT_WIDTH;
-    h = surface_height(s->surface) / FONT_HEIGHT;
-    if (w == t->width && h == t->height) {
-        return;
-    }
-
-    last_width = t->width;
-    t->width = w;
-    t->height = h;
-
-    w1 = MIN(t->width, last_width);
-
-    cells = g_new(TextCell, t->width * t->total_height + 1);
-    for (y = 0; y < t->total_height; y++) {
-        c = &cells[y * t->width];
-        if (w1 > 0) {
-            c1 = &t->cells[y * last_width];
-            for (x = 0; x < w1; x++) {
-                *c++ = *c1++;
-            }
-        }
-        for (x = w1; x < t->width; x++) {
-            c->ch = ' ';
-            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-            c++;
-        }
-    }
-    g_free(t->cells);
-    t->cells = cells;
-}
-
-static void invalidate_xy(QemuTextConsole *s, int x, int y)
-{
-    if (!qemu_console_is_visible(QEMU_CONSOLE(s))) {
-        return;
-    }
-    if (s->update_x0 > x * FONT_WIDTH)
-        s->update_x0 = x * FONT_WIDTH;
-    if (s->update_y0 > y * FONT_HEIGHT)
-        s->update_y0 = y * FONT_HEIGHT;
-    if (s->update_x1 < (x + 1) * FONT_WIDTH)
-        s->update_x1 = (x + 1) * FONT_WIDTH;
-    if (s->update_y1 < (y + 1) * FONT_HEIGHT)
-        s->update_y1 = (y + 1) * FONT_HEIGHT;
-}
-
-static void vc_update_xy(VCChardev *vc, int x, int y)
-{
-    QemuTextConsole *s = vc->console;
-    TextCell *c;
-    int y1, y2;
-
-    s->text_x[0] = MIN(s->text_x[0], x);
-    s->text_x[1] = MAX(s->text_x[1], x);
-    s->text_y[0] = MIN(s->text_y[0], y);
-    s->text_y[1] = MAX(s->text_y[1], y);
-
-    y1 = (s->y_base + y) % s->total_height;
-    y2 = y1 - s->y_displayed;
-    if (y2 < 0) {
-        y2 += s->total_height;
-    }
-    if (y2 < s->height) {
-        if (x >= s->width) {
-            x = s->width - 1;
-        }
-        c = &s->cells[y1 * s->width + x];
-        vga_putcharxy(QEMU_CONSOLE(s), x, y2, c->ch,
-                      &(c->t_attrib));
-        invalidate_xy(s, x, y2);
-    }
-}
-
-static void console_show_cursor(QemuTextConsole *s, int show)
-{
-    TextCell *c;
-    int y, y1;
-    int x = s->x;
-
-    s->cursor_invalidate = 1;
-
-    if (x >= s->width) {
-        x = s->width - 1;
-    }
-    y1 = (s->y_base + s->y) % s->total_height;
-    y = y1 - s->y_displayed;
-    if (y < 0) {
-        y += s->total_height;
-    }
-    if (y < s->height) {
-        c = &s->cells[y1 * s->width + x];
-        if (show && cursor_visible_phase) {
-            TextAttributes t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-            t_attrib.invers = !(t_attrib.invers); /* invert fg and bg */
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &t_attrib);
-        } else {
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch, &(c->t_attrib));
-        }
-        invalidate_xy(s, x, y);
-    }
-}
-
-static void console_refresh(QemuTextConsole *s)
-{
-    DisplaySurface *surface = qemu_console_surface(QEMU_CONSOLE(s));
-    TextCell *c;
-    int x, y, y1;
-
-    assert(surface);
-    s->text_x[0] = 0;
-    s->text_y[0] = 0;
-    s->text_x[1] = s->width - 1;
-    s->text_y[1] = s->height - 1;
-    s->cursor_invalidate = 1;
-
-    qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
-                           color_table_rgb[0][QEMU_COLOR_BLACK]);
-    y1 = s->y_displayed;
-    for (y = 0; y < s->height; y++) {
-        c = s->cells + y1 * s->width;
-        for (x = 0; x < s->width; x++) {
-            vga_putcharxy(QEMU_CONSOLE(s), x, y, c->ch,
-                          &(c->t_attrib));
-            c++;
-        }
-        if (++y1 == s->total_height) {
-            y1 = 0;
-        }
-    }
-    console_show_cursor(s, 1);
-    dpy_gfx_update(QEMU_CONSOLE(s), 0, 0,
-                   surface_width(surface), surface_height(surface));
-}
-
-static void console_scroll(QemuTextConsole *s, int ydelta)
-{
-    int i, y1;
-
-    if (ydelta > 0) {
-        for(i = 0; i < ydelta; i++) {
-            if (s->y_displayed == s->y_base)
-                break;
-            if (++s->y_displayed == s->total_height)
-                s->y_displayed = 0;
-        }
-    } else {
-        ydelta = -ydelta;
-        i = s->backscroll_height;
-        if (i > s->total_height - s->height)
-            i = s->total_height - s->height;
-        y1 = s->y_base - i;
-        if (y1 < 0)
-            y1 += s->total_height;
-        for(i = 0; i < ydelta; i++) {
-            if (s->y_displayed == y1)
-                break;
-            if (--s->y_displayed < 0)
-                s->y_displayed = s->total_height - 1;
-        }
-    }
-    console_refresh(s);
-}
-
-static void vc_put_lf(VCChardev *vc)
-{
-    QemuTextConsole *s = vc->console;
-    TextCell *c;
-    int x, y1;
-
-    s->y++;
-    if (s->y >= s->height) {
-        s->y = s->height - 1;
-
-        if (s->y_displayed == s->y_base) {
-            if (++s->y_displayed == s->total_height)
-                s->y_displayed = 0;
-        }
-        if (++s->y_base == s->total_height)
-            s->y_base = 0;
-        if (s->backscroll_height < s->total_height)
-            s->backscroll_height++;
-        y1 = (s->y_base + s->height - 1) % s->total_height;
-        c = &s->cells[y1 * s->width];
-        for(x = 0; x < s->width; x++) {
-            c->ch = ' ';
-            c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-            c++;
-        }
-        if (s->y_displayed == s->y_base) {
-            s->text_x[0] = 0;
-            s->text_y[0] = 0;
-            s->text_x[1] = s->width - 1;
-            s->text_y[1] = s->height - 1;
-
-            qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
-                                s->width * FONT_WIDTH,
-                                (s->height - 1) * FONT_HEIGHT);
-            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
-                                   s->width * FONT_WIDTH, FONT_HEIGHT,
-                                   color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
-            s->update_x0 = 0;
-            s->update_y0 = 0;
-            s->update_x1 = s->width * FONT_WIDTH;
-            s->update_y1 = s->height * FONT_HEIGHT;
-        }
-    }
-}
-
-/* Set console attributes depending on the current escape codes.
- * NOTE: I know this code is not very efficient (checking every color for it
- * self) but it is more readable and better maintainable.
- */
-static void vc_handle_escape(VCChardev *vc)
-{
-    int i;
-
-    for (i = 0; i < vc->nb_esc_params; i++) {
-        switch (vc->esc_params[i]) {
-            case 0: /* reset all console attributes to default */
-                vc->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-                break;
-            case 1:
-                vc->t_attrib.bold = 1;
-                break;
-            case 4:
-                vc->t_attrib.uline = 1;
-                break;
-            case 5:
-                vc->t_attrib.blink = 1;
-                break;
-            case 7:
-                vc->t_attrib.invers = 1;
-                break;
-            case 8:
-                vc->t_attrib.unvisible = 1;
-                break;
-            case 22:
-                vc->t_attrib.bold = 0;
-                break;
-            case 24:
-                vc->t_attrib.uline = 0;
-                break;
-            case 25:
-                vc->t_attrib.blink = 0;
-                break;
-            case 27:
-                vc->t_attrib.invers = 0;
-                break;
-            case 28:
-                vc->t_attrib.unvisible = 0;
-                break;
-            /* set foreground color */
-            case 30:
-                vc->t_attrib.fgcol = QEMU_COLOR_BLACK;
-                break;
-            case 31:
-                vc->t_attrib.fgcol = QEMU_COLOR_RED;
-                break;
-            case 32:
-                vc->t_attrib.fgcol = QEMU_COLOR_GREEN;
-                break;
-            case 33:
-                vc->t_attrib.fgcol = QEMU_COLOR_YELLOW;
-                break;
-            case 34:
-                vc->t_attrib.fgcol = QEMU_COLOR_BLUE;
-                break;
-            case 35:
-                vc->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
-                break;
-            case 36:
-                vc->t_attrib.fgcol = QEMU_COLOR_CYAN;
-                break;
-            case 37:
-                vc->t_attrib.fgcol = QEMU_COLOR_WHITE;
-                break;
-            /* set background color */
-            case 40:
-                vc->t_attrib.bgcol = QEMU_COLOR_BLACK;
-                break;
-            case 41:
-                vc->t_attrib.bgcol = QEMU_COLOR_RED;
-                break;
-            case 42:
-                vc->t_attrib.bgcol = QEMU_COLOR_GREEN;
-                break;
-            case 43:
-                vc->t_attrib.bgcol = QEMU_COLOR_YELLOW;
-                break;
-            case 44:
-                vc->t_attrib.bgcol = QEMU_COLOR_BLUE;
-                break;
-            case 45:
-                vc->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
-                break;
-            case 46:
-                vc->t_attrib.bgcol = QEMU_COLOR_CYAN;
-                break;
-            case 47:
-                vc->t_attrib.bgcol = QEMU_COLOR_WHITE;
-                break;
-        }
-    }
-}
-
-static void vc_clear_xy(VCChardev *vc, int x, int y)
-{
-    QemuTextConsole *s = vc->console;
-    int y1 = (s->y_base + y) % s->total_height;
-    if (x >= s->width) {
-        x = s->width - 1;
-    }
-    TextCell *c = &s->cells[y1 * s->width + x];
-    c->ch = ' ';
-    c->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
-    vc_update_xy(vc, x, y);
-}
-
-static void vc_put_one(VCChardev *vc, int ch)
-{
-    QemuTextConsole *s = vc->console;
-    TextCell *c;
-    int y1;
-    if (s->x >= s->width) {
-        /* line wrap */
-        s->x = 0;
-        vc_put_lf(vc);
-    }
-    y1 = (s->y_base + s->y) % s->total_height;
-    c = &s->cells[y1 * s->width + s->x];
-    c->ch = ch;
-    c->t_attrib = vc->t_attrib;
-    vc_update_xy(vc, s->x, s->y);
-    s->x++;
-}
-
-static void vc_respond_str(VCChardev *vc, const char *buf)
-{
-    while (*buf) {
-        vc_put_one(vc, *buf);
-        buf++;
-    }
-}
-
-/* set cursor, checking bounds */
-static void vc_set_cursor(VCChardev *vc, int x, int y)
-{
-    QemuTextConsole *s = vc->console;
-
-    if (x < 0) {
-        x = 0;
-    }
-    if (y < 0) {
-        y = 0;
-    }
-    if (y >= s->height) {
-        y = s->height - 1;
-    }
-    if (x >= s->width) {
-        x = s->width - 1;
-    }
-
-    s->x = x;
-    s->y = y;
-}
-
-static void vc_putchar(VCChardev *vc, int ch)
-{
-    QemuTextConsole *s = vc->console;
-    int i;
-    int x, y;
-    char response[40];
-
-    switch(vc->state) {
-    case TTY_STATE_NORM:
-        switch(ch) {
-        case '\r':  /* carriage return */
-            s->x = 0;
-            break;
-        case '\n':  /* newline */
-            vc_put_lf(vc);
-            break;
-        case '\b':  /* backspace */
-            if (s->x > 0)
-                s->x--;
-            break;
-        case '\t':  /* tabspace */
-            if (s->x + (8 - (s->x % 8)) > s->width) {
-                s->x = 0;
-                vc_put_lf(vc);
-            } else {
-                s->x = s->x + (8 - (s->x % 8));
-            }
-            break;
-        case '\a':  /* alert aka. bell */
-            /* TODO: has to be implemented */
-            break;
-        case 14:
-            /* SI (shift in), character set 0 (ignored) */
-            break;
-        case 15:
-            /* SO (shift out), character set 1 (ignored) */
-            break;
-        case 27:    /* esc (introducing an escape sequence) */
-            vc->state = TTY_STATE_ESC;
-            break;
-        default:
-            vc_put_one(vc, ch);
-            break;
-        }
-        break;
-    case TTY_STATE_ESC: /* check if it is a terminal escape sequence */
-        if (ch == '[') {
-            for(i=0;i<MAX_ESC_PARAMS;i++)
-                vc->esc_params[i] = 0;
-            vc->nb_esc_params = 0;
-            vc->state = TTY_STATE_CSI;
-        } else {
-            vc->state = TTY_STATE_NORM;
-        }
-        break;
-    case TTY_STATE_CSI: /* handle escape sequence parameters */
-        if (ch >= '0' && ch <= '9') {
-            if (vc->nb_esc_params < MAX_ESC_PARAMS) {
-                int *param = &vc->esc_params[vc->nb_esc_params];
-                int digit = (ch - '0');
-
-                *param = (*param <= (INT_MAX - digit) / 10) ?
-                         *param * 10 + digit : INT_MAX;
-            }
-        } else {
-            if (vc->nb_esc_params < MAX_ESC_PARAMS)
-                vc->nb_esc_params++;
-            if (ch == ';' || ch == '?') {
-                break;
-            }
-            trace_console_putchar_csi(vc->esc_params[0], vc->esc_params[1],
-                                      ch, vc->nb_esc_params);
-            vc->state = TTY_STATE_NORM;
-            switch(ch) {
-            case 'A':
-                /* move cursor up */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
-                }
-                vc_set_cursor(vc, s->x, s->y - vc->esc_params[0]);
-                break;
-            case 'B':
-                /* move cursor down */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
-                }
-                vc_set_cursor(vc, s->x, s->y + vc->esc_params[0]);
-                break;
-            case 'C':
-                /* move cursor right */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
-                }
-                vc_set_cursor(vc, s->x + vc->esc_params[0], s->y);
-                break;
-            case 'D':
-                /* move cursor left */
-                if (vc->esc_params[0] == 0) {
-                    vc->esc_params[0] = 1;
-                }
-                vc_set_cursor(vc, s->x - vc->esc_params[0], s->y);
-                break;
-            case 'G':
-                /* move cursor to column */
-                vc_set_cursor(vc, vc->esc_params[0] - 1, s->y);
-                break;
-            case 'f':
-            case 'H':
-                /* move cursor to row, column */
-                vc_set_cursor(vc, vc->esc_params[1] - 1, vc->esc_params[0] - 1);
-                break;
-            case 'J':
-                switch (vc->esc_params[0]) {
-                case 0:
-                    /* clear to end of screen */
-                    for (y = s->y; y < s->height; y++) {
-                        for (x = 0; x < s->width; x++) {
-                            if (y == s->y && x < s->x) {
-                                continue;
-                            }
-                            vc_clear_xy(vc, x, y);
-                        }
-                    }
-                    break;
-                case 1:
-                    /* clear from beginning of screen */
-                    for (y = 0; y <= s->y; y++) {
-                        for (x = 0; x < s->width; x++) {
-                            if (y == s->y && x > s->x) {
-                                break;
-                            }
-                            vc_clear_xy(vc, x, y);
-                        }
-                    }
-                    break;
-                case 2:
-                    /* clear entire screen */
-                    for (y = 0; y <= s->height; y++) {
-                        for (x = 0; x < s->width; x++) {
-                            vc_clear_xy(vc, x, y);
-                        }
-                    }
-                    break;
-                }
-                break;
-            case 'K':
-                switch (vc->esc_params[0]) {
-                case 0:
-                    /* clear to eol */
-                    for(x = s->x; x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
-                    }
-                    break;
-                case 1:
-                    /* clear from beginning of line */
-                    for (x = 0; x <= s->x && x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
-                    }
-                    break;
-                case 2:
-                    /* clear entire line */
-                    for(x = 0; x < s->width; x++) {
-                        vc_clear_xy(vc, x, s->y);
-                    }
-                    break;
-                }
-                break;
-            case 'm':
-                vc_handle_escape(vc);
-                break;
-            case 'n':
-                switch (vc->esc_params[0]) {
-                case 5:
-                    /* report console status (always succeed)*/
-                    vc_respond_str(vc, "\033[0n");
-                    break;
-                case 6:
-                    /* report cursor position */
-                    sprintf(response, "\033[%d;%dR",
-                           (s->y_base + s->y) % s->total_height + 1,
-                            s->x + 1);
-                    vc_respond_str(vc, response);
-                    break;
-                }
-                break;
-            case 's':
-                /* save cursor position */
-                vc->x_saved = s->x;
-                vc->y_saved = s->y;
-                break;
-            case 'u':
-                /* restore cursor position */
-                s->x = vc->x_saved;
-                s->y = vc->y_saved;
-                break;
-            default:
-                trace_console_putchar_unhandled(ch);
-                break;
-            }
-            break;
-        }
-    }
-}
-
 static void displaychangelistener_gfx_switch(DisplayChangeListener *dcl,
                                              struct DisplaySurface *new_surface,
                                              bool update)
@@ -1065,13 +305,6 @@ static void displaychangelistener_display_console(DisplayChangeListener *dcl,
     }
 }
 
-static void
-qemu_text_console_select(QemuTextConsole *c)
-{
-    dpy_text_resize(QEMU_CONSOLE(c), c->width, c->height);
-    qemu_text_console_update_cursor(NULL);
-}
-
 void console_select(unsigned int index)
 {
     DisplayChangeListener *dcl;
@@ -1096,101 +329,6 @@ void console_select(unsigned int index)
     }
 }
 
-#define TYPE_CHARDEV_VC "chardev-vc"
-DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
-                         TYPE_CHARDEV_VC)
-
-static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
-{
-    VCChardev *drv = VC_CHARDEV(chr);
-    QemuTextConsole *s = drv->console;
-    int i;
-
-    s->update_x0 = s->width * FONT_WIDTH;
-    s->update_y0 = s->height * FONT_HEIGHT;
-    s->update_x1 = 0;
-    s->update_y1 = 0;
-    console_show_cursor(s, 0);
-    for(i = 0; i < len; i++) {
-        vc_putchar(drv, buf[i]);
-    }
-    console_show_cursor(s, 1);
-    if (s->update_x0 < s->update_x1) {
-        dpy_gfx_update(QEMU_CONSOLE(s), s->update_x0, s->update_y0,
-                       s->update_x1 - s->update_x0,
-                       s->update_y1 - s->update_y0);
-    }
-    return len;
-}
-
-static void kbd_send_chars(QemuTextConsole *s)
-{
-    uint32_t len, avail;
-
-    len = qemu_chr_be_can_write(s->chr);
-    avail = fifo8_num_used(&s->out_fifo);
-    while (len > 0 && avail > 0) {
-        const uint8_t *buf;
-        uint32_t size;
-
-        buf = fifo8_pop_buf(&s->out_fifo, MIN(len, avail), &size);
-        qemu_chr_be_write(s->chr, buf, size);
-        len = qemu_chr_be_can_write(s->chr);
-        avail -= size;
-    }
-}
-
-/* called when an ascii key is pressed */
-static void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
-{
-    uint8_t buf[16], *q;
-    int c;
-    uint32_t num_free;
-
-    switch(keysym) {
-    case QEMU_KEY_CTRL_UP:
-        console_scroll(s, -1);
-        break;
-    case QEMU_KEY_CTRL_DOWN:
-        console_scroll(s, 1);
-        break;
-    case QEMU_KEY_CTRL_PAGEUP:
-        console_scroll(s, -10);
-        break;
-    case QEMU_KEY_CTRL_PAGEDOWN:
-        console_scroll(s, 10);
-        break;
-    default:
-        /* convert the QEMU keysym to VT100 key string */
-        q = buf;
-        if (keysym >= 0xe100 && keysym <= 0xe11f) {
-            *q++ = '\033';
-            *q++ = '[';
-            c = keysym - 0xe100;
-            if (c >= 10)
-                *q++ = '0' + (c / 10);
-            *q++ = '0' + (c % 10);
-            *q++ = '~';
-        } else if (keysym >= 0xe120 && keysym <= 0xe17f) {
-            *q++ = '\033';
-            *q++ = '[';
-            *q++ = keysym & 0xff;
-        } else if (s->echo && (keysym == '\r' || keysym == '\n')) {
-            qemu_chr_write(s->chr, (uint8_t *)"\r", 1, true);
-            *q++ = '\n';
-        } else {
-            *q++ = keysym;
-        }
-        if (s->echo) {
-            qemu_chr_write(s->chr, buf, q - buf, true);
-        }
-        num_free = fifo8_num_free(&s->out_fifo);
-        fifo8_push_all(&s->out_fifo, buf, MIN(num_free, q - buf));
-        kbd_send_chars(s);
-        break;
-    }
-}
-
 void qemu_text_console_put_keysym(QemuTextConsole *s, int keysym)
 {
     if (!s) {
@@ -1249,45 +387,6 @@ void qemu_text_console_put_string(QemuTextConsole *s, const char *str, int len)
     }
 }
 
-static void text_console_invalidate(void *opaque)
-{
-    QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
-
-    if (!QEMU_IS_FIXED_TEXT_CONSOLE(s)) {
-        text_console_resize(QEMU_TEXT_CONSOLE(s));
-    }
-    console_refresh(s);
-}
-
-static void text_console_update(void *opaque, console_ch_t *chardata)
-{
-    QemuTextConsole *s = QEMU_TEXT_CONSOLE(opaque);
-    int i, j, src;
-
-    if (s->text_x[0] <= s->text_x[1]) {
-        src = (s->y_base + s->text_y[0]) * s->width;
-        chardata += s->text_y[0] * s->width;
-        for (i = s->text_y[0]; i <= s->text_y[1]; i ++)
-            for (j = 0; j < s->width; j++, src++) {
-                console_write_ch(chardata ++,
-                                 ATTR2CHTYPE(s->cells[src].ch,
-                                             s->cells[src].t_attrib.fgcol,
-                                             s->cells[src].t_attrib.bgcol,
-                                             s->cells[src].t_attrib.bold));
-            }
-        dpy_text_update(QEMU_CONSOLE(s), s->text_x[0], s->text_y[0],
-                        s->text_x[1] - s->text_x[0], i - s->text_y[0]);
-        s->text_x[0] = s->width;
-        s->text_y[0] = s->height;
-        s->text_x[1] = 0;
-        s->text_y[1] = 0;
-    }
-    if (s->cursor_invalidate) {
-        dpy_text_cursor(QEMU_CONSOLE(s), s->x, s->y);
-        s->cursor_invalidate = 0;
-    }
-}
-
 static void
 qemu_console_register(QemuConsole *c)
 {
@@ -1396,51 +495,6 @@ qemu_graphic_console_init(Object *obj)
 {
 }
 
-static void
-qemu_text_console_finalize(Object *obj)
-{
-}
-
-static void
-qemu_text_console_class_init(ObjectClass *oc, void *data)
-{
-    if (!cursor_timer) {
-        cursor_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
-                                    qemu_text_console_update_cursor, NULL);
-    }
-}
-
-static const GraphicHwOps text_console_ops = {
-    .invalidate  = text_console_invalidate,
-    .text_update = text_console_update,
-};
-
-static void
-qemu_text_console_init(Object *obj)
-{
-    QemuTextConsole *c = QEMU_TEXT_CONSOLE(obj);
-
-    fifo8_create(&c->out_fifo, 16);
-    c->total_height = DEFAULT_BACKSCROLL;
-    QEMU_CONSOLE(c)->hw_ops = &text_console_ops;
-    QEMU_CONSOLE(c)->hw = c;
-}
-
-static void
-qemu_fixed_text_console_finalize(Object *obj)
-{
-}
-
-static void
-qemu_fixed_text_console_class_init(ObjectClass *oc, void *data)
-{
-}
-
-static void
-qemu_fixed_text_console_init(Object *obj)
-{
-}
-
 #ifdef WIN32
 void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
                                           HANDLE h, uint32_t offset)
@@ -1692,6 +746,7 @@ dcl_set_graphic_cursor(DisplayChangeListener *dcl, QemuGraphicConsole *con)
         dcl->ops->dpy_mouse_set(dcl, con->cursor_x, con->cursor_y, con->cursor_on);
     }
 }
+
 void register_displaychangelistener(DisplayChangeListener *dcl)
 {
     QemuConsole *con;
@@ -1712,7 +767,7 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
     if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
         dcl_set_graphic_cursor(dcl, QEMU_GRAPHIC_CONSOLE(con));
     }
-    qemu_text_console_update_cursor(NULL);
+    qemu_text_console_update_cursor();
 }
 
 void update_displaychangelistener(DisplayChangeListener *dcl,
@@ -2399,13 +1454,6 @@ bool qemu_console_is_multihead(DeviceState *dev)
     return false;
 }
 
-
-static const char *
-qemu_text_console_get_label(QemuTextConsole *c)
-{
-    return c->chr ? c->chr->label : NULL;
-}
-
 char *qemu_console_get_label(QemuConsole *con)
 {
     if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
@@ -2500,20 +1548,6 @@ int qemu_console_get_height(QemuConsole *con, int fallback)
     }
 }
 
-static void vc_chr_accept_input(Chardev *chr)
-{
-    VCChardev *drv = VC_CHARDEV(chr);
-
-    kbd_send_chars(drv->console);
-}
-
-static void vc_chr_set_echo(Chardev *chr, bool echo)
-{
-    VCChardev *drv = VC_CHARDEV(chr);
-
-    drv->console->echo = echo;
-}
-
 int qemu_invalidate_text_consoles(void)
 {
     QemuConsole *s;
@@ -2531,70 +1565,6 @@ int qemu_invalidate_text_consoles(void)
     return count;
 }
 
-static void qemu_text_console_update_cursor(void *opaque)
-{
-    cursor_visible_phase = !cursor_visible_phase;
-
-    if (qemu_invalidate_text_consoles()) {
-        timer_mod(cursor_timer,
-                  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + CONSOLE_CURSOR_PERIOD / 2);
-    }
-}
-
-static void vc_chr_open(Chardev *chr,
-                        ChardevBackend *backend,
-                        bool *be_opened,
-                        Error **errp)
-{
-    ChardevVC *vc = backend->u.vc.data;
-    VCChardev *drv = VC_CHARDEV(chr);
-    QemuTextConsole *s;
-    unsigned width = 0;
-    unsigned height = 0;
-
-    if (vc->has_width) {
-        width = vc->width;
-    } else if (vc->has_cols) {
-        width = vc->cols * FONT_WIDTH;
-    }
-
-    if (vc->has_height) {
-        height = vc->height;
-    } else if (vc->has_rows) {
-        height = vc->rows * FONT_HEIGHT;
-    }
-
-    trace_console_txt_new(width, height);
-    if (width == 0 || height == 0) {
-        s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_TEXT_CONSOLE));
-        width = qemu_console_get_width(NULL, 80 * FONT_WIDTH);
-        height = qemu_console_get_height(NULL, 24 * FONT_HEIGHT);
-    } else {
-        s = QEMU_TEXT_CONSOLE(object_new(TYPE_QEMU_FIXED_TEXT_CONSOLE));
-    }
-
-    dpy_gfx_replace_surface(QEMU_CONSOLE(s), qemu_create_displaysurface(width, height));
-
-    s->chr = chr;
-    drv->console = s;
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
-    *be_opened = true;
-}
-
 void qemu_console_resize(QemuConsole *s, int width, int height)
 {
     DisplaySurface *surface = qemu_console_surface(s);
@@ -2721,63 +1691,3 @@ void qemu_display_help(void)
         }
     }
 }
-
-static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
-{
-    int val;
-    ChardevVC *vc;
-
-    backend->type = CHARDEV_BACKEND_KIND_VC;
-    vc = backend->u.vc.data = g_new0(ChardevVC, 1);
-    qemu_chr_parse_common(opts, qapi_ChardevVC_base(vc));
-
-    val = qemu_opt_get_number(opts, "width", 0);
-    if (val != 0) {
-        vc->has_width = true;
-        vc->width = val;
-    }
-
-    val = qemu_opt_get_number(opts, "height", 0);
-    if (val != 0) {
-        vc->has_height = true;
-        vc->height = val;
-    }
-
-    val = qemu_opt_get_number(opts, "cols", 0);
-    if (val != 0) {
-        vc->has_cols = true;
-        vc->cols = val;
-    }
-
-    val = qemu_opt_get_number(opts, "rows", 0);
-    if (val != 0) {
-        vc->has_rows = true;
-        vc->rows = val;
-    }
-}
-
-static void char_vc_class_init(ObjectClass *oc, void *data)
-{
-    ChardevClass *cc = CHARDEV_CLASS(oc);
-
-    cc->parse = vc_chr_parse;
-    cc->open = vc_chr_open;
-    cc->chr_write = vc_chr_write;
-    cc->chr_accept_input = vc_chr_accept_input;
-    cc->chr_set_echo = vc_chr_set_echo;
-}
-
-static const TypeInfo char_vc_type_info = {
-    .name = TYPE_CHARDEV_VC,
-    .parent = TYPE_CHARDEV,
-    .instance_size = sizeof(VCChardev),
-    .class_init = char_vc_class_init,
-};
-
-void qemu_console_early_init(void)
-{
-    /* set the default vc driver */
-    if (!object_class_by_name(TYPE_CHARDEV_VC)) {
-        type_register(&char_vc_type_info);
-    }
-}
diff --git a/ui/meson.build b/ui/meson.build
index d81609fb0e..0a1e8272a3 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -6,6 +6,7 @@ system_ss.add(png)
 system_ss.add(files(
   'clipboard.c',
   'console.c',
+  'console-vc.c',
   'cursor.c',
   'input-keymap.c',
   'input-legacy.c',
-- 
2.41.0


