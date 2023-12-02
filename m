Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AB5801B52
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:03:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9Kwd-0004jL-I6; Sat, 02 Dec 2023 03:01:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwX-0004dN-GD
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:41 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwS-00059x-CG
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:39 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b83ed78a91so1177676b6e.1
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504095; x=1702108895;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JguH82PUwVfOszRffb4OflLmTzbPcjtVzvpIUdtjwWc=;
 b=eVmDDLGARMrHn/1ldZHBAHgScEgto6l0r52QLp28k6mhzVbZTwbI74Mph4tNM9mCXq
 /l+WaKTPQ+U4E3bTc2raSWY/fPk+qLpcfzkyFOriQpa30eSVzraGWrvthOPZUcDog0uP
 YoJ/qRorIIh8aPuDvW1ML0IpzSYF0/kwpw1+3SwsBhyk38P2Okk0UUS2cNhaSaJF7kOX
 ew4YjIjbJeg5h8nAkWYN3dDOWZ1CLUAeSdLcXwzacAEHgHE3DhPuTdPF7KoOzkr7hW5y
 1z4ZnpJ+JBdaLgJghQdna4F6R1I35HSqnhP06XhYw3GDh7OfXbZlkR2Ru2qltWbQmnkV
 j1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504095; x=1702108895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JguH82PUwVfOszRffb4OflLmTzbPcjtVzvpIUdtjwWc=;
 b=pAuwByI9MCexeplqgiRDJk6zhVwTzeIUwEPlqycL1qVGLQpuQe2dJQK9wq5ghJOM4y
 uCZSGsu/ekFtlNgw6pt5i3oH8zR0rZJBhKbcbTfztN0GHdIgSyHd5Zvf//dqlzy20B2h
 rEgiT4pQDn9GxwEAsfAG0eGA5Ex6WFCMaWTUA/tBCOCjEt5Nz1DNbJn+kGkhrh+7ylQd
 pubQewoVtfiHlMsfef83hMMWFyfANsx9fg+dcKOapWfJkQVwMmslVRFb/uaRXjQMYKeS
 dyxZ7+UPf7TaXkx/a1mxjevWJJBdIcOmaTlYzApUIczxtcR7oZD5691AQbqnS09mNcvV
 enJA==
X-Gm-Message-State: AOJu0Yxy7xJA+Djq6Evmd4kHVVS+2BQvNLklHYm9J1R9PXAe9qhRPnYA
 N9I4TQvzii6VVBwLAe33FJCw1w==
X-Google-Smtp-Source: AGHT+IER8dKbWh85bPXvAiPMWgYhKUFZ5XJbzQsCXrPHejUi4BL9e1YK97ssYTvVF7way7J6tcJ1dA==
X-Received: by 2002:a05:6808:30a7:b0:3b8:6057:b087 with SMTP id
 bl39-20020a05680830a700b003b86057b087mr1508948oib.9.1701504095289; 
 Sat, 02 Dec 2023 00:01:35 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 d16-20020a170902ced000b001d076ebf328sm508543plg.8.2023.12.02.00.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:35 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:36 +0900
