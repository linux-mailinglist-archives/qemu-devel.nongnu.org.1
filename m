Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E803B051F5
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 08:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZKb-0000bw-I8; Tue, 15 Jul 2025 02:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZEg-0003BG-35
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZEd-0003gW-TE
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZ6ede4IF7hcbtbVARxcoQx/2guiV8SEtwPpCfCALO4=;
 b=djLO6zrIEqPXsS57S//gvXevF5nSBq+FKh9gteCgrhZ6tDS1n8PA1nJdPpdAbv3xRkqIp2
 s863f5aFAtANr4nhJxKmITQ3qTpe2VeXE4JGq5oN9tTx91/pRmbcZvXb9G7ySgEW2/Sugj
 WHvkXqOy7JaN4gPoTGWCVwtbGSeIZGU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-TzNAe1L3NHa5DQtGfp50ig-1; Tue,
 15 Jul 2025 02:33:48 -0400
X-MC-Unique: TzNAe1L3NHa5DQtGfp50ig-1
X-Mimecast-MFC-AGG-ID: TzNAe1L3NHa5DQtGfp50ig_1752561227
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36BF719560AD; Tue, 15 Jul 2025 06:33:47 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97B951977000; Tue, 15 Jul 2025 06:33:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PULL v2 06/13] ui/spice: Add an option to submit gl_draw requests at
 fixed rate
Date: Tue, 15 Jul 2025 10:32:52 +0400
Message-ID: <20250715063301.145191-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250715063301.145191-1-marcandre.lureau@redhat.com>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

From: Vivek Kasireddy <vivek.kasireddy@intel.com>

