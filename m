Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E9773B8D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:52:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTP05-0000bZ-Gw; Tue, 08 Aug 2023 11:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTP03-0000bF-0l
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:51:59 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTP01-00032U-Gx
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:51:58 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-79aa1f24ba2so1538806241.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691509916; x=1692114716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtrQ+WzacSawTVSmH5F3sN3FASDEzKyHTWVNJRZzpMc=;
 b=TnqQbXY3PO942AHiTdtD0ITtkI5+vVviZlJZb7E3Y6UyO50pdDudgXg+tu6LZh7mKr
 Eekbbex4TsvBjJIvuOKTRQoizxUvoRdd8FCp2hSn0/8zXyHzv1zqxsFzdBw17SuBn/Y/
 WMyCfUkkj5+aTgsaYmuesib2SGuoXLE+IJeXGp+0vBXWMX6bGqEZ9UmEZp/y3WgCtAfz
 njx3d0MAOXitwmJSi1+aSyYRsHxjtwhHtlgYaGg8XVuNjMWaDCUZHxCzXDCiPMThgK1y
 wAq/Aadv+mDxZBKT4Oa2EA2ZWtlHoOlnGx4Uh9NMZzMFycmpVO/IKarM+u5iZ/x9HQIo
 o0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691509916; x=1692114716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtrQ+WzacSawTVSmH5F3sN3FASDEzKyHTWVNJRZzpMc=;
 b=dn4p3qMv/hOXo2CdMtOGsU+FF0Lejt1kefbmnaV9q4LktaIcmWkkUzIoYPr+de7n9h
 RYXJo1mFoGPOoC6jsMRB/7EzgxiFQfo/f8JPMBItxanCHNyvEP173Hx1e6aDBQbR0ahm
 3Z9NzjHZthXhJM/D1r1A2vrg1fXve+ru6mnVTmduUtj//EHOYkKo2yh1xYGQVtQpsDpD
 xx2qzlZb5iKtoq4clF+JkUa6RpQkklEj5dnRmvZZJdIzwouh/80SP7nRMXpYibkJTeIG
 QItRIlKF7NQBNML3rHn0fEqJ305w/9RNN6NZr+jYqq6NX9hzJjuhTIzG0VBMN5G2ujRA
 FdVQ==
X-Gm-Message-State: AOJu0YwTBSX6ttBhpZ3EAAe4ZFvgtLYj9aFLm3pzrrg/tphcMVdEzLZL
 NPwKrIKT4Cpq5yhM2p9nZ23BvVj9NxvTR1QClNojKg==
X-Google-Smtp-Source: AGHT+IG3h0MlNkxY/xZQ+GlM7vPUxjP3aZ/me/7etj90xYs12ANK67kptIv3SNxlU2IJsvzlPax8Pw==
X-Received: by 2002:a67:f4c8:0:b0:443:ef68:1f06 with SMTP id
 s8-20020a67f4c8000000b00443ef681f06mr255240vsn.18.1691509916363; 
 Tue, 08 Aug 2023 08:51:56 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a67ca11000000b004409e21cf23sm2013324vsk.6.2023.08.08.08.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:51:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v1 2/3] hw: nvme: ctrl: Initial support for DOE
Date: Tue,  8 Aug 2023 11:51:23 -0400
Message-ID: <1a75abf2fce0683b3d1ac2522eb6965384179c20.1691509717.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691509717.git.alistair.francis@wdc.com>
References: <cover.1691509717.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/nvme/nvme.h            |  4 ++++
 include/hw/pci/pcie_doe.h |  1 +
 hw/nvme/ctrl.c            | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 209e8f5b4c..e0918516e3 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -20,6 +20,7 @@
 
 #include "qemu/uuid.h"
 #include "hw/pci/pci_device.h"
+#include "hw/pci/pcie_doe.h"
 #include "hw/block/block.h"
 
 #include "block/nvme.h"
@@ -597,6 +598,9 @@ typedef struct NvmeCtrl {
         uint16_t    vqrfap;
         uint16_t    virfap;
     } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
+
+    /* DOE */
+    DOECap doe_spdm;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
index 87dc17dcef..18e9492977 100644
--- a/include/hw/pci/pcie_doe.h
+++ b/include/hw/pci/pcie_doe.h
@@ -46,6 +46,7 @@ REG32(PCI_DOE_CAP_STATUS, 0)
 
 /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
 #define PCI_SIG_DOE_DISCOVERY       0x00
+#define PCI_SIG_DOE_SPDM            0x01
 
 #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
 #define PCI_DOE_PROTOCOL_NUM_MAX    256
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f2e5a2fa73..ec3d5d3c29 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -202,6 +202,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/hostmem.h"
 #include "hw/pci/msix.h"
+#include "hw/pci/pcie_doe.h"
 #include "hw/pci/pcie_sriov.h"
 #include "migration/vmstate.h"
 
@@ -8088,6 +8089,13 @@ static int nvme_add_pm_capability(PCIDevice *pci_dev, uint8_t offset)
     return 0;
 }
 
+#ifdef CONFIG_LIBSPDM
+static bool nvme_doe_spdm_rsp(DOECap *doe_cap)
+{
+    return false;
+}
+#endif
+
 static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
 {
     ERRP_GUARD();
@@ -8317,6 +8325,13 @@ void nvme_attach_ns(NvmeCtrl *n, NvmeNamespace *ns)
                             BDRV_REQUEST_MAX_BYTES / nvme_l2b(ns, 1));
 }
 
+#ifdef CONFIG_LIBSPDM
+static DOEProtocol doe_spdm_prot[] = {
+    { PCI_VENDOR_ID_PCI_SIG, PCI_SIG_DOE_SPDM, nvme_doe_spdm_rsp },
+    { }
+};
+#endif
+
 static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
@@ -8359,6 +8374,11 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 
         nvme_attach_ns(n, ns);
     }
+
+#ifdef CONFIG_LIBSPDM
+    /* DOE Initailization */
+    pcie_doe_init(pci_dev, &n->doe_spdm, 0x190, doe_spdm_prot, true, 0);
+#endif
 }
 
 static void nvme_exit(PCIDevice *pci_dev)
-- 
2.41.0


