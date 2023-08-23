Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BFE784E2F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 03:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYcdA-0006x4-Fu; Tue, 22 Aug 2023 21:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd8-0006wC-9Q
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd6-0002Bc-1k
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:54 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-26d0d376ec7so3513953a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692753950; x=1693358750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvionuIXv7LMOq0cI8KPe5wcQe2Sqak65Qf/t8GWDQo=;
 b=AXhl9SNly20etAGpNlyfVDBqCU816FfqsImZQVBLIJjqvVzDGBXfgKWVab+pFkgVZu
 AnZY4rSW6HkEiuRjouoOyi6gexgV9Ixl97/MoPE6CM+iRvOHV365KPkZMR+h5jwj/VIN
 nzUyVeQKR0LwoBtR2FUu4IzGBZ1xgUGds7grQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692753950; x=1693358750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvionuIXv7LMOq0cI8KPe5wcQe2Sqak65Qf/t8GWDQo=;
 b=B8tECtfJjo2dCeNGKUpri48vb9Iz5V5qFmq5hWKq5Qi0n8tX88KTVvFmidGZjMM2oc
 xnRqwAKyBRa4UVHE9+cXQoLMyoD4wUCzXI+vfApQvcR+8Suuh9rr8YYwCP3E0aD1rJC9
 TBk2YATw0+YYwV8ATJ2CXQd/oyjm77aq1JgqQgW66OKXbL5/STLk6T8fSQYlMWUh8ZKJ
 dylYSgUnWJc2q87wuqwbofkehJdxqLQEyyiwD/ZqFW43l9OdyjR+7NsIaCtDTsQ+AeNs
 cMLWBz79AX+BJ2+8jMIEjhe5sSgNqLd23kcQwiNq+ETnvG1Ze0bVMZw9Fj+wEf/Auc4w
 gLcQ==
X-Gm-Message-State: AOJu0YxGUutrP0xnMdsjQ6Z0t5ZM68XtYbGp7EZScJCOsoTyUB4ITJiL
 IKx2d4ByoTqsr1Rv6jRxNVfCWAu6KlyAOh92MP4=
X-Google-Smtp-Source: AGHT+IG+gV7T1SG925qQEubsOgSyOYFLdoPSSMe1ACxYovAp4Mrq2IDdpXHtetAF6CbhhBolj+psfw==
X-Received: by 2002:a17:90b:e97:b0:268:34b1:a5a9 with SMTP id
 fv23-20020a17090b0e9700b0026834b1a5a9mr10626882pjb.8.1692753950549; 
 Tue, 22 Aug 2023 18:25:50 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a483:9c7e:d68:4057])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a17090af0ce00b00263ba6a248bsm10291409pjb.1.2023.08.22.18.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 18:25:50 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: [PATCH v11 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Tue, 22 Aug 2023 18:25:37 -0700
Message-Id: <20230823012541.485-6-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230823012541.485-1-gurchetansingh@chromium.org>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pj1-x1036.google.com
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

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
v1: void *rutabaga --> struct rutabaga *rutabaga (Akihiko)
    have a separate rutabaga device instead of using GL device (Bernard)

v2: VirtioGpuRutabaga --> VirtIOGPURutabaga (Akihiko)
    move MemoryRegionInfo into VirtIOGPURutabaga (Akihiko)
    remove 'ctx' field (Akihiko)
    remove 'rutabaga_active'

v6: remove command from commit message, refer to docs instead (Manos)

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
2.42.0.rc1.204.g551eb34607-goog


