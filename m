Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC67A1361E
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 10:04:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLlU-0008VM-KI; Thu, 16 Jan 2025 04:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLlO-0008UD-Uc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:02:07 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tYLlM-00012z-Jc
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:02:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so35122055ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737018123; x=1737622923;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xwODeiAmUKin1dC/nSDAdnrtbdfpKWFdm1CDRITC1UE=;
 b=CJ6PmbdMwCbX44HY14sFDHyJryNIlYsTdCNq7GullGU7DTmk9QghkqcFwsMRe0zZAp
 P4HD4YlJnjYRiZZYHJE/2++m6tsvWGnavFD5ver4QPjwfw+ba/BGjd1LaKr7YPsiQA6H
 n9XAwT77ROYXnBB3x2XNG+TPFWBwTcykmzo9PN3sztkSz54MzkN0/zE2Mss5TBOfVInF
 lbo6+n773u3Q4Ywop8/ids90PjK41hFsTBvco+P/JONJ4HyN8wmRmS9egXOxYAkm4o2X
 wD/+EMmdgTLtYC6DxpRLYH+W54t2emHGd5WhFyPJ2TLaN1UnVgpBbjLQl4Wtd8swu/SJ
 XqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737018123; x=1737622923;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwODeiAmUKin1dC/nSDAdnrtbdfpKWFdm1CDRITC1UE=;
 b=xEeSTcfZW8UdRIKd02QcIa1iCVFzqhNPNSlLk63bVcPD/Vk/teEe5MglBJIGtBmLNV
 /MEkuAJhLuWiVdEsOXFuV8iWu3I4Cb33Jxudw3p54gB0+1tHnyLgg1pU3E4cj45vDzE9
 dCewveBWFyh4fn57bccplOjycZyxUQFMWbrsl0QGhgJKRUHATWemveOgJDcp5+QQXopo
 opLr7NKVw3hnH8vmtdg4riYXmEnMlw7s3SSmM0xjFTSaaqhZEcVMwoxYNykQAbdJSoMs
 C65chpTRZ+Pj6rLin3FLhUvbppLnfBSJH5SpSfMaDe7udrOdFIkxhjlkF4SoDiMl83m2
 X4dQ==
X-Gm-Message-State: AOJu0YzF7V/7px8HQkkyeiyKTzo9BIEhk8l7ZVciOMzpGfbtF3nHY6wC
 o2DUNJYveR+uglM/RKyrku1GFQTtxWZA0taVorrD2HKD8YOejqnz9MoApJPManU=
X-Gm-Gg: ASbGncv+4Vtb9z3iyCXeO+eSkDtlLkIesAPl7UOFiTWn+16hwXWL9VwdXxaO2lByMwV
 7MuW+/Jlphv0ZyRLWYIhsJ24YrXlPAfKVStuvvV22MaEvvY/PK78aEcdfWuLNM5AJoDBZTPyEm5
 Mvf3Ecixwp8+rb+MkqpXW1Zm0gUDB7t6NM27YB2QZUhwVtV490L6tpepHmR782u0xsG5+vcLlHq
 JNMzkbPiapRqROH5aRl5W5apuxlZeLXrl13S79zJjRtxJlmxtA/DY2XVDo=
X-Google-Smtp-Source: AGHT+IGvNNGiQcSSE/lTV1vRZ2xgd4a86yhNRAel14gm+U6Ut2nYklcvm3IYIN5TzJK75ASzaVl0Zw==
X-Received: by 2002:a05:6a21:6d8f:b0:1e1:e2d8:fd4a with SMTP id
 adf61e73a8af0-1eb0250961amr10506031637.5.1737018123266; 
 Thu, 16 Jan 2025 01:02:03 -0800 (PST)
