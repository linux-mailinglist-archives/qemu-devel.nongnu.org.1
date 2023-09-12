Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2110179CEB3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:48:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vE-0002qi-3i; Tue, 12 Sep 2023 06:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vC-0002qV-6c
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0v9-0003Dl-PW
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j0EHmtHt1Xn9fl2jW6TVrxoYeM5hV+CcFMmy9zENXco=;
 b=X/2kQ3OhzwX8CuixOMGwqoaj4mqay/a6c4aGue6rQ75G83cMV1tVCWtQn6EWtCWYphbtiH
 7CakPQkXaRBfl9DpbAp/cEZotyMIrYo33S5ii6yc80FopIzcqP0TbDTmZPnDUBE8NX0D0o
 Jej/mWxqtTBI+kPW4atp9TYwsLYF62o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-9r5gN00EO2WwsTMkQHEsFw-1; Tue, 12 Sep 2023 06:47:00 -0400
X-MC-Unique: 9r5gN00EO2WwsTMkQHEsFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D7761C18C79
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:47:00 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FD9C64687;
 Tue, 12 Sep 2023 10:46:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Erico Nunes <ernunes@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 02/14] contrib/vhost-user-gpu: add support for sending dmabuf
 modifiers
Date: Tue, 12 Sep 2023 14:46:36 +0400
Message-ID: <20230912104649.1638640-3-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Erico Nunes <ernunes@redhat.com>

virglrenderer recently added virgl_renderer_resource_get_info_ext as a
new api, which gets resource information, including dmabuf modifiers.

We have to support dmabuf modifiers since the driver may choose to
allocate buffers with these modifiers for efficiency, and importing
buffers without modifiers information may result in completely broken
rendering.

Signed-off-by: Erico Nunes <ernunes@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Message-Id: <20230714153900.475857-3-ernunes@redhat.com>
---
 contrib/vhost-user-gpu/vugpu.h          |  9 +++++
 contrib/vhost-user-gpu/vhost-user-gpu.c |  5 ++-
 contrib/vhost-user-gpu/virgl.c          | 51 +++++++++++++++++++++++--
 3 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.h
