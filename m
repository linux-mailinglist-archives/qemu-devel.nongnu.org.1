Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2BAADC0EA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Jun 2025 06:39:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRO5k-0002ri-1J; Tue, 17 Jun 2025 00:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5h-0002rC-KE
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:33 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uRO5f-0007ja-P7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 00:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750135112; x=1781671112;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H+bzC9R1rwWKRfo5+CXouNBCZFJm6s2WQLQ7fPjkRDk=;
 b=dW+ljxqmR1YRtukkRYI9z3xbagbFjLlrdEoffgAQlS6NOPo1jdFX5cbo
 Mk7nPQaZDCt2jeD0zhteavPVZTC3OTM9ANr9FWe6dLZtYWNwlC0+18EL+
 BXt0P27AjCBGJmNnokLezpGW4NEntZrvKovorE4c6JmAyaPiejf00ru3Y
 QTng7SJYNCIy8bW08l2ED789vbUNI3WPZ9q4UbV60F28zs9zsHjkA2pcF
 I6T8ODB7bPtdWy5txWKzWIA03FIIhfvx6U3qf+KH9MBhHrl672YIAVUCI
 cSqp5lGJqEhnEt5ITKRE38CqmM+TKDshHXLHHKYxBqx087oS4bwXBbnL0 A==;
X-CSE-ConnectionGUID: ALhmFZ3DR7agnYiaz9CmMQ==
X-CSE-MsgGUID: c4G4DglpR9Sy7KrM/PlckA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52432320"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="52432320"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:26 -0700
X-CSE-ConnectionGUID: jTTXjVaaTaWmqY4hm2xH1A==
X-CSE-MsgGUID: DoHdGCsMRZS+s+k+6od36Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; d="scan'208";a="149551057"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 21:38:24 -0700
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Subject: [PATCH v6 6/7] ui/spice: Create a new texture with linear layout when
 gl=on is specified
Date: Mon, 16 Jun 2025 21:32:30 -0700
Message-ID: <20250617043546.1022779-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
References: <20250617043546.1022779-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.892,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Since most encoders/decoders (invoked by Spice) may not work properly
with tiled memory associated with a texture, we need to create another
texture that has linear memory layout and use that instead.

Note that, there does not seem to be a direct way to indicate to the
GL implementation that a texture's backing memory needs to be linear.
Instead, we have to do it in a roundabout way where we need to first
create a tiled texture and import that as a memory object to create
a new texture that has a linear memory layout.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Co-developed-by: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/surface.h |  1 +
 ui/console-gl.c      |  6 ++++
 ui/spice-display.c   | 82 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+)

diff --git a/include/ui/surface.h b/include/ui/surface.h
index f16f7be8be..006b1986bb 100644
--- a/include/ui/surface.h
+++ b/include/ui/surface.h
@@ -22,6 +22,7 @@ typedef struct DisplaySurface {
     GLenum glformat;
     GLenum gltype;
     GLuint texture;
+    GLuint mem_obj;
 #endif
     qemu_pixman_shareable share_handle;
     uint32_t share_handle_offset;
diff --git a/ui/console-gl.c b/ui/console-gl.c
index afb36dba64..403fc36fbd 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -184,6 +184,12 @@ void surface_gl_destroy_texture(QemuGLShader *gls,
     }
     glDeleteTextures(1, &surface->texture);
     surface->texture = 0;
+#ifdef GL_EXT_memory_object_fd
+    if (surface->mem_obj) {
+        glDeleteMemoryObjectsEXT(1, &surface->mem_obj);
+        surface->mem_obj = 0;
+    }
+#endif
 }
 
 void surface_gl_setup_viewport(QemuGLShader *gls,
diff --git a/ui/spice-display.c b/ui/spice-display.c
index e409b6bdb2..854a97c198 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -893,6 +893,81 @@ static void spice_gl_update(DisplayChangeListener *dcl,
     ssd->gl_updates++;
 }
 
+static bool spice_gl_replace_fd_texture(SimpleSpiceDisplay *ssd,
+                                        int *fds, uint64_t *modifier,
+                                        int *num_planes)
+{
+    uint32_t offsets[DMABUF_MAX_PLANES], strides[DMABUF_MAX_PLANES];
+    GLuint texture;
+    GLuint mem_obj;
+    int fourcc;
+    bool ret;
+
+    if (!spice_remote_client) {
+        return true;
+    }
+
+    if (*modifier == DRM_FORMAT_MOD_LINEAR) {
+        return true;
+    }
+
+    if (*num_planes > 1) {
+        error_report("spice: cannot replace texture with multiple planes");
+        return false;
+    }
+
+    /*
+     * We really want to ensure that the memory layout of the texture
+     * is linear; otherwise, the encoder's output may show corruption.
+     */
+    if (!surface_gl_create_texture_from_fd(ssd->ds, fds[0], &texture,
+                                           &mem_obj)) {
+        error_report("spice: cannot create new texture from fd");
+        return false;
+    }
+
+    /*
+     * A successful return after glImportMemoryFdEXT() means that
+     * the ownership of fd has been passed to GL. In other words,
+     * the fd we got above should not be used anymore.
+     */
+    ret = egl_dmabuf_export_texture(texture,
+                                    fds,
+                                    (EGLint *)offsets,
+                                    (EGLint *)strides,
+                                    &fourcc,
+                                    num_planes,
+                                    modifier);
+    if (!ret) {
+        glDeleteTextures(1, &texture);
+#ifdef GL_EXT_memory_object_fd
+        glDeleteMemoryObjectsEXT(1, &mem_obj);
+#endif
+
+        /*
+         * Since we couldn't export our newly create texture (or create,
+         * an fd associated with it) we need to backtrack and try to
+         * recreate the fd associated with the original texture.
+         */
+        ret = egl_dmabuf_export_texture(ssd->ds->texture,
+                                        fds,
+                                        (EGLint *)offsets,
+                                        (EGLint *)strides,
+                                        &fourcc,
+                                        num_planes,
+                                        modifier);
+        if (!ret) {
+            surface_gl_destroy_texture(ssd->gls, ssd->ds);
+            warn_report("spice: no texture available to display");
+        }
+    } else {
+        surface_gl_destroy_texture(ssd->gls, ssd->ds);
+        ssd->ds->texture = texture;
+        ssd->ds->mem_obj = mem_obj;
+    }
+    return ret;
+}
+
 static void spice_server_gl_scanout(QXLInstance *qxl,
                                     const int *fd,
                                     uint32_t width, uint32_t height,
@@ -917,6 +992,7 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
+    bool ret;
 
     if (ssd->ds) {
         surface_gl_destroy_texture(ssd->gls, ssd->ds);
@@ -939,6 +1015,12 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
             return;
         }
 
+        ret = spice_gl_replace_fd_texture(ssd, fd, &modifier, &num_planes);
+        if (!ret) {
+            surface_gl_destroy_texture(ssd->gls, ssd->ds);
+            return;
+        }
+
         trace_qemu_spice_gl_surface(ssd->qxl.id,
                                     surface_width(ssd->ds),
                                     surface_height(ssd->ds),
-- 
2.49.0


