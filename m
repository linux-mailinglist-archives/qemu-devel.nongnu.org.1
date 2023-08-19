Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A52781659
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAWA-0003mE-Pg; Fri, 18 Aug 2023 21:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAW9-0003lw-Cu
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:12:41 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAW7-00018i-5Q
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:12:41 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-56d455462c2so978850eaf.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692407557; x=1693012357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hvionuIXv7LMOq0cI8KPe5wcQe2Sqak65Qf/t8GWDQo=;
 b=Sff+3d7aJjMkjAYNusquVuLH41c1hlc5ykaEfDfrx/Lgy+B5/hh7Bh+n83YBveJqBi
 s4wzSQNRJKMgGKwVGW46ysharrcoGxQTAUgGol3928YKRYsjHR/ueOT6k8pOFt5FmllS
 ZpcXOBhW9ONcd7X79EcAXv1s3JqZgTSAw7LSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692407557; x=1693012357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hvionuIXv7LMOq0cI8KPe5wcQe2Sqak65Qf/t8GWDQo=;
 b=apkawlTqLIN1IIP2M5Q24k0Ly7dO0Jv/kvHCQwsr9x/vIPyorq9UMrCxjJQrR9WODm
 IucOMf8e+gLdkfSf3w55FUxftt8gpjWwhGhHamzIizZqH8rn9KrlmVVtGPh26Szcpnkg
 nyJEGSj8yAV8SzSRZ1E2yLOLiPLv7fvFHeLGHJY4B8HZPMvykEaLhXN6WA83HRUFYI1z
 FCUEYIHcA3kYaqEcEXJrTx8VITpRKruNADevoZfP54mQ+G66lzgmw/crhoo3aVqZeZt0
 TQVQXK+rV6/FH5EtSOhCwYLISLsKmT0GZ2H/rp65iaCqXRwWjYcISzf37EqoJ1fTOVOx
 g6pA==
X-Gm-Message-State: AOJu0YxWgUarGK5jRb5JsKil48rBjniHS5wu5OanbcaUR2n0c11ujtlV
 4Cw7gwuvJ8LUnVsvtP40pJimoD84QHwU78wbC6k=
X-Google-Smtp-Source: AGHT+IFEx0jruknae73x0V7FHj9q5wb9t78QDaKv8ohACZZXU4af2R+WFPY/tudnrdbzrQqpSYg2hg==
X-Received: by 2002:a05:6359:622:b0:132:d333:4a5c with SMTP id
 eh34-20020a056359062200b00132d3334a5cmr734044rwb.10.1692407557444; 
 Fri, 18 Aug 2023 18:12:37 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:92c9:8bef:2f4d:5ef5])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a056a00165a00b0068a077b21c2sm554810pfc.172.2023.08.18.18.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:12:37 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v9 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Fri, 18 Aug 2023 18:12:25 -0700
Message-Id: <20230819011229.415-5-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230819011229.415-1-gurchetansingh@chromium.org>
References: <20230819011229.415-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oo1-xc2b.google.com
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


