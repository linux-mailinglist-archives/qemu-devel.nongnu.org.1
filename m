Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB2C737891
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGH-0007pT-JR; Tue, 20 Jun 2023 21:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGF-0007ow-OD
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:51 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGD-0001Fp-7X
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309429; x=1718845429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iIvXRDjNpdwCohk7Bble4vBFfcTjdFku6wDTuZGtskc=;
 b=OJ0QvkH/eQIrz9vgr4BUWd3iCWGJ9M2R7valvHW64ASbSv9vQmEF9/qi
 XngH57ZfBKENUinWxo7w0PaVy6lo1qA0mt7C2gkFNguy6nkl2y/4y74VM
 ELe33lS6eZTxm62yAQNnNZCPNp0PwvE3z9E47oAJmDsTIQn3h0GQ0vi3h
 5RjAhstnmiPTHTzWtvPzaefZ3NC9sq1nN/ekOxKfYuwK4jsPS0eL7q8g2
 7I5poZBOhzx46OBmkFz8UL3G7DTAkGI9sXFcOP25tKiadtHzEQRTZSdz+
 snoUmNy7M+LNTuvw5vKk3FJQ1Z5IM8pU/VDYgLlIe0azuwTQeS3XXgtlf Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522830"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522830"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429572"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429572"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:42 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 6/9] ui/gtk: Add a new parameter to assign
 connectors/monitors to GFX VCs
Date: Tue, 20 Jun 2023 17:43:52 -0700
Message-Id: <20230621004355.19920-7-dongwon.kim@intel.com>
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

The new parameter named "connector" can be used to assign physical
monitors/connectors to individual GFX VCs such that when the monitor
is connected or hotplugged, the associated GTK window would be
moved to it. If the monitor is disconnected or unplugged, the
associated GTK window would be hidden and a relevant disconnect
event would be sent to the Guest.

Usage: -device virtio-gpu-pci,max_outputs=2,blob=true,...
       -display gtk,gl=on,connectors.0=eDP-1,connectors.1=DP-1.....

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 include/ui/gtk.h |   1 +
 qapi/ui.json     |  11 +-
 qemu-options.hx  |   5 +-
 ui/gtk.c         | 271 +++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 263 insertions(+), 25 deletions(-)

diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index e7c4726aad..189817ab88 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -84,6 +84,7 @@ typedef struct VirtualConsole {
     GtkWidget *menu_item;
     GtkWidget *tab_item;
     GtkWidget *focus;
+    GdkMonitor *monitor;
     VirtualConsoleType type;
     union {
         VirtualGfxConsole gfx;
diff --git a/qapi/ui.json b/qapi/ui.json
index 2755395483..0f5ab35bae 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1315,13 +1315,22 @@
 # @show-menubar: Display the main window menubar.  Defaults to "on".
 #     (Since 8.0)
 #
+# @connectors:  List of physical monitor/connector names where the GTK
+#               windows containing the respective graphics virtual consoles
+#               (VCs) are to be placed. If a mapping exists for a VC, it
+#               will be moved to that specific monitor or else it would
+#               not be displayed anywhere and would appear disconnected
+#               to the guest.
+#               (Since 8.1)
+#
 # Since: 2.12
 ##
 { 'struct'  : 'DisplayGTK',
   'data'    : { '*grab-on-hover' : 'bool',
                 '*zoom-to-fit'   : 'bool',
                 '*show-tabs'     : 'bool',
-                '*show-menubar'  : 'bool'  } }
+                '*show-menubar'  : 'bool',
+                '*connectors'    : ['str'] } }
 
 ##
 # @DisplayEGLHeadless:
diff --git a/qemu-options.hx b/qemu-options.hx
index b57489d7ca..2eb0d6a129 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2044,7 +2044,7 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
 #if defined(CONFIG_GTK)
     "-display gtk[,full-screen=on|off][,gl=on|off][,grab-on-hover=on|off]\n"
     "            [,show-tabs=on|off][,show-cursor=on|off][,window-close=on|off]\n"
-    "            [,show-menubar=on|off]\n"
+    "            [,show-menubar=on|off][,connectors.<index>=<connector name>]\n"
 #endif
 #if defined(CONFIG_VNC)
     "-display vnc=<display>[,<optargs>]\n"
@@ -2139,6 +2139,9 @@ SRST
 
         ``show-menubar=on|off`` : Display the main window menubar, defaults to "on"
 
