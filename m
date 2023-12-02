Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC1801B5B
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:04:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwX-0004WU-SI; Sat, 02 Dec 2023 03:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwP-0004V2-OV
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:34 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9KwN-000595-Qg
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:33 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-58a42c3cbb8so1837189eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504090; x=1702108890;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z8QsyW6l5I9S2QTemJwIB3U4zf0/ves6SUfycgaph7Q=;
 b=bazWa6UhHLvTNPsLsD19ua9kmxrpyfR/c/otbKY32PoLI2k4mJrT3C4K++0qduxTPr
 fGDjPZWLVxQoB3AfL7XjDIe3xeYOJ9YT3bi5UbDsNMlRQ16fJcqdnpfvlG88tn8iBeqC
 OuzWKdaslLDn1dfJZY18ZEVOTScvbgIh4ckKX6qIrM5V7iRChRIewVAzDW42/fCpIJd1
 QOexdSn6yPqBRYyG3TXzszTzjWV89/HIJVS7M+m0ylCZdkyjyrsV1W4APrlUkgJHq0v/
 AfkCyVQLylUMSIVSCalsCLpaWj8Z6GVQ0l0lGZvRus29jjFaiQKlhTGkpLTWn0/sWMEK
 1oHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504090; x=1702108890;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z8QsyW6l5I9S2QTemJwIB3U4zf0/ves6SUfycgaph7Q=;
 b=khPYp0avCClM8qg/vGJRPUdFQtSisfDbDg7WaSWqDwQnVKyStZEIKiU4/tDu6TCxUS
 cJP57W5Xf9hHg3yrydHO3GGrP19pht2NR8Unj6VZbK4oAaP+3wGCMjv6Vz5CzvLilda2
 tg06pM85ePqWQFAxI/dDjqM66TYJPH0zFyxxm3btLZ3s+nncc5hjs9mDzHa6CdnUjS+z
 nI5sBKNRVeDjRpsUOx/29ixPS2faH4gFJdtKBJ0uOffF0fcUqx38CiCv7REjU3Smykn+
 8Vpy0lR+orOeHJQJGIaUaYczrOIpJcogC01/p+KZqtgIDle3MOOUXy7VaqQC3tzjWSej
 oCpw==
X-Gm-Message-State: AOJu0YziBzMbEL6BP/RMF979oVBagrxXY0hgIFc5K3UcGnSozf+6xgsD
 P8JXFjBJkGsnoCSuuQMKSXpTtg==
X-Google-Smtp-Source: AGHT+IFQqExgZnzHND5ybjcxum/RDBReygnwa3pDDqzLP4XmnLTKfBaKi9+5GMc7Jaznp2nkPiE4Fw==
X-Received: by 2002:a05:6358:f59:b0:170:17eb:2056 with SMTP id
 c25-20020a0563580f5900b0017017eb2056mr594681rwj.63.1701504090616; 
 Sat, 02 Dec 2023 00:01:30 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 b11-20020a1709027e0b00b001bbb7af4963sm4633318plm.68.2023.12.02.00.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:30 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:35 +0900
Subject: [PATCH 12/14] pcie_sriov: Allow to specify VF device options
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-12-32b3570f7bd6@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2a.google.com
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

Specifying VF device options will be useful to create VFs based on
conventional device emulation code which have user-configurable
options.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt         |  2 +-
 include/hw/pci/pcie_sriov.h | 13 ++++++--
 hw/net/igb.c                |  2 +-
 hw/nvme/ctrl.c              |  2 +-
 hw/pci/pcie_sriov.c         | 73 ++++++++++++++++++++++++++++++++++++---------
 5 files changed, 72 insertions(+), 20 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index a47aad0bfa..dc70b40ae2 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -52,7 +52,7 @@ setting up a BAR for a VF.
       ...
 
       /* Add and initialize the SR/IOV capability */
-      pcie_sriov_pf_init(d, 0x200, "your_virtual_dev",
+      pcie_sriov_pf_init(d, 0x200, "your_virtual_dev", NULL,
                        vf_devid, initial_vfs, total_vfs,
                        fun_offset, stride);
 
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 095fb0c9ed..aa3d81fa44 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -15,10 +15,16 @@
 
 #include "hw/pci/pci.h"
 
+typedef struct PCIESriovVFOpts {
+    QDict *device_opts;
+    bool from_json;
+} PCIESriovVFOpts;
+
 struct PCIESriovPF {
     uint16_t num_vfs;   /* Number of virtual functions created */
     uint8_t vf_bar_type[PCI_NUM_REGIONS];   /* Store type for each VF bar */
     const char *vfname; /* Reference to the device type used for the VFs */
+    PCIESriovVFOpts *vfopts; /* Poiner to an array of VF options */
     PCIDevice **vf;     /* Pointer to an array of num_vfs VF devices */
 };
 
@@ -28,9 +34,10 @@ struct PCIESriovVF {
 };
 
 void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
-                        const char *vfname, uint16_t vf_dev_id,
-                        uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride);
+                        const char *vfname, PCIESriovVFOpts *vfopts,
+                        uint16_t vf_dev_id, uint16_t init_vfs,
+                        uint16_t total_vfs, uint16_t vf_offset,
+                        uint16_t vf_stride);
 void pcie_sriov_pf_exit(PCIDevice *dev);
 
 /* Set up a VF bar in the SR/IOV bar area */
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 8089acfea4..8168d401cb 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -447,7 +447,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150);
 
