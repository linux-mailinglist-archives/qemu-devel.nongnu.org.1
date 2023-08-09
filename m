Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA627750C4
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYfQ-000742-PZ; Tue, 08 Aug 2023 22:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfO-000735-Px
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qTYfM-00015P-VQ
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:11:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686daaa5f1fso4435129b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691547075; x=1692151875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81rlyT+xWeEmR879NP9yyBdQbwCd4Zm82c4EiSJU1RY=;
 b=QOzyiXUAXdGDeQKbqzqmu11PXxBx97drvTzw8sDjYP59wwLHFjKrSWQTWYbkk9mkwz
 MbTgS3kq7R8ACDyjJLWYsOoTTfmW7U2niqF9L/uDN49VIf2FI0aTPytYgPt+UK2G5EQq
 Y83kLxwO+nD1kvyOiC4ggAQrcZfMpawdXOUZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691547075; x=1692151875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81rlyT+xWeEmR879NP9yyBdQbwCd4Zm82c4EiSJU1RY=;
 b=kxi9Dkw9F/H0wcHqg1R+WVznoZ4syFlTlomtwydRhpMIxquKjK/pAg7slGeSb1UeYH
 CCQakt7fDedBIDYRfV7taUI9D/Rm9fwYAFE2zbijZweZLpFUnupzPUAq7HYlsPwQsxie
 7Zgmm4XrEg7k4dblxIo5K5t/QrZ7urATW6L/HaRHFUbrU074xViBpYy6OhkJLNPDlodq
 Iw0Hmb56u5izcbj1AN+opLB41RPYxkMfGQIWRMNBjLHJyQJJlQvRWbzYDRTQCpsmzGSw
 636xki4z0+EqbI54uht4pL6BVDUOi9ABLvf9p9WbP5W3l62IKnRL9XqLD2+jWpWQNzyl
 1E4w==
X-Gm-Message-State: AOJu0Yz9aMZz4LQdfxyjjdgqIkuugb2+4azahfHhdMS4HcQYivOCmMr4
 SMKb9XzjJJ6ZWG2sBVfDw6KYwa3dK3rdoR59T+D+2Q==
X-Google-Smtp-Source: AGHT+IGm0xLg6YIhMQ0kXauA5qm5/WsRDdHP2TMVplVqCYmpP8syKSLdzvdHYWlNV4Gjv9juE9Zhvw==
X-Received: by 2002:a05:6a21:7988:b0:131:5f8b:9c7d with SMTP id
 bh8-20020a056a21798800b001315f8b9c7dmr1139917pzc.22.1691547074805; 
 Tue, 08 Aug 2023 19:11:14 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a5a2:f074:e7af:41fe])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa78650000000b00687494a59bfsm8681887pfo.61.2023.08.08.19.11.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 19:11:14 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com
Subject: [PATCH v4 3/9] virtio-gpu: hostmem
Date: Tue,  8 Aug 2023 19:11:02 -0700
Message-Id: <20230809021108.674-4-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230809021108.674-1-gurchetansingh@chromium.org>
References: <20230809021108.674-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42f.google.com
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
2.41.0.640.ga95def55d0-goog


