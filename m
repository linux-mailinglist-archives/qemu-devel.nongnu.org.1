Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E4A8331FC
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 01:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQzbl-0001u2-EH; Fri, 19 Jan 2024 19:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbd-0001rs-SC
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:05 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbc-0000HA-2Z
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705711984; x=1737247984;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aH1svmPvRSrhxRPRQhEiXVSt38d9wIOqogeHz9Ctq7s=;
 b=IM0a9SzRIoctuLI/m83TXFIz1HKsVTq+v/JX92Xj4LJ9YUp8FwX59poi
 XN2+G6NjjqGBgv4/0zQGZPNbHP/ZCu3kfOo4S8OGqu4q2YQZwTT/JWKA0
 mwEJ53DUi8l4j2+XIkI7f7ljnPMgj2K1nwehEau9dJwQyHNuZ4Kom4+tK
 4LC94ajKUVPAcmNup0cI5JpoIWt1pvRlLK2d6kif7AZH0GelzhYWHk1Wo
 YuxD4XEYiLyNs81SyqrS6rwbkrNG8RfGbBANB26AGWhU5I2j+e315W/LL
 hzxBA2iCt9U/FGtaQuhX9yU9AHsBBYIEdCDrPJalhS7aYmmJQo+9gA8hV Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399763768"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="399763768"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904297451"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="904297451"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1 6/7] ui/console-gl: Add a helper to create a texture with
 linear memory layout
Date: Fri, 19 Jan 2024 16:30:12 -0800
Message-Id: <20240120003013.1829757-7-vivek.kasireddy@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
References: <20240120003013.1829757-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

There are cases where we do not want the memory layout of a texture to
be tiled as the component processing the texture memory would not know
how to de-tile either via software or hardware. Therefore, ensuring
that the memory backing the texture has a linear layout is absolutely
necessary in these situations.

Note that, requesting GL implementation to create a texture with
linear memory layout can only be done using memory objects. And, a
memory object can be created by importing a dmabuf fd.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 include/ui/console.h |  2 ++
 ui/console-gl.c      | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc64..e53e3ce03e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -444,6 +444,8 @@ bool console_gl_check_format(DisplayChangeListener *dcl,
                              pixman_format_code_t format);
 void surface_gl_create_texture(QemuGLShader *gls,
                                DisplaySurface *surface);
+void surface_gl_create_texture_from_fd(DisplaySurface *surface,
+                                       int fd, GLuint *texture);
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h);
diff --git a/ui/console-gl.c b/ui/console-gl.c
index dee317f42c..2c1b2ae377 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -102,6 +102,32 @@ void surface_gl_create_texture(QemuGLShader *gls,
     glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
 }
 
+void surface_gl_create_texture_from_fd(DisplaySurface *surface,
+                                       int fd, GLuint *texture)
+{
+    unsigned long size = surface_stride(surface) * surface_height(surface);
+    GLuint mem_obj;
+
+    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
+        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
+        return;
+    }
+
+#ifdef GL_EXT_memory_object_fd
+    glCreateMemoryObjectsEXT(1, &mem_obj);
+    glImportMemoryFdEXT(mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd);
+    if (!glIsMemoryObjectEXT(mem_obj)) {
+        return;
+    }
+
+    glGenTextures(1, texture);
+    glBindTexture(GL_TEXTURE_2D, *texture);
+    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT, GL_LINEAR_TILING_EXT);
+    glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8, surface_width(surface),
+                         surface_height(surface), mem_obj, 0);
+#endif
+}
+
 void surface_gl_update_texture(QemuGLShader *gls,
                                DisplaySurface *surface,
                                int x, int y, int w, int h)
-- 
2.39.2


