Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A3A7CAA8A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:55:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsO3R-0001xM-CK; Mon, 16 Oct 2023 09:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qsO3O-0001ui-W7
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qsO3M-0005zT-8N
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697464479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObueEwrT0Hm52hOpehSMtgKc75oIA2T2TT5b7lnSKwc=;
 b=GqG8L6WVpvqnhJSym8ZidMD6MmGxcwIHX1aUFq7Qvr+2CjiENG13IubAiYRgtgKsEmufrw
 X4ZFKJ8PNoEu5+GD/EDM0f4CYPUwCoEwEoM4l/rWwzDyQdNYowkzmzqnxopnPJ/T2Y+HYs
 EDoqbUmisaD8/k5vENVbbk/IGxSm6VA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-136-3W5PRJfBM_2dzykFxcbS8w-1; Mon, 16 Oct 2023 09:54:26 -0400
X-MC-Unique: 3W5PRJfBM_2dzykFxcbS8w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A3CA85A5BF;
 Mon, 16 Oct 2023 13:54:26 +0000 (UTC)
Received: from localhost (unknown [10.39.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCA2040C6F79;
 Mon, 16 Oct 2023 13:54:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 3/9] virtio-gpu: hostmem
Date: Mon, 16 Oct 2023 17:53:55 +0400
Message-ID: <20231016135404.899743-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231016135404.899743-1-marcandre.lureau@redhat.com>
References: <20231016135404.899743-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

From: Gerd Hoffmann <kraxel@redhat.com>

Use VIRTIO_GPU_SHM_ID_HOST_VISIBLE as id for virtio-gpu.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Tested-by: Huang Rui <ray.huang@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-gpu.h |  5 +++++
 hw/display/virtio-gpu-pci.c    | 14 ++++++++++++++
 hw/display/virtio-gpu.c        |  1 +
 hw/display/virtio-vga.c        | 33 ++++++++++++++++++++++++---------
 4 files changed, 44 insertions(+), 9 deletions(-)

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
index 93857ad523..5585558855 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1511,6 +1511,7 @@ static Property virtio_gpu_properties[] = {
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
-- 
2.41.0


