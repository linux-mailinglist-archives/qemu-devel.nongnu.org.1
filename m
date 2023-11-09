Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5865D7E6C1C
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:08:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15gj-00085C-8N; Thu, 09 Nov 2023 09:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15eB-0000zG-UD; Thu, 09 Nov 2023 09:04:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15e8-0007FS-HG; Thu, 09 Nov 2023 09:04:39 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3CD7C31BED;
 Thu,  9 Nov 2023 16:59:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4704034524;
 Thu,  9 Nov 2023 16:59:50 +0300 (MSK)
Received: (nullmailer pid 1462940 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 53/62] ui/gtk: force realization of drawing area
Date: Thu,  9 Nov 2023 16:59:21 +0300
Message-Id: <20231109135933.1462615-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes the GL context creation from a widget that isn't yet realized (in
a hidden tab for example).

Resolves:
https://gitlab.com/qemu-project/qemu/-/issues/1727

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Message-Id: <20231017111642.1155545-1-marcandre.lureau@redhat.com>
(cherry picked from commit 565f85a9c293818a91a3d3414311303de7e00cec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk.c b/ui/gtk.c
index e681e8c319..283c41a1a1 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2317,6 +2317,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     GdkDisplay *window_display;
     GtkIconTheme *theme;
     char *dir;
+    int idx;
 
     if (!gtkinit) {
         fprintf(stderr, "gtk initialization failed\n");
@@ -2379,6 +2380,15 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     gtk_container_add(GTK_CONTAINER(s->window), s->vbox);
 
     gtk_widget_show_all(s->window);
+
+    for (idx = 0;; idx++) {
+        QemuConsole *con = qemu_console_lookup_by_index(idx);
+        if (!con) {
+            break;
+        }
+        gtk_widget_realize(s->vc[idx].gfx.drawing_area);
+    }
+
     if (opts->u.gtk.has_show_menubar &&
         !opts->u.gtk.show_menubar) {
         gtk_widget_hide(s->menu_bar);
-- 
2.39.2


