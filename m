Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E17750C0
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYfT-00076H-9l; Tue, 08 Aug 2023 22:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfQ-000743-HM
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:20 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfO-00015v-Ue
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:20 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-565331f0736so140144a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691547077; x=1692151877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQ9VfOCKhI/4PoRZII8g8ypIqt32q/bHpgwUwryN+E8=;
 b=b+ETbqapgYtAHFa6wQ91R/skszPk2YmG/9pctVg786qYwp1Xu7XhxuxkMshXcwnqyK
 +jjFSlz2nrXvfbaSTFZoyU0KLncSfufVqJrQKJfSfJDZ7DIfXGXlOihngCf5CfB77MWy
 jeWdx7FeFqhkRCWm3kbMPGUPyc66XEMzwm6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691547077; x=1692151877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQ9VfOCKhI/4PoRZII8g8ypIqt32q/bHpgwUwryN+E8=;
 b=N3vezFKjrbh6Aj43WxOqmtcO/0CXlN1b1N/9aEaLZ3folGLJLy6rgMyIePWWsP5zBa
 43vFItt9JV+vdnhB8GXLgLLTaVgkLTtLtXoaolItZyQNYW4EI3PKQnzwjUMGkgs3Nrgb
 dmmtHce39ZipSJL3Purx3Ra7wdey1ffImhUESGfyxEPrKx1mp7nFnjIFycU2Gxavd5Jw
 Wg7kt85lGj7eE2YIyQYk6fLADOlNsTcRaNtJy1TrOrmGg5uhxZlG2R0YroUnuZsHHKQ+
 AsAf5pyQaapRZPvTAQ45yK7mReS+goK4pcrxrvxQKvcXTfnahqbK0mQtRumwmuJltJi6
 SPOw==
X-Gm-Message-State: AOJu0YxoDIfOALhgnQH5IXYN3LSvcujUPF1XRxrfHlaWP6Tty6snQb76
 8cgbqbT5R9LerUoYMmSZj1kWk9bWiGHcWf5k5WooDg==
X-Google-Smtp-Source: AGHT+IF9I9/ITTCSb4yRbWRIauk21U5P/1xDTnCyNmRSCxA4p+Re0+mya98pWXy2iK8O1B1GlDFeZQ==
X-Received: by 2002:a05:6a21:271c:b0:126:a80d:4960 with SMTP id
 rm28-20020a056a21271c00b00126a80d4960mr1205898pzb.30.1691547077045; 
 Tue, 08 Aug 2023 19:11:17 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a5a2:f074:e7af:41fe])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa78650000000b00687494a59bfsm8681887pfo.61.2023.08.08.19.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 19:11:16 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com
Subject: [PATCH v4 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Tue,  8 Aug 2023 19:11:04 -0700
Message-Id: <20230809021108.674-6-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230809021108.674-1-gurchetansingh@chromium.org>
References: <20230809021108.674-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This modifies the common virtio-gpu.h file have the fields and
defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.

The command to run these would be:

-device virtio-vga-rutabaga,capset_names=gfxstream-vulkan:cross-domain, \
        wayland_socket_path=/run/user/1000/wayland-0,hostmem=8G  \

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
---
v1: void *rutabaga --> struct rutabaga *rutabaga (Akihiko)
    have a separate rutabaga device instead of using GL device (Bernard)

v2: VirtioGpuRutabaga --> VirtIOGPURutabaga (Akihiko)
    move MemoryRegionInfo into VirtIOGPURutabaga (Akihiko)
    remove 'ctx' field (Akihiko)
    remove 'rutabaga_active'

 include/hw/virtio/virtio-gpu.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 55973e112f..e2a07e68d9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_GL)
 #define TYPE_VHOST_USER_GPU "vhost-user-gpu"
 OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)
 
+#define TYPE_VIRTIO_GPU_RUTABAGA "virtio-gpu-rutabaga-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabaga, VIRTIO_GPU_RUTABAGA)
+
 struct virtio_gpu_simple_resource {
     uint32_t resource_id;
     uint32_t width;
@@ -94,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_DMABUF_ENABLED,
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
+    VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -108,6 +112,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
 #define virtio_gpu_context_init_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
+#define virtio_gpu_rutabaga_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
 #define virtio_gpu_hostmem_enabled(_cfg) \
     (_cfg.hostmem > 0)
 
@@ -232,6 +238,28 @@ struct VhostUserGPU {
     bool backend_blocked;
 };
 
+#define MAX_SLOTS 4096
+
+struct MemoryRegionInfo {
+    int used;
+    MemoryRegion mr;
+    uint32_t resource_id;
+};
+
+struct rutabaga;
+
+struct VirtIOGPURutabaga {
+    struct VirtIOGPU parent_obj;
+
+    struct MemoryRegionInfo memory_regions[MAX_SLOTS];
+    char *capset_names;
+    char *wayland_socket_path;
+    char *wsi;
+    bool headless;
+    uint32_t num_capsets;
+    struct rutabaga *rutabaga;
+};
+
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
         size_t s;                                                       \
         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
-- 
2.41.0.640.ga95def55d0-goog


