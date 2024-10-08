Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9016F994C71
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Oct 2024 14:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9hM-0000IP-Oa; Tue, 08 Oct 2024 08:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9hA-0008Uk-Hy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9h8-0002Xl-Uo
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728391925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5g1LvEfgHrNEvw1BydwnpqKGOH85c035TVkBHyhicI=;
 b=expPD53c1eqFrIMBrrgmXa7GteXWL9ZY9iJvWY+AmNp2vKvTaHDrRA+bqQtT3Lv9FBGOmN
 iQBizd1u+4lHLJjZYcrJvdVvGMWSbJnxF8r7cJL4UFR3SQ0kWJFLJzfwJ+vcOEdvjY3J82
 Ea+VV80Z/gCVTCr5vUVfymI8F+X8nFk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-tWgYy3A_NaWsTVp96u61UA-1; Tue,
 08 Oct 2024 08:52:02 -0400
X-MC-Unique: tWgYy3A_NaWsTVp96u61UA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 615F9195FE3F; Tue,  8 Oct 2024 12:52:01 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72BAA1956089; Tue,  8 Oct 2024 12:52:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, belmouss@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 17/19] virtio-gpu: allocate shareable 2d resources on !win32
Date: Tue,  8 Oct 2024 16:50:26 +0400
Message-ID: <20241008125028.1177932-18-marcandre.lureau@redhat.com>
In-Reply-To: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
References: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Similar to what was done in commit 9462ff46 ("virtio-gpu/win32: allocate
shareable 2d resources/images") for win32, allocate resource memory with
memfd, so the associated display surface memory can be shared with a
different process.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  2 ++
 hw/display/virtio-gpu.c        | 39 +++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a59379f5a..7509d13265 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -53,6 +53,8 @@ struct virtio_gpu_simple_resource {
     pixman_image_t *image;
 #ifdef WIN32
     HANDLE handle;
+#else
+    int shmfd;
 #endif
     uint64_t hostmem;
 
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 77f6e76f23..23ebefa59c 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -28,6 +28,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
+#include "qemu/memfd.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -238,6 +239,20 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
     return height * stride;
 }
 
+static void
+resource_set_image_destroy(struct virtio_gpu_simple_resource *res)
+{
+    if (!res) {
+        return;
+    }
+#ifdef WIN32
+    void *data = res->handle;
+#else
+    void *data = GINT_TO_POINTER(res->shmfd);
+#endif
+    pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, data);
+}
+
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -287,25 +302,21 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
         void *bits = NULL;
 #ifdef WIN32
         bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+#else
+        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
+#endif
         if (!bits) {
             goto end;
         }
-#endif
         res->image = pixman_image_create_bits(
             pformat,
             c2d.width,
             c2d.height,
             bits, c2d.height ? res->hostmem / c2d.height : 0);
-#ifdef WIN32
-        if (res->image) {
-            pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
-        }
-#endif
+        resource_set_image_destroy(res);
     }
 
-#ifdef WIN32
 end:
-#endif
     if (!res->image) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: resource creation failed %d %d %d\n",
@@ -678,6 +689,8 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
         scanout->ds = qemu_create_displaysurface_pixman(rect);
 #ifdef WIN32
         qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, fb->offset);
+#else
+        qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, fb->offset);
 #endif
 
         pixman_image_unref(rect);
@@ -1303,11 +1316,13 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
 #ifdef WIN32
         bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+#else
+        bits = qemu_memfd_alloc("virtio-gpu-res", res->hostmem, 0, &res->shmfd, &error_warn);
+#endif
         if (!bits) {
             g_free(res);
             return -EINVAL;
         }
-#endif
         res->image = pixman_image_create_bits(
             pformat,
             res->width, res->height,
@@ -1316,9 +1331,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             g_free(res);
             return -EINVAL;
         }
-#ifdef WIN32
-        pixman_image_set_destroy_function(res->image, qemu_pixman_shared_image_destroy, res->handle);
-#endif
+        resource_set_image_destroy(res);
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
@@ -1453,6 +1466,8 @@ static int virtio_gpu_post_load(void *opaque, int version_id)
             scanout->ds = qemu_create_displaysurface_pixman(res->image);
 #ifdef WIN32
             qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
+#else
+            qemu_displaysurface_set_shmfd(scanout->ds, res->shmfd, 0);
 #endif
             dpy_gfx_replace_surface(scanout->con, scanout->ds);
         }
-- 
2.47.0


