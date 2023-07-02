Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2770744D88
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 14:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFvmy-0001zP-Ov; Sun, 02 Jul 2023 08:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFvmw-0001xd-O4
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:02:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFvmv-0003jr-8P
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:02:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b80f2e6c17so28610845ad.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688299363; x=1690891363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G/84/MAMhwguVGfvnfXmyKgEA4/oRTMjkgnlllQVYaQ=;
 b=ajDeLqoeE4dxxvu+sZ8t0pjPGEJ0XbQJVu3o/EXmW2hbYXgh9N0+MPsMEkMGd0R/cb
 cL3JNMwMnqOpRk2773iSNj3ekehyMJohN2D58sjF0fzoN74bXoA26GYb4StMqSH8BsSz
 5rpY7ckX14xiRlBInwnjnhcwywdaYml4tneJhNTlBdxnMkqrgayAr2etbclcNAXZaEv3
 M4X/NqjdXPirlNxiLfCWrkszIh29KRWZmyDLHgqxx4eWYEJ5iSxkbb2Js5FtM++TXZ7y
 JaMKr/GnFJ1uhLkAnBFNsT7o/jMRMvZss/P8BtAUftBASlfaeYB5ScLC8SzF3e8D7xHp
 RfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688299363; x=1690891363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G/84/MAMhwguVGfvnfXmyKgEA4/oRTMjkgnlllQVYaQ=;
 b=QkMWmz1bVjsbHepbmXSlph4XdF/v45cRCKnPwFUpHDKgwXOjZgPljr7l2HosJ1SaJZ
 QHmTG94mwHPOj0YueB5aeA/GTxaubwCLBDvEUSgCUYWwTeHBMLgCYiz+jdPp7aBThyDq
 oHKPrhC4qrN6kKW+ppXcNhrCA7LWCZawPt/znfdZRTgLD3zyjrBng35RqDdkQtRsUYMP
 IId1EeqK40Bxf3fPlmiw7rZ4M/7RSJMhi7SaSllynuq8rV2YPsm0wfA0aMVp8Mb7YK0U
 AKKP9nuNACFAqGiDt+kqBvOtB+6+xmiVXOkM//uvJ0WQM2ku8UVhw/GQb4k4Iw2Wq8fw
 E43A==
X-Gm-Message-State: ABy/qLYL0CJDBvOLu6hof0S9c6HowIIPcgkKcQh9MznC3fbreJyNXvFq
 xV/jis3EHKEfdNqaNkK6ott9piotcCeRb3CKP3k=
X-Google-Smtp-Source: APBJJlGG4c/pW+6wiI2D7b7K52qhTzJxbLl95ypRkCvN4emvMfmlB1gSoU8FS7/lpAP7nk/dEFcZBg==
X-Received: by 2002:a17:902:f683:b0:1b6:9954:2037 with SMTP id
 l3-20020a170902f68300b001b699542037mr8793879plg.4.1688299363717; 
 Sun, 02 Jul 2023 05:02:43 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 n9-20020a170902d2c900b001b008b3dee2sm7215563plc.287.2023.07.02.05.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 05:02:43 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 2/2] pcie: Specify 0 for ARI next function numbers
Date: Sun,  2 Jul 2023 21:02:27 +0900
Message-ID: <20230702120229.66978-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702120229.66978-1-akihiko.odaki@daynix.com>
References: <20230702120229.66978-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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

The current implementers of ARI are all SR-IOV devices. The ARI next
function number field is undefined for VF. The PF should end the linked
list formed with the field by specifying 0.

Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
Fixes: 44c2c09488 ("hw/nvme: Add support for SR-IOV")
Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci.h | 2 ++
 hw/core/machine.c    | 1 +
 hw/pci/pci.c         | 2 ++
 hw/pci/pcie.c        | 2 +-
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index e6d0574a29..9c5b5eb206 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -209,6 +209,8 @@ enum {
     QEMU_PCIE_CAP_CXL = (1 << QEMU_PCIE_CXL_BITNR),
 #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
     QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
+#define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
+    QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
 };
 
 typedef struct PCIINTxRoute {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 46f8f9a2b0..f0d35c6401 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
+    { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
 };
 const size_t hw_compat_8_0_len = G_N_ELEMENTS(hw_compat_8_0);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e2eb4c3b4a..f2ce1dbfd0 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -82,6 +82,8 @@ static Property pci_props[] = {
     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
     DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
+    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
+                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, true),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 9a3f6430e8..cf09e03a10 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1030,7 +1030,7 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
 /* ARI */
 void pcie_ari_init(PCIDevice *dev, uint16_t offset)
 {
-    uint16_t nextfn = 1;
+    uint16_t nextfn = dev->cap_present & QEMU_PCIE_ARI_NEXTFN_1 ? 1 : 0;
 
     pcie_add_capability(dev, PCI_EXT_CAP_ID_ARI, PCI_ARI_VER,
                         offset, PCI_ARI_SIZEOF);
-- 
2.41.0


