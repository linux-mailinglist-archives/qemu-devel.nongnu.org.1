Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 143C0B03E01
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Jul 2025 14:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHk5-0005jl-Ck; Mon, 14 Jul 2025 07:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6M-0006xL-HD
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubH6K-0003RD-CK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/4myqjH/Kdl7ZWCnYA3d+VdEmgMCkL9UEwDV1RI1+bc=;
 b=CJpYAaRTWfPlUfkeYcMwvLQh+gxcyZ9l+HvTabiDXPFEG7Rky3tUWy7H4dZ1QMy8FqowQW
 uDGHexBMDwJckUBqjlPiN2LZSBRaeo4oev073dak2YvrvP2+mM43f0KByApaPxox0KANnR
 borMbovzD2O43pto1DcPZJSEMbym9i8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644--CDi-feGM_KNAB9sB405tA-1; Mon,
 14 Jul 2025 07:12:00 -0400
X-MC-Unique: -CDi-feGM_KNAB9sB405tA-1
X-Mimecast-MFC-AGG-ID: -CDi-feGM_KNAB9sB405tA_1752491519
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2AF8119560B6; Mon, 14 Jul 2025 11:11:59 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4E221956094; Mon, 14 Jul 2025 11:11:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Weifeng Liu <weifeng.liu.z@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 12/13] ui/gtk: Add scale option
Date: Mon, 14 Jul 2025 15:10:35 +0400
Message-ID: <20250714111039.4150419-13-marcandre.lureau@redhat.com>
In-Reply-To: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
References: <20250714111039.4150419-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Weifeng Liu <weifeng.liu.z@gmail.com>

Allow user to set a preferred scale (defaulting to 1) of the virtual
display. Along with zoom-to-fix=false, this would be helpful for users
running QEMU on hi-dpi host desktop to achieve pixel to pixel display --
e.g., if the scale factor of a user's host desktop is set to 200%, then
they can set a 0.5 scale for the virtual display to avoid magnification
that might cause blurriness.

Signed-off-by: Weifeng Liu <weifeng.liu.z@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20250601045245.36778-3-weifeng.liu.z@gmail.com>
---
 qapi/ui.json     |  5 ++++-
 include/ui/gtk.h |  1 +
 ui/gtk.c         | 46 +++++++++++++++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 9e496b4835..a465d671c7 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1338,6 +1338,8 @@
 # @keep-aspect-ratio: Keep width/height aspect ratio of guest content when
 #     resizing host window.  Defaults to "on". (Since 10.1)
 #
