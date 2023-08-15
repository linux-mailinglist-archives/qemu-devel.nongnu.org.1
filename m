Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFB77CDEB
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVurW-0002Om-8r; Tue, 15 Aug 2023 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVurJ-0002Mz-J7
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:17:21 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVuqu-0006xb-2F
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:17:00 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe4ad22eb0so53344805e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692109013; x=1692713813;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sAH4koPIBDACcsT/HTWoHcL4Mm8W5K29gVPhewZMRzg=;
 b=TKyvPp0JpCn84eTgADwx4/KupwEvOjCUlFLaWsL/fYm6FARBCG56p+A8lfaaHSt2m0
 gCd/DG50INAxEuvIqQXP0DEolEhiFA9N7XLKZF+L3Auurv8KQ02TRHdDQ66DVtE///5A
 D7snvXp4RubHNyGGXeJMX+MMPhlp+2ASiPi+AwXwQ8mVo5AOf9sabklGZeFgYzIwf5KE
 pCQKTSuNtB9eMn9iBVPG9iPb3IC8JD1/s5gWhASPEbPCisant74WdPhC9YySSriTh5fe
 76ay+E7/eQfE4cTDG41FRH6uLWPEngRwDDTVNaTL/rQr4RoJ9ngly/eZR89bPxA75P3k
 Z1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692109013; x=1692713813;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sAH4koPIBDACcsT/HTWoHcL4Mm8W5K29gVPhewZMRzg=;
 b=ZTlScNM7trkgPNrZhtaoGzsVZJXsOHG+fXghCf6fuJItvMNSm/4sq1u7WAepweP7VM
 6hzMnD9l9uyBQEI0u2ESzgBL6Wuca+9jUTVpig7IFWvWGFLrdwTYIVOTvBzAej/jWWhp
 uvNn6OPSXZ553030/oJFYhDJaYbd1ZDm+ua63ejMkuJPllt9LFLWdOTyY0A3wizHYmW1
 MG1m7GB+kf/pxYVpSYbRXMHLp7BD+RRr8vL+444n2l3bK/5GYBPjzTqD0LQSGM8gpdwO
 vW0Ds+5mt6C1iqnwYhnF+wvxrkcaTJPPcN6+rLllYqvWM+/JfRU9OrzCEpDfx7piEpsB
 zLew==
X-Gm-Message-State: AOJu0Yz287O4loa/mUPJOicfHygQQi+CVy75Gp6rEBbnTbgB0u7/4XUz
 5mFedEgkcif+UN/vvRX2BOZtrn9DQtyJfzomWYc=
X-Google-Smtp-Source: AGHT+IGSdwnypKlsCt1tu80Se53aS2XFyHMZDZaZKBtnnWkxeHYK8GBiUoRwTLSn+sdvbUGQqYujTw==
X-Received: by 2002:adf:e2d1:0:b0:316:f3cf:6f12 with SMTP id
 d17-20020adfe2d1000000b00316f3cf6f12mr7696286wrj.48.1692109013051; 
 Tue, 15 Aug 2023 07:16:53 -0700 (PDT)