+        ``connectors=<conn name>`` : VC to connector mappings to display the VC
+                                     window on a specific monitor
+
     ``curses[,charset=<encoding>]``
         Display video output via curses. For graphics device models
         which support a text mode, QEMU can display this output using a
diff --git a/ui/gtk.c b/ui/gtk.c
index d8323a3a9d..f4c71454a3 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -38,6 +38,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/option.h"
 
 #include "ui/console.h"
 #include "ui/gtk.h"
@@ -741,6 +742,39 @@ static void gd_set_ui_size(VirtualConsole *vc, gint width, gint height)
     dpy_set_ui_info(vc->gfx.dcl.con, &info, true);
 }
 
+static void gd_ui_hide(VirtualConsole *vc)
+{
+    QemuUIInfo info;
+
+    vc->gfx.visible = false;
+    info = *dpy_get_ui_info(vc->gfx.dcl.con);
+    info.width = 0;
+    info.height = 0;
+    dpy_set_ui_info(vc->gfx.dcl.con, &info, false);
+}
+
+static void gd_ui_show(VirtualConsole *vc)
+{
+    QemuUIInfo info;
+    GtkDisplayState *s = vc->s;
+    GdkWindow *window = gtk_widget_get_window(vc->gfx.drawing_area);
+
+    info = *dpy_get_ui_info(vc->gfx.dcl.con);
+    info.width = gdk_window_get_width(window);
+    info.height = gdk_window_get_height(window);
+    dpy_set_ui_info(vc->gfx.dcl.con, &info, false);
+
+    if (gd_is_grab_active(s)) {
+        gd_grab_keyboard(vc, "user-request-main-window");
+        gd_grab_pointer(vc, "user-request-main-window");
+    } else {
+        gd_ungrab_keyboard(s);
+        gd_ungrab_pointer(s);
+    }
+
+    vc->gfx.visible = true;
+}
+
 #if defined(CONFIG_OPENGL)
 
 static gboolean gd_render_event(GtkGLArea *area, GdkGLContext *context,
@@ -1352,12 +1386,10 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc;
     GtkNotebook *nb = GTK_NOTEBOOK(s->notebook);
-    GdkWindow *window;
     gint page;
 
     vc = gd_vc_find_current(s);
-    vc->gfx.visible = false;
-    gd_set_ui_size(vc, 0, 0);
+    gd_ui_hide(vc);
 
     vc = gd_vc_find_by_menu(s);
     gtk_release_modifiers(s);
@@ -1365,10 +1397,7 @@ static void gd_menu_switch_vc(GtkMenuItem *item, void *opaque)
         page = gtk_notebook_page_num(nb, vc->tab_item);
         gtk_notebook_set_current_page(nb, page);
         gtk_widget_grab_focus(vc->focus);
-        window = gtk_widget_get_window(vc->gfx.drawing_area);
-        gd_set_ui_size(vc, gdk_window_get_width(window),
-                       gdk_window_get_height(window));
-        vc->gfx.visible = true;
+        gd_ui_show(vc);
     }
 }
 
@@ -1398,8 +1427,8 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     VirtualConsole *vc = opaque;
     GtkDisplayState *s = vc->s;
 
-    vc->gfx.visible = false;
-    gd_set_ui_size(vc, 0, 0);
+    gd_ui_hide(vc);
+
     dpy_gl_scanout_disable(vc->gfx.dcl.con);
     gtk_widget_set_sensitive(vc->menu_item, true);
     gd_widget_reparent(vc->window, s->notebook, vc->tab_item);
@@ -1430,20 +1459,14 @@ static gboolean gd_window_state_event(GtkWidget *widget, GdkEvent *event,
     }
 
     if (event->window_state.new_window_state & GDK_WINDOW_STATE_ICONIFIED) {
-        vc->gfx.visible = false;
-        gd_set_ui_size(vc, 0, 0);
+        gd_ui_hide(vc);
         if (vc->gfx.guest_fb.dmabuf &&
             vc->gfx.guest_fb.dmabuf->draw_submitted) {
             vc->gfx.guest_fb.dmabuf->draw_submitted = false;
             graphic_hw_gl_block(vc->gfx.dcl.con, false);
         }
     } else {
-        GdkWindow *window;
-        window = gtk_widget_get_window(vc->gfx.drawing_area);
-        gd_set_ui_size(vc, gdk_window_get_width(window),
-                       gdk_window_get_height(window));
-
-        vc->gfx.visible = true;
+        gd_ui_show(vc);
     }
 
     return TRUE;
