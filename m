Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C7F8B4AD4
	for <lists+qemu-devel@lfdr.de>; Sun, 28 Apr 2024 11:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s10UT-0007ga-Js; Sun, 28 Apr 2024 05:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UQ-0007gF-Ov
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:30 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s10UK-0003vO-Lu
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 05:06:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e9320c2ef6so25338115ad.2
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714295183; x=1714899983;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3DGuRf25zpt97dtQO9H18zaqAmnxyBU2T0H4x/77sK4=;
 b=HXl0Iw5IU02gAjws1ZS1xpyitNtMTslP9mG4bJU4yrI8Jpy5rrE2zpx08B4PZs/fTx
 8Wz41rN9WLcsuzt/t4ytUFbEHtM60s7LYUmKcVkHSetdAEZQbOQzazzTpvKBL9D24tXv
 1PD63UGn+e1fv46G2nm2bQeIr4AzVF/vz5ONc3aO6pQtPCT0+4ESA95qR/xaN0JXXHZ8
 Du9ror/9nF7+vhwbvNy705iiCp2qhbryrPX9BFskHfJox/LdsZOMkXan7fs+PaKWyeif
 z1vx0L3u9XvSdFe4MKCbnwwy5+swxJHjfF9ayFIpyK5yLhnU5lZpOsn+QaUWtV+2ks6P
 5Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714295183; x=1714899983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3DGuRf25zpt97dtQO9H18zaqAmnxyBU2T0H4x/77sK4=;
 b=QEroLi7ikD4DvNWO4OnQTHHtF0aWWLLP/ygoXm5/7jrdZ9RuhSRnTDOB1l9wzMhwGR
 MDrKewLs8XLH+ave/uZmSrT0QEynr9/KpSUxvdJr5JcZlFWOATrjMv1WxDBvfq08h71/
 D3B/Lk28uWDhWX9VZhYs4KDoQ8TqOFsnLtGYam1oQebnhFIDHHBjGBJaUVX1yAAwaPY7
 MQEc31jzs1UfOi54kdU5x/9gJxVmm1xHDbpECsLhWkDG0SV2AjzLopTrcfqdXL7OwgyD
 XApdNfHMNBy9kY0tT6rHhYATu4afWedaJUSA+swEOPOtmtlipS9CY494inwbDSlrYWrY
 yFSQ==
X-Gm-Message-State: AOJu0YzE/ZrwDmIsawghqZ8ZRUTumDOiUOsRPmVS1X+xE/mMqtfTeG/b
 oHR6XCtP0b+atXK5BpMciRQh84Hycpnm0MG19m7YyTrIwnf5ZQlGeCdkk077YOI=
X-Google-Smtp-Source: AGHT+IEBUfulE/uaYlrPrSe6nnBW038ufOsKIk8wNYtCJMB72+rnQzgnNPtYwKrFCjzvUfoGi2fccw==
X-Received: by 2002:a17:902:d4c7:b0:1eb:3ef7:1237 with SMTP id
 o7-20020a170902d4c700b001eb3ef71237mr5327634plg.50.1714295183300; 
 Sun, 28 Apr 2024 02:06:23 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 kg8-20020a170903060800b001ea699b79cbsm7648039plb.213.2024.04.28.02.06.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 02:06:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 18:05:45 +0900
Subject: [PATCH RFC v4 5/7] pcie_sriov: Allow user to create SR-IOV device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-sriov-v4-5-ac8ac6212982@daynix.com>
References: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
In-Reply-To: <20240428-sriov-v4-0-ac8ac6212982@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-a718f
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A user can create a SR-IOV device by specifying the PF with the
sriov-pf property of the VFs. The VFs must be added before the PF.

A user-creatable VF must have PCIDeviceClass::sriov_vf_user_creatable
set. Such a VF cannot refer to the PF because it is created before the
PF.