Received: from localhost ([157.82.203.37]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72d40567624sm10415172b3a.41.2025.01.16.01.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 01:02:02 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 16 Jan 2025 18:00:58 +0900
Subject: [PATCH v20 07/11] pcie_sriov: Ensure VF addr does not overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-reuse-v20-7-7cb370606368@daynix.com>
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
In-Reply-To: <20250116-reuse-v20-0-7cb370606368@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

pci_new() aborts when creating a VF with addr >= PCI_DEVFN_MAX.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt         |  8 +++++---
 include/hw/pci/pcie_sriov.h |  5 +++--
 hw/net/igb.c                | 10 +++++++---
 hw/nvme/ctrl.c              | 22 ++++++++++++++--------
 hw/pci/pcie_sriov.c         | 14 ++++++++++++--
 5 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index a47aad0bfab0..ab2142807f79 100644
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
diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 450cbef6c201..aa704e8f9d9f 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -27,10 +27,11 @@ typedef struct PCIESriovVF {
     uint16_t vf_number; /* Logical VF number of this function */
 } PCIESriovVF;
 
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
index 4d93ce629f95..c965fc2fb68a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -446,9 +446,13 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
 
     pcie_ari_init(pci_dev, 0x150);
 
-    pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
-        IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
-        IGB_VF_OFFSET, IGB_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
+                            IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS,
+                            IGB_MAX_VF_FUNCTIONS, IGB_VF_OFFSET, IGB_VF_STRIDE,
+                            errp)) {
+        igb_cleanup_msix(s);
+        return;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, IGBVF_MMIO_BAR_IDX,
         PCI_BASE_ADDRESS_MEM_TYPE_64 | PCI_BASE_ADDRESS_MEM_PREFETCH,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 68903d1d7067..8175751518f8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8481,7 +8481,8 @@ out:
     return pow2ceil(bar_size);
 }
 
-static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
+static bool nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset,
+                            Error **errp)
 {
     uint16_t vf_dev_id = n->params.use_intel_id ?
                          PCI_DEVICE_ID_INTEL_NVME : PCI_DEVICE_ID_REDHAT_NVME;
@@ -8490,12 +8491,16 @@ static void nvme_init_sriov(NvmeCtrl *n, PCIDevice *pci_dev, uint16_t offset)
                                       le16_to_cpu(cap->vifrsm),
                                       NULL, NULL);
 
-    pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
-                       n->params.sriov_max_vfs, n->params.sriov_max_vfs,
-                       NVME_VF_OFFSET, NVME_VF_STRIDE);
+    if (!pcie_sriov_pf_init(pci_dev, offset, "nvme", vf_dev_id,
+                            n->params.sriov_max_vfs, n->params.sriov_max_vfs,
+                            NVME_VF_OFFSET, NVME_VF_STRIDE, errp)) {
+        return false;
+    }
 
     pcie_sriov_pf_init_vf_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
                               PCI_BASE_ADDRESS_MEM_TYPE_64, bar_size);
+
+    return true;
 }
 
 static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
@@ -8620,6 +8625,11 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         return false;
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs &&
+        !nvme_init_sriov(n, pci_dev, 0x120, errp)) {
+        return false;
+    }
+
     nvme_update_msixcap_ts(pci_dev, n->conf_msix_qsize);
 
     pcie_cap_deverr_init(pci_dev);
@@ -8649,10 +8659,6 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         nvme_init_pmr(n, pci_dev);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        nvme_init_sriov(n, pci_dev, 0x120);
-    }
-
     return true;
 }
 
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 499becd5273f..91c64c988eb4 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -24,14 +24,22 @@ static PCIDevice *register_vf(PCIDevice *pf, int devfn,
                               const char *name, uint16_t vf_num);
 static void unregister_vfs(PCIDevice *dev);
 
-void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
+bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
                         const char *vfname, uint16_t vf_dev_id,
                         uint16_t init_vfs, uint16_t total_vfs,
-                        uint16_t vf_offset, uint16_t vf_stride)
+                        uint16_t vf_offset, uint16_t vf_stride,
+                        Error **errp)
 {
+    int32_t devfn = dev->devfn + vf_offset;
     uint8_t *cfg = dev->config + offset;
     uint8_t *wmask;
 
+    if (total_vfs &&
+        (uint32_t)devfn + (uint32_t)(total_vfs - 1) * vf_stride >= PCI_DEVFN_MAX) {
+        error_setg(errp, "VF addr overflows");
+        return false;
+    }
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_SRIOV, 1,
                         offset, PCI_EXT_CAP_SRIOV_SIZEOF);
     dev->exp.sriov_cap = offset;
@@ -69,6 +77,8 @@ void pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
     pci_set_word(wmask + PCI_SRIOV_SYS_PGSIZE, 0x553);
 
     qdev_prop_set_bit(&dev->qdev, "multifunction", true);
+
+    return true;
 }
 
 void pcie_sriov_pf_exit(PCIDevice *dev)

-- 
2.47.1


