Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AD8811280
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:06:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOuH-0003w9-DK; Wed, 13 Dec 2023 08:04:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsg-0000R3-Ei; Wed, 13 Dec 2023 08:02:32 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsc-0007Bi-Uw; Wed, 13 Dec 2023 08:02:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E65BF3B448;
 Wed, 13 Dec 2023 16:01:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8B8223C8D9;
 Wed, 13 Dec 2023 16:00:46 +0300 (MSK)
Received: (nullmailer pid 1024778 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:46 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 21/24] ui/gtk-egl: move function calls back to regular
 code path
Date: Wed, 13 Dec 2023 16:00:30 +0300
Message-Id: <20231213130041.1024630-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
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

From: Volker Rümelin <vr_qemu@t-online.de>

Commit 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing
scanout") introduced a regression when QEMU is running with a
virtio-gpu-gl-device on a host under X11. After the guest has
initialized the virtio-gpu-gl-device, the guest screen only
shows "Display output is not active.".

Commit 6f189a08c1 moved all function calls in
gd_egl_scanout_texture() to a code path which is only called
once after gd_egl_init() succeeds in gd_egl_scanout_texture().
Move all function calls in gd_egl_scanout_texture() back to
the regular code path so they get always called if one of the
gd_egl_init() calls was successful.

Fixes: 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing scanout")
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231111104020.26183-1-vr_qemu@t-online.de>
(cherry picked from commit 53a939f1bf8e4a3e38f9449fac44f572676966ad)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 17755b1185..7ff9f1648c 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -239,14 +239,14 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
         if (!vc->gfx.esurface) {
             return;
         }
+    }
 
-        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
-                       vc->gfx.esurface, vc->gfx.ectx);
+    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                   vc->gfx.esurface, vc->gfx.ectx);
 
-        gtk_egl_set_scanout_mode(vc, true);
-        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
-                             backing_id, false);
-    }
+    gtk_egl_set_scanout_mode(vc, true);
+    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
+                         backing_id, false);
 }
 
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
-- 
2.39.2


