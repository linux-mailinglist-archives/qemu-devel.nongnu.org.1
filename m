Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8A980B8CB
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Dec 2023 05:08:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCB5a-0005U7-0t; Sat, 09 Dec 2023 23:06:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5X-0005TO-2c
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:43 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCB5U-0005Cb-CO
 for qemu-devel@nongnu.org; Sat, 09 Dec 2023 23:06:42 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-28647f4ebd9so2729994a91.3
 for <qemu-devel@nongnu.org>; Sat, 09 Dec 2023 20:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702181199; x=1702785999;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EkdQc7ICCCkKoV3N+vmlIAK0bTEsGFxUW/BgFnwJvwk=;
 b=pgAFAQUsIqz+qv8KTMysDLkaHh8Lsvg6bx5K/dDVgFcoHg0TjpqyKBALIwZR5vFoSg
 GZhrJN8n/t59oN6Gb/eq7c5LB0W5Un1jyD1QYbVOUtw0VsDVDDgna+f9S1QXprtJNGzx
 iPiJQuUxitdtO7rCMIMuDYX2lqlMmgoVK9B8LxqsfaDiuJSA0yZNyfWxn6AlmbN4aBeL
 goJs21iA4h7dt6envBo4Ply7QbA7jYYnUKX3Ec2rD1mpbrt/KP6QZLqc2erTTabO8fD/
 YuasLKHGqQ7t9PZ45BpkcF44FfuqvY+gzWVd+xg5qEWVmnsZ6cKVR8+h8QO1mvzIn2pf
 FS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702181199; x=1702785999;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkdQc7ICCCkKoV3N+vmlIAK0bTEsGFxUW/BgFnwJvwk=;
 b=Fs0KxnDANGAcme2fvUukmEBV1d5OlZeUw9FRn+9mfdR4uAOJJ8+Q0rdolXCvs9O0+8
 cOrWHgkDzPWjIAmBacsxZjkl2RoguccApb/xshewu4n1QDPF4sKCBvx4Ci9fDPZvqXYX
 gRDDzk/L2B8U5pufhrHtzYlFoiKlLAM+cc9IgK2k2iQ52smRmzxcfPDVu4warkioE61Y
 1wt+lKBmvsaK8oj2JvT10wLmINZ1h+tfoyijBh2HpglBxkHMGCqbeahTNZ+X5rZESIKq
 N2z4N+jLNEBg+5ADRF8PvVxiHsigm9BasLbMR0qnBUzeeL0EVkr76T7x8JmnzQlMVcSs
 CyWg==
X-Gm-Message-State: AOJu0YzCsP2o67UhqrqL7KSAfkVaXmTKGkExiRqdibH6P9UlCzWXkf73
 H3xYetnTbvb5k7qxHNNZ3Txhkw==
X-Google-Smtp-Source: AGHT+IFznLeGjhm/DBsAkqKfXgKbWQCtwtIKb/oGDrjiXuiz23+N5V92vtO1un0AjEp3CSXJRWGc9A==
X-Received: by 2002:a17:902:c20d:b0:1d0:3eac:e66 with SMTP id
 13-20020a170902c20d00b001d03eac0e66mr1131924pll.29.1702181199130; 
 Sat, 09 Dec 2023 20:06:39 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 d4-20020a170902b70400b001cfb971edfasm4113396pls.205.2023.12.09.20.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Dec 2023 20:06:38 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 10 Dec 2023 13:05:49 +0900
Subject: [PATCH RFC v2 06/12] pcie_sriov: Reuse SR-IOV VF device instances
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231210-sriov-v2-6-b959e8a6dfaf@daynix.com>
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::1029;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Disable SR-IOV VF devices by reusing code to power down PCI devices
instead of removing them when the guest requests to disable VFs. This
allows to realize devices and report VF realization errors at PF
realization time.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt         |   8 ++--
 include/hw/pci/pci.h        |   2 +-
 include/hw/pci/pci_device.h |   2 +-
 include/hw/pci/pcie_sriov.h |   6 +--
 hw/net/igb.c                |   3 +-
 hw/nvme/ctrl.c              |   3 +-
 hw/pci/pci.c                |  18 ++++----
 hw/pci/pci_host.c           |   4 +-
 hw/pci/pcie.c               |   4 +-
 hw/pci/pcie_sriov.c         | 105 +++++++++++++++++++++-----------------------
 10 files changed, 79 insertions(+), 76 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index a47aad0bfa..ab2142807f 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -52,9 +52,11 @@ setting up a BAR for a VF.
       ...
 
       /* Add and initialize the SR/IOV capability */
