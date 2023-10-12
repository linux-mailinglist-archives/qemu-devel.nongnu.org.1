Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D41267C79F9
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 00:52:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr4Wp-0003cp-T4; Thu, 12 Oct 2023 18:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qr4Wn-0003cb-BI
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 18:51:37 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qr4Wl-0005IC-1d
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 18:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697151095; x=1728687095;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gcQnJTfFm02x3rMHZkjd8mUHp7iQGPFy9Xv5R2+gKWQ=;
 b=bee8vUp64Kdii+erWgOoYObt2WlS3ElbpJgQ2dWja4Oz+VEhytT122t4
 8HAlPB4SYmnU1Mb1cVwKJTg+N1KfkGz/XSHitJ7y64n2IUqLKZLLCRwOZ
 +MLO+aFJa99Rq/ea+6eA0mTgAgGisz0YtmTmH3IXTRLo8V8QU6OprnfGc
 IUiRkHfylJL7Ty2fHpF0INQxrpbyoOO4KS5iENzkBrsYUT8jjAWpPlTQq
 8OgevD3zpEkdup74w5ZuQncmQoH3at0iw2FJzqVdfDccQ8TRIkRwyQpEo
 9mphPeEFZ4WLntDmE7TCdFW1uOSb288Ti+A+Z8mXyFjlrlztK44kdpBtJ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449249633"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="449249633"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2023 15:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="928172198"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; d="scan'208";a="928172198"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.124])
 by orsmga005.jf.intel.com with ESMTP; 12 Oct 2023 15:51:12 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/gtk: full-screening all detached windows
Date: Thu, 12 Oct 2023 15:24:38 -0700
Message-Id: <20231012222438.13853-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
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

When turning on or off full-screen menu, all detached windows should
be full-screened or un-full-screened altogether.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 44 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 10 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 935de1209b..3a380f8d59 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1452,29 +1452,53 @@ static void gd_accel_show_menubar(void *opaque)
 static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
-    VirtualConsole *vc = gd_vc_find_current(s);
+    VirtualConsole *vc;
+    int i;
 
     if (!s->full_screen) {
         gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
         gtk_widget_hide(s->menu_bar);
-        if (vc->type == GD_VC_GFX) {
-            gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
-        }
-        gtk_window_fullscreen(GTK_WINDOW(s->window));
         s->full_screen = TRUE;
+        gtk_window_fullscreen(GTK_WINDOW(s->window));
+
+        for (i = 0; i < s->nb_vcs; i++) {
+            vc = &s->vc[i];
+            if (!vc->window) {
+                continue;
+            }
+            if (vc->type == GD_VC_GFX) {
+                gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
+            }
+            gtk_window_fullscreen(GTK_WINDOW(vc->window));
+        }
     } else {
         gtk_window_unfullscreen(GTK_WINDOW(s->window));
+
+        for (i = 0; i < s->nb_vcs; i++) {
+            vc = &s->vc[i];
+            if (!vc->window) {
+                continue;
+            }
+            gtk_window_unfullscreen(GTK_WINDOW(vc->window));
+
+            if (vc->type == GD_VC_GFX) {
+                vc->gfx.scale_x = 1.0;
+                vc->gfx.scale_y = 1.0;
+                gd_update_windowsize(vc);
+            }
+        }
+
         gd_menu_show_tabs(GTK_MENU_ITEM(s->show_tabs_item), s);
         if (gtk_check_menu_item_get_active(
                     GTK_CHECK_MENU_ITEM(s->show_menubar_item))) {
             gtk_widget_show(s->menu_bar);
         }
         s->full_screen = FALSE;
-        if (vc->type == GD_VC_GFX) {
-            vc->gfx.scale_x = 1.0;
-            vc->gfx.scale_y = 1.0;
-            gd_update_windowsize(vc);
-        }
+    }
+
+    vc = gd_vc_find_current(s);
+    if (!vc) {
+        return;
     }
 
     gd_update_cursor(vc);
-- 
2.20.1


