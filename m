Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446ABA728ED
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Mar 2025 04:00:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txdT3-0006y8-VM; Wed, 26 Mar 2025 22:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdT2-0006xj-HC
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:40 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuq825@gmail.com>) id 1txdT0-0007ff-KH
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 22:59:40 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so906156a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743044377; x=1743649177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scZB3kO1v79bpMnUIX9O7OHn0/vGdtuwxgVoyMOdinc=;
 b=Ak8TGq6kdgLyDLowBwOmfeGlO1WQStX62GO0rq5I/ZykP9fg5C3aY/KIt9qWFzVeup
 ZFwDL0p2oNh7jCQ5A1DXsyQyauxhBiwVoXXwtSDVq2X5k2R/Ma/fPTA0XExQKI1KeSBl
 ube/Pg/0iiRtUbR5yQuzUsxWbxUlttaXWtCojAUMDPzBo/KbBD7xb+ahoX3TnyODHCPu
 2b02k1hQBp3kMMUckHQPZ8KbzljE2hpaWx3ZwEnsHF0vjLI+KjgKKaEYh0cmd7N6kpng
 nFQ2jRd5V41nVLmL7hnrqnk33AebHCO4g2fu7UlJMG84qTeLX5EK/C8t8/Iu0eSbm0Is
 j85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743044377; x=1743649177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=scZB3kO1v79bpMnUIX9O7OHn0/vGdtuwxgVoyMOdinc=;
 b=ESm8G/AsekL17JyEzrIIdJu4VfYRWoKpDxCnUMSE6NboTIVmQt8iM/fbK6OOUyaqic
 JFLqlhQ9nxrowvPUuar0kFXJSIIMzKx1fDKt5CxFiSYFnhszRJhjy6WH9LsPqz0HD+jb
 uy/7awof+5FY+NHho5RWoowIbXdGujnBMpcx3SxZDdMO+cPTlLkG2lOqVcNUcoAKChrZ
 4V3DD7lQ2qb/kRr/ha4ylt05L2H3so6sP8bFNsIuLNn3qNcP9VBBjysajxAKQjIiDgjx
 q/InXt158Rvo4+1d+oFIpwX9EpDtW5Q04JQBTXmgkqsB1+ifN6gKqb0FBfwG+lsqgQeQ
 tb1A==
X-Gm-Message-State: AOJu0YzJjJlF3ChF8+rClequTLz9zKSshdieuJNwPs2/ZV5oPQ+a7ZXv
 FtoLuMu7kTPtXT7XJwOQFMaen6H1QYhoh266kTOEvn9eS59pIXonDeHrFbKJ
X-Gm-Gg: ASbGncvPj79m8JoNEQVz1DyxqX+LCUTa8Af6nZwDe3w9UneYg22uGUpRxD9oOyhR0iz
 bmesmJUnJlfrDXopwd0vgED2tTIImzqDfz2jzRabmj0U1Tzs9N/CPtY0EkCYHNSn0D/V/mhOQD4
 TROhjcKQd7lNZ6GB0X4v7NSMqSyRRiDMZLzBTT8WAvAcPa+zk12oXhpXs1RNJzEAZjqQ4CW7IL5
 I6PRCukbDjTx0cNzjbx49cBeTHdMkR00kKgCVofVWAbc25YpKC28Ypm07/gDftvqBVhKhVlczvv
 fMzqGqGVWi3rXTvhtjFYvNIK0fj2Jqq08Ir4qBW31c49+twepvEcYclWpx2HS91bImCEM8av7uR
 NVByqk361l6Ve/4W3NrBv
X-Google-Smtp-Source: AGHT+IFjYQfLvEuCmfEkgVB/MjtUEmCR+/eNpIX86OPb320m8Rj0Q3V3Teyi5uA8bOIcEvTaxlp3Nw==
X-Received: by 2002:a17:90a:e184:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-303a919374emr2973744a91.33.1743044376479; 
 Wed, 26 Mar 2025 19:59:36 -0700 (PDT)
