Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D123B0520F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 08:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZMi-0003B9-Ae; Tue, 15 Jul 2025 02:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZF0-0003NS-M6
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:34:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ubZEy-0003io-Jr
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752561251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DKBN3+7PHd5LpCAXXeTGQanR81sYEgVkI6B9fYUCVQ=;
 b=K3qhLCNW97wW2rbZVSB0lhCpBYIGVmNYOqpTvRnZzRsNcLs2M3ro1qrEd/d2VnT6b/4Dwk
 e1M/hYcQKUBGTdWO0s0vy3fiB9fIJnpPeLMzL5lk2JL4MqOAjogWPwunmnFDcx1mk7dF6g
 EmrjedgdT7fJl1H6pheaohd3aDLabFs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-bPUKmgsxPLirvJ21-TXU_Q-1; Tue,
 15 Jul 2025 02:34:07 -0400
X-MC-Unique: bPUKmgsxPLirvJ21-TXU_Q-1
X-Mimecast-MFC-AGG-ID: bPUKmgsxPLirvJ21-TXU_Q_1752561246
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C229F1808993; Tue, 15 Jul 2025 06:34:05 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E372218046C7; Tue, 15 Jul 2025 06:34:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PULL v2 09/13] ui/spice: Blit the scanout texture if its memory
 layout is not linear
Date: Tue, 15 Jul 2025 10:32:55 +0400
Message-ID: <20250715063301.145191-10-marcandre.lureau@redhat.com>
In-Reply-To: <20250715063301.145191-1-marcandre.lureau@redhat.com>
References: <20250715063301.145191-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
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

In cases where the scanout buffer is provided as a texture (e.g. Virgl)
we need to check to see if it has a linear memory layout or not. If
it doesn't have a linear layout, then blitting it onto the texture
associated with the display surface (which already has a linear layout)
seems to ensure that there is no corruption seen regardless of which
encoder or decoder is used.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Message-Id: <20250617043546.1022779-8-vivek.kasireddy@intel.com>
---
 include/ui/spice-display.h |  3 ++
 ui/spice-display.c         | 81 +++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 9bdde78266..690ece7380 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -132,6 +132,9 @@ struct SimpleSpiceDisplay {
     egl_fb guest_fb;
     egl_fb blit_fb;
     egl_fb cursor_fb;
+    bool backing_y_0_top;
+    bool blit_scanout_texture;
+    bool new_scanout_texture;
     bool have_hot;
 #endif
 };
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 854a97c198..9ce622cefc 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1086,7 +1086,7 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;
-    int fd[DMABUF_MAX_PLANES], num_planes;
+    int fd[DMABUF_MAX_PLANES], num_planes, i;
     uint64_t modifier;
 
     assert(tex_id);
@@ -1098,11 +1098,26 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
 
     trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
-    /* note: spice server will close the fd */
-    spice_server_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
-                            (uint32_t *)offset, (uint32_t *)stride, num_planes,
-                            fourcc, modifier, y_0_top);
-    qemu_spice_gl_monitor_config(ssd, x, y, w, h);
+    if (spice_remote_client && modifier != DRM_FORMAT_MOD_LINEAR) {
+        egl_fb_destroy(&ssd->guest_fb);
+        egl_fb_setup_for_tex(&ssd->guest_fb,
+                             backing_width, backing_height,
+                             tex_id, false);
+        ssd->backing_y_0_top = y_0_top;
+        ssd->blit_scanout_texture = true;
+        ssd->new_scanout_texture = true;
+
+        for (i = 0; i < num_planes; i++) {
+            close(fd[i]);
+        }
+    } else {
+        /* note: spice server will close the fd */
+        spice_server_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
+                                (uint32_t *)offset, (uint32_t *)stride,
+                                num_planes, fourcc, modifier, y_0_top);
+        qemu_spice_gl_monitor_config(ssd, x, y, w, h);
+    }
+
     ssd->have_surface = false;
     ssd->have_scanout = true;
 }
@@ -1168,6 +1183,50 @@ static void qemu_spice_gl_release_dmabuf(DisplayChangeListener *dcl,
     egl_dmabuf_release_texture(dmabuf);
 }
 
+static bool spice_gl_blit_scanout_texture(SimpleSpiceDisplay *ssd,
+                                          egl_fb *scanout_tex_fb)
+{
+    uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+    int fds[DMABUF_MAX_PLANES], num_planes, fourcc;
+    uint64_t modifier;
+    bool ret;
+
+    egl_fb_destroy(scanout_tex_fb);
+    egl_fb_setup_for_tex(scanout_tex_fb,
+                         surface_width(ssd->ds), surface_height(ssd->ds),
+                         ssd->ds->texture, false);
+    egl_fb_blit(scanout_tex_fb, &ssd->guest_fb, false);
+    glFlush();
+
+    if (!ssd->new_scanout_texture) {
+        return true;
+    }
+
+    ret = egl_dmabuf_export_texture(ssd->ds->texture,
+                                    fds,
+                                    (EGLint *)offsets,
+                                    (EGLint *)strides,
+                                    &fourcc,
+                                    &num_planes,
+                                    &modifier);
+    if (!ret) {
+        error_report("spice: failed to get fd for texture");
+        return false;
+    }
+
+    spice_server_gl_scanout(&ssd->qxl, fds,
+                            surface_width(ssd->ds),
+                            surface_height(ssd->ds),
+                            (uint32_t *)offsets, (uint32_t *)strides,
+                            num_planes, fourcc, modifier,
+                            ssd->backing_y_0_top);
+    qemu_spice_gl_monitor_config(ssd, 0, 0,
+                                 surface_width(ssd->ds),
+                                 surface_height(ssd->ds));
+    ssd->new_scanout_texture = false;
+    return true;
+}
+
 static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
@@ -1175,6 +1234,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     EGLint fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
+    bool ret;
     uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
@@ -1269,6 +1329,15 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
         glFlush();
     }
 
+    if (spice_remote_client && ssd->blit_scanout_texture) {
+        egl_fb scanout_tex_fb;
+
+        ret = spice_gl_blit_scanout_texture(ssd, &scanout_tex_fb);
+        if (!ret) {
+            return;
+        }
+    }
+
     trace_qemu_spice_gl_update(ssd->qxl.id, w, h, x, y);
     qemu_spice_gl_block(ssd, true);
     glFlush();
-- 
2.50.0


