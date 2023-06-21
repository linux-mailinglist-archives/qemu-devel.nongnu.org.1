Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5855737887
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGD-0007ml-7z; Tue, 20 Jun 2023 21:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGA-0007mL-QR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:46 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmG8-0001GW-TG
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309424; x=1718845424;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3lzjvxFJKYJyk+nzcElwzHCDA3yRPOKrv0YkI3O6ra4=;
 b=W4lRqY706T9yoFDDWUVBizJeI4RgUk/pzZT6E6e7a3m1y3iBfoaBSEG2
 fhjxbEI9JmgjC/fXwY/ZZStzb0A3KCMyLuKWCyd/T0+bvHylBsEYsNbG3
 9GO1m9ySDoE02M+YLdK6GBeN3XnxPAcXcfTE0oYsk5L7Q6fDQm4fHlYCX
 fLDsa2P4jn8pI9AfFW+FkhebiZ3x5jv+yka2Lu1sC2SrWyXoXhwpvgXAa
 Wlf+6QoHGXM3aXTV0T+ZPJTJOlrLjoiWWGBGfY9bjQQpv3f0btU5ZqxIC
 DVPWPX8w+oeGbHVH/nOgYtyRyuVNxl10RQXDMk6mviNf/QLkgE6Gp8USo Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522803"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522803"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429551"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429551"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:38 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 1/9] ui/gtk: skip drawing guest scanout when associated VC
 is invisible
Date: Tue, 20 Jun 2023 17:43:47 -0700
Message-Id: <20230621004355.19920-2-dongwon.kim@intel.com>
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

A new flag "visible" that specifies visibility status of the gfx console.
The polarity of the flag determines whether the drawing surface should
continuously updated upon scanout flush. The flag is set to 'true' when
the window bound to the VC is in visible state  but set to 'false' when
the window is inactivated or closed. When invisible, QEMU will skip any of
draw events.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/gtk.h |  1 +
 ui/gtk-egl.c     |  8 ++++++++
 ui/gtk-gl-area.c |  8 ++++++++
 ui/gtk.c         | 10 +++++++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index ae0f53740d..e7c4726aad 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -57,6 +57,7 @@ typedef struct VirtualGfxConsole {
     bool y0_top;
     bool scanout_mode;
     bool has_dmabuf;
+    bool visible;
 #endif
 } VirtualGfxConsole;
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 19130041bc..443873e266 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -247,6 +247,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 #ifdef CONFIG_GBM
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
                    vc->gfx.esurface, vc->gfx.ectx);
 
@@ -341,6 +345,10 @@ void gd_egl_flush(DisplayChangeListener *dcl,
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
     GtkWidget *area = vc->gfx.drawing_area;
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c384a1516b..68b16a5ff1 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -278,6 +278,10 @@ void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     if (vc->gfx.guest_fb.dmabuf && !vc->gfx.guest_fb.dmabuf->draw_submitted) {
         graphic_hw_gl_block(vc->gfx.dcl.con, true);
         vc->gfx.guest_fb.dmabuf->draw_submitted = true;
@@ -291,6 +295,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 #ifdef CONFIG_GBM
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
+    if (!vc->gfx.visible) {
+        return;
+    }
+
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     egl_dmabuf_import_texture(dmabuf);
     if (!dmabuf->texture) {
diff --git a/ui/gtk.c b/ui/gtk.c
index e50f950f2b..84c50d835e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1350,15 +1350,20 @@ static void gd_menu_quit(GtkMenuItem *item, void *opaque)
 static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
-    VirtualConsole *vc = gd_vc_find_by_menu(s);
+    VirtualConsole *vc;
     GtkNotebook *nb = GTK_NOTEBOOK(s->notebook);
     gint page;
 
+    vc = gd_vc_find_current(s);
+    vc->gfx.visible = false;
+
+    vc = gd_vc_find_by_menu(s);
     gtk_release_modifiers(s);
     if (vc) {
         page = gtk_notebook_page_num(nb, vc->tab_item);
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
+        vc->gfx.visible = true;
     }
 }
 
@@ -1388,6 +1393,7 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
 
+    vc->gfx.visible = false;
     gtk_widget_set_sensitive(vc->menu_item, true);
     gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
     gtk_notebook_set_tab_label_text(GTK_NOTEBOOK(s->notebook),
@@ -1461,6 +1467,7 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
         gd_update_geometry_hints(vc);
         gd_update_caption(s);
     }
+    vc->gfx.visible = true;
 }
 
 static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
@@ -2499,6 +2506,7 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
 #ifdef CONFIG_GTK_CLIPBOARD
     gd_clipboard_init(s);
 #endif /* CONFIG_GTK_CLIPBOARD */
+    vc->gfx.visible = true;
 }
 
 static void early_gtk_display_init(DisplayOptions *opts)
-- 
2.34.1


