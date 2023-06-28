Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCFA7418EE
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:36:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEawL-0000qG-GB; Wed, 28 Jun 2023 15:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEawG-0000q7-Oz
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:34:52 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEawD-0008HC-T7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687980889; x=1719516889;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9fchXZ2ophNbouHNdmHEqwgdBKk2l8bkH7P3e0bTHls=;
 b=feZcrDErYau3SxWTUAiXjakePdfQU1K8ACChfL+RNbwhEUcm39bRsg2m
 WrTG7dBsjqL9YPBHid3/VqKFqPKobFgDouD1GUaE+L0yBnszhZfzC4nr9
 K6k4dnZllWsUfn2FMEB8dxXVlI+XYnh1Tcpsb9IUOKGrxJhy6FbQTBZv2
 d1sUOt2lrbsPSwmJzhVA8Zxfr6LPn2d0TIwNhFPNtJi0Xe6oMF9y1e8jw
 hdI6jMYBYl5td4HIPADHgSXdZxeNjsIbciMmJWtiPzE5Z1uUfXOiGNZ6P
 CUhrRNLwkSyBqhz6i1s1bvyIizPyQ1LN7Bs9NGhzAiER3aM5lmgxiTGJy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="365403843"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="365403843"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 12:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720327797"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="720327797"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2023 12:34:41 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: Make sure the right EGL context is currently bound
Date: Wed, 28 Jun 2023 12:15:04 -0700
Message-Id: <20230628191504.17185-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=dongwon.kim@intel.com; helo=mga03.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Observed a wrong context is bound when changing the scanout mode.
To prevent problem, it is needed to make sure to bind the right
context in gtk_egl_set_scanout_mode/gtk_gl_area_set_scanout_mode
as well as unbind one in the end of gd_egl_update/gd_gl_area_update.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 4 ++++
 ui/gtk-gl-area.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 19130041bc..79f9f334f2 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -31,6 +31,8 @@ static void gtk_egl_set_scanout_mode(VirtualConsole *vc, bool scanout)
 
     vc->gfx.scanout_mode = scanout;
     if (!vc->gfx.scanout_mode) {
+        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
+                       vc->gfx.esurface, vc->gfx.ectx);
         egl_fb_destroy(&vc->gfx.guest_fb);
         if (vc->gfx.surface) {
             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
@@ -134,6 +136,8 @@ void gd_egl_update(DisplayChangeListener *dcl,
                    vc->gfx.esurface, vc->gfx.ectx);
     surface_gl_update_texture(vc->gfx.gls, vc->gfx.ds, x, y, w, h);
     vc->gfx.glupdates++;
+    eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE,
+                   EGL_NO_SURFACE, EGL_NO_CONTEXT);
 }
 
 void gd_egl_refresh(DisplayChangeListener *dcl)
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c384a1516b..285e661071 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -26,6 +26,7 @@ static void gtk_gl_area_set_scanout_mode(VirtualConsole *vc, bool scanout)
 
     vc->gfx.scanout_mode = scanout;
     if (!vc->gfx.scanout_mode) {
+        gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
         egl_fb_destroy(&vc->gfx.guest_fb);
         if (vc->gfx.surface) {
             surface_gl_destroy_texture(vc->gfx.gls, vc->gfx.ds);
@@ -115,6 +116,7 @@ void gd_gl_area_update(DisplayChangeListener *dcl,
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     surface_gl_update_texture(vc->gfx.gls, vc->gfx.ds, x, y, w, h);
     vc->gfx.glupdates++;
+    gdk_gl_context_clear_current();
 }
 
 void gd_gl_area_refresh(DisplayChangeListener *dcl)
-- 
2.34.1


