Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66077D79A
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 03:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW5BO-0002hO-HV; Tue, 15 Aug 2023 21:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qW5BL-0002gF-IC
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 21:18:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qW5BH-00059j-SL
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 21:18:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso50886035ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 18:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692148718; x=1692753518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QthAOBZZCI8ZLTtSuM4U2dFYkSSlAWTRoH3E2e64a6k=;
 b=b5T2FnbQXmTA39HEO6apKpL9mr++ElZX/tBWS3yTs9P3lxZLoXMg9tFE5D82UmgkAm
 WmCHyG3pYgXt5n6ce5NEanWkPvR9/8m+dqiv5pPqQCwz/tO1M+oPe7tueuSPDJV0QhC2
 DXTZgsZqoma0/F+rh9gU8a5W9fK5GyX+93/Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692148718; x=1692753518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QthAOBZZCI8ZLTtSuM4U2dFYkSSlAWTRoH3E2e64a6k=;
 b=BPzPKE9Zo12bWxmOOWTosX6TuJSusKvcUlOYirNEVyVyV8EXi3RiOfxqh/BSV3Lh2x
 pSn1cFoYBdXxOuhFlXZaZ8f7lHGZRu7MJ4Vn8gYzoGYkkmH5Xpz/rZlOOeBgv2d0hQU/
 IBVF7+ohsnHXzwktPhgO5rC/o+UlAa9DuMVC8kgcR6lVS4BcVq/1L/VP4rQaZxVtPxAm
 Gqv25TY91p1585vYg7HdYh41CIj6zPRhpJDqBAVaAev+8/Xqyjjjm9WAMn8NngYAGMyJ
 0k8QCbCuJSq9fEZI/tGwJ1oaYU4ho2bjykrzPQzLkLmkndEpQlI9ioti9KBjFyvtsumY
 am7A==
X-Gm-Message-State: AOJu0YzCrVUmzmqiSVMHOXBh7Dz0j+Ft4CPAx9cjAbiR6uQdNEcSkxK6
 KqfzNjm/dICPYW0hYzcjqQdlgdk0DED4cQx3FitQ+w==
X-Google-Smtp-Source: AGHT+IEG9SuM+2PNXiTVTOzWb72yxGI9klF07Va7MEnCgVE57ryqzPvCvYjnxvMGoGiiJiG0fsIriQ==
X-Received: by 2002:a17:903:1251:b0:1b8:66f6:87a3 with SMTP id
 u17-20020a170903125100b001b866f687a3mr652953plh.52.1692148718261; 
 Tue, 15 Aug 2023 18:18:38 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5f11:65df:7276:aadf])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a170902da8200b001bc7306d321sm11723562plx.282.2023.08.15.18.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 18:18:37 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v6 3/9] virtio-gpu: hostmem
Date: Tue, 15 Aug 2023 18:18:25 -0700
Message-Id: <20230816011831.599-4-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230816011831.599-1-gurchetansingh@chromium.org>
References: <20230816011831.599-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Use VIRTIO_GPU_SHM_ID_HOST_VISIBLE as id for virtio-gpu.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Tested-by: Alyssa Ross <hi@alyssa.is>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/display/virtio-gpu-pci.c    | 14 ++++++++++++++
 hw/display/virtio-gpu.c        |  1 +
 hw/display/virtio-vga.c        | 33 ++++++++++++++++++++++++---------
 include/hw/virtio/virtio-gpu.h |  5 +++++
 4 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 93f214ff58..da6a99f038 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -33,6 +33,20 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     DeviceState *vdev = DEVICE(g);
     int i;
 
+    if (virtio_gpu_hostmem_enabled(g->conf)) {
+        vpci_dev->msix_bar_idx = 1;
+        vpci_dev->modern_mem_bar_idx = 2;
+        memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
+                           g->conf.hostmem);
+        pci_register_bar(&vpci_dev->pci_dev, 4,
+                         PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_PREFETCH |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                         &g->hostmem);
+        virtio_pci_add_shm_cap(vpci_dev, 4, 0, g->conf.hostmem,
+                               VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
+    }
+
     virtio_pci_force_virtio_1(vpci_dev);
     if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index bbd5c6561a..48ef0d9fad 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1509,6 +1509,7 @@ static Property virtio_gpu_properties[] = {
                      256 * MiB),
     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
+    DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index e6fb0aa876..c8552ff760 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -115,17 +115,32 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     pci_register_bar(&vpci_dev->pci_dev, 0,
                      PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
 
-    /*
-     * Configure virtio bar and regions
-     *
-     * We use bar #2 for the mmio regions, to be compatible with stdvga.
-     * virtio regions are moved to the end of bar #2, to make room for
-     * the stdvga mmio registers at the start of bar #2.
-     */
-    vpci_dev->modern_mem_bar_idx = 2;
-    vpci_dev->msix_bar_idx = 4;
     vpci_dev->modern_io_bar_idx = 5;
 
+    if (!virtio_gpu_hostmem_enabled(g->conf)) {
+        /*
+         * Configure virtio bar and regions
+         *
+         * We use bar #2 for the mmio regions, to be compatible with stdvga.
+         * virtio regions are moved to the end of bar #2, to make room for
+         * the stdvga mmio registers at the start of bar #2.
+         */
+        vpci_dev->modern_mem_bar_idx = 2;
+        vpci_dev->msix_bar_idx = 4;
+    } else {
+        vpci_dev->msix_bar_idx = 1;
+        vpci_dev->modern_mem_bar_idx = 2;
+        memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
+                           g->conf.hostmem);
+        pci_register_bar(&vpci_dev->pci_dev, 4,
+                         PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_PREFETCH |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                         &g->hostmem);
+        virtio_pci_add_shm_cap(vpci_dev, 4, 0, g->conf.hostmem,
+                               VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
+    }
+
     if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
         /*
          * with page-per-vq=off there is no padding space we can use
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 8377c365ef..de4f624e94 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -108,12 +108,15 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
 #define virtio_gpu_context_init_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
+#define virtio_gpu_hostmem_enabled(_cfg) \
+    (_cfg.hostmem > 0)
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
     uint32_t flags;
     uint32_t xres;
     uint32_t yres;
+    uint64_t hostmem;
 };
 
 struct virtio_gpu_ctrl_command {
@@ -137,6 +140,8 @@ struct VirtIOGPUBase {
     int renderer_blocked;
     int enable;
 
+    MemoryRegion hostmem;
+
     struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
 
     int enabled_output_bitmask;
-- 
2.42.0.rc1.204.g551eb34607-goog


