Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A8473FC87
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M7-0000A6-2r; Tue, 27 Jun 2023 09:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M4-00008G-1m
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M1-0007EP-ML
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NrUfPOeNrBIPtawUpBtKT3k03tl++nKnWc/sGwW/Fc=;
 b=UUsMNcBSQCm0ukcKuU4zCVNO4sq1MxJU4bewZIPzsfLO6ig2QT2kwAVgWSsrsasIxjqVNl
 dDdgy7ruM8pjUo5SC/nnhSeGsJW/A4r2lelHHMdogmVosbC1kcsWLs05Hbp7Bwc2F5ijih
 M3Fe0/3RQE8EhjsUXOHOFQ8gVtpmLxM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-L3DwUenlPQKOGlZp2qimBA-1; Tue, 27 Jun 2023 09:03:30 -0400
X-MC-Unique: L3DwUenlPQKOGlZp2qimBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0165858F1E;
 Tue, 27 Jun 2023 13:03:18 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66CAE140EBB8;
 Tue, 27 Jun 2023 13:03:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 22/33] virtio-gpu/win32: allocate shareable 2d resources/images
Date: Tue, 27 Jun 2023 15:02:19 +0200
Message-ID: <20230627130231.1614896-23-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
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

Allocate pixman bits for scanouts with qemu_win32_map_alloc() so we can
set a shareable handle on the associated display surface.

Note: when bits are provided to pixman_image_create_bits(), you must also give
the rowstride (the argument is ignored when bits is NULL)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-11-marcandre.lureau@redhat.com>
---
 include/hw/virtio/virtio-gpu.h |  3 +++
 hw/display/virtio-gpu.c        | 46 +++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 2e28507efe..7a5f8056ea 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -48,6 +48,9 @@ struct virtio_gpu_simple_resource {
     unsigned int iov_cnt;
     uint32_t scanout_bitmask;
     pixman_image_t *image;
+#ifdef WIN32
+    HANDLE handle;
+#endif
     uint64_t hostmem;
 
     uint64_t blob_size;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 1f8a5b16c6..347e17d490 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -258,6 +258,16 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
     return height * stride;
 }
 
+#ifdef WIN32
+static void
+win32_pixman_image_destroy(pixman_image_t *image, void *data)
+{
+    HANDLE handle = data;
+
+    qemu_win32_map_free(pixman_image_get_data(image), handle, &error_warn);
+}
+#endif
+
 static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
                                           struct virtio_gpu_ctrl_command *cmd)
 {
@@ -304,12 +314,27 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
 
     res->hostmem = calc_image_hostmem(pformat, c2d.width, c2d.height);
     if (res->hostmem + g->hostmem < g->conf_max_hostmem) {
+        void *bits = NULL;
+#ifdef WIN32
+        bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+        if (!bits) {
+            goto end;
+        }
+#endif
         res->image = pixman_image_create_bits(pformat,
                                               c2d.width,
                                               c2d.height,
-                                              NULL, 0);
+                                              bits, res->hostmem / c2d.height);
+#ifdef WIN32
+        if (res->image) {
+            pixman_image_set_destroy_function(res->image, win32_pixman_image_destroy, res->handle);
+        }
+#endif
     }
 
+#ifdef WIN32
+end:
+#endif
     if (!res->image) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: resource creation failed %d %d %d\n",
@@ -685,6 +710,9 @@ static void virtio_gpu_do_set_scanout(VirtIOGPU *g,
             *error = VIRTIO_GPU_RESP_ERR_UNSPEC;
             return;
         }
+#ifdef WIN32
+        qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, fb->offset);
+#endif
 
         pixman_image_unref(rect);
         dpy_gfx_replace_surface(g->parent_obj.scanout[scanout_id].con,
@@ -1228,6 +1256,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_scanout *scanout;
     uint32_t resource_id, pformat;
+    void *bits = NULL;
     int i;
 
     g->hostmem = 0;
@@ -1252,15 +1281,23 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
             g_free(res);
             return -EINVAL;
         }
+
+        res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
+#ifdef WIN32
+        bits = qemu_win32_map_alloc(res->hostmem, &res->handle, &error_warn);
+        if (!bits) {
+            g_free(res);
+            return -EINVAL;
+        }
+#endif
         res->image = pixman_image_create_bits(pformat,
                                               res->width, res->height,
-                                              NULL, 0);
+                                              bits, res->hostmem / res->height);
         if (!res->image) {
             g_free(res);
             return -EINVAL;
         }
 
-        res->hostmem = calc_image_hostmem(pformat, res->width, res->height);
 
         res->addrs = g_new(uint64_t, res->iov_cnt);
         res->iov = g_new(struct iovec, res->iov_cnt);
@@ -1321,6 +1358,9 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
         if (!scanout->ds) {
             return -EINVAL;
         }
+#ifdef WIN32
+        qemu_displaysurface_win32_set_handle(scanout->ds, res->handle, 0);
+#endif
 
         dpy_gfx_replace_surface(scanout->con, scanout->ds);
         dpy_gfx_update_full(scanout->con);
-- 
2.41.0