Received: from localhost.localdomain (awork062150.netvigator.com.
 [203.198.28.150]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd37e5sm1027698a91.2.2025.03.26.19.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 19:59:36 -0700 (PDT)
From: yuq825@gmail.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Qiang Yu <yuq825@gmail.com>
Subject: [PATCH v3 6/6] ui/spice: support multi plane dmabuf scanout
Date: Thu, 27 Mar 2025 10:58:48 +0800
Message-ID: <20250327025848.46962-7-yuq825@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327025848.46962-1-yuq825@gmail.com>
References: <20250327025848.46962-1-yuq825@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=yuq825@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Qiang Yu <yuq825@gmail.com>

We need spice version >= 0.15.3 which has spice_qxl_gl_scanout2
API for multi plane scanout support.

v2:
  * use new dmabuf API and check length
  * check spice_qxl_gl_scanout2 present instead of
    bump spice version dependency

Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 meson.build        |  5 +++
 ui/spice-display.c | 90 +++++++++++++++++++++++++++++-----------------
 2 files changed, 63 insertions(+), 32 deletions(-)

diff --git a/meson.build b/meson.build
index 9d9c11731f..7c4c81aa78 100644
--- a/meson.build
+++ b/meson.build
@@ -3173,6 +3173,11 @@ if host_os == 'windows'
     }''', name: '_lock_file and _unlock_file'))
 endif
 
+if spice.found()
+  config_host_data.set('HAVE_SPICE_QXL_GL_SCANOUT2',
+    cc.has_function('spice_qxl_gl_scanout2', dependencies: spice))
+endif
+
 if host_os == 'windows'
   mingw_has_setjmp_longjmp = cc.links('''
     #include <setjmp.h>
diff --git a/ui/spice-display.c b/ui/spice-display.c
index d7ebb3682d..38ee47e4c1 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -28,6 +28,8 @@
 
 #include "ui/spice-display.h"
 
+#include "standard-headers/drm/drm_fourcc.h"
+
 bool spice_opengl;
 
 int qemu_spice_rect_is_empty(const QXLRect* r)
@@ -872,6 +874,26 @@ static void spice_gl_update(DisplayChangeListener *dcl,
     ssd->gl_updates++;
 }
 
+static void spice_server_gl_scanout(QXLInstance *qxl,
+                                    const int *fd,
+                                    uint32_t width, uint32_t height,
+                                    const uint32_t *offset,
+                                    const uint32_t *stride,
+                                    uint32_t num_planes, uint32_t format,
+                                    uint64_t modifier, int y_0_top)
+{
+#ifdef HAVE_SPICE_QXL_GL_SCANOUT2
+    spice_qxl_gl_scanout2(qxl, fd, width, height, offset, stride,
+                          num_planes, format, modifier, y_0_top);
+#else
+    if (num_planes <= 1) {
+        spice_qxl_gl_scanout(qxl, fd[0], width, height, stride[0], format, y_0_top);
+    } else {
+        error_report("SPICE server does not support multi plane GL scanout");
+    }
+#endif
+}
+
 static void spice_gl_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface)
 {
@@ -884,16 +906,11 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
     if (ssd->ds) {
         uint32_t offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES];
         int fd[DMABUF_MAX_PLANES], num_planes, fourcc;
+        uint64_t modifier;
 
         surface_gl_create_texture(ssd->gls, ssd->ds);
         if (!egl_dmabuf_export_texture(ssd->ds->texture, fd, (EGLint *)offset,
-                                       (EGLint *)stride, &fourcc, &num_planes, NULL)) {
-            surface_gl_destroy_texture(ssd->gls, ssd->ds);
-            return;
-        }
-
-        if (num_planes > 1) {
-            fprintf(stderr, "%s: does not support multi-plane texture\n", __func__);
+                                       (EGLint *)stride, &fourcc, &num_planes, &modifier)) {
             surface_gl_destroy_texture(ssd->gls, ssd->ds);
             return;
         }
@@ -904,10 +921,11 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                                     fourcc);
 
         /* note: spice server will close the fd */
-        spice_qxl_gl_scanout(&ssd->qxl, fd[0],
-                             surface_width(ssd->ds),
-                             surface_height(ssd->ds),
-                             stride[0], fourcc, false);
+        spice_server_gl_scanout(&ssd->qxl, fd,
+                                surface_width(ssd->ds),
+                                surface_height(ssd->ds),
+                                offset, stride, num_planes,
+                                fourcc, modifier, false);
         ssd->have_surface = true;
         ssd->have_scanout = false;
 
@@ -930,7 +948,8 @@ static void qemu_spice_gl_scanout_disable(DisplayChangeListener *dcl)
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
 
     trace_qemu_spice_gl_scanout_disable(ssd->qxl.id);
-    spice_qxl_gl_scanout(&ssd->qxl, -1, 0, 0, 0, 0, false);
+    spice_server_gl_scanout(&ssd->qxl, NULL, 0, 0, NULL, NULL, 0, DRM_FORMAT_INVALID,
+                            DRM_FORMAT_MOD_INVALID, false);
     qemu_spice_gl_monitor_config(ssd, 0, 0, 0, 0);
     ssd->have_surface = false;
     ssd->have_scanout = false;
