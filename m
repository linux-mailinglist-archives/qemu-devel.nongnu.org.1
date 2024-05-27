Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9A98CF7B6
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 05:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQe6-0005JP-2J; Sun, 26 May 2024 23:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdy-0005Gq-AW
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:26 -0400
Received: from madrid.collaboradmins.com ([2a00:1098:ed:100::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sBQdv-0002Ks-Hb
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1716779002;
 bh=W2q8CJ+9h8iCf1SV0H3SchSg+lzojM6bfvjQmGMRAjo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mqmPaD0YNlFNuRwHzpMUlM3fzmhiElPMXCFLw6lFOMZFXxy5x5jJrrfKcxGJxD5aw
 BgwpQKbG8dhQpZwRAscjkP40AAc49isoaFa2+7QR2hB7yq2SUXzngxFJeMElchCRT2
 TpdsX8lil78zJk5SZzfn12BRYUQMTYwkHUxZGz9Y4GUMEGMDSzdVLgybh+pPbqxfe4
 ae/KYL3YmVTrNcTCUa+rE0OCT0ml/RRBybLgY3CBNJEMdTTLrg1nXUXZ1ualngmenM
 yd6my/YBdZKjLLf0yqJs8CH5ja1HKWO/bOBuIFv6E3OpxIFlrYW3k7uxCtxb86oplN
 MdtZF28I0I45A==
Received: from workpc.. (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dmitry.osipenko)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id A866D37820A7;
 Mon, 27 May 2024 03:03:20 +0000 (UTC)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
Subject: [PATCH v13 11/13] virtio-gpu: Handle resource blob commands
Date: Mon, 27 May 2024 06:02:31 +0300
Message-ID: <20240527030233.3775514-12-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
References: <20240527030233.3775514-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:ed:100::25;
 envelope-from=dmitry.osipenko@collabora.com; helo=madrid.collaboradmins.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

Support BLOB resources creation, mapping and unmapping by calling the
new stable virglrenderer 0.10 interface. Only enabled when available and
via the blob config. E.g. -device virtio-vga-gl,blob=true

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu-virgl.c  | 320 ++++++++++++++++++++++++++++++++-
 hw/display/virtio-gpu.c        |   4 +-
 include/hw/virtio/virtio-gpu.h |   2 +
 3 files changed, 322 insertions(+), 4 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 7f45b4fa5fd7..0c73d9ba65f9 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -26,6 +26,7 @@
 
 struct virtio_gpu_virgl_resource {
     struct virtio_gpu_simple_resource base;
+    MemoryRegion *mr;
 };
 
 static struct virtio_gpu_virgl_resource *
@@ -49,6 +50,159 @@ virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
 }
 #endif
 
+#ifdef HAVE_VIRGL_RESOURCE_BLOB
+typedef enum {
+    HOSTMEM_MR_MAPPED,
+    HOSTMEM_MR_UNMAPPING,
+    HOSTMEM_MR_FINISH_UNMAPPING,
+} HostmemMRState;
+
+struct virtio_gpu_virgl_hostmem_region {
+    MemoryRegion mr;
+    struct VirtIOGPU *g;
+    HostmemMRState state;
+};
+
+static struct virtio_gpu_virgl_hostmem_region *
+to_hostmem_region(MemoryRegion *mr)
+{
+    return container_of(mr, struct virtio_gpu_virgl_hostmem_region, mr);
+}
+
+static void virtio_gpu_virgl_resume_cmdq_bh(void *opaque)
+{
+    VirtIOGPU *g = opaque;
+
+    virtio_gpu_process_cmdq(g);
+}
+
+static void virtio_gpu_virgl_hostmem_region_free(void *obj)
+{
+    MemoryRegion *mr = MEMORY_REGION(obj);
+    struct virtio_gpu_virgl_hostmem_region *vmr;
+    VirtIOGPUBase *b;
+    VirtIOGPUGL *gl;
+
+    vmr = to_hostmem_region(mr);
+    vmr->state = HOSTMEM_MR_FINISH_UNMAPPING;
+
+    b = VIRTIO_GPU_BASE(vmr->g);
+    b->renderer_blocked--;
+
+    /*
+     * memory_region_unref() is executed from RCU thread context, while
+     * virglrenderer works only on the main-loop thread that's holding GL
+     * context.
+     */
+    gl = VIRTIO_GPU_GL(vmr->g);
+    qemu_bh_schedule(gl->cmdq_resume_bh);
+}
+
+static int
+virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
+                                   struct virtio_gpu_virgl_resource *res,
+                                   uint64_t offset)
+{
+    struct virtio_gpu_virgl_hostmem_region *vmr;
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    MemoryRegion *mr;
+    uint64_t size;
+    void *data;
+    int ret;
+
+    if (!virtio_gpu_hostmem_enabled(b->conf)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: hostmem disabled\n", __func__);
+        return -EOPNOTSUPP;
+    }
+
+    ret = virgl_renderer_resource_map(res->base.resource_id, &data, &size);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to map virgl resource: %s\n",
+                      __func__, strerror(-ret));
+        return ret;
+    }
+
+    vmr = g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
+    vmr->g = g;
+
+    mr = &vmr->mr;
+    memory_region_init_ram_ptr(mr, OBJECT(mr), "blob", size, data);
+    memory_region_add_subregion(&b->hostmem, offset, mr);
+    memory_region_set_enabled(mr, true);
+
+    /*
+     * MR could outlive the resource if MR's reference is held outside of
+     * virtio-gpu. In order to prevent unmapping resource while MR is alive,
+     * and thus, making the data pointer invalid, we will block virtio-gpu
+     * command processing until MR is fully unreferenced and freed.
+     */
+    OBJECT(mr)->free = virtio_gpu_virgl_hostmem_region_free;
+
+    res->mr = mr;
+
+    return 0;
+}
+
+static int
+virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
+                                     struct virtio_gpu_virgl_resource *res,
+                                     bool *cmd_suspended)
+{
+    struct virtio_gpu_virgl_hostmem_region *vmr;
+    VirtIOGPUBase *b = VIRTIO_GPU_BASE(g);
+    MemoryRegion *mr = res->mr;
+    int ret;
+
+    if (!mr) {
+        return 0;
+    }
+
+    vmr = to_hostmem_region(res->mr);
+
+    /*
+     * Perform async unmapping in 3 steps:
+     *
+     * 1. Begin async unmapping with memory_region_del_subregion()
+     *    and suspend/block cmd processing.
+     * 2. Wait for res->mr to be freed and cmd processing resumed
+     *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
+     * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
+     */
+
+    switch (vmr->state) {
+    case HOSTMEM_MR_MAPPED:
+        vmr->state = HOSTMEM_MR_UNMAPPING;
+
+        *cmd_suspended = true;
+
+        /* render will be unblocked once MR is freed */
+        b->renderer_blocked++;
+
+        /* memory region owns self res->mr object and frees it by itself */
+        memory_region_set_enabled(mr, false);
+        memory_region_del_subregion(&b->hostmem, mr);
+        object_unparent(OBJECT(mr));
+        break;
+    case HOSTMEM_MR_FINISH_UNMAPPING:
+        ret = virgl_renderer_resource_unmap(res->base.resource_id);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: failed to unmap virgl resource: %s\n",
+                          __func__, strerror(-ret));
+            return ret;
+        }
+        res->mr = NULL;
+        g_free(vmr);
+        break;
+    case HOSTMEM_MR_UNMAPPING:
+        *cmd_suspended = true;
+        break;
+    }
+
+    return 0;
+}
+#endif /* HAVE_VIRGL_RESOURCE_BLOB */
+
 static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
                                          struct virtio_gpu_ctrl_command *cmd)
 {
@@ -146,7 +300,8 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
 }
 
 static void virgl_cmd_resource_unref(VirtIOGPU *g,
-                                     struct virtio_gpu_ctrl_command *cmd)
+                                     struct virtio_gpu_ctrl_command *cmd,
+                                     bool *cmd_suspended)
 {
     struct virtio_gpu_resource_unref unref;
     struct virtio_gpu_virgl_resource *res;
@@ -164,6 +319,16 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
         return;
     }
 