Received: from meli.delivery (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 i3-20020a05600c2d8300b003fd2e898aa3sm1488248wmg.0.2023.08.15.07.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:16:52 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:11:01 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: Re: [PATCH v5 3/9] virtio-gpu: hostmem
User-Agent: meli 0.7.3
References: <20230815003526.631-1-gurchetansingh@chromium.org>
 <20230815003526.631-4-gurchetansingh@chromium.org>
In-Reply-To: <20230815003526.631-4-gurchetansingh@chromium.org>
Message-ID: <zfro2.gsnbdy0821zu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

On Tue, 15 Aug 2023 03:35, Gurchetan Singh <gurchetansingh@chromium.org> wrote:
>From: Gerd Hoffmann <kraxel@redhat.com>
>
>Use VIRTIO_GPU_SHM_ID_HOST_VISIBLE as id for virtio-gpu.
>
>Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>Tested-by: Alyssa Ross <hi@alyssa.is>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> hw/display/virtio-gpu-pci.c    | 14 ++++++++++++++
> hw/display/virtio-gpu.c        |  1 +
> hw/display/virtio-vga.c        | 33 ++++++++++++++++++++++++---------
> include/hw/virtio/virtio-gpu.h |  5 +++++
> 4 files changed, 44 insertions(+), 9 deletions(-)
>
>diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
>index 93f214ff58..da6a99f038 100644
>--- a/hw/display/virtio-gpu-pci.c
>+++ b/hw/display/virtio-gpu-pci.c
>@@ -33,6 +33,20 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>     DeviceState *vdev = DEVICE(g);
>     int i;
> 
>+    if (virtio_gpu_hostmem_enabled(g->conf)) {
>+        vpci_dev->msix_bar_idx = 1;
>+        vpci_dev->modern_mem_bar_idx = 2;
>+        memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
>+                           g->conf.hostmem);
>+        pci_register_bar(&vpci_dev->pci_dev, 4,
>+                         PCI_BASE_ADDRESS_SPACE_MEMORY |
>+                         PCI_BASE_ADDRESS_MEM_PREFETCH |
>+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
>+                         &g->hostmem);
>+        virtio_pci_add_shm_cap(vpci_dev, 4, 0, g->conf.hostmem,
>+                               VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
>+    }
>+
>     virtio_pci_force_virtio_1(vpci_dev);
>     if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
>         return;
>diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>index bbd5c6561a..48ef0d9fad 100644
>--- a/hw/display/virtio-gpu.c
>+++ b/hw/display/virtio-gpu.c
>@@ -1509,6 +1509,7 @@ static Property virtio_gpu_properties[] = {
>                      256 * MiB),
>     DEFINE_PROP_BIT("blob", VirtIOGPU, parent_obj.conf.flags,
>                     VIRTIO_GPU_FLAG_BLOB_ENABLED, false),
>+    DEFINE_PROP_SIZE("hostmem", VirtIOGPU, parent_obj.conf.hostmem, 0),
>     DEFINE_PROP_END_OF_LIST(),
> };
> 
>diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
>index e6fb0aa876..c8552ff760 100644
>--- a/hw/display/virtio-vga.c
>+++ b/hw/display/virtio-vga.c
>@@ -115,17 +115,32 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>     pci_register_bar(&vpci_dev->pci_dev, 0,
>                      PCI_BASE_ADDRESS_MEM_PREFETCH, &vga->vram);
> 
>-    /*
>-     * Configure virtio bar and regions
>-     *
>-     * We use bar #2 for the mmio regions, to be compatible with stdvga.
>-     * virtio regions are moved to the end of bar #2, to make room for
>-     * the stdvga mmio registers at the start of bar #2.
>-     */
>-    vpci_dev->modern_mem_bar_idx = 2;
>-    vpci_dev->msix_bar_idx = 4;
>     vpci_dev->modern_io_bar_idx = 5;
> 
>+    if (!virtio_gpu_hostmem_enabled(g->conf)) {
>+        /*
>+         * Configure virtio bar and regions
>+         *
>+         * We use bar #2 for the mmio regions, to be compatible with stdvga.
>+         * virtio regions are moved to the end of bar #2, to make room for
>+         * the stdvga mmio registers at the start of bar #2.
>+         */
>+        vpci_dev->modern_mem_bar_idx = 2;
>+        vpci_dev->msix_bar_idx = 4;
>+    } else {
>+        vpci_dev->msix_bar_idx = 1;
>+        vpci_dev->modern_mem_bar_idx = 2;
>+        memory_region_init(&g->hostmem, OBJECT(g), "virtio-gpu-hostmem",
>+                           g->conf.hostmem);
>+        pci_register_bar(&vpci_dev->pci_dev, 4,
>+                         PCI_BASE_ADDRESS_SPACE_MEMORY |
>+                         PCI_BASE_ADDRESS_MEM_PREFETCH |
>+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
>+                         &g->hostmem);
>+        virtio_pci_add_shm_cap(vpci_dev, 4, 0, g->conf.hostmem,
>+                               VIRTIO_GPU_SHM_ID_HOST_VISIBLE);
>+    }
>+
>     if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
>         /*
>          * with page-per-vq=off there is no padding space we can use
>diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>index 8377c365ef..de4f624e94 100644
>--- a/include/hw/virtio/virtio-gpu.h
>+++ b/include/hw/virtio/virtio-gpu.h
>@@ -108,12 +108,15 @@ enum virtio_gpu_base_conf_flags {
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
> #define virtio_gpu_context_init_enabled(_cfg) \
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
>+#define virtio_gpu_hostmem_enabled(_cfg) \
>+    (_cfg.hostmem > 0)
> 
> struct virtio_gpu_base_conf {
>     uint32_t max_outputs;
>     uint32_t flags;
>     uint32_t xres;
>     uint32_t yres;
>+    uint64_t hostmem;
> };
> 
> struct virtio_gpu_ctrl_command {
>@@ -137,6 +140,8 @@ struct VirtIOGPUBase {
>     int renderer_blocked;
>     int enable;
> 
>+    MemoryRegion hostmem;
>+
>     struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
> 
>     int enabled_output_bitmask;
>-- 
>2.41.0.694.ge786442a9b-goog
>
>

