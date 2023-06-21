Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3040073788B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGG-0007ox-8G; Tue, 20 Jun 2023 21:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGE-0007nz-8c
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:50 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGC-0001Gy-Cj
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309428; x=1718845428;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hy79wK9DpN3H5yoP1fsmyNoeHbhQG7E7cc12uKXGjIw=;
 b=WFqtmKPGE2g+X3D/C6LaCB2TCu1u3Q4TpIlxdeS86829iO87lgy8CUNt
 X7w1gttOAM0Y4xBiIda9ZTQaKDK3u6OfkjfDuanbNn7bUjIUZOH7EZL3q
 Rh/QxmY1biiFxjUWIjD5yhswZKmz6dBiRspsol3o9Ca7DbLan/XAEQ3Cw
 KCVsESjRlLeXY5ieua1nbbR2l777Zbu02OYGdmZ+nNykQjzKGEkQC+5pz
 bUAvgtyXeu7wvVUarwtGp56jR1k3AebGSH3bEY3CvTK6dWGWxKrO9QkxR
 MLeug9qv6D6yeP2HiTpu8EPp9VUwxtEi5ClGJwN4BUhcHPR9YMY9TYU0L A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522825"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522825"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429569"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429569"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:42 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 5/9] ui/gtk: Factor out tab window creation into a
 separate function
Date: Tue, 20 Jun 2023 17:43:51 -0700
Message-Id: <20230621004355.19920-6-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230621004355.19920-1-dongwon.kim@intel.com>
References: <20230621004355.19920-1-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=dongwon.kim@intel.com;
 helo=mga11.intel.com
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

Pull the code that creates a new window associated with a notebook
tab into a separate function. This new function can be useful not
just when user wants to detach a tab but also in the future when
a new window creation is needed in other scenarios.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 71 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 90ecb8b82f..d8323a3a9d 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1462,6 +1462,44 @@ static gboolean gd_win_grab(void *opaque)
     return TRUE;
 }
 
+static void gd_tab_window_create(VirtualConsole *vc)
+{
+    GtkDisplayState *s = vc->s;
+
+    gtk_widget_set_sensitive(vc->menu_item, false);
+    vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
+    gtk_window_set_default_size(GTK_WINDOW(vc->window),
+                                surface_width(vc->gfx.ds),
+                                surface_height(vc->gfx.ds));
+#if defined(CONFIG_OPENGL)
+    if (vc->gfx.esurface) {
+	eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
+	vc->gfx.esurface = NULL;
+    }
+    if (vc->gfx.ectx) {
+	eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
+	vc->gfx.ectx = NULL;
+    }
+#endif
+    gd_widget_reparent(s->notebook, vc->window, vc->tab_item);
+
+    g_signal_connect(vc->window, "delete-event",
+		     G_CALLBACK(gd_tab_window_close), vc);
+    gtk_widget_show_all(vc->window);
+
+    if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
+	GtkAccelGroup *ag = gtk_accel_group_new();
+	gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
+
+	GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
+					   vc, NULL);
+	gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
+    }
+
+    gd_update_geometry_hints(vc);
+    gd_update_caption(s);
+}
+
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
@@ -1474,38 +1512,7 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
                                        FALSE);
     }
     if (!vc->window) {
-        gtk_widget_set_sensitive(vc->menu_item, false);
-        vc->window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
-#if defined(CONFIG_OPENGL)
-        if (vc->gfx.esurface) {
-            eglDestroySurface(qemu_egl_display, vc->gfx.esurface);
-            vc->gfx.esurface = NULL;
-        }
-        if (vc->gfx.esurface) {
-            eglDestroyContext(qemu_egl_display, vc->gfx.ectx);
-            vc->gfx.ectx = NULL;
-        }
-#endif
-        gd_widget_reparent(s->notebook, vc->window, vc->tab_item);
-
-        g_signal_connect(vc->window, "delete-event",
-                         G_CALLBACK(gd_tab_window_close), vc);
-        g_signal_connect(vc->window, "window-state-event",
-                         G_CALLBACK(gd_window_state_event), vc);
-
-        gtk_widget_show_all(vc->window);
-
-        if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
-            GtkAccelGroup *ag = gtk_accel_group_new();
-            gtk_window_add_accel_group(GTK_WINDOW(vc->window), ag);
-
-            GClosure *cb = g_cclosure_new_swap(G_CALLBACK(gd_win_grab),
-                                               vc, NULL);
-            gtk_accel_group_connect(ag, GDK_KEY_g, HOTKEY_MODIFIERS, 0, cb);
-        }
-
-        gd_update_geometry_hints(vc);
-        gd_update_caption(s);
+        gd_tab_window_create(vc);
     }
 
     window = gtk_widget_get_window(vc->gfx.drawing_area);
-- 
2.34.1


