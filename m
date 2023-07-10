Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8697674E204
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwj-0004Fe-Lg; Mon, 10 Jul 2023 19:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwU-0003Bk-Gl
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwP-0004od-9W
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U2PQIgfh7c5FIKJQdtrKt4BlDrgB/tEbncYB4sm69iQ=;
 b=A6n4A6jQJjs2YqQj57/wm2/kXwCBf4Sxpev4rnXy2Nc7JoVYk6UwGfK2MFAYAbHVPt+8qF
 1bTaUL8AXf+IFIZDVTnuUpiJU+VdJdnVepyYKvcPJMV9vtaimy37tqo2z/DlQRHYvgFzoM
 ius8+bf/XEMd7JorEjcu/29rkaUs3sI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-BVjsuUgNOgirOgo02dnVCg-1; Mon, 10 Jul 2023 19:05:11 -0400
X-MC-Unique: BVjsuUgNOgirOgo02dnVCg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc07d4c2f4so18892175e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030309; x=1691622309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U2PQIgfh7c5FIKJQdtrKt4BlDrgB/tEbncYB4sm69iQ=;
 b=OLNidRdROyfIRtWO8Jvgv2Fqt0bbqszG36IyzHFd2RtnsU2yzacWUTpLe3kxbB7vgT
 GHR4/nwqBQFz1QrCpjMyc/3scu7NqBuLXQwWksy9Q9o0AelTr1Jku5jZ+KQAeEmNzczq
 T3UPJ8w2+2RDkF/YF54WnQ8/xnMdjFfB+k6460XwZinTmcih8bLzPn8idYKzRdP4L0QL
 mm9+7EuCMOb2CPIwtadsQC0igRc09B150ka+8bdNWOYLzGR+lKWUXyPk1wRaFJ3fpK7Z
 j4vtJq/SVsU8VCnyzLUeQ5jf0+TIj+GukUoPozaRQ60vxyKWmCTbA+VWXaD/VYRWtmnL
 eeYg==
X-Gm-Message-State: ABy/qLYjvD9ru+B327vEeJ0ykunLFxSpt8TX+Uzk/3928SENdGhuRY78
 Tow9EUJQWnDPZsMnSWx4hlqkeKBqE5H/XIhw9ZILxtt8xrgGmsPBlYvcqzer32zGzwc8PtPe7cx
 bAKfgYoCpP3IKDhXiCZ7Jx4ndN4S7KKKNXfXR8hiK7httVI4DOZ+CpnSKhzjfNmHQNjos
X-Received: by 2002:a1c:6a03:0:b0:3fb:a576:3212 with SMTP id
 f3-20020a1c6a03000000b003fba5763212mr13842120wmc.39.1689030309257; 
 Mon, 10 Jul 2023 16:05:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFJ9JAYYk0p9XumFVmMAXeFRhko6eGEblXKiHMmjOKTpxyxY83XbOcN9+Y0A17ZCM1D86e2kg==
X-Received: by 2002:a1c:6a03:0:b0:3fb:a576:3212 with SMTP id
 f3-20020a1c6a03000000b003fba5763212mr13842093wmc.39.1689030308913; 
 Mon, 10 Jul 2023 16:05:08 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 t25-20020a1c7719000000b003fbfef555d2sm10655077wmi.23.2023.07.10.16.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:08 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
Subject: [PULL 56/66] pcie: Use common ARI next function number
Message-ID: <445416e3010a2525c577d692921979a64d88a998.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Currently the only implementers of ARI is SR-IOV devices, and they
behave similar. Share the ARI next function number.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230710153838.33917-2-akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index 51ab57bc3c..11f5a91bbb 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -135,7 +135,7 @@ void pcie_sync_bridge_lnk(PCIDevice *dev);
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
index 355668bdf8..8e8e870b9a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8120,7 +8120,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(pci_dev, 0x80);
     pcie_cap_flr_init(pci_dev);
     if (n->params.sriov_max_vfs) {
-        pcie_ari_init(pci_dev, 0x100, 1);
+        pcie_ari_init(pci_dev, 0x100);
     }
 
     /* add one to max_ioqpairs to account for the admin queue pair */
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 763f65c528..6075ff5556 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1039,8 +1039,10 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
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
MST


