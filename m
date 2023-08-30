Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 988AF78D4E1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:46:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHhc-0000go-ET; Wed, 30 Aug 2023 05:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhK-0000TD-5L
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHhH-0001Tu-Mf
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcP8Jbb6P94GlnsCHtBb+7ml3WM/0XgijhwvUrfnjbE=;
 b=DQmErIqpVOyWMBjcb0qshTS+xn5nI16ht/de9rDvmvwpt4/GbLm6I53tfDWn5DsoAp4LKg
 8d7nNuGaNI/QLSeuenNYozeREHcDs7Ta2FK0Jqk89/5haTPmKcthCqvsZkP229Daqr0t6C
 zZwvxnWFY83M3mxmhik8FB3ru8/74C0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-E8X14ua8OiK8rJKi7CIhUg-1; Wed, 30 Aug 2023 05:41:09 -0400
X-MC-Unique: E8X14ua8OiK8rJKi7CIhUg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26F9F806007
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:41:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 041B9C15BAE;
 Wed, 30 Aug 2023 09:41:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 36/67] ui/console: use QEMU_PIXMAN_COLOR helpers
Date: Wed, 30 Aug 2023 13:38:10 +0400
Message-ID: <20230830093843.3531473-37-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

QEMU_RGB macro is actually defining a pixman color. Make this explicit
in the macro name. Move it to qemu-pixman.h so it can be used elsewhere,
as done in the following patch. Finally, define
QEMU_PIXMAN_COLOR_{BLACK,GRAY}, to avoid need to look up the VGA color
table from the QemuConsole placeholder surface rendering.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/qemu-pixman.h |  6 ++++++
 ui/console.c             | 39 ++++++++++++++++++---------------------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
index ce4518e4de..51f8709327 100644
--- a/include/ui/qemu-pixman.h
+++ b/include/ui/qemu-pixman.h
@@ -47,6 +47,12 @@
 # define PIXMAN_LE_x8r8g8b8   PIXMAN_x8r8g8b8
 #endif
 
+#define QEMU_PIXMAN_COLOR(r, g, b)                                               \
+    { .red = r << 8, .green = g << 8, .blue = b << 8, .alpha = 0xffff }
+
+#define QEMU_PIXMAN_COLOR_BLACK QEMU_PIXMAN_COLOR(0x00, 0x00, 0x00)
+#define QEMU_PIXMAN_COLOR_GRAY QEMU_PIXMAN_COLOR(0xaa, 0xaa, 0xaa)
+
 /* -------------------------------------------------------------------- */
 
 typedef struct PixelFormat {
diff --git a/ui/console.c b/ui/console.c
index ed9e7137b8..88e37eaff3 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -363,29 +363,26 @@ static void vga_bitblt(QemuConsole *con,
 
 #include "vgafont.h"
 
-#define QEMU_RGB(r, g, b)                                               \
-    { .red = r << 8, .green = g << 8, .blue = b << 8, .alpha = 0xffff }
-
 static const pixman_color_t color_table_rgb[2][8] = {
     {   /* dark */
-        [QEMU_COLOR_BLACK]   = QEMU_RGB(0x00, 0x00, 0x00),  /* black */
-        [QEMU_COLOR_BLUE]    = QEMU_RGB(0x00, 0x00, 0xaa),  /* blue */
-        [QEMU_COLOR_GREEN]   = QEMU_RGB(0x00, 0xaa, 0x00),  /* green */
-        [QEMU_COLOR_CYAN]    = QEMU_RGB(0x00, 0xaa, 0xaa),  /* cyan */
-        [QEMU_COLOR_RED]     = QEMU_RGB(0xaa, 0x00, 0x00),  /* red */
-        [QEMU_COLOR_MAGENTA] = QEMU_RGB(0xaa, 0x00, 0xaa),  /* magenta */
-        [QEMU_COLOR_YELLOW]  = QEMU_RGB(0xaa, 0xaa, 0x00),  /* yellow */
-        [QEMU_COLOR_WHITE]   = QEMU_RGB(0xaa, 0xaa, 0xaa),  /* white */
+        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
+        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xaa),  /* blue */
+        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0x00),  /* green */
+        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xaa, 0xaa),  /* cyan */
+        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0x00),  /* red */
+        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xaa, 0x00, 0xaa),  /* magenta */
+        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xaa, 0xaa, 0x00),  /* yellow */
+        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR_GRAY,
     },
     {   /* bright */
-        [QEMU_COLOR_BLACK]   = QEMU_RGB(0x00, 0x00, 0x00),  /* black */
-        [QEMU_COLOR_BLUE]    = QEMU_RGB(0x00, 0x00, 0xff),  /* blue */
-        [QEMU_COLOR_GREEN]   = QEMU_RGB(0x00, 0xff, 0x00),  /* green */
-        [QEMU_COLOR_CYAN]    = QEMU_RGB(0x00, 0xff, 0xff),  /* cyan */
-        [QEMU_COLOR_RED]     = QEMU_RGB(0xff, 0x00, 0x00),  /* red */
-        [QEMU_COLOR_MAGENTA] = QEMU_RGB(0xff, 0x00, 0xff),  /* magenta */
-        [QEMU_COLOR_YELLOW]  = QEMU_RGB(0xff, 0xff, 0x00),  /* yellow */
-        [QEMU_COLOR_WHITE]   = QEMU_RGB(0xff, 0xff, 0xff),  /* white */
+        [QEMU_COLOR_BLACK]   = QEMU_PIXMAN_COLOR_BLACK,
+        [QEMU_COLOR_BLUE]    = QEMU_PIXMAN_COLOR(0x00, 0x00, 0xff),  /* blue */
+        [QEMU_COLOR_GREEN]   = QEMU_PIXMAN_COLOR(0x00, 0xff, 0x00),  /* green */
+        [QEMU_COLOR_CYAN]    = QEMU_PIXMAN_COLOR(0x00, 0xff, 0xff),  /* cyan */
+        [QEMU_COLOR_RED]     = QEMU_PIXMAN_COLOR(0xff, 0x00, 0x00),  /* red */
+        [QEMU_COLOR_MAGENTA] = QEMU_PIXMAN_COLOR(0xff, 0x00, 0xff),  /* magenta */
+        [QEMU_COLOR_YELLOW]  = QEMU_PIXMAN_COLOR(0xff, 0xff, 0x00),  /* yellow */
+        [QEMU_COLOR_WHITE]   = QEMU_PIXMAN_COLOR(0xff, 0xff, 0xff),  /* white */
     }
 };
 
@@ -1520,8 +1517,8 @@ DisplaySurface *qemu_create_placeholder_surface(int w, int h,
                                                 const char *msg)
 {
     DisplaySurface *surface = qemu_create_displaysurface(w, h);
-    pixman_color_t bg = color_table_rgb[0][QEMU_COLOR_BLACK];
-    pixman_color_t fg = color_table_rgb[0][QEMU_COLOR_WHITE];
+    pixman_color_t bg = QEMU_PIXMAN_COLOR_BLACK;
+    pixman_color_t fg = QEMU_PIXMAN_COLOR_GRAY;
     pixman_image_t *glyph;
     int len, x, y, i;
 
-- 
2.41.0