Subject: [PATCH 13/14] virtio-pci: add SR-IOV capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-13-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::22f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This enables SR-IOV emulation on virtio-pci devices. It introduces a
property 'sriov-pf' to state that the device will be a VF, and it
will be paired with the PF identified with the property.
Currently this feature needs to be explicitly enabled by a subclass.

Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-pci.h |   2 +
 hw/virtio/virtio-pci.c         | 208 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index 5a3f182f99..0cd781ea98 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -105,6 +105,7 @@ struct VirtioPCIClass {
     PCIDeviceClass parent_class;
     DeviceRealize parent_dc_realize;
     void (*realize)(VirtIOPCIProxy *vpci_dev, Error **errp);
+    bool sriov_supported;
 };
 
 typedef struct VirtIOPCIRegion {
@@ -159,6 +160,7 @@ struct VirtIOPCIProxy {
     uint32_t gfselect;
     uint32_t guest_features[2];
     VirtIOPCIQueue vqs[VIRTIO_QUEUE_MAX];
+    GArray *sriov_vfs;
 
     VirtIOIRQFD *vector_irqfd;
     int nvqs_with_notifiers;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 205dbf24fb..3f1b3db9b7 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -26,6 +26,9 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
+#include "monitor/qdev.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qobject.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -49,6 +52,18 @@
  * configuration space */
 #define VIRTIO_PCI_CONFIG_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_enabled(dev))
 
+typedef struct VirtIOPCISriovVF {
+    ObjectClass *class;
+    PCIESriovVFOpts opts;
+    struct {
+        pcibus_t size;
+        uint8_t type;
+    } io_regions[PCI_NUM_REGIONS];
+    uint16_t devfn;
+} VirtIOPCISriovVF;
+
+static GHashTable *sriov_vfs;
+
 static void virtio_pci_bus_new(VirtioBusState *bus, size_t bus_size,
                                VirtIOPCIProxy *dev);
 static void virtio_pci_reset(DeviceState *qdev);
@@ -1912,6 +1927,18 @@ static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
 
+    if (d->id) {
+        if (pci_is_vf(&proxy->pci_dev)) {
+            if (g_hash_table_contains(sriov_vfs, d->id)) {
+                error_setg(errp, "a function cannot be SR-IOV PF and VF at the same time");
+                return;
+            }
+        } else {
+            proxy->sriov_vfs = g_hash_table_lookup(sriov_vfs, d->id);
+            virtio_add_feature(&vdev->host_features, VIRTIO_F_SR_IOV);
+        }
+    }
+
     if (virtio_pci_modern(proxy)) {
         virtio_add_feature(&vdev->host_features, VIRTIO_F_VERSION_1);
     }
@@ -1919,10 +1946,26 @@ static void virtio_pci_pre_plugged(DeviceState *d, Error **errp)
     virtio_add_feature(&vdev->host_features, VIRTIO_F_BAD_FEATURE);
 }
 
+static gint virtio_pci_sriov_vfs_compare(gconstpointer a, gconstpointer b)
+{
+    return ((VirtIOPCISriovVF *)a)->devfn - ((VirtIOPCISriovVF *)b)->devfn;
+}
+
+static void virtio_pci_register_bar(VirtIOPCIProxy *proxy, int region_num,
+                                    uint8_t type, MemoryRegion *memory)
+{
+    if (pci_is_vf(&proxy->pci_dev)) {
+        pcie_sriov_vf_register_bar(&proxy->pci_dev, region_num, memory);
+    } else {
+        pci_register_bar(&proxy->pci_dev, region_num, type, memory);
+    }
+}
+
 /* This is called by virtio-bus just after the device is plugged. */
 static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
+    VirtioPCIClass *k = VIRTIO_PCI_GET_CLASS(d);
     VirtioBusState *bus = &proxy->bus;
     bool legacy = virtio_pci_legacy(proxy);
     bool modern;
@@ -2026,18 +2069,18 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
             memory_region_init(&proxy->io_bar, OBJECT(proxy),
                                "virtio-pci-io", 0x4);
 
-            pci_register_bar(&proxy->pci_dev, proxy->modern_io_bar_idx,
-                             PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
+            virtio_pci_register_bar(proxy, proxy->modern_io_bar_idx,
+                                    PCI_BASE_ADDRESS_SPACE_IO, &proxy->io_bar);
 
             virtio_pci_modern_io_region_map(proxy, &proxy->notify_pio,
                                             &notify_pio.cap);
         }
 
-        pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
-                         PCI_BASE_ADDRESS_SPACE_MEMORY |
-                         PCI_BASE_ADDRESS_MEM_PREFETCH |
-                         PCI_BASE_ADDRESS_MEM_TYPE_64,
-                         &proxy->modern_bar);
+        virtio_pci_register_bar(proxy, proxy->modern_mem_bar_idx,
+                                PCI_BASE_ADDRESS_SPACE_MEMORY |
+                                PCI_BASE_ADDRESS_MEM_PREFETCH |
+                                PCI_BASE_ADDRESS_MEM_TYPE_64,
+                                &proxy->modern_bar);
 
         proxy->config_cap = virtio_pci_add_mem_cap(proxy, &cfg.cap);
         cfg_mask = (void *)(proxy->pci_dev.wmask + proxy->config_cap);
@@ -2072,8 +2115,92 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
                               &virtio_pci_config_ops,
                               proxy, "virtio-pci", size);
 
