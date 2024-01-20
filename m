Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2508331FD
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 01:54:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQzbo-0001u3-5B; Fri, 19 Jan 2024 19:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbf-0001sX-5P
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:07 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1rQzbd-0000Hu-Dc
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 19:53:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705711985; x=1737247985;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MJ8rtDIcQk012Iggqg+BBERZJYsckiVBOTAXB2wUZy0=;
 b=YFE+8avgDCMHfXAzI2m3CQFRnxp2CTdbFNGR5UV+FnImn1iMBFxOLFYx
 kTXhA6Y1OxtaJuHAHuxA2nM0Gw64ebmLzfJHvFQR/tEc+XUaBNBApmyJ6
 7ZrxS1pjEGXTqjdO85vSXJiViFLvasBv5LUGdbZavuojof/meCy/eVXIX
 ZpG3pVXiGYzbcV5iuKwpnaprVvAzWy9aOAFt7Gw9wsND9jKCDKNjkiVPt
 GoOEO5UBhwKh7riEmbDuQwTGXaiD3B2i36pyYaZx1Qfb1VHzi2Rocpsp8
 berQaktZKloEzjg+2Gfzzrg+3f/3feixuF/Bqcyl6BSjlgaG5UQEQWMJm g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="399763771"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="399763771"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="904297454"
X-IronPort-AV: E=Sophos;i="6.05,206,1701158400"; d="scan'208";a="904297454"
Received: from vkasired-desk2.fm.intel.com ([10.105.128.132])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2024 16:52:52 -0800
From: Vivek Kasireddy <vivek.kasireddy@intel.com>
To: qemu-devel@nongnu.org
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Subject: [PATCH v1 7/7] ui/spice: Create another texture with linear layout
 when gl=on is enabled
Date: Fri, 19 Jan 2024 16:30:13 -0800
Message-Id: <20240120003013.1829757-8-vivek.kasireddy@intel.com>
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

Since most encoders (invoked by Spice) may not work with tiled memory
associated with a texture, we need to create another texture that has
linear memory layout and use that instead.

Note that, there does not seem to be a direct way to indicate to the
GL implementation that a texture's backing memory needs to be linear.
Instead, we have to do it in a roundabout way where we first need to
create a tiled texture and obtain a dmabuf fd associated with it via
EGL. Next, we have to create a memory object by importing the dmabuf
fd created earlier and finally create a linear texture by using the
memory object as the texture storage mechanism.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
---
 ui/spice-display.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 08b4aec921..94cb378dbe 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -893,6 +893,7 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint stride, fourcc;
+    GLuint texture = 0;
     int fd;
 
     if (ssd->ds) {
@@ -912,6 +913,38 @@ static void spice_gl_switch(DisplayChangeListener *dcl,
             return;
         }
 
+        if (remote_client && surface_format(ssd->ds) != PIXMAN_r5g6b5) {
+            /*
+             * We really want to ensure that the memory layout of the texture
+             * is linear; otherwise, the encoder's output may show corruption.
+             */
+            surface_gl_create_texture_from_fd(ssd->ds, fd, &texture);
+
+            /*
+             * A successful return after glImportMemoryFdEXT() means that
+             * the ownership of fd has been passed to GL. In other words,
+             * the fd we got above should not be used anymore.
+             */
+            if (texture > 0) {
+                fd = egl_get_fd_for_texture(texture,
+                                            &stride, &fourcc,
+                                            NULL);
+                if (fd < 0) {
+                    glDeleteTextures(1, &texture);
+                    fd = egl_get_fd_for_texture(ssd->ds->texture,
+                                                &stride, &fourcc,
+                                                NULL);
+                    if (fd < 0) {
+                        surface_gl_destroy_texture(ssd->gls, ssd->ds);
+                        return;
+                    }
+                } else {
+                    surface_gl_destroy_texture(ssd->gls, ssd->ds);
+                    ssd->ds->texture = texture;
+                }
+            }
+        }
+
         trace_qemu_spice_gl_surface(ssd->qxl.id,
                                     surface_width(ssd->ds),
                                     surface_height(ssd->ds),
-- 
2.39.2