-      pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
-                       vf_devid, initial_vfs, total_vfs,
-                       fun_offset, stride);
+      if (!pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
+                              vf_devid, initial_vfs, total_vfs,
+                              fun_offset, stride, errp)) {
+         return;
+      }
 
       /* Set up individual VF BARs (parameters as for normal BARs) */
       pcie_sriov_pf_init_vf_bar( ... )
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index fa6313aabc..fae83b9b72 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -643,6 +643,6 @@ static inline void pci_irq_pulse(PCIDevice *pci_dev)
 }
 
 MSIMessage pci_get_msi_message(PCIDevice *dev, int vector);
-void pci_set_power(PCIDevice *pci_dev, bool state);
+void pci_set_enabled(PCIDevice *pci_dev, bool state);
 
 #endif
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 54fa0676ab..f5aba8ae26 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -56,7 +56,7 @@ typedef struct PCIReqIDCache PCIReqIDCache;
 struct PCIDevice {
     DeviceState qdev;
     bool partially_hotplugged;
-    bool has_power;
+    bool is_enabled;
 
     /* PCI config space */
     uint8_t *config;
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 095fb0c9ed..d9a39dacca 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,7 +18,6 @@
 struct PCIESriovPF {
     uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
-    const char *vfname; /* Reference to the device type used for the VFs */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 };
 
@@ -27,10 +26,11 @@ struct PCIESriovVF {
     uint16_t vf_number; /* Logical VF number of this function */
 };
 
-void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride);
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp);
 void pcie_sriov_pf_exit(PCIDevice *dev);
 
 /* Set up a VF bar in the SR/IOV bar area */
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 8089acfea4..326e334a8d 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -449,7 +449,8 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
-        IGB_VF_OFFSET, IGB_VF_STRIDE);
+        IGB_VF_OFFSET, IGB_VF_STRIDE,
+        &error_abort);
 
     pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..ea006e6175 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8042,7 +8042,8 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
 
     pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
                        n->params.sriov_max_vfs, n->params.sriov_max_vfs,
-                       NVME_VF_OFFSET, NVME_VF_STRIDE);
+                       NVME_VF_OFFSET, NVME_VF_STRIDE,
+                       &error_abort);
 
     pcie_sriov_pf_init_vf_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                               PCI_BASE_ADDRESS_MEM_TYPE_64, bar_size);
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 5a93cc1681..eb351844ee 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1516,7 +1516,7 @@ static void pci_update_mappings(PCIDevice *d)
             continue;
 
         new_addr = pci_bar_address(d, i, r->type, r->size);
-        if (!d->has_power) {
+        if (!d->is_enabled) {
             new_addr = PCI_BAR_UNMAPPED;
         }
 
@@ -1604,7 +1604,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val_in, int
         pci_update_irq_disabled(d, was_irq_disabled);
         memory_region_set_enabled(&d->bus_master_enable_region,
                                   (pci_get_word(d->config + PCI_COMMAND)
-                                   & PCI_COMMAND_MASTER) && d->has_power);
+                                   & PCI_COMMAND_MASTER) && d->is_enabled);
     }
 
     msi_write_config(d, addr, val_in, l);
@@ -2180,7 +2180,9 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         return;
     }
 
-    pci_set_power(pci_dev, true);
+    if (!pci_is_vf(pci_dev)) {
+        pci_set_enabled(pci_dev, true);
+    }
 
     pci_dev->msi_trigger = pci_msi_trigger;
 }
@@ -2844,18 +2846,18 @@ MSIMessage pci_get_msi_message(PCIDevice *dev, int vector)
     return msg;
 }
 
-void pci_set_power(PCIDevice *d, bool state)
+void pci_set_enabled(PCIDevice *d, bool state)
 {
-    if (d->has_power == state) {
+    if (d->is_enabled == state) {
         return;
     }
 
-    d->has_power = state;
+    d->is_enabled = state;
     pci_update_mappings(d);
     memory_region_set_enabled(&d->bus_master_enable_region,
                               (pci_get_word(d->config + PCI_COMMAND)
-                               & PCI_COMMAND_MASTER) && d->has_power);
-    if (!d->has_power) {
+                               & PCI_COMMAND_MASTER) && d->is_enabled);
+    if (!d->is_enabled) {
         pci_device_reset(d);
     }
 }
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index a18aa0a8d4..1f3030108c 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -86,7 +86,7 @@ void pci_host_config_write_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->is_enabled || is_pci_dev_ejected(pci_dev)) {
         return;
     }
 
