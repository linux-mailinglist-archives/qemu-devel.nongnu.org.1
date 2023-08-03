Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F776F656
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 01:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRiA1-0007Hu-Mb; Thu, 03 Aug 2023 19:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9z-0007H9-4c
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:15 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9x-0003cK-1R
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:14 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a4875e65a3so1141750b6e.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691106911; x=1691711711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ML5pegNJxZCBXfDIlgLBAOqali8aVcVhLJQ1yHj3ULc=;
 b=VrD+mr2M+rZFO8M9GEAREpK2hBmkgZ4lr2M8AjNM5UV/E3Sm36e8zjlvEEtwsMQ7me
 zJgC2FzaJGrPS9xY4BqqvDkwZKR6RUJclVK/krLQoSRYGurtXO7PhuZDx8SkjmQsK6zJ
 JyS7pgBr3lU+R5CN7myXiLtLH7Npwj3BXC6L8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691106911; x=1691711711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ML5pegNJxZCBXfDIlgLBAOqali8aVcVhLJQ1yHj3ULc=;
 b=dI+fTG0smKLQeAoDBcvBV3e8HTrVjmHWYEsPLgjRRWDxWRp4y/9vTRCxEfwDhvDCTT
 W6J3g7QoQvtqWiLorrFZGnXnP5F8dhB5oxMoZQ3Q6wtYn250in8F7xs+Q1KFPBOuVICa
 jp8UAl5TCmf1MYyzKqoW+lSFGrRl1cE00JMPmQ0lJCTTfl2mXPZr4BTvTp2mErC5aS0S
 gvuRHyRnGAM5eMJSV6Z0sOtDSHxtlzm3P+eKYdKj6LHujy8nMWZ5RxBONg7S2zzNcWXz
 LJGr0qDbKPN09UwO3Z0uoyk6X5FU51CMbpZxoZoAOtjK3rrYvimBa68+witDm/H5WeqJ
 MNcg==
X-Gm-Message-State: AOJu0Yx9FsTLLQxv6Q9jhelEwrg3uPl/nUdIabWAezkqgteCvcZjSpox
 wewJptpS+NKCxFWuSTac68YVbaqxt+lGU9u+o5M=
X-Google-Smtp-Source: AGHT+IH1jTj8TzXjGUAdHT9wjzuRG0yCL8MurXpSaOb6E/KKFQbMPPBvmyU2TjoJKGLMCPyGYWhIJw==
X-Received: by 2002:a05:6808:1686:b0:3a1:d656:21c with SMTP id
 bb6-20020a056808168600b003a1d656021cmr135144oib.21.1691106911038; 
 Thu, 03 Aug 2023 16:55:11 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9efb:b80c:dd5c:56c9])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a63a708000000b0055387ffef10sm364329pgf.24.2023.08.03.16.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 16:55:10 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v3 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Thu,  3 Aug 2023 16:54:58 -0700
Message-Id: <20230803235502.373-6-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230803235502.373-1-gurchetansingh@google.com>
References: <20230803235502.373-1-gurchetansingh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Gurchetan Singh <gurchetansingh@chromium.org>

This modifies the common virtio-gpu.h file have the fields and
defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.

The command to run these would be:

-device virtio-vga-rutabaga,capset_names=gfxstream-vulkan:cross-domain, \
        wayland_socket_path=/run/user/1000/wayland-0,hostmem=8G  \

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
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
index f25f3ce075..62d1804ab2 100644
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
 
@@ -229,6 +235,28 @@ struct VhostUserGPU {
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
2.41.0.585.gd2178a4bd4-goog


