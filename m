Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F5787C0D
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZJwn-0007Ej-RV; Thu, 24 Aug 2023 19:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwi-0007Cg-3v
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:41:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwf-0005BI-Lp
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:40:59 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68730bafa6bso1025498b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692920456; x=1693525256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yK3XrAu1GwURrEx3RY3L+xasbQ0ma1AzcvEK4mcYtEA=;
 b=exm/wpujDT6mbB5sXoorlNghmzom2EY7jb1uH34uNojUSOE+4BXCCln2xbWfM5MPc9
 Io/wmM1GGoL+ONjygXZjb4+phKKjiRUbeBSJ9juqdigxGDWfRyUUbLAQ/8Hau9t0ht5h
 /ZL5qW+uHBMPZwJNrQJ0rCjfo7vwmUE9r2GUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692920456; x=1693525256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yK3XrAu1GwURrEx3RY3L+xasbQ0ma1AzcvEK4mcYtEA=;
 b=PO1rWRmwh/nlK3LguKZ4dAajrWHCNonVzgXF9LyMkljS4dIYscPiQTmYwOKvCORdfn
 DktuSXQxsX8dyqN/dhw5GUrTz59FpSraTCSSksBlBm5ZYR1pGP2rpesnNeEgh7u6V/u0
 MkNkAor3lGBr6pr/a3I+n1nR4/xH5KjfjGIvFAk2Y45Fb29LbbKKwI+LOSXFmzaBxad0
 Vi0ng2EoMyBgdUZyuFipCdyNsZETTllEANUIYYi4/xNFSXPOklFaCKbpRggGWR+DQpUW
 wRZbqFZWzmn5aAegQ7gpjbHBXsOV3AE/9oRWg9QytM71mud/mL3WU0BMO9GrLLQEf7tK
 EBBA==
X-Gm-Message-State: AOJu0YyY27HVM3N9LMnyfWyKoJf6HQA/h/AZ88YzxSYRoskhNQDHFgXm
 MMZW/pUtC7ZF6+br7FmeXpos/7X5l3woryGuwkY=
X-Google-Smtp-Source: AGHT+IGYzvfTUJmua10Y1O6h2+OKRE5btDNN2c2wzBU1dFK9Tp5dWuSYJYqBnTBJWysRAdEkjUXZQw==
X-Received: by 2002:a05:6a20:7346:b0:13f:13cb:bc50 with SMTP id
 v6-20020a056a20734600b0013f13cbbc50mr25171865pzc.25.1692920455998; 
 Thu, 24 Aug 2023 16:40:55 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:1fa0:9cd:3c53:231b])
 by smtp.gmail.com with ESMTPSA id
 fe8-20020a056a002f0800b0066a31111cc5sm274798pfb.152.2023.08.24.16.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 16:40:55 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v12 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Thu, 24 Aug 2023 16:40:42 -0700
Message-Id: <20230824234046.499-6-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230824234046.499-1-gurchetansingh@chromium.org>
References: <20230824234046.499-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x431.google.com
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

v12: Drop unnecessary "struct" (Mark)

 include/hw/virtio/virtio-gpu.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 55973e112f..de06bcdba4 100644
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
+    VirtIOGPU parent_obj;
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
2.42.0.rc2.253.gd59a3bf2b4-goog


