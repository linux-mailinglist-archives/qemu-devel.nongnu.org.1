Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E273788A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmGF-0007oZ-Jn; Tue, 20 Jun 2023 21:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGC-0007nF-Ve
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:48 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qBmGB-0001GW-3s
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687309427; x=1718845427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8ecAhgIN3FOozG45b0VPagWbfpHdvTXwa+wo0o/M2p8=;
 b=QAyRfyJracLCMnGxqnOCWRVRW+eiILo/V6TKZjqV2ierXC7qA2pEnv+4
 E2mv6fEqrNEoV99RgQk1NmotByRW7MBY58klmNGC8+55iHVNNZ4pBReRj
 U7TdA5RPTqJEL0ZC9z82xz0+tb5ekHycvPGBv9J6fy+GlS0qJi4894B+/
 kH7VhuL6C7moKzlClSOfqakcV6ufu/KNEabk7PaKZvVU2UkQ3YRE9oIP7
 VhaBZooFayUXciO348IpcLql0JVO05aWBIsizqaZ1EiiGH2n3geB8WpwO
 Om0eK5A0KFDt8+6TcX7TUUgZxfkuhVMN1kfIzBTnKJVbawScrxQVWaDRv Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="357522813"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="357522813"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="838429561"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="838429561"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga004.jf.intel.com with ESMTP; 20 Jun 2023 18:03:40 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, berrange@redhat.com, armbru@redhat.com,
 philmd@linaro.org, marcandre.lureau@redhat.com, vivek.kasireddy@intel.com,
 Dongwon Kim <dongwon.kim@intel.com>
Subject: [RFC PATCH 3/9] ui/gtk: reset visible flag when window is minimized
Date: Tue, 20 Jun 2023 17:43:49 -0700
Message-Id: <20230621004355.19920-4-dongwon.kim@intel.com>
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

Add a callback for window-state-event that resets vc->gfx.visible when
associated window is minimized or restored.

In case of virtio-gpu blob scanout, if the window is minimized before
the rendering event for the last guest scanout frame is finished, it cancels
the draw submission and unblocks the pipeline to prevent a permanent lockup.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 ui/gtk.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/ui/gtk.c b/ui/gtk.c
index ff4a5c58ea..f9096aea14 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -1419,6 +1419,35 @@ static gboolean gd_tab_window_close(GtkWidget *widget, GdkEvent *event,
     return TRUE;
 }
 
+static gboolean gd_window_state_event(GtkWidget *widget, GdkEvent *event,
+                                      void *opaque)
+{
+    VirtualConsole *vc = opaque;
+
+    if (!vc) {
+        return TRUE;
+    }
+
+    if (event->window_state.new_window_state & GDK_WINDOW_STATE_ICONIFIED) {
+        vc->gfx.visible = false;
+        gd_set_ui_size(vc, 0, 0);
+        if (vc->gfx.guest_fb.dmabuf &&
+            vc->gfx.guest_fb.dmabuf->draw_submitted) {
+            vc->gfx.guest_fb.dmabuf->draw_submitted = false;
+            graphic_hw_gl_block(vc->gfx.dcl.con, false);
+        }
+    } else {
+        GdkWindow *window;
+        window = gtk_widget_get_window(vc->gfx.drawing_area);
+        gd_set_ui_size(vc, gdk_window_get_width(window),
+                       gdk_window_get_height(window));
+
+        vc->gfx.visible = true;
+    }
+
+    return TRUE;
+}
+
 static gboolean gd_win_grab(void *opaque)
 {
     VirtualConsole *vc = opaque;
@@ -1460,6 +1489,9 @@ static void gd_menu_untabify(GtkMenuItem *item, void *opaque)
 
         g_signal_connect(vc->window, "delete-event",
                          G_CALLBACK(gd_tab_window_close), vc);
+        g_signal_connect(vc->window, "window-state-event",
+                         G_CALLBACK(gd_window_state_event), vc);
+
         gtk_widget_show_all(vc->window);
 
         if (qemu_console_is_graphic(vc->gfx.dcl.con)) {
@@ -2498,6 +2530,11 @@ static void gtk_display_init(DisplayState *ds, DisplayOptions *opts)
     }
 
     vc = gd_vc_find_current(s);
+
+    g_signal_connect(s->window, "window-state-event",
+                     G_CALLBACK(gd_window_state_event),
+                     vc);
+
     gtk_widget_set_sensitive(s->view_menu, vc != NULL);
 #ifdef CONFIG_VTE
     gtk_widget_set_sensitive(s->copy_item,
-- 
2.34.1


