Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 046A179167D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd89i-00030B-Jb; Mon, 04 Sep 2023 07:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89d-0002uQ-Sh
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd89a-0008Pd-8l
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTBrJC8D1PkYdpQFXHid33Rd32afenRNUdHCc6ngp/Q=;
 b=MPjENGfNhvRWrh7SIpjEtGGePwBv+zHSsRmdnS3nJJMAEBsSKeaPpKn9HGbxg47T23+5bf
 YutUDOq770HGh4K/0ESE9+5ALMeb2XvllziztJ689aTdQ5dskwvhz2oBtN3SDgvuGZxf3t
 ZZfMcmfDEXOjsNSC+bUoRFKUdXU17Do=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-679-D-1tpXzVPTejyKhFwgVgyg-1; Mon, 04 Sep 2023 07:53:58 -0400
X-MC-Unique: D-1tpXzVPTejyKhFwgVgyg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 442C98008A4
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:53:58 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBD88493110;
 Mon,  4 Sep 2023 11:53:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 16/52] ui/vc: move VCCharDev specific fields out of QemuConsole
Date: Mon,  4 Sep 2023 15:52:13 +0400
Message-ID: <20230904115251.4161397-17-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
Message-Id: <20230830093843.3531473-17-marcandre.lureau@redhat.com>
---
 ui/console.c | 147 +++++++++++++++++++++++++--------------------------
 1 file changed, 73 insertions(+), 74 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index f9ed012e1c..1336a1be6c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -106,10 +106,8 @@ struct QemuConsole {
     int total_height;
     int backscroll_height;
     int x, y;
-    int x_saved, y_saved;
     int y_displayed;
     int y_base;
-    TextAttributes t_attrib; /* currently active text attributes */
     TextCell *cells;
     int text_x[2], text_y[2], cursor_invalidate;
     int echo;
@@ -119,10 +117,6 @@ struct QemuConsole {
     int update_x1;
     int update_y1;
 
-    enum TTYState state;
-    int esc_params[MAX_ESC_PARAMS];
-    int nb_esc_params;
-
     Chardev *chr;
     /* fifo for key pressed */
     Fifo8 out_fifo;
@@ -134,6 +128,12 @@ struct QemuConsole {
 struct VCChardev {
     Chardev parent;
     QemuConsole *console;
+
+    enum TTYState state;
+    int esc_params[MAX_ESC_PARAMS];
+    int nb_esc_params;
+    TextAttributes t_attrib; /* currently active text attributes */
+    int x_saved, y_saved;
 };
 typedef struct VCChardev VCChardev;
 
@@ -607,93 +607,92 @@ static void vc_put_lf(VCChardev *vc)
  */
 static void vc_handle_escape(VCChardev *vc)
 {
-    QemuConsole *s = vc->console;
     int i;
 
-    for (i=0; i<s->nb_esc_params; i++) {
-        switch (s->esc_params[i]) {
+    for (i = 0; i < vc->nb_esc_params; i++) {
+        switch (vc->esc_params[i]) {
             case 0: /* reset all console attributes to default */
-                s->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+                vc->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
                 break;
             case 1:
-                s->t_attrib.bold = 1;
+                vc->t_attrib.bold = 1;
                 break;
             case 4:
-                s->t_attrib.uline = 1;
+                vc->t_attrib.uline = 1;
                 break;
             case 5:
-                s->t_attrib.blink = 1;
+                vc->t_attrib.blink = 1;
                 break;
             case 7:
-                s->t_attrib.invers = 1;
+                vc->t_attrib.invers = 1;
                 break;
             case 8:
-                s->t_attrib.unvisible = 1;
+                vc->t_attrib.unvisible = 1;
                 break;
             case 22:
-                s->t_attrib.bold = 0;
+                vc->t_attrib.bold = 0;
                 break;
             case 24:
-                s->t_attrib.uline = 0;
+                vc->t_attrib.uline = 0;
                 break;
             case 25:
-                s->t_attrib.blink = 0;
+                vc->t_attrib.blink = 0;
                 break;
             case 27:
-                s->t_attrib.invers = 0;
+                vc->t_attrib.invers = 0;
                 break;
             case 28:
-                s->t_attrib.unvisible = 0;
+                vc->t_attrib.unvisible = 0;
                 break;
             /* set foreground color */
             case 30:
-                s->t_attrib.fgcol = QEMU_COLOR_BLACK;
+                vc->t_attrib.fgcol = QEMU_COLOR_BLACK;
                 break;
             case 31:
-                s->t_attrib.fgcol = QEMU_COLOR_RED;
+                vc->t_attrib.fgcol = QEMU_COLOR_RED;
                 break;
             case 32:
-                s->t_attrib.fgcol = QEMU_COLOR_GREEN;
+                vc->t_attrib.fgcol = QEMU_COLOR_GREEN;
                 break;
             case 33:
-                s->t_attrib.fgcol = QEMU_COLOR_YELLOW;
+                vc->t_attrib.fgcol = QEMU_COLOR_YELLOW;
                 break;
             case 34:
-                s->t_attrib.fgcol = QEMU_COLOR_BLUE;
+                vc->t_attrib.fgcol = QEMU_COLOR_BLUE;
                 break;
             case 35:
-                s->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
+                vc->t_attrib.fgcol = QEMU_COLOR_MAGENTA;
                 break;
             case 36:
-                s->t_attrib.fgcol = QEMU_COLOR_CYAN;
+                vc->t_attrib.fgcol = QEMU_COLOR_CYAN;
                 break;
             case 37:
-                s->t_attrib.fgcol = QEMU_COLOR_WHITE;
+                vc->t_attrib.fgcol = QEMU_COLOR_WHITE;
                 break;
             /* set background color */
             case 40:
-                s->t_attrib.bgcol = QEMU_COLOR_BLACK;
+                vc->t_attrib.bgcol = QEMU_COLOR_BLACK;
                 break;
             case 41:
-                s->t_attrib.bgcol = QEMU_COLOR_RED;
+                vc->t_attrib.bgcol = QEMU_COLOR_RED;
                 break;
             case 42:
-                s->t_attrib.bgcol = QEMU_COLOR_GREEN;
+                vc->t_attrib.bgcol = QEMU_COLOR_GREEN;
                 break;
             case 43:
-                s->t_attrib.bgcol = QEMU_COLOR_YELLOW;
+                vc->t_attrib.bgcol = QEMU_COLOR_YELLOW;
                 break;
             case 44:
-                s->t_attrib.bgcol = QEMU_COLOR_BLUE;
+                vc->t_attrib.bgcol = QEMU_COLOR_BLUE;
                 break;
             case 45:
-                s->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
+                vc->t_attrib.bgcol = QEMU_COLOR_MAGENTA;
                 break;
             case 46:
-                s->t_attrib.bgcol = QEMU_COLOR_CYAN;
+                vc->t_attrib.bgcol = QEMU_COLOR_CYAN;
                 break;
             case 47:
-                s->t_attrib.bgcol = QEMU_COLOR_WHITE;
+                vc->t_attrib.bgcol = QEMU_COLOR_WHITE;
                 break;
         }
     }
@@ -725,7 +724,7 @@ static void vc_put_one(VCChardev *vc, int ch)
     y1 = (s->y_base + s->y) % s->total_height;
     c = &s->cells[y1 * s->width + s->x];
     c->ch = ch;
-    c->t_attrib = s->t_attrib;
+    c->t_attrib = vc->t_attrib;
     vc_update_xy(vc, s->x, s->y);
     s->x++;
 }
@@ -767,7 +766,7 @@ static void vc_putchar(VCChardev *vc, int ch)
     int x, y;
     char response[40];
 
-    switch(s->state) {
+    switch(vc->state) {
     case TTY_STATE_NORM:
         switch(ch) {
         case '\r':  /* carriage return */
@@ -798,7 +797,7 @@ static void vc_putchar(VCChardev *vc, int ch)
             /* SO (shift out), character set 1 (ignored) */
             break;
         case 27:    /* esc (introducing an escape sequence) */
-            s->state = TTY_STATE_ESC;
+            vc->state = TTY_STATE_ESC;
             break;
         default:
             vc_put_one(vc, ch);
@@ -808,71 +807,71 @@ static void vc_putchar(VCChardev *vc, int ch)
     case TTY_STATE_ESC: /* check if it is a terminal escape sequence */
         if (ch == '[') {
             for(i=0;i<MAX_ESC_PARAMS;i++)
-                s->esc_params[i] = 0;
-            s->nb_esc_params = 0;
-            s->state = TTY_STATE_CSI;
+                vc->esc_params[i] = 0;
+            vc->nb_esc_params = 0;
+            vc->state = TTY_STATE_CSI;
         } else {
-            s->state = TTY_STATE_NORM;
+            vc->state = TTY_STATE_NORM;
         }
         break;
     case TTY_STATE_CSI: /* handle escape sequence parameters */
         if (ch >= '0' && ch <= '9') {
-            if (s->nb_esc_params < MAX_ESC_PARAMS) {
-                int *param = &s->esc_params[s->nb_esc_params];
+            if (vc->nb_esc_params < MAX_ESC_PARAMS) {
+                int *param = &vc->esc_params[vc->nb_esc_params];
                 int digit = (ch - '0');
 
                 *param = (*param <= (INT_MAX - digit) / 10) ?
                          *param * 10 + digit : INT_MAX;
             }
         } else {
-            if (s->nb_esc_params < MAX_ESC_PARAMS)
-                s->nb_esc_params++;
+            if (vc->nb_esc_params < MAX_ESC_PARAMS)
+                vc->nb_esc_params++;
             if (ch == ';' || ch == '?') {
                 break;
             }
-            trace_console_putchar_csi(s->esc_params[0], s->esc_params[1],
-                                      ch, s->nb_esc_params);
-            s->state = TTY_STATE_NORM;
+            trace_console_putchar_csi(vc->esc_params[0], vc->esc_params[1],
+                                      ch, vc->nb_esc_params);
+            vc->state = TTY_STATE_NORM;
             switch(ch) {
             case 'A':
                 /* move cursor up */
-                if (s->esc_params[0] == 0) {
-                    s->esc_params[0] = 1;
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x, s->y - s->esc_params[0]);
+                vc_set_cursor(vc, s->x, s->y - vc->esc_params[0]);
                 break;
             case 'B':
                 /* move cursor down */
-                if (s->esc_params[0] == 0) {
-                    s->esc_params[0] = 1;
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x, s->y + s->esc_params[0]);
+                vc_set_cursor(vc, s->x, s->y + vc->esc_params[0]);
                 break;
             case 'C':
                 /* move cursor right */
-                if (s->esc_params[0] == 0) {
-                    s->esc_params[0] = 1;
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x + s->esc_params[0], s->y);
+                vc_set_cursor(vc, s->x + vc->esc_params[0], s->y);
                 break;
             case 'D':
                 /* move cursor left */
-                if (s->esc_params[0] == 0) {
-                    s->esc_params[0] = 1;
+                if (vc->esc_params[0] == 0) {
+                    vc->esc_params[0] = 1;
                 }
-                vc_set_cursor(vc, s->x - s->esc_params[0], s->y);
+                vc_set_cursor(vc, s->x - vc->esc_params[0], s->y);
                 break;
             case 'G':
                 /* move cursor to column */
-                vc_set_cursor(vc, s->esc_params[0] - 1, s->y);
+                vc_set_cursor(vc, vc->esc_params[0] - 1, s->y);
                 break;
             case 'f':
             case 'H':
                 /* move cursor to row, column */
-                vc_set_cursor(vc, s->esc_params[1] - 1, s->esc_params[0] - 1);
+                vc_set_cursor(vc, vc->esc_params[1] - 1, vc->esc_params[0] - 1);
                 break;
             case 'J':
-                switch (s->esc_params[0]) {
+                switch (vc->esc_params[0]) {
                 case 0:
                     /* clear to end of screen */
                     for (y = s->y; y < s->height; y++) {
@@ -906,7 +905,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                 }
                 break;
             case 'K':
-                switch (s->esc_params[0]) {
+                switch (vc->esc_params[0]) {
                 case 0:
                     /* clear to eol */
                     for(x = s->x; x < s->width; x++) {
@@ -931,7 +930,7 @@ static void vc_putchar(VCChardev *vc, int ch)
                 vc_handle_escape(vc);
                 break;
             case 'n':
-                switch (s->esc_params[0]) {
+                switch (vc->esc_params[0]) {
                 case 5:
                     /* report console status (always succeed)*/
                     vc_respond_str(vc, "\033[0n");
@@ -947,13 +946,13 @@ static void vc_putchar(VCChardev *vc, int ch)
                 break;
             case 's':
                 /* save cursor position */
-                s->x_saved = s->x;
-                s->y_saved = s->y;
+                vc->x_saved = s->x;
+                vc->y_saved = s->y;
                 break;
             case 'u':
                 /* restore cursor position */
-                s->x = s->x_saved;
-                s->y = s->y_saved;
+                s->x = vc->x_saved;
+                s->y = vc->y_saved;
                 break;
             default:
                 trace_console_putchar_unhandled(ch);
@@ -2427,17 +2426,17 @@ static void text_console_do_init(Chardev *chr)
     s->hw = s;
 
     /* set current text attributes to default */
-    s->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+    drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     text_console_resize(s);
 
     if (chr->label) {
         char *msg;
 
-        s->t_attrib.bgcol = QEMU_COLOR_BLUE;
+        drv->t_attrib.bgcol = QEMU_COLOR_BLUE;
         msg = g_strdup_printf("%s console\r\n", chr->label);
         qemu_chr_write(chr, (uint8_t *)msg, strlen(msg), true);
         g_free(msg);
-        s->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
+        drv->t_attrib = TEXT_ATTRIBUTES_DEFAULT;
     }
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-- 
2.41.0


