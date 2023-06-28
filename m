Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFB17418B7
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 21:12:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEaZ6-0003XK-TE; Wed, 28 Jun 2023 15:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEaZ4-0003X5-Sl
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:10:54 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qEaZ2-0006su-5u
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 15:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687979452; x=1719515452;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PP9pAmPk0vomY1/j+PyoQbnehJQs704T/59T1LPGOVg=;
 b=LOVwZscc94VLbOTmQRAKl4YVdUsHg/Dx6ciuwCFt/dhVKu+fY/JJuNUm
 dg3PRjrk61mD1ejwYB3pdw9xgpJFIFBJqRaItol5arAEiXv/XXxyRSN+s
 VdxfE6puohSh0av9Kipjp5Ay2sG1SJREeqJ9foVTdIwvpWu9JkL0Ijed4
 3exbMY1H2qB6MPva88LcrqJjNFp5mhEIdbw/3mxWLehm9hD5sHHYMnSrT
 36BfAvrH8RKX7eGAw1nTfnV30WMWCrGArDCB0h8eO3v8zOJGwaBGXOyFq
 k3iYjhoKb8EWv32Oc0e9sVHikiylIl7GD/6ww8J17xQnKmTva4fOF/jRs A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342273924"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="342273924"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2023 12:10:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="746777951"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; d="scan'208";a="746777951"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga008.jf.intel.com with ESMTP; 28 Jun 2023 12:10:45 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] ui/gtk: skip refresh if new dmabuf is submitted
Date: Wed, 28 Jun 2023 11:51:08 -0700
Message-Id: <20230628185108.16697-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151; envelope-from=dongwon.kim@intel.com;
 helo=mga17.intel.com
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

Skip refresh if a new dmabuf (guest scanout frame) is submitted
and ready to be drawn because the scanout will be refreshed with
new frame anyway.

Also, setting scanout mode is better to be done right before
a draw event is scheduled because the mode can be reset anytime
after it is set in dpy_gl_scanout_texture by any asynchronouse
dpy_refresh call, which eventually cancels the drawing of the
guest scanout texture.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c     | 6 +++++-
 ui/gtk-gl-area.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 19130041bc..62ff6812b6 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -143,6 +143,10 @@ void gd_egl_refresh(DisplayChangeListener *dcl)
     gd_update_monitor_refresh_rate(
             vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        return;
+    }
+
     if (!vc->gfx.esurface) {
         gd_egl_init(vc);
         if (!vc->gfx.esurface) {
@@ -236,7 +240,6 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
-    gtk_egl_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
 }
@@ -344,6 +347,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        gtk_egl_set_scanout_mode(vc, true);
         gtk_widget_queue_draw_area(area, x, y, w, h);
         return;
     }
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c384a1516b..68eff3435b 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -123,6 +123,10 @@ void gd_gl_area_refresh(DisplayChangeListener *dcl)
 
     gd_update_monitor_refresh_rate(vc, vc->window ? vc->window : vc->gfx.drawing_area);
 
+    if (vc->gfx.guest_fb.dmabuf && vc->gfx.guest_fb.dmabuf->draw_submitted) {
+        return;
+    }
+
     if (!vc->gfx.gls) {
         if (!gtk_widget_get_realized(vc->gfx.drawing_area)) {
             return;
@@ -261,7 +265,6 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
         return;
     }
 
-    gtk_gl_area_set_scanout_mode(vc, true);
     egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
                          backing_id, false);
 }
@@ -281,6 +284,7 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
+        gtk_gl_area_set_scanout_mode(vc, true);
     }
     gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
 }
-- 
2.34.1


