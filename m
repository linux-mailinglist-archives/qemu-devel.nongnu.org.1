Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C7574DA0C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:38:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsyS-00089n-AT; Mon, 10 Jul 2023 11:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIsyQ-00087R-Ah
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:38:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIsyO-0005Pp-N0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:38:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b89e10d356so23719175ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689003527; x=1691595527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7r/U7SVtPAxlWbjK3ddc6oRCYoIzzP1GAcp4TadPfc=;
 b=brU2qUAK59R9qTRjnQ1n1EuWFHUbWOlZ6htVY+8tGiV0aEVrS6d64R/wzuPzmOPPQo
 7D7pWGLYewdFwl2RuRf/ZV7lcDjxORf/dnlPFq8Mm3nEZK2LMGSG5X717ZgfUTYxDhmx
 bJLZhht3LOeN2zYJ8x3PINfuKbxNRYw54qeMWoTTyqTnkvCfyTdxE/pe/28M+DfXIE3b
 8sfPSzeVtjrXYPtGLYSE4vrTPPY5+QGc08ljyZjWuKctAQnn4RWy1+o+iAnTs5VSECT2
 AtsNEtvRNXNz8mx9LFROeAn1AagIce0LHHbnzgBLbK3Rm4xquBeLvbEjwfUpyRitEdMZ
 Gx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689003527; x=1691595527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7r/U7SVtPAxlWbjK3ddc6oRCYoIzzP1GAcp4TadPfc=;
 b=QJ66YzkcGu+y7IplEOIaVQrVCz+h1ZJ2CSs4o+B3M+HONMKMxA0r8JipM451d73lkL
 BGftGK3Hb7xpQ02PW3+kDhTr2CwGdDmKyOQqe1ZgwjW80Mck1i5D9eNHe7eABJuJci7G
 EkQ3WXqMJngGTFgQt9b4TIVBrhnqRbA2h9VkTOo1DHjNadZ/Ko0JoFuQIN0QlFyY8CSr
 jIo+1d+0QeKAgLhQGGyu6EAWZGdtcsV97hqCL8wB1W3RPE4XaiFytrmFbFgx0jNf+FBq
 eg5Ve8EaUdbcrd4fDNE4GbiRSyn4IxO4/LWNdg4tcLu9k39GlI5Z5/bW9CgzRoFpVYLl
 cs7w==
X-Gm-Message-State: ABy/qLY5aD4tDaj1WrZMivQQ0DxycOI+eQ1vOJkj3qOlQDJni67JFrel
 TPljqE/otrx9KGjiEwvo3iYoHbNiFc16WY/O67I=
X-Google-Smtp-Source: APBJJlHq+6cw+TvUt8b8oI8XoXX7BjAO7fmbDh9z9OQ7SLkQ3R3Vo6hA9JilUyP0UV2UEdXQKqZ/MQ==
X-Received: by 2002:a17:902:ce8b:b0:1b9:e399:4c8d with SMTP id
 f11-20020a170902ce8b00b001b9e3994c8dmr1953213plg.3.1689003527292; 
 Mon, 10 Jul 2023 08:38:47 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a170902b60900b001b9e1d5f8e0sm48345pls.91.2023.07.10.08.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 08:38:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v7 1/2] pcie: Use common ARI next function number
Date: Tue, 11 Jul 2023 00:38:35 +0900
Message-ID: <20230710153838.33917-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710153838.33917-1-akihiko.odaki@daynix.com>
References: <20230710153838.33917-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

Currently the only implementers of ARI is SR-IOV devices, and they
behave similar. Share the ARI next function number.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
---
 docs/pcie_sriov.txt   | 4 ++--
 include/hw/pci/pcie.h | 2 +-
 hw/net/igb.c          | 2 +-
 hw/net/igbvf.c        | 2 +-
 hw/nvme/ctrl.c        | 2 +-
 hw/pci/pcie.c         | 4 +++-
 6 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index 7eff7f2703..a47aad0bfa 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -48,7 +48,7 @@ setting up a BAR for a VF.
       ...
       int ret = pcie_endpoint_cap_init(d, 0x70);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100);
       ...
 
       /* Add and initialize the SR/IOV capability */
@@ -78,7 +78,7 @@ setting up a BAR for a VF.
       ...
       int ret = pcie_endpoint_cap_init(d, 0x60);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100);
       ...
       memory_region_init(mr, ... )
       pcie_sriov_vf_register_bar(d, bar_nr, mr);
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 3cc2b15957..bf7dc5d685 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -134,7 +134,7 @@ void pcie_sync_bridge_lnk(PCIDevice *dev);
 void pcie_acs_init(PCIDevice *dev, uint16_t offset);
 void pcie_acs_reset(PCIDevice *dev);
 
-void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn);
+void pcie_ari_init(PCIDevice *dev, uint16_t offset);
 void pcie_dev_ser_num_init(PCIDevice *dev, uint16_t offset, uint64_t ser_num);
 void pcie_ats_init(PCIDevice *dev, uint16_t offset, bool aligned);
 
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 1c989d7677..8ff832acfc 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -431,7 +431,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
         hw_error("Failed to initialize AER capability");
     }
 
-    pcie_ari_init(pci_dev, 0x150, 1);
+    pcie_ari_init(pci_dev, 0x150);
 
     pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
         IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index 284ea61184..d55e1e8a6a 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -270,7 +270,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
         hw_error("Failed to initialize AER capability");
     }
 
-    pcie_ari_init(dev, 0x150, 1);
+    pcie_ari_init(dev, 0x150);
 }
 
 static void igbvf_pci_uninit(PCIDevice *dev)
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd917fcda1..8b7168a266 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8088,7 +8088,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
     pcie_cap_flr_init(pci_dev);
     if (n->params.sriov_max_vfs) {
-        pcie_ari_init(pci_dev, 0x100, 1);
+        pcie_ari_init(pci_dev, 0x100);
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b8c24cf45f..9a3f6430e8 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1028,8 +1028,10 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
  */
 
 /* ARI */
-void pcie_ari_init(PCIDevice *dev, uint16_t offset, uint16_t nextfn)
+void pcie_ari_init(PCIDevice *dev, uint16_t offset)
 {
+    uint16_t nextfn = 1;
+
     pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
                         offset, PCI_ARI_SIZEOF);
     pci_set_long(dev->config + offset + PCI_ARI_CAP, (nextfn & 0xff) << 8);
-- 
2.41.0