@@ -111,7 +111,7 @@ uint32_t pci_host_config_read_common(PCIDevice *pci_dev, uint32_t addr,
      * allowing direct removal of unexposed functions.
      */
     if ((pci_dev->qdev.hotplugged && !pci_get_function_0(pci_dev)) ||
-        !pci_dev->has_power || is_pci_dev_ejected(pci_dev)) {
+        !pci_dev->is_enabled || is_pci_dev_ejected(pci_dev)) {
         return ~0x0;
     }
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6db0cf69cd..f34c157e1f 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -394,7 +394,9 @@ static void pcie_set_power_device(PCIBus *bus, PCIDevice *dev, void *opaque)
 {
     bool *power = opaque;
 
-    pci_set_power(dev, *power);
+    if (!pci_is_vf(dev)) {
+        pci_set_enabled(dev, *power);
+    }
 }
 
 static void pcie_cap_update_power(PCIDevice *hotplug_dev)
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 5ef8950940..5fc146efc4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -20,15 +20,29 @@
 #include "qapi/error.h"
 #include "trace.h"
 
-static PCIDevice *register_vf(PCIDevice *pf, int devfn,
-                              const char *name, uint16_t vf_num);
-static void unregister_vfs(PCIDevice *dev);
+static void unrealize_vfs(PCIDevice *dev, uint16_t total_vfs)
+{
+    for (uint16_t i = 0; i < total_vfs; i++) {
+        Error *err = NULL;
+        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
+        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
+            error_reportf_err(err, "Failed to unplug: ");
+        }
+        object_unparent(OBJECT(vf));
+        object_unref(OBJECT(vf));
+    }
+    g_free(dev->exp.sriov_pf.vf);
+    dev->exp.sriov_pf.vf = NULL;
+}
 
-void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride)
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
 {
+    BusState *bus = qdev_get_parent_bus(&dev->qdev);
+    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
@@ -36,7 +50,6 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
     dev->exp.sriov_pf.num_vfs = 0;
-    dev->exp.sriov_pf.vfname = g_strdup(vfname);
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -69,13 +82,36 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pci_set_word(wmask + PCI_SRIOV_SYS_PGSIZE, 0x553);
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
+
+    dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
+    assert(dev->exp.sriov_pf.vf);
+
+    for (uint16_t i = 0; i < total_vfs; i++) {
+        PCIDevice *vf = pci_new(devfn, vfname);
+        vf->exp.sriov_vf.pf = dev;
+        vf->exp.sriov_vf.vf_number = i;
+
+        if (!qdev_realize(&vf->qdev, bus, errp)) {
+            unrealize_vfs(dev, i);
+            return false;
+        }
+
+        /* set vid/did according to sr/iov spec - they are not used */
+        pci_config_set_vendor_id(vf->config, 0xffff);
+        pci_config_set_device_id(vf->config, 0xffff);
+
+        dev->exp.sriov_pf.vf[i] = vf;
+        devfn += vf_stride;
+    }
+
+    return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
-    unregister_vfs(dev);
-    g_free((char *)dev->exp.sriov_pf.vfname);
-    dev->exp.sriov_pf.vfname = NULL;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    unrealize_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -141,55 +177,22 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
     }
 }
 
-static PCIDevice *register_vf(PCIDevice *pf, int devfn, const char *name,
-                              uint16_t vf_num)
-{
-    PCIDevice *dev = pci_new(devfn, name);
-    dev->exp.sriov_vf.pf = pf;
-    dev->exp.sriov_vf.vf_number = vf_num;
-    PCIBus *bus = pci_get_bus(pf);
-    Error *local_err = NULL;
-
-    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return NULL;
-    }
-
-    /* set vid/did according to sr/iov spec - they are not used */
-    pci_config_set_vendor_id(dev->config, 0xffff);
-    pci_config_set_device_id(dev->config, 0xffff);
-
-    return dev;
-}
-
 static void register_vfs(PCIDevice *dev)
 {
     uint16_t num_vfs;
     uint16_t i;
     uint16_t sriov_cap = dev->exp.sriov_cap;
-    uint16_t vf_offset =
-        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
-    uint16_t vf_stride =
-        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_STRIDE);
-    int32_t devfn = dev->devfn + vf_offset;
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-
-    dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
-    assert(dev->exp.sriov_pf.vf);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        return;
+    }
 
     trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
                              PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        dev->exp.sriov_pf.vf[i] = register_vf(dev, devfn,
-                                              dev->exp.sriov_pf.vfname, i);
-        if (!dev->exp.sriov_pf.vf[i]) {
-            num_vfs = i;
-            break;
-        }
-        devfn += vf_stride;
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
     }
     dev->exp.sriov_pf.num_vfs = num_vfs;
 }
@@ -202,16 +205,8 @@ static void unregister_vfs(PCIDevice *dev)
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
-        Error *err = NULL;
-        PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
-            error_reportf_err(err, "Failed to unplug: ");
-        }
-        object_unparent(OBJECT(vf));
-        object_unref(OBJECT(vf));
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
     }
-    g_free(dev->exp.sriov_pf.vf);
-    dev->exp.sriov_pf.vf = NULL;
     dev->exp.sriov_pf.num_vfs = 0;
     pci_set_word(dev->config + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0);
 }

-- 
2.43.0