@@ -1503,7 +1526,6 @@ static void gd_tab_window_create(VirtualConsole *vc)
 static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 {
     GtkDisplayState *s = opaque;
-    GdkWindow *window;
     VirtualConsole *vc = gd_vc_find_current(s);
 
     if (vc->type == GD_VC_GFX &&
@@ -1515,10 +1537,205 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
         gd_tab_window_create(vc);
     }
 
-    window = gtk_widget_get_window(vc->gfx.drawing_area);
-    gd_set_ui_size(vc, gdk_window_get_width(window),
-                   gdk_window_get_height(window));
-    vc->gfx.visible = true;
+    gd_ui_show(vc);
+}
+
+static void gd_window_show_on_monitor(GdkDisplay *dpy, VirtualConsole *vc,
+                                      gint monitor_num)
+{
+    GtkDisplayState *s = vc->s;
+    GdkMonitor *monitor = gdk_display_get_monitor(dpy, monitor_num);
+    GdkRectangle geometry;
+
+    if (!vc->window) {
+        gd_tab_window_create(vc);
+    }
+
+    gdk_window_show(gtk_widget_get_window(vc->window));
+    gd_update_windowsize(vc);
+    gdk_monitor_get_geometry(monitor, &geometry);
+    /*
+     * Note: some compositors (mainly Wayland ones) may not honor a
+     * request to move to a particular location. The user is expected
+     * to drag the window to the preferred location in this case.
+     */
+    gtk_window_move(GTK_WINDOW(vc->window), geometry.x, geometry.y);
+
+    if (s->opts->has_full_screen && s->opts->full_screen) {
+        gtk_widget_set_size_request(vc->gfx.drawing_area, -1, -1);
+        gtk_window_fullscreen(GTK_WINDOW(vc->window));
+    }
+
+    vc->monitor = monitor;
+    gd_ui_show(vc);
+
+    if (vc->window) {
+        g_signal_connect(vc->window, "window-state-event",
+                         G_CALLBACK(gd_window_state_event), vc);
+    }
+
+    gd_update_cursor(vc);
+}
+
+static int gd_monitor_lookup(GdkDisplay *dpy, char *label)
+{
+    GdkMonitor *monitor;
+    int total_monitors = gdk_display_get_n_monitors(dpy);
+    int i;
+
+    for (i = 0; i < total_monitors; i++) {
+        monitor = gdk_display_get_monitor(dpy, i);
+        if (monitor && !g_strcmp0(gdk_monitor_get_model(monitor), label)) {
+            return i;
+        }
+    }
+    return -1;
+}
+
+static gboolean gd_vc_is_misplaced(GdkDisplay *dpy, GdkMonitor *monitor,
+                                   VirtualConsole *vc)
+{
+    GdkWindow *window = gtk_widget_get_window(vc->gfx.drawing_area);
+    GdkMonitor *mon = gdk_display_get_monitor_at_window(dpy, window);
+    const char *monitor_name = gdk_monitor_get_model(monitor);
+
+    if (!vc->monitor) {
+        if (!g_strcmp0(monitor_name, vc->label)) {
+            return TRUE;
+        }
+    } else {
+        if (mon && mon != vc->monitor) {
+            return TRUE;
+        }
+    }
+    return FALSE;
+}
+
+static void gd_vc_add_remove_monitor(GdkDisplay *dpy, GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    GdkMonitor *monitor;
+    gint monitor_num;
+    int i;
+
+    /*
+     * We need to call gd_vc_is_misplaced() after a monitor is added to
+     * ensure that the Host compositor has not moved our windows around.
+     */
+    for (i = 0; i < s->nb_vcs; i++) {
+        vc = &s->vc[i];
+        if (vc->label) {
+            monitor_num = gd_monitor_lookup(dpy, vc->label);
+            if (monitor_num >= 0) {
+                monitor = gdk_display_get_monitor(dpy, monitor_num);
+                if (gd_vc_is_misplaced(dpy, monitor, vc)) {
+                    gd_window_show_on_monitor(dpy, vc, monitor_num);
+                }
+            } else if (vc->monitor) {
+                vc->monitor = NULL;
+                if (vc->window) {
+                    g_signal_handlers_disconnect_by_func(vc->window,
+                                                 G_CALLBACK(gd_window_state_event),
+                                                 vc);
+                }
+
+                gd_ui_hide(vc);
+                /* if window exist, hide it */
+                if (vc->window) {
+                    gdk_window_hide(gtk_widget_get_window(vc->window));
+                }
+            }
+        }
+    }
+}
+
+static void gd_monitors_reset_timer(void *opaque)
+{
+    GtkDisplayState *s = opaque;
+    GdkDisplay *dpy = gdk_display_get_default();
+
+    gd_vc_add_remove_monitor(dpy, s);
+}
+
+static void gd_monitors_changed(GdkScreen *scr, void *opaque)
+{
+    GtkDisplayState *s = opaque;
+    QEMUTimer *mon_reset_timer;
+
+    mon_reset_timer = timer_new_ms(QEMU_CLOCK_REALTIME,
+                                   gd_monitors_reset_timer, s);
+    timer_mod(mon_reset_timer,
+              qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
+}
+
+static VirtualConsole *gd_next_gfx_vc(GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    int i;
+
+    for (i = 0; i < s->nb_vcs; i++) {
+        vc = &s->vc[i];
+        if (vc->type == GD_VC_GFX &&
+            qemu_console_is_graphic(vc->gfx.dcl.con) &&
+            !vc->label) {
+            return vc;
+        }
+    }
+    return NULL;
+}
+
+static void gd_vc_free_labels(GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    int i;
+
+    for (i = 0; i < s->nb_vcs; i++) {
+        vc = &s->vc[i];
+        if (vc->type == GD_VC_GFX &&
+            qemu_console_is_graphic(vc->gfx.dcl.con)) {
+            g_free(vc->label);
+            vc->label = NULL;
+        }
+    }
+}
+
+static void gd_connectors_init(GdkDisplay *dpy, GtkDisplayState *s)
+{
+    VirtualConsole *vc;
+    strList *conn;
+    gint monitor_num;
+    gboolean first_vc = TRUE;
+
+    gtk_notebook_set_show_tabs(GTK_NOTEBOOK(s->notebook), FALSE);
+    gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
+                                   FALSE);
+    gd_vc_free_labels(s);
+    for (conn = s->opts->u.gtk.connectors; conn; conn = conn->next) {
+        vc = gd_next_gfx_vc(s);
+        if (!vc) {
+            break;
+        }
+        if (first_vc) {
+            vc->window = s->window;
+            first_vc = FALSE;
+        }
+
+        vc->label = g_strdup(conn->value);
+        monitor_num = gd_monitor_lookup(dpy, vc->label);
+        if (monitor_num >= 0) {
+            gd_window_show_on_monitor(dpy, vc, monitor_num);
+        } else {
+            if (vc->window) {
+                 g_signal_handlers_disconnect_by_func(vc->window,
+                                             G_CALLBACK(gd_window_state_event),
+                                             vc);
+            }
+            gd_ui_hide(vc);
+            if (vc->window) {
+                gdk_window_hide(gtk_widget_get_window(vc->window));
+            }
+        }
+    }
 }
 
 static void gd_menu_show_menubar(GtkMenuItem *item, void *opaque)
