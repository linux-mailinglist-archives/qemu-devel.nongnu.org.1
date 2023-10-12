Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530F17C79FD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 00:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr4YW-0004H9-6k; Thu, 12 Oct 2023 18:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qr4YU-0004Gx-6C
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 18:53:22 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qr4YS-0005h1-ID
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 18:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697151200; x=1728687200;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Uz4HSDLKCYm5l/QBVryvFvKn6IMUZkue3RvIdfiGSL8=;
 b=MXzTDSYHv90H2MpkeLxCrkBuFlEORJZDxan4diT5TGgWFvK8O0YkroLW
 F0aMav6CdMzyeazE+rd246stHYys4LeB/+N6RQSPIyyMNrj70rP0m+oky
 FG1CQs0IHdHjdyt9jwLFACYt0AtZvEwEqOWXjkf8ZPLUp72PV0+slSWq8
 gEgZfx8paj9oDcDUh3KXUi499T1LjBpl2UnHEDn8T6MbC6chezVRr3/6O
 hgGCDSN3utZ7JnxFpvBAoEYedDiMKHkxOqpf7ke2SjLhe/5H7t3c5KjkQ
 J9P9I+EHKXLOUonRobvZlRKQ7PzXjSatqPgFlQi6BLhZuXN50TCLDPjZt g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471293006"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="471293006"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 15:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="870785544"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="870785544"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.124])
 by fmsmga002.fm.intel.com with ESMTP; 12 Oct 2023 15:53:16 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/gtk-egl: apply scale factor when calculating window's
 dimension
Date: Thu, 12 Oct 2023 15:26:43 -0700
Message-Id: <20231012222643.13996-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Scale factor needs to be applied when calculating width/height of the
GTK windows.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk-egl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

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
2.20.1