-    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
+    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF, NULL,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
         IGB_VF_OFFSET, IGB_VF_STRIDE);
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f026245d1e..91bbccb49f 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8040,7 +8040,7 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
-    pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
+    pcie_sriov_pf_init(pci_dev, offset, "nvme", NULL, vf_dev_id,
                        n->params.sriov_max_vfs, n->params.sriov_max_vfs,
                        NVME_VF_OFFSET, NVME_VF_STRIDE);
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 3ec786d341..4e73559dc1 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -15,8 +15,11 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/qdev-properties.h"
+#include "monitor/qdev.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qobject.h"
 #include "qapi/error.h"
 #include "trace.h"
 
@@ -25,9 +28,10 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn,
 static void unregister_vfs(PCIDevice *dev);
 
 void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
-                        const char *vfname, uint16_t vf_dev_id,
-                        uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride)
+                        const char *vfname, PCIESriovVFOpts *vfopts,
+                        uint16_t vf_dev_id, uint16_t init_vfs,
+                        uint16_t total_vfs, uint16_t vf_offset,
+                        uint16_t vf_stride)
 {
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
@@ -37,6 +41,7 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     dev->exp.sriov_cap = offset;
     dev->exp.sriov_pf.num_vfs = 0;
     dev->exp.sriov_pf.vfname = g_strdup(vfname);
+    dev->exp.sriov_pf.vfopts = vfopts;
     dev->exp.sriov_pf.vf = NULL;
 
     pci_set_word(cfg + PCI_SRIOV_VF_OFFSET, vf_offset);
@@ -76,6 +81,16 @@ void pcie_sriov_pf_exit(PCIDevice *dev)
     unregister_vfs(dev);
     g_free((char *)dev->exp.sriov_pf.vfname);
     dev->exp.sriov_pf.vfname = NULL;
+
+    if (dev->exp.sriov_pf.vfopts) {
+        uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+
+        for (uint16_t i = 0; i < pci_get_word(cfg + PCI_SRIOV_TOTAL_VF); i++) {
+            qobject_unref(dev->exp.sriov_pf.vfopts[i].device_opts);
+        }
+
+        g_free(dev->exp.sriov_pf.vfopts);
+    }
 }
 
 void pcie_sriov_pf_init_vf_bar(PCIDevice *dev, int region_num,
@@ -144,25 +159,50 @@ void pcie_sriov_vf_register_bar(PCIDevice *dev, int region_num,
 static PCIDevice *register_vf(PCIDevice *pf, int devfn, const char *name,
                               uint16_t vf_num)
 {
-    PCIDevice *dev = pci_new(devfn, name);
-    dev->exp.sriov_vf.pf = pf;
-    dev->exp.sriov_vf.vf_number = vf_num;
-    PCIBus *bus = pci_get_bus(pf);
+    PCIDevice *pci_dev;
+    BusState *bus = qdev_get_parent_bus(DEVICE(pf));
     Error *local_err = NULL;
 
-    qdev_realize(&dev->qdev, &bus->qbus, &local_err);
+    if (pf->exp.sriov_pf.vfopts) {
+        BusState *local_bus;
+        PCIESriovVFOpts *vfopts = pf->exp.sriov_pf.vfopts + vf_num;
+        DeviceState *dev = qdev_device_new_from_qdict(vfopts->device_opts,
+                                                      vfopts->from_json,
+                                                      &local_bus, &local_err);
+        if (!dev) {
+            error_report_err(local_err);
+            return NULL;
+        }
+
+        pci_dev = PCI_DEVICE(dev);
+
+        if (bus != local_bus) {
+            error_report("unexpected SR-IOV VF parent bus");
+            goto fail;
+        }
+    } else {
+        pci_dev = pci_new(devfn, name);
+    }
+
+    pci_dev->exp.sriov_vf.pf = pf;
+    pci_dev->exp.sriov_vf.vf_number = vf_num;
+
+    qdev_realize(&pci_dev->qdev, bus, &local_err);
     if (local_err) {
         error_report_err(local_err);
-        object_unparent(OBJECT(dev));
-        object_unref(dev);
-        return NULL;
+        goto fail;
     }
 
     /* set vid/did according to sr/iov spec - they are not used */
-    pci_config_set_vendor_id(dev->config, 0xffff);
-    pci_config_set_device_id(dev->config, 0xffff);
+    pci_config_set_vendor_id(pci_dev->config, 0xffff);
+    pci_config_set_device_id(pci_dev->config, 0xffff);
 
-    return dev;
+    return pci_dev;
+
+fail:
+    object_unparent(OBJECT(pci_dev));
+    object_unref(pci_dev);
+    return NULL;
 }
 
 static void register_vfs(PCIDevice *dev)
@@ -170,6 +210,8 @@ static void register_vfs(PCIDevice *dev)
     uint16_t num_vfs;
     uint16_t i;
     uint16_t sriov_cap = dev->exp.sriov_cap;
+    uint16_t total_vfs =
+        pci_get_word(dev->config + sriov_cap + PCI_SRIOV_TOTAL_VF);
     uint16_t vf_offset =
         pci_get_word(dev->config + sriov_cap + PCI_SRIOV_VF_OFFSET);
     uint16_t vf_stride =
@@ -178,6 +220,9 @@ static void register_vfs(PCIDevice *dev)
 
     assert(sriov_cap > 0);
     num_vfs = pci_get_word(dev->config + sriov_cap + PCI_SRIOV_NUM_VF);
+    if (num_vfs > total_vfs) {
+        return;
+    }
 
     dev->exp.sriov_pf.vf = g_new(PCIDevice *, num_vfs);
     assert(dev->exp.sriov_pf.vf);

-- 
2.43.0


