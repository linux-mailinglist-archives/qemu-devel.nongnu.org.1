Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1207E6B84
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:50:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15OA-0002jE-AX; Thu, 09 Nov 2023 08:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ni-0000IQ-5W; Thu, 09 Nov 2023 08:47:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Nf-0002Fq-VJ; Thu, 09 Nov 2023 08:47:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F369931B25;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0F50A344CB;
 Thu,  9 Nov 2023 16:43:07 +0300 (MSK)
Received: (nullmailer pid 1461898 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 45/55] ui/gtk-egl: apply scale factor when calculating
 window's dimension
Date: Thu,  9 Nov 2023 16:42:49 +0300
Message-Id: <20231109134300.1461632-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: Dongwon Kim <dongwon.kim@intel.com>

Scale factor needs to be applied when calculating width/height of the
GTK windows.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231012222643.13996-1-dongwon.kim@intel.com>
(cherry picked from commit 47fd6ab1e334962890bc3e8d2e32857f6594e1c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index a1060fd80f..45c7544337 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -69,15 +69,16 @@ void gd_egl_draw(VirtualConsole *vc)
 #ifdef CONFIG_GBM
     QemuDmaBuf *dmabuf = vc->gfx.guest_fb.dmabuf;
 #endif
-    int ww, wh;
+    int ww, wh, ws;
 
     if (!vc->gfx.gls) {
         return;
     }
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ww = gdk_window_get_width(window);
-    wh = gdk_window_get_height(window);
+    ws = gdk_window_get_scale_factor(window);
+    ww = gdk_window_get_width(window) * ws;
+    wh = gdk_window_get_height(window) * ws;
 
     if (vc->gfx.scanout_mode) {
 #ifdef CONFIG_GBM
@@ -312,7 +313,7 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GdkWindow *window;
-    int ww, wh;
+    int ww, wh, ws;
 
     if (!vc->gfx.scanout_mode) {
         return;
@@ -325,8 +326,9 @@ void gd_egl_scanout_flush(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-    ww = gdk_window_get_width(window);
-    wh = gdk_window_get_height(window);
+    ws = gdk_window_get_scale_factor(window);
+    ww = gdk_window_get_width(window) * ws;
+    wh = gdk_window_get_height(window) * ws;
     egl_fb_setup_default(&vc->gfx.win_fb, ww, wh);
     if (vc->gfx.cursor_fb.texture) {
         egl_texture_blit(vc->gfx.gls, &vc->gfx.win_fb, &vc->gfx.guest_fb,
-- 
2.39.2


