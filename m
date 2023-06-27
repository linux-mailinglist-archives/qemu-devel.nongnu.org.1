Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C5973FC5C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8MS-0000GS-Fw; Tue, 27 Jun 2023 09:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8MJ-0000Fo-Ln
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8MH-0007H7-SO
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksHcW5Ph8ILNmt7xN6U/dSeYOzHv2QzcBbTUWPHy45c=;
 b=Km2QlNAKiWrMLOh5cTDCUb/jgyoiNqs0SRKGx5WFT41VrNlfTsJsvTj97k8CrPE1bRHitK
 OKs+digssHyZPE9CKTYAlwGd7QJn1UybvtuSnooZpVEcC9c8wSm/J0f9cVWilZrejP/Q8m
 cAETkenn88xcLlRx4yPBw3bqh/TU1Fg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-u7JPspIZOiORkxBsayecIQ-1; Tue, 27 Jun 2023 09:03:46 -0400
X-MC-Unique: u7JPspIZOiORkxBsayecIQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDC891C0725E;
 Tue, 27 Jun 2023 13:03:38 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CF3440C6CCD;
 Tue, 27 Jun 2023 13:03:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/33] virtio-gpu-virgl: use D3D11_SHARE_TEXTURE when available
Date: Tue, 27 Jun 2023 15:02:29 +0200
Message-ID: <20230627130231.1614896-33-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Enable D3D texture sharing when possible, and pass it to the texture
display callbacks.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-21-marcandre.lureau@redhat.com>
---
 meson.build                   |  6 ++++++
 hw/display/virtio-gpu-virgl.c | 24 +++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 9a1ce43471..1631e60a3b 100644
--- a/meson.build
+++ b/meson.build
@@ -1072,6 +1072,12 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
                      method: 'pkg-config',
                      required: get_option('virglrenderer'))
+  if virgl.found()
+    config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
+                         cc.has_member('struct virgl_renderer_resource_info_ext', 'd3d_tex2d',
+                                       prefix: '#include <virglrenderer.h>',
+                                       dependencies: virgl))
+  endif
 endif
 blkio = not_found
 if not get_option('blkio').auto() or have_block
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 8fa9809371..8bb7a2c21f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -153,8 +153,6 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
                                   struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_set_scanout ss;
-    struct virgl_renderer_resource_info info;
-    void *d3d_tex2d = NULL;
     int ret;
 
     VIRTIO_GPU_FILL_CMD(ss);
@@ -169,10 +167,20 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
     }
     g->parent_obj.enable = 1;
 
-    memset(&info, 0, sizeof(info));
-
     if (ss.resource_id && ss.r.width && ss.r.height) {
+        struct virgl_renderer_resource_info info;
+        void *d3d_tex2d = NULL;
+
+#ifdef HAVE_VIRGL_D3D_INFO_EXT
+        struct virgl_renderer_resource_info_ext ext;
+        memset(&ext, 0, sizeof(ext));
+        ret = virgl_renderer_resource_get_info_ext(ss.resource_id, &ext);
+        info = ext.base;
+        d3d_tex2d = ext.d3d_tex2d;
+#else
+        memset(&info, 0, sizeof(info));
         ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
+#endif
         if (ret == -1) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: illegal resource specified %d\n",
@@ -617,6 +625,7 @@ void virtio_gpu_virgl_reset(VirtIOGPU *g)
 int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
+    uint32_t flags = 0;
 
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
@@ -624,8 +633,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         virtio_gpu_3d_cbs.get_egl_display = virgl_get_egl_display;
     }
 #endif
+#ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
+    if (qemu_egl_angle_d3d) {
+        flags |= VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
+    }
+#endif
 
-    ret = virgl_renderer_init(g, 0, &virtio_gpu_3d_cbs);
+    ret = virgl_renderer_init(g, flags, &virtio_gpu_3d_cbs);
     if (ret != 0) {
         error_report("virgl could not be initialized: %d", ret);
         return ret;
-- 
2.41.0


