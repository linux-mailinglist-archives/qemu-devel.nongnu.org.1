Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A3E75976F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 15:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7ca-0008Aw-4R; Wed, 19 Jul 2023 09:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qLwTo-0005C3-6E
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:59:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yui.washidu@gmail.com>)
 id 1qLwTj-000336-28
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 21:59:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b8a8154f9cso2188415ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 18:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689731985; x=1692323985;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=llJTCFcv5Rg3RCCCSr2yOInbysqkB7vzggXaRhdtqe0=;
 b=f1mNcM1fGfi8EQ43DeTuqwBMFbRdR2U7ben7JrC2x5+ZC5J7bjX7bSV0Y7PQx0nyik
 NqQD269HRb14IISEiEKnvQ3mt5T2Pn7+/vBZ+YKRxfrXH4Mp9/sadzh4X/QhV4nmkt1o
 kQFuZsDeE1uEqsMwk9+Up4zmKnJeEBl4OGHUwrtmzps86yRPrl6CNfFe6CI59iOKB0QL
 GVLb9YasthTmOf2wS3l7ojy9kkPdGmonoptU4bFjXKKXJwiGfgffdKlXtWP6Bd3fxn81
 VyMP3kZhcOtFVJeOiegqjWyJuSHQ2+DExASk37cRenHlGvLCKos1dWRdU4j9FRnAReZk
 gOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689731985; x=1692323985;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llJTCFcv5Rg3RCCCSr2yOInbysqkB7vzggXaRhdtqe0=;
 b=jBBWgM/6hnAJkArvsZaiPDe1Rz7adsyd0pxlLaYV0WWZrshdJDTPizIKy77qQZK/4h
 jlApnObDislLgpm/KGvqWzXcfhyMcqQV/eVIZyy6SQE3u5QRai2yiDaX+fYsZIftS7qW
 I+UwM2GHXhjEBjC9UguUiS2R6HTL1DGJY/7nraB/G50fTenVJmit9rFzMBpuAXg8D5g3
 dw6HljPwHegHMoN7UHo+qz0JgOHA2NLWv/aVST6E06/kjyugq/NAWIDH0/nk+vVr0oVT
 I5G+KZWt1GwMB4ULyLavwY0csUGanbPw/IZekFhQqZFFA/0IkNPSRxPEmwM/vHklScJw
 c1Dg==
X-Gm-Message-State: ABy/qLarZitcoWcMN0e28AXWL9iUq1/T3Mx6qH9P/1CTq2xFyVLO3MrQ
 f1BqzFwaMxNPcYyNR2c8FtmvldmRDAQ=
X-Google-Smtp-Source: APBJJlFcpfhF2TCUrTru4TGrR0wRwLRikuWLNg87mmw/RIvAE4Xc8E3NtgMgPnwYJls0+0yelOaLRQ==
X-Received: by 2002:a17:902:d505:b0:1b8:c63:4b79 with SMTP id
 b5-20020a170902d50500b001b80c634b79mr955956plg.19.1689731985476; 
 Tue, 18 Jul 2023 18:59:45 -0700 (PDT)
Received: from redsen-desktop625.kern.oss.ntt.co.jp ([222.151.198.97])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a1709026acc00b001bb54abfc07sm19722plt.252.2023.07.18.18.59.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Jul 2023 18:59:45 -0700 (PDT)
From: Yui Washizu <yui.washidu@gmail.com>
To: qemu-devel@nongnu.org
Cc: Yui Washizu <yui.washidu@gmail.com>, jasowang@redhat.com, mst@redhat.com,
 akihiko.odaki@daynix.com, yvugenfi@redhat.com, ybendito@redhat.com,
 mapfelba@redhat.com, marcel@redhat.com, ghammer@redhat.com,
 mdean@redhat.com
Subject: [RFC 1/1] virtio-pci: add SR-IOV capability
Date: Wed, 19 Jul 2023 10:56:48 +0900
Message-Id: <1689731808-3009-2-git-send-email-yui.washidu@gmail.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
References: <1689731808-3009-1-git-send-email-yui.washidu@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yui.washidu@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Jul 2023 09:53:28 -0400
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

This enables SR-IOV emulation on virtio-pci devices by adding SR-IOV capability
It also introduces a newly added property 'sriov_max_vfs'
to enable or disable the SR-IOV feature on the virtio-pci device in guest,
as well as to specify the maximum number of VFs that can be created in the guest.
Currently only virtio-net is supported.
Also, the vendor ID and device ID remain the same for both the PF and VF,
enabling existing guest PF drivers to be used in the VF without any modifications.

Signed-off-by: Yui Washizu <yui.washidu@gmail.com>
---
 hw/pci/msix.c                  |  8 +++--
 hw/pci/pci.c                   |  4 +++
 hw/virtio/virtio-pci.c         | 62 ++++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-pci.h |  1 +
 4 files changed, 66 insertions(+), 9 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index ab8869d9d0..3b94ce389f 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -421,8 +421,12 @@ int msix_init_exclusive_bar(PCIDevice *dev, unsigned short nentries,
         return ret;
     }
 