@@ -1843,7 +2060,7 @@ static gboolean gd_configure(GtkWidget *widget,
     VirtualConsole *vc = opaque;
 
     if (vc->gfx.visible) {
-        gd_set_ui_size(vc, cfg->width, cfg->height);
+        gd_ui_show(vc);
     }
     return FALSE;
 }
@@ -2180,6 +2397,10 @@ static void gd_connect_signals(GtkDisplayState *s)
                      G_CALLBACK(gd_menu_grab_input), s);
     g_signal_connect(s->notebook, "switch-page",
                      G_CALLBACK(gd_change_page), s);
+    if (s->opts->u.gtk.has_connectors) {
+        g_signal_connect(gdk_screen_get_default(), "monitors-changed",
+                         G_CALLBACK(gd_monitors_changed), s);
+    }
 }
 
 static GtkWidget *gd_create_menu_machine(GtkDisplayState *s)
@@ -2561,6 +2782,10 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
         opts->u.gtk.show_tabs) {
         gtk_menu_item_activate(GTK_MENU_ITEM(s->show_tabs_item));
     }
+
+    if (s->opts->u.gtk.has_connectors) {
+        gd_connectors_init(window_display, s);
+    }
 #ifdef CONFIG_GTK_CLIPBOARD
     gd_clipboard_init(s);
 #endif /* CONFIG_GTK_CLIPBOARD */
-- 
2.34.1