A PF that user-creatable VFs can be attached calls
pcie_sriov_pf_init_from_user_created_vfs() during realization and
pcie_sriov_pf_exit() when exiting.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h |   6 +-
 include/hw/pci/pcie_sriov.h |  19 +++
 hw/pci/pci.c                |  62 ++++++----
 hw/pci/pcie_sriov.c         | 288 +++++++++++++++++++++++++++++++++++---------
 4 files changed, 292 insertions(+), 83 deletions(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 6be0f989ebe0..eefd9d9a7b5a 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -37,6 +37,8 @@ struct PCIDeviceClass {
     uint16_t subsystem_id;              /* only for header type = 0 */
 
     const char *romfile;                /* rom bar */
+
+    bool sriov_vf_user_creatable;
 };
 
 enum PCIReqIDType {
@@ -160,6 +162,8 @@ struct PCIDevice {
     /* ID of standby device in net_failover pair */
     char *failover_pair_id;
     uint32_t acpi_index;
+
+    char *sriov_pf;
 };
 
 static inline int pci_intx(PCIDevice *pci_dev)
@@ -192,7 +196,7 @@ static inline int pci_is_express_downstream_port(const PCIDevice *d)
 
 static inline int pci_is_vf(const PCIDevice *d)
 {
-    return d->exp.sriov_vf.pf != NULL;
+    return d->sriov_pf || d->exp.sriov_vf.pf != NULL;
 }
 
 static inline uint32_t pci_config_size(const PCIDevice *d)
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index d576a8c6be19..20626b5605c9 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -18,6 +18,7 @@
 struct PCIESriovPF {
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
+    bool vf_user_created; /* If VFs are created by user */
 };
 
 struct PCIESriovVF {
@@ -40,6 +41,24 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory);
 
+/**
+ * pcie_sriov_pf_init_from_user_created_vfs() - Initialize PF with user-created
+ *                                              VFs.
+ * @dev: A PCIe device being realized.
+ * @offset: The offset of the SR-IOV capability.
+ * @errp: pointer to Error*, to store an error if it happens.
+ *
+ * Return:
+ * * true - @dev is initialized as a PCIe SR-IOV PF.
+ * * false - @dev is not initialized because there is no SR-IOV VFs or an error
+ *           occurred.
+ */
+bool pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev, uint16_t offset,
+                                              Error **errp);
+
+bool pcie_sriov_register_device(PCIDevice *dev, Error **errp);
+void pcie_sriov_unregister_device(PCIDevice *dev);
+
 /*
  * Default (minimal) page size support values
  * as required by the SR/IOV standard:
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index dbecb3d4aa42..e79bb8b6b6fa 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -85,6 +85,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    DEFINE_PROP_STRING("sriov-pf", PCIDevice, sriov_pf),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -959,13 +960,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
         dev->config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
     }
 
-    /*
-     * With SR/IOV and ARI, a device at function 0 need not be a multifunction
-     * device, as it may just be a VF that ended up with function 0 in
-     * the legacy PCI interpretation. Avoid failing in such cases:
-     */
-    if (pci_is_vf(dev) &&
-        dev->exp.sriov_vf.pf->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+    /* SR/IOV is not handled here. */
+    if (pci_is_vf(dev)) {
         return;
     }
 
@@ -998,7 +994,8 @@ static void pci_init_multifunction(PCIBus *bus, PCIDevice *dev, Error **errp)
     }
     /* function 0 indicates single function, so function > 0 must be NULL */
     for (func = 1; func < PCI_FUNC_MAX; ++func) {
-        if (bus->devices[PCI_DEVFN(slot, func)]) {
+        PCIDevice *device = bus->devices[PCI_DEVFN(slot, func)];
+        if (device && !pci_is_vf(device)) {
             error_setg(errp, "PCI: %x.0 indicates single function, "
                        "but %x.%x is already populated.",
                        slot, slot, func);
@@ -1283,6 +1280,7 @@ static void pci_qdev_unrealize(DeviceState *dev)
 
     pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
+    pcie_sriov_unregister_device(pci_dev);
 
     if (pc->exit) {
         pc->exit(pci_dev);
@@ -1314,7 +1312,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     pcibus_t size = memory_region_size(memory);
     uint8_t hdr_type;
 
-    assert(!pci_is_vf(pci_dev)); /* VFs must use pcie_sriov_vf_register_bar */
     assert(region_num >= 0);
     assert(region_num < PCI_NUM_REGIONS);
     assert(is_power_of_2(size));
@@ -1325,7 +1322,6 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     assert(hdr_type != PCI_HEADER_TYPE_BRIDGE || region_num < 2);
 
     r = &pci_dev->io_regions[region_num];
-    r->addr = PCI_BAR_UNMAPPED;
     r->size = size;
     r->type = type;
     r->memory = memory;
@@ -1333,22 +1329,35 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
                         ? pci_get_bus(pci_dev)->address_space_io
                         : pci_get_bus(pci_dev)->address_space_mem;
 
-    wmask = ~(size - 1);
-    if (region_num == PCI_ROM_SLOT) {
-        /* ROM enable bit is writable */
-        wmask |= PCI_ROM_ADDRESS_ENABLE;
-    }
-
-    addr = pci_bar(pci_dev, region_num);
-    pci_set_long(pci_dev->config + addr, type);
+    if (pci_is_vf(pci_dev)) {
+        PCIDevice *pf = pci_dev->exp.sriov_vf.pf;
+        assert(!pf || type == pf->exp.sriov_pf.vf_bar_type[region_num]);
 
-    if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
-        r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-        pci_set_quad(pci_dev->wmask + addr, wmask);
-        pci_set_quad(pci_dev->cmask + addr, ~0ULL);
+        r->addr = pci_bar_address(pci_dev, region_num, r->type, r->size);
+        if (r->addr != PCI_BAR_UNMAPPED) {
+            memory_region_add_subregion_overlap(r->address_space,
+                                                r->addr, r->memory, 1);
+        }
     } else {
-        pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
-        pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        r->addr = PCI_BAR_UNMAPPED;
+
+        wmask = ~(size - 1);
+        if (region_num == PCI_ROM_SLOT) {
+            /* ROM enable bit is writable */
+            wmask |= PCI_ROM_ADDRESS_ENABLE;
+        }
+
+        addr = pci_bar(pci_dev, region_num);
+        pci_set_long(pci_dev->config + addr, type);
+
+        if (!(r->type & PCI_BASE_ADDRESS_SPACE_IO) &&
+            r->type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+            pci_set_quad(pci_dev->wmask + addr, wmask);
+            pci_set_quad(pci_dev->cmask + addr, ~0ULL);
+        } else {
+            pci_set_long(pci_dev->wmask + addr, wmask & 0xffffffff);
+            pci_set_long(pci_dev->cmask + addr, 0xffffffff);
+        }
     }
 }
 
@@ -2109,6 +2118,11 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
         }
     }
 
+    if (!pcie_sriov_register_device(pci_dev, errp)) {
+        pci_qdev_unrealize(DEVICE(pci_dev));
+        return;
+    }
+
     /*
      * A PCIe Downstream Port that do not have ARI Forwarding enabled must
      * associate only Device 0 with the device attached to the bus
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 3af0cc7d560a..183d6f17d606 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -20,6 +20,8 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+static GHashTable *pfs;
+
 static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
 {
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -31,14 +33,49 @@ static void unparent_vfs(PCIDevice *dev, uint16_t total_vfs)
     dev->exp.sriov_pf.vf = NULL;
 }
 
-bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
-                        const char *vfname, uint16_t vf_dev_id,
-                        uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride,
-                        Error **errp)
+static void clear_ctrl_vfe(PCIDevice *dev)
+{
+    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
+    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
+}
+
+static void register_vfs(PCIDevice *dev)
+{
+    uint16_t num_vfs;
+    uint16_t i;
+    uint16_t sriov_cap = dev->exp.sriov_cap;
+
+    assert(sriov_cap > 0);
+    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
+        clear_ctrl_vfe(dev);
+        return;
+    }
+
+    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
+                             PCI_FUNC(dev->devfn), num_vfs);
+    for (i = 0; i < num_vfs; i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
+    }
+}
+
+static void unregister_vfs(PCIDevice *dev)
+{
+    uint16_t i;
+    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
+                               PCI_FUNC(dev->devfn));
+    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
+        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+    }
+}
+
+static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
+                                      uint16_t vf_dev_id, uint16_t init_vfs,
+                                      uint16_t total_vfs, uint16_t vf_offset,
+                                      uint16_t vf_stride, Error **errp)
 {
-    BusState *bus = qdev_get_parent_bus(&dev->qdev);
-    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
@@ -100,6 +137,28 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
 
+    return true;
+}
+
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+                        const char *vfname, uint16_t vf_dev_id,
+                        uint16_t init_vfs, uint16_t total_vfs,
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
+{
+    BusState *bus = qdev_get_parent_bus(&dev->qdev);
+    int32_t devfn = dev->devfn + vf_offset;
+
+    if (pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
+
+    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, init_vfs,
+                                   total_vfs, vf_offset, vf_stride, errp)) {
+        return false;
+    }
+
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, total_vfs);
 
     for (uint16_t i = 0; i < total_vfs; i++) {
@@ -129,7 +188,22 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
 {
     uint8_t *cfg = dev->config + dev->exp.sriov_cap;
 
-    unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
+    if (dev->exp.sriov_pf.vf_user_created) {
+        uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+        uint16_t total_vfs = pci_get_word(dev->config + PCI_SRIOV_TOTAL_VF);
+        uint16_t vf_dev_id = pci_get_word(dev->config + PCI_SRIOV_VF_DID);
+
+        unregister_vfs(dev);
+
+        for (uint16_t i = 0; i < total_vfs; i++) {
+            dev->exp.sriov_pf.vf[i]->exp.sriov_vf.pf = NULL;
+
+            pci_config_set_vendor_id(dev->exp.sriov_pf.vf[i]->config, ven_id);
+            pci_config_set_device_id(dev->exp.sriov_pf.vf[i]->config, vf_dev_id);
+        }
+    } else {
+        unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
+    }
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -162,74 +236,172 @@ void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
 void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
                                 MemoryRegion *memory)
 {
-    PCIIORegion *r;
-    PCIBus *bus = pci_get_bus(dev);
     uint8_t type;
-    pcibus_t size = memory_region_size(memory);
 
-    assert(pci_is_vf(dev)); /* PFs must use pci_register_bar */
-    assert(region_num >= 0);
-    assert(region_num < PCI_NUM_REGIONS);
+    assert(dev->exp.sriov_vf.pf);
     type = dev->exp.sriov_vf.pf->exp.sriov_pf.vf_bar_type[region_num];
 
-    if (!is_power_of_2(size)) {
-        error_report("%s: PCI region size must be a power"
-                     " of two - type=0x%x, size=0x%"FMT_PCIBUS,
-                     __func__, type, size);
-        exit(1);
-    }
-
-    r = &dev->io_regions[region_num];
-    r->memory = memory;
-    r->address_space =
-        type & PCI_BASE_ADDRESS_SPACE_IO
-        ? bus->address_space_io
-        : bus->address_space_mem;
-    r->size = size;
-    r->type = type;
-
-    r->addr = pci_bar_address(dev, region_num, r->type, r->size);
-    if (r->addr != PCI_BAR_UNMAPPED) {
-        memory_region_add_subregion_overlap(r->address_space,
-                                            r->addr, r->memory, 1);
-    }
+    return pci_register_bar(dev, region_num, type, memory);
 }
 
-static void clear_ctrl_vfe(PCIDevice *dev)
+static gint compare_vf_devfns(gconstpointer a, gconstpointer b)
 {
-    uint8_t *ctrl = dev->config + dev->exp.sriov_cap + PCI_SRIOV_CTRL;
-    pci_set_word(ctrl, pci_get_word(ctrl) & ~PCI_SRIOV_CTRL_VFE);
+    return (*(PCIDevice **)a)->devfn - (*(PCIDevice **)b)->devfn;
 }
 
-static void register_vfs(PCIDevice *dev)
+bool pcie_sriov_pf_init_from_user_created_vfs(PCIDevice *dev, uint16_t offset,
+                                              Error **errp)
 {
-    uint16_t num_vfs;
+    GPtrArray *pf;
+    PCIDevice **vfs;
+    BusState *bus = qdev_get_parent_bus(DEVICE(dev));
+    uint16_t ven_id = pci_get_word(dev->config + PCI_VENDOR_ID);
+    uint16_t vf_dev_id;
+    uint16_t vf_offset;
+    uint16_t vf_stride;
     uint16_t i;
-    uint16_t sriov_cap = dev->exp.sriov_cap;
 
-    assert(sriov_cap > 0);
-    num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
-    if (num_vfs > pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF)) {
-        clear_ctrl_vfe(dev);
-        return;
+    if (!pfs || !dev->qdev.id) {
+        return false;
     }
 
-    trace_sriov_register_vfs(dev->name, PCI_SLOT(dev->devfn),
-                             PCI_FUNC(dev->devfn), num_vfs);
-    for (i = 0; i < num_vfs; i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], true);
+    pf = g_hash_table_lookup(pfs, dev->qdev.id);
+    if (!pf) {
+        return false;
+    }
+
+    if (pf->len > UINT16_MAX) {
+        error_setg(errp, "too many VFs");
+        return false;
+    }
+
+    g_ptr_array_sort(pf, compare_vf_devfns);
+    vfs = (void *)pf->pdata;
+
+    if (vfs[0]->devfn <= dev->devfn) {
+        error_setg(errp, "a VF function number is less than the PF function number");
+        return false;
     }
+
+    vf_dev_id = pci_get_word(vfs[0]->config + PCI_DEVICE_ID);
+    vf_offset = vfs[0]->devfn - dev->devfn;
+    vf_stride = pf->len < 2 ? 0 : vfs[1]->devfn - vfs[0]->devfn;
+
+    for (i = 0; i < pf->len; i++) {
+        if (bus != qdev_get_parent_bus(&vfs[i]->qdev)) {
+            error_setg(errp, "SR-IOV VF parent bus mismatches with PF");
+            return false;
+        }
+
+        if (ven_id != pci_get_word(vfs[i]->config + PCI_VENDOR_ID)) {
+            error_setg(errp, "SR-IOV VF vendor ID mismatches with PF");
+            return false;
+        }
+
+        if (vf_dev_id != pci_get_word(vfs[i]->config + PCI_DEVICE_ID)) {
+            error_setg(errp, "inconsistent SR-IOV VF device IDs");
+            return false;
+        }
+
+        for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
+            if (vfs[i]->io_regions[j].size != vfs[0]->io_regions[j].size ||
+                vfs[i]->io_regions[j].type != vfs[0]->io_regions[j].type) {
+                error_setg(errp, "inconsistent SR-IOV BARs");
+                return false;
+            }
+        }
+
+        if (vfs[i]->devfn - vfs[0]->devfn != vf_stride * i) {
+            error_setg(errp, "inconsistent SR-IOV stride");
+            return false;
+        }
+    }
+
+    if (!pcie_sriov_pf_init_common(dev, offset, vf_dev_id, pf->len,
+                                   pf->len, vf_offset, vf_stride, errp)) {
+        return false;
+    }
+
+    for (i = 0; i < pf->len; i++) {
+        vfs[i]->exp.sriov_vf.pf = dev;
+        vfs[i]->exp.sriov_vf.vf_number = i;
+
+        /* set vid/did according to sr/iov spec - they are not used */
+        pci_config_set_vendor_id(vfs[i]->config, 0xffff);
+        pci_config_set_device_id(vfs[i]->config, 0xffff);
+    }
+
+    dev->exp.sriov_pf.vf = vfs;
+    dev->exp.sriov_pf.vf_user_created = true;
+
+    for (i = 0; i < PCI_NUM_REGIONS; i++) {
+        uint8_t type = vfs[0]->io_regions[i].type;
+        pcibus_t size = vfs[0]->io_regions[i].size;
+
+        if (size) {
+            pcie_sriov_pf_init_vf_bar(dev, i, type, size);
+        }
+    }
+
+    return true;
 }
 
