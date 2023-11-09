Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BFA7E6BAC
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:53:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15OS-0002xN-6j; Thu, 09 Nov 2023 08:48:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15O7-0002gI-9I; Thu, 09 Nov 2023 08:48:03 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15O3-0002Hx-M1; Thu, 09 Nov 2023 08:48:02 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 107AC31B26;
 Thu,  9 Nov 2023 16:43:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 20B01344CC;
 Thu,  9 Nov 2023 16:43:07 +0300 (MSK)
Received: (nullmailer pid 1461901 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Antonio Caggiano <quic_acaggian@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 46/55] ui/gtk-egl: Check EGLSurface before doing scanout
Date: Thu,  9 Nov 2023 16:42:50 +0300
Message-Id: <20231109134300.1461632-46-mjt@tls.msk.ru>
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

From: Antonio Caggiano <quic_acaggian@quicinc.com>

The first time gd_egl_scanout_texture() is called, there's a possibility
that the GTK drawing area might not be realized yet, in which case its
associated GdkWindow is NULL. This means gd_egl_init() was also skipped
and the EGLContext and EGLSurface stored in the VirtualGfxConsole are
not valid yet.

Continuing with the scanout in this conditions would result in hitting
an assert in libepoxy: "Couldn't find current GLX or EGL context".

A possible workaround is to just ignore the scanout request, giving the
the GTK drawing area some time to finish its realization. At that point,
the gd_egl_init() will succeed and the EGLContext and EGLSurface stored
in the VirtualGfxConsole will be valid.

Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231016123215.2699269-1-quic_acaggian@quicinc.com>
(cherry picked from commit 6f189a08c1b0085808af1bfbf4567f0da193ecc1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 45c7544337..cd2f176502 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -244,12 +244,19 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     vc->gfx.h = h;
     vc->gfx.y0_top = backing_y_0_top;
 
-    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                   vc->gfx.esurface, vc->gfx.ectx);
+    if (!vc->gfx.esurface) {
+        gd_egl_init(vc);
+        if (!vc->gfx.esurface) {
+            return;
+        }
+
+        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                       vc->gfx.esurface, vc->gfx.ectx);
 
-    gtk_egl_set_scanout_mode(vc, true);
-    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
-                         backing_id, false);
+        gtk_egl_set_scanout_mode(vc, true);
+        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                             backing_id, false);
+    }
 }
 
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
-- 
2.39.2


