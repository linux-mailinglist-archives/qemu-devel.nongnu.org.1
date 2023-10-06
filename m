Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD07BAFF9
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 03:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoZKx-0001DV-Ro; Thu, 05 Oct 2023 21:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKw-0001DH-Ae
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:09:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKf-00080G-N7
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:09:02 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-69af8a42066so695938b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 18:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696554524; x=1697159324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qe+wtQv9qhCLmTvdjDWl5QcBmuIflHhjhM4zRRF4e6s=;
 b=IEYflbpmjxGz4UM3GWsRfMwiGDltrjoAD+Zv6S0H6E8pmDfSCClRdZFOJGAJKVPiAa
 gaKD/tH1N5kniEcEI8oEAoCxKxN/OlSP5qxIj9rvw05Fd9KNdOl8DVXpt0JLt7SD+Qeb
 PIy6t65jJhQj4sVdwJUrA6XlEHKZpekM//wRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696554524; x=1697159324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qe+wtQv9qhCLmTvdjDWl5QcBmuIflHhjhM4zRRF4e6s=;
 b=J1MwNt/FTcUb1033sdiZtTjhwV1PI5DuaVD+2sqPg2O2K3ACRE1ANTdDA5Hr9ozQa6
 U+vJKeW9nbnyuEFyUr+8WoTAzZoT85JJwVuR9oYrQBU/qS4xtPdwFfqFzzWZXAwuY7ZC
 xdL0xYckBEyYR6zMT02YsgvzjmGYakyLKnv5axpHenDbI238QW8m9FWwaDtcJWFSQp6n
 BT2O4BTXoIAujRo/J8HfecF2O0AFZj/j95/9u+utpvOdUboxhAWjR2nme+CXnZc7r1zT
 QwgDEV0UfC0SIIDUJkEITL55wvxwC8+yTQeZB46wibAcGkoL7KxzTHOM2Qe4V1oyfnAH
 4plA==
X-Gm-Message-State: AOJu0Yz0KeJCGyZt5JXGyA1aRbvJb5pU71BdPHvHcA4T1Lteh5syFUse
 L9FSXYpyfrut69dPT18xClfwjxXzm44VWaPZ4Fc=
X-Google-Smtp-Source: AGHT+IFDlQeqerkra3TFBkyO7hOplIybZGfzf2suPqvtZg11kzY0eLrXICzK2qBIomJQJP5Un3TeJw==
X-Received: by 2002:a05:6a00:2348:b0:690:d251:28ad with SMTP id
 j8-20020a056a00234800b00690d25128admr7731562pfj.29.1696554523972; 
 Thu, 05 Oct 2023 18:08:43 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:176a:c8b6:faa3:f083])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a62ed16000000b00690fe1c928csm215079pfh.147.2023.10.05.18.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 18:08:43 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v17 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Thu,  5 Oct 2023 18:08:31 -0700
Message-Id: <20231006010835.444-6-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231006010835.444-1-gurchetansingh@chromium.org>
References: <20231006010835.444-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This modifies the common virtio-gpu.h file have the fields and
defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-gpu.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 55973e112f..39018377d2 100644
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
 
@@ -232,6 +238,27 @@ struct VhostUserGPU {
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
+    struct MemoryRegionInfo memory_regions[MAX_SLOTS];
+    uint64_t capset_mask;
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
2.42.0.609.gbb76f46606-goog