+# @scale: Set preferred scale of the display.  Defaults to 1.0.  (Since 10.1)
+#
 # Since: 2.12
 ##
 { 'struct'  : 'DisplayGTK',
@@ -1345,7 +1347,8 @@
                 '*zoom-to-fit'       : 'bool',
                 '*show-tabs'         : 'bool',
                 '*show-menubar'      : 'bool',
-                '*keep-aspect-ratio' : 'bool'  } }
+                '*keep-aspect-ratio' : 'bool',
+                '*scale'             : 'number'  } }
 
 ##
 # @DisplayEGLHeadless:
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index b7cfbf218e..3e6ce3cb48 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -41,6 +41,7 @@ typedef struct VirtualGfxConsole {
     DisplaySurface *ds;
     pixman_image_t *convert;
     cairo_surface_t *surface;
+    double preferred_scale;
     double scale_x;
     double scale_y;
 #if defined(CONFIG_OPENGL)
diff --git a/ui/gtk.c b/ui/gtk.c
index 9104509ee1..e91d093a49 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -67,6 +67,7 @@
 #define VC_TERM_X_MIN     80
 #define VC_TERM_Y_MIN     25
 #define VC_SCALE_MIN    0.25
+#define VC_SCALE_MAX       4
 #define VC_SCALE_STEP   0.25
 
 #ifdef GDK_WINDOWING_X11
@@ -272,15 +273,11 @@ static void gd_update_geometry_hints(VirtualConsole *vc)
         if (!vc->gfx.ds) {
             return;
         }
-        if (s->free_scale) {
-            geo.min_width  = surface_width(vc->gfx.ds) * VC_SCALE_MIN;
-            geo.min_height = surface_height(vc->gfx.ds) * VC_SCALE_MIN;
-            mask |= GDK_HINT_MIN_SIZE;
-        } else {
-            geo.min_width  = surface_width(vc->gfx.ds) * vc->gfx.scale_x;
-            geo.min_height = surface_height(vc->gfx.ds) * vc->gfx.scale_y;
-            mask |= GDK_HINT_MIN_SIZE;
-        }
+        double scale_x = s->free_scale ? VC_SCALE_MIN : vc->gfx.scale_x;
+        double scale_y = s->free_scale ? VC_SCALE_MIN : vc->gfx.scale_y;
+        geo.min_width  = surface_width(vc->gfx.ds) * scale_x;
+        geo.min_height = surface_height(vc->gfx.ds) * scale_y;
+        mask |= GDK_HINT_MIN_SIZE;
         geo_widget = vc->gfx.drawing_area;
         gtk_widget_set_size_request(geo_widget, geo.min_width, geo.min_height);
 
@@ -1579,8 +1576,8 @@ static void gd_menu_full_screen(GtkMenuItem *item, void *opaque)
         }
         s->full_screen = FALSE;
         if (vc->type == GD_VC_GFX) {
-            vc->gfx.scale_x = 1.0;
-            vc->gfx.scale_y = 1.0;
+            vc->gfx.scale_x = vc->gfx.preferred_scale;
+            vc->gfx.scale_y = vc->gfx.preferred_scale;
             gd_update_windowsize(vc);
         }
     }
@@ -1636,8 +1633,8 @@ static void gd_menu_zoom_fixed(GtkMenuItem *item, void *opaque)
     GtkDisplayState *s = opaque;
     VirtualConsole *vc = gd_vc_find_current(s);
 
-    vc->gfx.scale_x = 1.0;
-    vc->gfx.scale_y = 1.0;
+    vc->gfx.scale_x = vc->gfx.preferred_scale;
+    vc->gfx.scale_y = vc->gfx.preferred_scale;
 
     gd_update_windowsize(vc);
 }
@@ -1651,8 +1648,8 @@ static void gd_menu_zoom_fit(GtkMenuItem *item, void *opaque)
         s->free_scale = TRUE;
     } else {
         s->free_scale = FALSE;
-        vc->gfx.scale_x = 1.0;
-        vc->gfx.scale_y = 1.0;
+        vc->gfx.scale_x = vc->gfx.preferred_scale;
+        vc->gfx.scale_y = vc->gfx.preferred_scale;
     }
 
     gd_update_windowsize(vc);
@@ -2243,6 +2240,11 @@ static void gl_area_realize(GtkGLArea *area, VirtualConsole *vc)
 }
 #endif
 
+static bool gd_scale_valid(double scale)
+{
+    return scale >= VC_SCALE_MIN && scale <= VC_SCALE_MAX;
+}
+
 static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
                               QemuConsole *con, int idx,
                               GSList *group, GtkWidget *view_menu)
@@ -2252,8 +2254,18 @@ static GSList *gd_vc_gfx_init(GtkDisplayState *s, VirtualConsole *vc,
 
     vc->label = qemu_console_get_label(con);
     vc->s = s;
-    vc->gfx.scale_x = 1.0;
-    vc->gfx.scale_y = 1.0;
+    vc->gfx.preferred_scale = 1.0;
+    if (s->opts->u.gtk.has_scale) {
+        if (gd_scale_valid(s->opts->u.gtk.scale)) {
+            vc->gfx.preferred_scale = s->opts->u.gtk.scale;
+        } else {
+            error_report("Invalid scale value %lf given, being ignored",
+                         s->opts->u.gtk.scale);
+            s->opts->u.gtk.has_scale = false;
+        }
+    }
+    vc->gfx.scale_x = vc->gfx.preferred_scale;
+    vc->gfx.scale_y = vc->gfx.preferred_scale;
 
 #if defined(CONFIG_OPENGL)
     if (display_opengl) {
-- 
2.50.0