-    pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
-                     &dev->msix_exclusive_bar);
+    if (pci_is_vf(dev)) {
+        pcie_sriov_vf_register_bar(dev, bar_nr, &dev->msix_exclusive_bar);
+    } else {
+        pci_register_bar(dev, bar_nr, PCI_BASE_ADDRESS_SPACE_MEMORY,
+                         &dev->msix_exclusive_bar);
+    }
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..cbd50b38ea 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2325,6 +2325,10 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
+    if (pci_is_vf(pdev)) {
+        return;
+    }
+
     if (!pdev->rom_bar) {
         /*
          * Load rom via fw_cfg instead of creating a rom bar,
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index edbc0daa18..2315c2647a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -49,6 +49,8 @@
  * configuration space */
 #define VIRTIO_PCI_CONFIG_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_enabled(dev))
 
+#define VIRTIO_MAX_VFS 127
+
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtIOPCIProxy *dev);
 static void virtio_pci_reset(DeviceState *qdev);
@@ -1907,6 +1909,11 @@ static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
 
     if (virtio_pci_modern(proxy)) {
         virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
+        if (proxy->sriov_max_vfs) {
+            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+        }
+    } else if (proxy->sriov_max_vfs) {
+        error_setg(errp, "VirtIO PCI modern is required for the use of SR-IOV");
     }
 
     virtio_add_feature(&vdev->host_features, VIRTIO_F_BAD_FEATURE);
@@ -2015,22 +2022,62 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
         virtio_pci_modern_mem_region_map(proxy, &proxy->device, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->notify, &notify.cap);
 
+        if (!pci_is_vf(&proxy->pci_dev) && proxy->sriov_max_vfs) {
+            if (virtio_bus_get_vdev_id(bus) != VIRTIO_ID_NET) {
+                error_setg(errp, "sriov_max_vfs prop is not supported by %s",
+                           proxy->pci_dev.name);
+                return;
+            }
+            if (proxy->sriov_max_vfs > VIRTIO_MAX_VFS) {
+                error_setg(errp, "sriov_max_vfs must be between 0 and %d",
+                           VIRTIO_MAX_VFS);
+                return;
+            }
+
+            pcie_sriov_pf_init(&proxy->pci_dev, PCI_CONFIG_SPACE_SIZE,
+                               proxy->pci_dev.name,
+                               PCI_DEVICE_ID_VIRTIO_10_BASE
+                               + virtio_bus_get_vdev_id(bus),
+                               proxy->sriov_max_vfs, proxy->sriov_max_vfs, 1, 1);
+            if (proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY) {
+                pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
+                                          PCI_BASE_ADDRESS_SPACE_IO, 4);
+            }
+            if (proxy->nvectors) {
+                pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->msix_bar_idx,
+                                          PCI_BASE_ADDRESS_SPACE_MEMORY, 4 * 1024);
+            }
+            pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
+                                      PCI_BASE_ADDRESS_SPACE_MEMORY |
+                                      PCI_BASE_ADDRESS_MEM_PREFETCH |
+                                      PCI_BASE_ADDRESS_MEM_TYPE_64,
+                                      16 * 1024);
+        }
+
         if (modern_pio) {
             memory_region_init(&proxy->io_bar, OBJECT(proxy),
                                "virtio-pci-io", 0x4);
 
-            pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
-                             PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
+            if (pci_is_vf(&proxy->pci_dev))
+                pcie_sriov_vf_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
+                                           &proxy->io_bar);
+            else
+                pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
+                                 PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
 
             virtio_pci_modern_io_region_map(proxy, &proxy->notify_pio,
                                             &notify_pio.cap);
         }
 
-        pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
-                         PCI_BASE_ADDRESS_SPACE_MEMORY |
-                         PCI_BASE_ADDRESS_MEM_PREFETCH |
-                         PCI_BASE_ADDRESS_MEM_TYPE_64,
-                         &proxy->modern_bar);
+        if (pci_is_vf(&proxy->pci_dev))
+            pcie_sriov_vf_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
+                                       &proxy->modern_bar);
+        else
+            pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
+                             PCI_BASE_ADDRESS_SPACE_MEMORY |
+                             PCI_BASE_ADDRESS_MEM_PREFETCH |
+                             PCI_BASE_ADDRESS_MEM_TYPE_64,
+                             &proxy->modern_bar);
 
         proxy->config_cap = virtio_pci_add_mem_cap(proxy, &cfg.cap);
         cfg_mask = (void *)(proxy->pci_dev.wmask + proxy->config_cap);
@@ -2298,6 +2345,7 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_FLR_BIT, true),
     DEFINE_PROP_BIT("aer", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_AER_BIT, false),
+    DEFINE_PROP_UINT16("sriov_max_vfs", VirtIOPCIProxy, sriov_max_vfs, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index ab2051b64b..05ab6ddc3f 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -150,6 +150,7 @@ struct VirtIOPCIProxy {
     uint32_t flags;
     bool disable_modern;
     bool ignore_backend_features;
+    uint16_t sriov_max_vfs;
     OnOffAuto disable_legacy;
     /* Transitional device id */
     uint16_t trans_devid;
-- 
2.39.3