index f0f2069c47..509b679f03 100644
--- a/contrib/vhost-user-gpu/vugpu.h
+++ b/contrib/vhost-user-gpu/vugpu.h
@@ -37,6 +37,7 @@ typedef enum VhostUserGpuRequest {
     VHOST_USER_GPU_DMABUF_SCANOUT,
     VHOST_USER_GPU_DMABUF_UPDATE,
     VHOST_USER_GPU_GET_EDID,
+    VHOST_USER_GPU_DMABUF_SCANOUT2,
 } VhostUserGpuRequest;
 
 typedef struct VhostUserGpuDisplayInfoReply {
@@ -84,6 +85,11 @@ typedef struct VhostUserGpuDMABUFScanout {
     int fd_drm_fourcc;
 } QEMU_PACKED VhostUserGpuDMABUFScanout;
 
+typedef struct VhostUserGpuDMABUFScanout2 {
+    struct VhostUserGpuDMABUFScanout dmabuf_scanout;
+    uint64_t modifier;
+} QEMU_PACKED VhostUserGpuDMABUFScanout2;
+
 typedef struct VhostUserGpuEdidRequest {
     uint32_t scanout_id;
 } QEMU_PACKED VhostUserGpuEdidRequest;
@@ -98,6 +104,7 @@ typedef struct VhostUserGpuMsg {
         VhostUserGpuScanout scanout;
         VhostUserGpuUpdate update;
         VhostUserGpuDMABUFScanout dmabuf_scanout;
+        VhostUserGpuDMABUFScanout2 dmabuf_scanout2;
         VhostUserGpuEdidRequest edid_req;
         struct virtio_gpu_resp_edid resp_edid;
         struct virtio_gpu_resp_display_info display_info;
@@ -112,6 +119,7 @@ static VhostUserGpuMsg m __attribute__ ((unused));
 #define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4
 
 #define VHOST_USER_GPU_PROTOCOL_F_EDID 0
+#define VHOST_USER_GPU_PROTOCOL_F_DMABUF2 1
 
 struct virtio_gpu_scanout {
     uint32_t width, height;
@@ -132,6 +140,7 @@ typedef struct VuGpu {
     bool virgl;
     bool virgl_inited;
     bool edid_inited;
+    bool use_modifiers;
     uint32_t inflight;
 
     struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-gpu/vhost-user-gpu.c
index 2e7815a7a3..aa304475a0 100644
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
@@ -1071,6 +1071,7 @@ static gboolean
 protocol_features_cb(gint fd, GIOCondition condition, gpointer user_data)
 {
     const uint64_t protocol_edid = (1 << VHOST_USER_GPU_PROTOCOL_F_EDID);
+    const uint64_t protocol_dmabuf2 = (1 << VHOST_USER_GPU_PROTOCOL_F_DMABUF2);
     VuGpu *g = user_data;
     uint64_t protocol_features;
     VhostUserGpuMsg msg = {
@@ -1082,7 +1083,7 @@ protocol_features_cb(gint fd, GIOCondition condition, gpointer user_data)
         return G_SOURCE_CONTINUE;
     }
 
-    protocol_features &= protocol_edid;
+    protocol_features &= (protocol_edid | protocol_dmabuf2);
 
     msg = (VhostUserGpuMsg) {
         .request = VHOST_USER_GPU_SET_PROTOCOL_FEATURES,
@@ -1100,6 +1101,8 @@ protocol_features_cb(gint fd, GIOCondition condition, gpointer user_data)
         exit(EXIT_FAILURE);
     }
 
+    g->use_modifiers = !!(protocol_features & protocol_dmabuf2);
+
     return G_SOURCE_REMOVE;
 }
 
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.c
index 211aa110a9..1da6cc1588 100644
--- a/contrib/vhost-user-gpu/virgl.c
+++ b/contrib/vhost-user-gpu/virgl.c
@@ -318,6 +318,37 @@ virgl_resource_detach_backing(VuGpu *g,
     vg_cleanup_mapping_iov(g, res_iovs, num_iovs);
 }
 
+static int
+virgl_get_resource_info_modifiers(uint32_t resource_id,
+                                  struct virgl_renderer_resource_info *info,
+                                  uint64_t *modifiers)
+{
+    int ret;
+#ifdef VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION
+    struct virgl_renderer_resource_info_ext info_ext;
+    ret = virgl_renderer_resource_get_info_ext(resource_id, &info_ext);
+    if (ret < 0) {
+        return ret;
+    }
+
+    *info = info_ext.base;
+    *modifiers = info_ext.modifiers;
+#else
+    ret = virgl_renderer_resource_get_info(resource_id, info);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * Before virgl_renderer_resource_get_info_ext,
+     * getting the modifiers was not possible.
+     */
+    *modifiers = 0;
+#endif
+
+    return 0;
+}
+
 static void
 virgl_cmd_set_scanout(VuGpu *g,
                       struct virtio_gpu_ctrl_command *cmd)
@@ -338,7 +369,9 @@ virgl_cmd_set_scanout(VuGpu *g,
     memset(&info, 0, sizeof(info));
 
     if (ss.resource_id && ss.r.width && ss.r.height) {
-        ret = virgl_renderer_resource_get_info(ss.resource_id, &info);
+        uint64_t modifiers = 0;
+        ret = virgl_get_resource_info_modifiers(ss.resource_id, &info,
+                                                &modifiers);
         if (ret == -1) {
             g_critical("%s: illegal resource specified %d\n",
                        __func__, ss.resource_id);
@@ -354,8 +387,6 @@ virgl_cmd_set_scanout(VuGpu *g,
         }
         assert(fd >= 0);
         VhostUserGpuMsg msg = {
-            .request = VHOST_USER_GPU_DMABUF_SCANOUT,
-            .size = sizeof(VhostUserGpuDMABUFScanout),
             .payload.dmabuf_scanout.scanout_id = ss.scanout_id,
             .payload.dmabuf_scanout.x =  ss.r.x,
             .payload.dmabuf_scanout.y =  ss.r.y,
@@ -367,6 +398,20 @@ virgl_cmd_set_scanout(VuGpu *g,
             .payload.dmabuf_scanout.fd_flags = info.flags,
             .payload.dmabuf_scanout.fd_drm_fourcc = info.drm_fourcc
         };
+
+        if (g->use_modifiers) {
+            /*
+             * The mesage uses all the fields set in dmabuf_scanout plus
+             * modifiers which is appended after VhostUserGpuDMABUFScanout.
+             */
+            msg.request = VHOST_USER_GPU_DMABUF_SCANOUT2;
+            msg.size = sizeof(VhostUserGpuDMABUFScanout2);
+            msg.payload.dmabuf_scanout2.modifier = modifiers;
+        } else {
+            msg.request = VHOST_USER_GPU_DMABUF_SCANOUT;
+            msg.size = sizeof(VhostUserGpuDMABUFScanout);
+        }
+
         vg_send_msg(g, &msg, fd);
         close(fd);
     } else {
-- 
2.41.0