+#ifdef HAVE_VIRGL_RESOURCE_BLOB
+    if (virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+    if (*cmd_suspended) {
+        return;
+    }
+#endif
+
     virgl_renderer_resource_detach_iov(unref.resource_id,
                                        &res_iovs,
                                        &num_iovs);
@@ -514,6 +679,133 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
 }
 
 #ifdef HAVE_VIRGL_RESOURCE_BLOB
+static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
+                                           struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virgl_renderer_resource_create_blob_args virgl_args = { 0 };
+    struct virtio_gpu_resource_create_blob cblob;
+    struct virtio_gpu_virgl_resource *res;
+    int ret;
+
+    if (!virtio_gpu_blob_enabled(g->parent_obj.conf)) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
+        return;
+    }
+
+    VIRTIO_GPU_FILL_CMD(cblob);
+    virtio_gpu_create_blob_bswap(&cblob);
+    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
+
+    if (cblob.resource_id == 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed\n",
+                      __func__);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
+    if (res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
+                      __func__, cblob.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    res = g_new0(struct virtio_gpu_virgl_resource, 1);
+    res->base.resource_id = cblob.resource_id;
+    res->base.blob_size = cblob.size;
+    res->base.dmabuf_fd = -1;
+
+    if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
+        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeof(cblob),
+                                            cmd, &res->base.addrs,
+                                            &res->base.iov, &res->base.iov_cnt);
+        if (!ret) {
+            g_free(res);
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return;
+        }
+    }
+
+    virgl_args.res_handle = cblob.resource_id;
+    virgl_args.ctx_id = cblob.hdr.ctx_id;
+    virgl_args.blob_mem = cblob.blob_mem;
+    virgl_args.blob_id = cblob.blob_id;
+    virgl_args.blob_flags = cblob.blob_flags;
+    virgl_args.size = cblob.size;
+    virgl_args.iovecs = res->base.iov;
+    virgl_args.num_iovs = res->base.iov_cnt;
+
+    ret = virgl_renderer_resource_create_blob(&virgl_args);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error: %s\n",
+                      __func__, strerror(-ret));
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        virtio_gpu_cleanup_mapping(g, &res->base);
+        g_free(res);
+        return;
+    }
+
+    QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
+}
+
+static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
+                                        struct virtio_gpu_ctrl_command *cmd)
+{
+    struct virtio_gpu_resource_map_blob mblob;
+    struct virtio_gpu_virgl_resource *res;
+    struct virtio_gpu_resp_map_info resp;
+    int ret;
+
+    VIRTIO_GPU_FILL_CMD(mblob);
+    virtio_gpu_map_blob_bswap(&mblob);
+
+    res = virtio_gpu_virgl_find_resource(g, mblob.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, mblob.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    ret = virtio_gpu_virgl_map_resource_blob(g, res, mblob.offset);
+    if (ret) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+
+    memset(&resp, 0, sizeof(resp));
+    resp.hdr.type = VIRTIO_GPU_RESP_OK_MAP_INFO;
+    virgl_renderer_resource_get_map_info(mblob.resource_id, &resp.map_info);
+    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
+}
+
+static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
+                                          struct virtio_gpu_ctrl_command *cmd,
+                                          bool *cmd_suspended)
+{
+    struct virtio_gpu_resource_unmap_blob ublob;
+    struct virtio_gpu_virgl_resource *res;
+    int ret;
+
+    VIRTIO_GPU_FILL_CMD(ublob);
+    virtio_gpu_unmap_blob_bswap(&ublob);
+
+    res = virtio_gpu_virgl_find_resource(g, ublob.resource_id);
+    if (!res) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n",
+                      __func__, ublob.resource_id);
+        cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
+        return;
+    }
+
+    ret = virtio_gpu_virgl_unmap_resource_blob(g, res, cmd_suspended);
+    if (ret) {
+        cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+        return;
+    }
+}
+
 static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
                                        struct virtio_gpu_ctrl_command *cmd)
 {
@@ -616,6 +908,8 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
 void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
+    bool cmd_suspended = false;
+
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
     virgl_renderer_force_ctx_0();
@@ -657,7 +951,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virgl_cmd_resource_flush(g, cmd);
         break;
     case VIRTIO_GPU_CMD_RESOURCE_UNREF:
-        virgl_cmd_resource_unref(g, cmd);
+        virgl_cmd_resource_unref(g, cmd, &cmd_suspended);
         break;
     case VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE:
         /* TODO add security */
@@ -680,6 +974,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         virtio_gpu_get_edid(g, cmd);
         break;
 #ifdef HAVE_VIRGL_RESOURCE_BLOB
+    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
+        virgl_cmd_resource_create_blob(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
+        virgl_cmd_resource_map_blob(g, cmd);
+        break;
+    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
+        virgl_cmd_resource_unmap_blob(g, cmd, &cmd_suspended);
+        break;
     case VIRTIO_GPU_CMD_SET_SCANOUT_BLOB:
         virgl_cmd_set_scanout_blob(g, cmd);
         break;
@@ -689,7 +992,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
         break;
     }
 
-    if (cmd->finished) {
+    if (cmd_suspended || cmd->finished) {
         return;
     }
     if (cmd->error) {
@@ -858,6 +1161,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         timer_mod(gl->print_stats,
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
     }
+
+#ifdef HAVE_VIRGL_RESOURCE_BLOB
+    gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
+                                    virtio_gpu_virgl_resume_cmdq_bh,
+                                    g);
+#endif
+
     return 0;
 }
 
@@ -875,6 +1185,10 @@ void virtio_gpu_virgl_deinit(VirtIOGPU *g)
 {
     VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
+#ifdef HAVE_VIRGL_RESOURCE_BLOB
+    qemu_bh_delete(gl->cmdq_resume_bh);
+#endif
+
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         timer_free(gl->print_stats);
     }
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 8e05a2d0c7c5..d423bc9a7bf5 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1496,10 +1496,12 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
             return;
         }
 
+#ifndef HAVE_VIRGL_RESOURCE_BLOB
         if (virtio_gpu_virgl_enabled(g->parent_obj.conf)) {
-            error_setg(errp, "blobs and virgl are not compatible (yet)");
+            error_setg(errp, "old virglrenderer, blob resources unsupported");
             return;
         }
+#endif
     }
 
     if (!virtio_gpu_base_device_realize(qdev,
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 0bfdfd91db46..368f96a813c9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -239,6 +239,8 @@ struct VirtIOGPUGL {
 
     QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
+
+    QEMUBH *cmdq_resume_bh;
 };
 
 struct VhostUserGPU {
-- 
2.44.0


