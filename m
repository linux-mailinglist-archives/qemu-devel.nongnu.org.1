Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903EE73788D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGE-0007ns-S8; Tue, 20 Jun 2023 21:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGC-0007ma-2A
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:48 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmG8-0001Gy-OG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309424; x=1718845424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RefJekrSGuk5pNLcoaQG7BqPnJIgpirHosYa5MtoteM=;
 b=XLD1akbbg92UhdPrp9Wj6OvrIpq7JWS+JDR32JmdXxBg9s4eReX664Nr
 naHsLsV7hzQXnkhLQC0a/g0gLVzyGERWMKIneT+TBH6uqQd0Uu+CEN6wm
 dAi2ZpYaZ3EDYpMDuHRLjE9zofKXnCt+LoRmi7EcN400CHPwIdkmF8+QK
 Kot5gBAdtYX7xcxQ88MOES+BN2vRAKdDqrUiNJmaqeaEuR7tbR4WcIdPh
 xJ5ykEJL+zSwPUMgF7hZ0yYNPUmTR7jI3vmbzS+qbNP/FujJOA7hGvNJV
 i5X+p9/ZVAP6NurpvpIc1R4r8ckxV+LpYyRK5M2b3NYPeU1a+jTnLiPGm g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522808"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522808"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429556"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429556"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:39 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 2/9] ui/gtk: set the ui size to 0 when invisible
Date: Tue, 20 Jun 2023 17:43:48 -0700
Message-Id: <20230621004355.19920-3-dongwon.kim@intel.com>
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

Getting guest displays disconnected by setting ui size to 0 when
the VC is set as invisible. When the VC is set as visible again,
the ui size is restored back to its previous size to reconnect
guest displays.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 84c50d835e..ff4a5c58ea 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1352,10 +1352,12 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc;
     GtkNotebook *nb = GTK_NOTEBOOK(s->notebook);
+    GdkWindow *window;
     gint page;
 
     vc = gd_vc_find_current(s);
     vc->gfx.visible = false;
+    gd_set_ui_size(vc, 0, 0);
 
     vc = gd_vc_find_by_menu(s);
     gtk_release_modifiers(s);
@@ -1363,6 +1365,9 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
         page = gtk_notebook_page_num(nb, vc->tab_item);
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
+        window = gtk_widget_get_window(vc->gfx.drawing_area);
+        gd_set_ui_size(vc, gdk_window_get_width(window),
+                       gdk_window_get_height(window));
         vc->gfx.visible = true;
     }
 }
@@ -1394,6 +1399,7 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     GtkDisplayState *s = vc->s;
 
     vc->gfx.visible = false;
+    gd_set_ui_size(vc, 0, 0);
     gtk_widget_set_sensitive(vc->menu_item, true);
     gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
     gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
@@ -1429,6 +1435,7 @@ static gboolean gd_win_grab(void *opaque)
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
+    GdkWindow *window;
     VirtualConsole *vc = gd_vc_find_current(s);
 
     if (vc->type == GD_VC_GFX &&
@@ -1467,6 +1474,10 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
         gd_update_geometry_hints(vc);
         gd_update_caption(s);
     }
+
+    window = gtk_widget_get_window(vc->gfx.drawing_area);
+    gd_set_ui_size(vc, gdk_window_get_width(window),
+                   gdk_window_get_height(window));
     vc->gfx.visible = true;
 }
 
@@ -1791,7 +1802,9 @@ static gboolean gd_configure(GtkWidget *widget,
 {
     VirtualConsole *vc = opaque;
 
-    gd_set_ui_size(vc, cfg->width, cfg->height);
+    if (vc->gfx.visible) {
+        gd_set_ui_size(vc, cfg->width, cfg->height);
+    }
     return FALSE;
 }
 
-- 
2.34.1