-        pci_register_bar(&proxy->pci_dev, proxy->legacy_io_bar_idx,
-                         PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
+        virtio_pci_register_bar(proxy, proxy->legacy_io_bar_idx,
+                                PCI_BASE_ADDRESS_SPACE_IO, &proxy->bar);
+    }
+
+    if (proxy->sriov_vfs) {
+        uint16_t first_devfn;
+        uint16_t stride;
+        PCIESriovVFOpts *opts;
+
+        if (!k->sriov_supported) {
+            error_setg(errp, "SR-IOV is not supported by this device type");
+            return;
+        }
+
+        if (!pci_is_express(&proxy->pci_dev)) {
+            error_setg(errp, "PCI Express is required for SR-IOV");
+            return;
+        }
+
+        g_array_sort(proxy->sriov_vfs, virtio_pci_sriov_vfs_compare);
+
+        first_devfn = g_array_index(proxy->sriov_vfs, VirtIOPCISriovVF, 0).devfn;
+        if (first_devfn <= proxy->pci_dev.devfn) {
+            error_setg(errp, "a VF function number is less than the PF function number");
+            return;
+        }
+
+        stride = proxy->sriov_vfs->len < 2 ?
+                 0 :
+                 (g_array_index(proxy->sriov_vfs, VirtIOPCISriovVF, 1).devfn -
+                  first_devfn);
+
+        for (uint16_t i = 0; i < proxy->sriov_vfs->len; i++) {
+            VirtIOPCISriovVF *vf = &g_array_index(proxy->sriov_vfs,
+                                                  VirtIOPCISriovVF,
+                                                  i);
+            if (vf->class != object_get_class(OBJECT(proxy))) {
+                error_setg(errp, "a VF and its paired PF have different types");
+                return;
+            }
+
+            for (size_t j = 0; j < PCI_NUM_REGIONS; j++) {
+                if (j == PCI_ROM_SLOT) {
+                    continue;
+                }
+
+                if (vf->io_regions[j].size != proxy->pci_dev.io_regions[j].size ||
+                    vf->io_regions[j].type != proxy->pci_dev.io_regions[j].type) {
+                    error_setg(errp, "inconsistent SR-IOV BARs");
+                }
+            }
+
+            if (vf->devfn - first_devfn != stride * i) {
+                error_setg(errp, "inconsistent SR-IOV stride");
+                return;
+            }
+        }
+
+        opts = g_new(PCIESriovVFOpts, proxy->sriov_vfs->len);
+
+        for (uint16_t i = 0; i < proxy->sriov_vfs->len; i++) {
+            opts[i] = g_array_index(proxy->sriov_vfs, VirtIOPCISriovVF, i).opts;
+            qobject_ref(opts[i].device_opts);
+        }
+
+        pcie_sriov_pf_init(&proxy->pci_dev, PCI_CONFIG_SPACE_SIZE,
+                           proxy->pci_dev.name, opts,
+                           PCI_DEVICE_ID_VIRTIO_10_BASE
+                           + virtio_bus_get_vdev_id(bus),
+                           proxy->sriov_vfs->len, proxy->sriov_vfs->len,
+                           first_devfn - proxy->pci_dev.devfn,
+                           stride);
+
+        for (int i = 0; i < PCI_NUM_REGIONS; i++) {
+            if (i == PCI_ROM_SLOT) {
+                continue;
+            }
+
+            VirtIOPCISriovVF *vf = &g_array_index(proxy->sriov_vfs,
+                                                  VirtIOPCISriovVF,
+                                                  0);
+            uint8_t type = vf->io_regions[i].type;
+            size = vf->io_regions[i].size;
+
+            pcie_sriov_pf_init_vf_bar(&proxy->pci_dev, i, type, size);
+        }
     }
 }
 
@@ -2093,9 +2220,69 @@ static void virtio_pci_device_unplugged(DeviceState *d)
         if (modern_pio) {
             virtio_pci_modern_io_region_unmap(proxy, &proxy->notify_pio);
         }
+        if (proxy->sriov_vfs) {
+            pcie_sriov_pf_exit(&proxy->pci_dev);
+        }
     }
 }
 
+static bool virtio_pci_hide(PCIDeviceClass *pc, const QDict *device_opts,
+                            bool from_json, Error **errp)
+{
+    const char *pf;
+    GArray *array;
+    QDict *cloned_device_opts;
+    VirtIOPCISriovVF vf;
+    DeviceState *dev;
+    PCIDevice *pci_dev;
+
+    if (!device_opts) {
+        return false;
+    }
+
+    pf = qdict_get_try_str(device_opts, "sriov-pf");
+    if (!pf) {
+        return false;
+    }
+
+    cloned_device_opts = qdict_clone_shallow(device_opts);
+    qdict_del(cloned_device_opts, "sriov-pf");
+
+    dev = qdev_device_add_from_qdict(cloned_device_opts, from_json, errp);
+    if (!dev) {
+        qobject_unref(cloned_device_opts);
+        return false;
+    }
+
+    pci_dev = PCI_DEVICE(dev);
+    vf.class = object_get_class(OBJECT(dev));
+    vf.opts.device_opts = cloned_device_opts;
+    vf.opts.from_json = from_json;
+
+    for (size_t i = 0; i < PCI_NUM_REGIONS; i++) {
+        vf.io_regions[i].size = pci_dev->io_regions[i].size;
+        vf.io_regions[i].type = pci_dev->io_regions[i].type;
+    }
+
+    vf.devfn = pci_dev->devfn;
+
+    qdev_unplug(dev, errp);
+    if (*errp) {
+        qobject_unref(cloned_device_opts);
+        return false;
+    }
+
+    array = g_hash_table_lookup(sriov_vfs, pf);
+    if (!array) {
+        array = g_array_new(false, false, sizeof(VirtIOPCISriovVF));
+        g_hash_table_insert(sriov_vfs, g_strdup(pf), array);
+    }
+
+    g_array_append_val(array, vf);
+
+    return true;
+}
+
 static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
@@ -2325,7 +2512,10 @@ static void virtio_pci_class_init(ObjectClass *klass, void *data)
     VirtioPCIClass *vpciklass = VIRTIO_PCI_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    sriov_vfs = g_hash_table_new(g_str_hash, g_str_equal);
+
     device_class_set_props(dc, virtio_pci_properties);
+    k->hide = virtio_pci_hide;
     k->realize = virtio_pci_realize;
     k->exit = virtio_pci_exit;
     k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;

-- 
2.43.0