-static void unregister_vfs(PCIDevice *dev)
+bool pcie_sriov_register_device(PCIDevice *dev, Error **errp)
 {
-    uint16_t i;
-    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+    if (!dev->exp.sriov_pf.vf && dev->qdev.id &&
+        pfs && g_hash_table_contains(pfs, dev->qdev.id)) {
+        error_setg(errp, "attaching user-created SR-IOV VF unsupported");
+        return false;
+    }
 
-    trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
-                               PCI_FUNC(dev->devfn));
-    for (i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
-        pci_set_enabled(dev->exp.sriov_pf.vf[i], false);
+    if (dev->sriov_pf) {
+        PCIDevice *pci_pf;
+        GPtrArray *pf;
+
+        if (!PCI_DEVICE_GET_CLASS(dev)->sriov_vf_user_creatable) {
+            error_setg(errp, "user cannot create SR-IOV VF with this device type");
+            return false;
+        }
+
+        if (!pci_is_express(dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV VF");
+            return false;
+        }
+
+        if (!pci_qdev_find_device(dev->sriov_pf, &pci_pf)) {
+            error_setg(errp, "PCI device specified as SR-IOV PF already exists");
+            return false;
+        }
+
+        if (!pfs) {
+            pfs = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
+        }
+
+        pf = g_hash_table_lookup(pfs, dev->sriov_pf);
+        if (!pf) {
+            pf = g_ptr_array_new();
+            g_hash_table_insert(pfs, g_strdup(dev->sriov_pf), pf);
+        }
+
+        g_ptr_array_add(pf, dev);
+    }
+
+    return true;
+}
+
+void pcie_sriov_unregister_device(PCIDevice *dev)
+{
+    if (dev->sriov_pf && pfs) {
+        GPtrArray *pf = g_hash_table_lookup(pfs, dev->qdev.id);
+
+        if (pf) {
+            g_ptr_array_remove_fast(pf, dev);
+
+            if (!pf->len) {
+                g_hash_table_remove(pfs, dev->qdev.id);
+                g_ptr_array_free(pf, FALSE);
+            }
+        }
     }
 }
 
@@ -316,7 +488,7 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize)
 
 uint16_t pcie_sriov_vf_number(PCIDevice *dev)
 {
-    assert(pci_is_vf(dev));
+    assert(dev->exp.sriov_vf.pf);
     return dev->exp.sriov_vf.vf_number;
 }
 

-- 
2.44.0