@@ -948,22 +967,21 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint offset[DMABUF_MAX_PLANES], stride[DMABUF_MAX_PLANES], fourcc = 0;
     int fd[DMABUF_MAX_PLANES], num_planes;
+    uint64_t modifier;
 
     assert(tex_id);
     if (!egl_dmabuf_export_texture(tex_id, fd, offset, stride, &fourcc,
-                                   &num_planes, NULL)) {
+                                   &num_planes, &modifier)) {
         fprintf(stderr, "%s: failed to export dmabuf for texture\n", __func__);
         return;
     }
-    if (num_planes > 1) {
-        fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __func__);
-        return;
-    }
+
     trace_qemu_spice_gl_scanout_texture(ssd->qxl.id, w, h, fourcc);
 
     /* note: spice server will close the fd */
-    spice_qxl_gl_scanout(&ssd->qxl, fd[0], backing_width, backing_height,
-                         stride[0], fourcc, y_0_top);
+    spice_server_gl_scanout(&ssd->qxl, fd, backing_width, backing_height,
+                            (uint32_t *)offset, (uint32_t *)stride, num_planes,
+                            fourcc, modifier, y_0_top);
     qemu_spice_gl_monitor_config(ssd, x, y, w, h);
     ssd->have_surface = false;
     ssd->have_scanout = true;
@@ -1034,11 +1052,10 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y, uint32_t w, uint32_t h)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
-    EGLint stride = 0, fourcc = 0;
+    EGLint fourcc = 0;
     bool render_cursor = false;
     bool y_0_top = false; /* FIXME */
     uint64_t cookie;
-    int fd;
     uint32_t width, height, texture;
 
     if (!ssd->have_scanout) {
@@ -1075,6 +1092,7 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                 ssd->blit_fb.height != height) {
                 int fds[DMABUF_MAX_PLANES], num_planes;
                 uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+                uint64_t modifier;
 
                 trace_qemu_spice_gl_render_dmabuf(ssd->qxl.id, width,
                                                   height);
@@ -1083,27 +1101,35 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
                                      width, height);
                 if (!egl_dmabuf_export_texture(ssd->blit_fb.texture, fds,
                                                (EGLint *)offsets, (EGLint *)strides,
-                                               &fourcc, &num_planes, NULL)) {
+                                               &fourcc, &num_planes, &modifier)) {
                     fprintf(stderr, "%s: failed to export dmabuf for texture\n", __func__);
                     return;
                 }
-                if (num_planes > 1) {
-                    fprintf(stderr, "%s: does not support multi-plane dmabuf\n", __func__);
-                    return;
-                }
-                spice_qxl_gl_scanout(&ssd->qxl, fds[0], width, height,
-                                     strides[0], fourcc, false);
+
+                spice_server_gl_scanout(&ssd->qxl, fds, width, height, offsets, strides,
+                                        num_planes, fourcc, modifier, false);
             }
         } else {
-            stride = qemu_dmabuf_get_strides(dmabuf, NULL)[0];
+            int fds[DMABUF_MAX_PLANES];
+            int noffsets, nstrides;
+            const uint32_t *offsets = qemu_dmabuf_get_offsets(dmabuf, &noffsets);
+            const uint32_t *strides = qemu_dmabuf_get_strides(dmabuf, &nstrides);
+            uint32_t num_planes = qemu_dmabuf_get_num_planes(dmabuf);
+
+            assert(noffsets >= num_planes);
+            assert(nstrides >= num_planes);
+
             fourcc = qemu_dmabuf_get_fourcc(dmabuf);
             y_0_top = qemu_dmabuf_get_y0_top(dmabuf);
-            qemu_dmabuf_dup_fds(dmabuf, &fd, 1);
+            qemu_dmabuf_dup_fds(dmabuf, fds, DMABUF_MAX_PLANES);
 
             trace_qemu_spice_gl_forward_dmabuf(ssd->qxl.id, width, height);
             /* note: spice server will close the fd, so hand over a dup */
-            spice_qxl_gl_scanout(&ssd->qxl, fd, width, height,
-                                 stride, fourcc, y_0_top);
+            spice_server_gl_scanout(&ssd->qxl, fds, width, height,
+                                    offsets, strides, num_planes,
+                                    fourcc,
+                                    qemu_dmabuf_get_modifier(dmabuf),
+                                    y_0_top);
         }
         qemu_spice_gl_monitor_config(ssd, 0, 0, width, height);
         ssd->guest_dmabuf_refresh = false;
-- 
2.43.0


