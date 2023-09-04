Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2487916DE
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8B8-0007Za-4e; Mon, 04 Sep 2023 07:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Ax-00079C-6j
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Av-0000d4-2I
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4PK8BQ+1DCqciH7hpenAmD1DXvcbABEEaYzHETY/AU=;
 b=G7iNMWqxh9JIE70yhRqq/Pjgj6hgIrdRROeGOmUThnaPI/GHHQTR34m78SnYEBY1cavoga
 ILGaCNT0N/D26sQlccaSvOW1glbKBEasSdyHQkWuifTh9rZxQkPYMsv8Iopir1aV/GcTqY
 M3vfV81gYDOfNp883yjHzAF02wCjVBA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-3KobwjplOwWoE4OZRLnIWw-1; Mon, 04 Sep 2023 07:55:21 -0400
X-MC-Unique: 3KobwjplOwWoE4OZRLnIWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0C53380671E
 for <qemu-devel@nongnu.org>; Mon,  4 Sep 2023 11:55:20 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA1E12026D4B;
 Mon,  4 Sep 2023 11:55:19 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 37/52] ui/console: rename vga_ functions with qemu_console_
Date: Mon,  4 Sep 2023 15:52:34 +0400
Message-ID: <20230904115251.4161397-38-marcandre.lureau@redhat.com>
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

They are not specific to VGA. Let's use the object type name as prefix
instead, to avoid confusion.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230830093843.3531473-38-marcandre.lureau@redhat.com>
---
 ui/console.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 88e37eaff3..a157a5b31c 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -331,9 +331,8 @@ void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
     }
 }
 
-static void vga_fill_rect(QemuConsole *con,
-                          int posx, int posy, int width, int height,
-                          pixman_color_t color)
+static void qemu_console_fill_rect(QemuConsole *con, int posx, int posy,
+                                   int width, int height, pixman_color_t color)
 {
     DisplaySurface *surface = qemu_console_surface(con);
     pixman_rectangle16_t rect = {
@@ -345,8 +344,8 @@ static void vga_fill_rect(QemuConsole *con,
 }
 
 /* copy from (xs, ys) to (xd, yd) a rectangle of size (w, h) */
-static void vga_bitblt(QemuConsole *con,
-                       int xs, int ys, int xd, int yd, int w, int h)
+static void qemu_console_bitblt(QemuConsole *con,
+                                int xs, int ys, int xd, int yd, int w, int h)
 {
     DisplaySurface *surface = qemu_console_surface(con);
 
@@ -526,8 +525,8 @@ static void console_refresh(QemuTextConsole *s)
     s->text_y[1] = s->height - 1;
     s->cursor_invalidate = 1;
 
-    vga_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
-                  color_table_rgb[0][QEMU_COLOR_BLACK]);
+    qemu_console_fill_rect(QEMU_CONSOLE(s), 0, 0, surface_width(surface), surface_height(surface),
+                           color_table_rgb[0][QEMU_COLOR_BLACK]);
     y1 = s->y_displayed;
     for (y = 0; y < s->height; y++) {
         c = s->cells + y1 * s->width;
@@ -605,12 +604,12 @@ static void vc_put_lf(VCChardev *vc)
             s->text_x[1] = s->width - 1;
             s->text_y[1] = s->height - 1;
 
-            vga_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
-                       s->width * FONT_WIDTH,
-                       (s->height - 1) * FONT_HEIGHT);
-            vga_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
-                          s->width * FONT_WIDTH, FONT_HEIGHT,
-                          color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
+            qemu_console_bitblt(QEMU_CONSOLE(s), 0, FONT_HEIGHT, 0, 0,
+                                s->width * FONT_WIDTH,
+                                (s->height - 1) * FONT_HEIGHT);
+            qemu_console_fill_rect(QEMU_CONSOLE(s), 0, (s->height - 1) * FONT_HEIGHT,
+                                   s->width * FONT_WIDTH, FONT_HEIGHT,
+                                   color_table_rgb[0][TEXT_ATTRIBUTES_DEFAULT.bgcol]);
             s->update_x0 = 0;
             s->update_y0 = 0;
             s->update_x1 = s->width * FONT_WIDTH;
-- 
2.41.0