In the specific case where the display layer (virtio-gpu) is using
dmabuf, and if remote clients are enabled (-spice gl=on,port=xxxx),
it makes sense to limit the maximum (streaming) rate (refresh rate)
to a fixed value using the GUI refresh timer. Otherwise, the updates
or gl_draw requests would be sent as soon as the Guest submits a new
frame which is not optimal as it would lead to increased network
traffic and wastage of GPU cycles if the frames get dropped.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Message-Id: <20250617043546.1022779-5-vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h |  1 +
 ui/spice-core.c            | 12 ++++++++
 ui/spice-display.c         | 62 ++++++++++++++++++++++++++++++++------
 qemu-options.hx            |  5 +++
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 6c55f38c8b..9bdde78266 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -152,6 +152,7 @@ struct SimpleSpiceCursor {
 
 extern bool spice_opengl;
 extern bool spice_remote_client;
+extern int spice_max_refresh_rate;
 
 int qemu_spice_rect_is_empty(const QXLRect* r);
 void qemu_spice_rect_union(QXLRect *dest, const QXLRect *r);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 51bdcef1af..5992f9daec 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -56,6 +56,8 @@ struct SpiceTimer {
     QEMUTimer *timer;
 };
 
+#define DEFAULT_MAX_REFRESH_RATE 30
+
 static SpiceTimer *timer_add(SpiceTimerFunc func, void *opaque)
 {
     SpiceTimer *timer;
@@ -491,6 +493,9 @@ static QemuOptsList qemu_spice_opts = {
         },{
             .name = "video-codec",
             .type = QEMU_OPT_STRING,
+        },{
+            .name = "max-refresh-rate",
+            .type = QEMU_OPT_NUMBER,
         },{
             .name = "agent-mouse",
             .type = QEMU_OPT_BOOL,
@@ -804,6 +809,13 @@ static void qemu_spice_init(void)
         spice_server_set_streaming_video(spice_server, SPICE_STREAM_VIDEO_OFF);
     }
 
+    spice_max_refresh_rate = qemu_opt_get_number(opts, "max-refresh-rate",
+                                                 DEFAULT_MAX_REFRESH_RATE);
+    if (spice_max_refresh_rate <= 0) {
+        error_report("max refresh rate/fps is invalid");
+        exit(1);
+    }
+
     spice_server_set_agent_mouse
         (spice_server, qemu_opt_get_bool(opts, "agent-mouse", 1));
     spice_server_set_playback_compression
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 0fb72f6d6f..e409b6bdb2 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -32,6 +32,7 @@
 
 bool spice_opengl;
 bool spice_remote_client;
+int spice_max_refresh_rate;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
 {
@@ -844,12 +845,32 @@ static void qemu_spice_gl_block_timer(void *opaque)
     warn_report("spice: no gl-draw-done within one second");
 }
 
+static void spice_gl_draw(SimpleSpiceDisplay *ssd,
+                           uint32_t x, uint32_t y, uint32_t w, uint32_t h)
+{
+    uint64_t cookie;
+
+    cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
+    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
+}
+
 static void spice_gl_refresh(DisplayChangeListener *dcl)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
-    uint64_t cookie;
 
-    if (!ssd->ds || qemu_console_is_gl_blocked(ssd->dcl.con)) {
+    if (!ssd->ds) {
+        return;
+    }
+
+    if (qemu_console_is_gl_blocked(ssd->dcl.con)) {
+        if (spice_remote_client && ssd->gl_updates && ssd->have_scanout) {
+            glFlush();
+            spice_gl_draw(ssd, 0, 0,
+                          surface_width(ssd->ds), surface_height(ssd->ds));
+            ssd->gl_updates = 0;
+            /* E.g, to achieve 60 FPS, update_interval needs to be ~16.66 ms */
+            dcl->update_interval = 1000 / spice_max_refresh_rate;
+        }
         return;
     }
 
@@ -857,11 +878,8 @@ static void spice_gl_refresh(DisplayChangeListener *dcl)
     if (ssd->gl_updates && ssd->have_surface) {
         qemu_spice_gl_block(ssd, true);
         glFlush();
-        cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
-        spice_qxl_gl_draw_async(&ssd->qxl, 0, 0,
-                                surface_width(ssd->ds),
-                                surface_height(ssd->ds),
-                                cookie);
+        spice_gl_draw(ssd, 0, 0,
+                      surface_width(ssd->ds), surface_height(ssd->ds));
         ssd->gl_updates = 0;
     }
 }
@@ -954,6 +972,20 @@ static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
     trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
+
+    /*
+     * We need to check for the case of "lost" updates, where a gl_draw
+     * was not submitted because the timer did not get a chance to run.
+     * One case where this happens is when the Guest VM is getting
+     * rebooted. If the console is blocked in this situation, we need
+     * to unblock it. Otherwise, newer updates would not take effect.
+     */
+    if (qemu_console_is_gl_blocked(ssd->dcl.con)) {
+        if (spice_remote_client && ssd->gl_updates && ssd->have_scanout) {
+            ssd->gl_updates = 0;
+            qemu_spice_gl_block(ssd, false);
+        }
+    }
     spice_server_gl_scanout(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FORMAT_INVALID,
                             DRM_FORMAT_MOD_INVALID, false);
     qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
@@ -1061,7 +1093,6 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     EGLint fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
-    uint64_t cookie;
     uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
@@ -1159,8 +1190,19 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
     glFlush();
-    cookie = (uintptr_t)qxl_cookie_new(QXL_COOKIE_TYPE_GL_DRAW_DONE, 0);
-    spice_qxl_gl_draw_async(&ssd->qxl, x, y, w, h, cookie);
+
+    /*
+     * In the case of remote clients, the submission of gl_draw request is
+     * deferred here, so that it can be submitted later (to spice server)
+     * from spice_gl_refresh() timer callback. This is done to ensure that
+     * Guest updates are submitted at a steady rate (e.g. 60 FPS) instead
+     * of submitting them arbitrarily.
+     */
+    if (spice_remote_client) {
+        ssd->gl_updates++;
+    } else {
+        spice_gl_draw(ssd, x, y, w, h);
+    }
 }
 
 static const DisplayChangeListenerOps display_listener_gl_ops = {
diff --git a/qemu-options.hx b/qemu-options.hx
index 8f6a228a89..ac09abfd71 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2282,6 +2282,7 @@ DEF("spice", HAS_ARG, QEMU_OPTION_spice,
     "       [,disable-agent-file-xfer=on|off][,agent-mouse=[on|off]]\n"
     "       [,playback-compression=[on|off]][,seamless-migration=[on|off]]\n"
     "       [,video-codec=<codec>\n"
+    "       [,max-refresh-rate=rate\n"
     "       [,gl=[on|off]][,rendernode=<file>]\n"
     "                enable spice\n"
     "                at least one of {port, tls-port} is mandatory\n",
@@ -2377,6 +2378,10 @@ SRST
         would be used as default. And, for the case where gl=off, the
         default codec to be used is determined by the Spice server.
 
+    ``max-refresh-rate=rate``
+        Provide the maximum refresh rate (or FPS) at which the encoding
+        requests should be sent to the Spice server. Default would be 30.
+
     ``gl=[on|off]``
         Enable/disable OpenGL context. Default is off.
 
-- 
2.50.0


