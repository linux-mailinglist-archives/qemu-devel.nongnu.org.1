Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CC4744D86
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 14:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFvmw-0001xa-3w; Sun, 02 Jul 2023 08:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFvmu-0001wk-8F
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:02:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFvms-0003j0-Hl
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:02:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b7ef3e74edso17586755ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 05:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688299361; x=1690891361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s02o4ecEeuNUThWPP1l7HSPv9qpDPaUhEuBGwN7hbWw=;
 b=Xydx3BhK3bKkodN4AFmQhU3wkb0q2Va/1ThDsc942+zaEja+CdbYAQShV92+RcFTdt
 qQ8q3VjgRBgC6DgLLHSjMYlrkCD+4xX7f/9QM+OMmqrgEOPAPoHPsx2k9kYQ2Q1HVl/I
 eRQsLvd8MurKvqXQyZOn501BgZo/QN1HYiXX4sadYyxf//J9md4J5SATjJc6xDCSVUKW
 zN/j95GMh/X4S1Xdf3/ouJF3oSe4y5pqKtyW9PDJD3ngiNMt0kbThfxZyhrjIeG6d5Cf
 CYPjqXpdu45pYnpJccX4xa0n5PtQiSjNfNHzxd1PRFI87NRL6TghUD+6+Pof7JDouVl/
 1HXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688299361; x=1690891361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s02o4ecEeuNUThWPP1l7HSPv9qpDPaUhEuBGwN7hbWw=;
 b=GYXGFuHEylzKVYJkI2lb6phEDaQOqwrQB5X0rVPNCHLtSHgeMUo6a+NKh4Hrz1qejI
 sKBHtSIZjNjSuHXlDPpTtE11Qr/GQDyYuDtZVQw3bjFeWk1WPyub6M/TaVyjREaiGmCq
 X+HGy1ry+bPmAdPLwnZacT2vlEK1kebCxm4WpylVmnfbInj3rl5iFxXIOQr78xqvlVyS
 AYJHwmdhESW4fhVH9j96JquktdGeSUEeoB9pM9UrQ9U661ya1XfoPJnmYhn1RWealC4Z
 UoImN1vsOUGNc8+8LxooSIL2jHQbEDEjYcRpp0bxe3jdiSkCaZPsNm9+rAc8v+xwLVQp
 sT2A==
X-Gm-Message-State: ABy/qLYmQQQRVQfzY5dwOvINNfq/jMdaBFvnwyaFBMgdbiVyqnQAnkrH
 sGCHSg7GqEwAJdYuNLzTRPZN2GeiAhXfOaLv1So=
X-Google-Smtp-Source: APBJJlGfn4po9jFMbhSMh+7DKOAw7L47cViYv9fqpgKdd7/Kc8Ymsk9fZwFaezei8oaE4XMG9o3+vw==
X-Received: by 2002:a17:902:eec6:b0:1b3:c7c1:8ded with SMTP id
 h6-20020a170902eec600b001b3c7c18dedmr5640507plb.27.1688299361001; 
 Sun, 02 Jul 2023 05:02:41 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 n9-20020a170902d2c900b001b008b3dee2sm7215563plc.287.2023.07.02.05.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 05:02:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 1/2] pcie: Use common ARI next function number
Date: Sun,  2 Jul 2023 21:02:26 +0900
Message-ID: <20230702120229.66978-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702120229.66978-1-akihiko.odaki@daynix.com>
References: <20230702120229.66978-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

Currently the only implementers of ARI is SR-IOV devices, and they
behave similar. Share the ARI next function number.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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


