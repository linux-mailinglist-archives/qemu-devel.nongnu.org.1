Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF8747B88
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 04:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGsC6-0007oj-Oc; Tue, 04 Jul 2023 22:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGsC4-0007oD-WB
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 22:24:37 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGsC3-0002FT-I0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 22:24:36 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1b0156a1c49so5116835fac.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 19:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688523874; x=1691115874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47Yq+XAduorsz2KmhQ+w+8/Qtk7q4JrgCgNfGVyADpw=;
 b=NBRCBJW0Gh6zLqEa3BDOwnb6BsaYXSKzzhvhVsW/zXejmNYZRHTyQ5aBkOtVoD+MV2
 teaRrDqVjZ9SAxs5wwhUqdeFTTJ18krVsyMo3TYMij1dzl7EZyl3Jc2AyBcu/ncixXgH
 0GXLebfctE5euLO+eoLNP97QOOgSkwOVj7/ybbn5FSKqF1rRpGpTBIsEMCpy5ZgR/TaN
 LZOB+4TlMK91d95P6ecd9eNyVY+xwoWB01EiQrckU+byXk2xpaUH6XD9X7aK+6pWlOxJ
 npytgkek1GHxDXVjM2Ffin12e4aFCombyNZWhWXaHlWkIAZkZUVaOEdTMz1PEM7o1OOS
 pu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688523874; x=1691115874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47Yq+XAduorsz2KmhQ+w+8/Qtk7q4JrgCgNfGVyADpw=;
 b=kAHieDzp9TQR5Ubi/ked5OR6Gkc/WkLJ8EkQchES8ya+JA33FZdxV3PpsLscMYa8rA
 cfrzcRtkvjaLvXwl9otBHBs2unY31lBiUQNQDDMAvM9Ko3m7YNPtXTA2fc43R8DIR9Vx
 PczSPIGTMWKelEt7vrGCu02E4UISebudYqd2HwaaYt0+N9zt14BlHlmGIThSoMwsrYXk
 ZW5t8DZDSKZKu4FvaBQUTCuqphKfc1+/bc5dLWVEwgAGPeO3ufTeyoe544sjBeiO3Zem
 XAe+HBCJFIZvStYk+leu5rYWTb8s72T5KLJy5WcgPQLVwvLtVF7vvu670s0BGJNzNWnB
 DQHg==
X-Gm-Message-State: ABy/qLaeoDG73Nj2wUILXsAzbnGwmNDIuAwp2MLPTrRAg1pGoxe4bNHt
 zinxjxNuAxxo22lIQYKw7l0tvXVgpHC3+Jpifkw=
X-Google-Smtp-Source: APBJJlHd/EcOVs4PMVpLY5v1w6kuQQsE7LdWj5VXUs1tsIfWuga5PDVAAec8OEuNdGP7H2SBmTvOvA==
X-Received: by 2002:a05:6870:e746:b0:1b3:ec6b:b264 with SMTP id
 t6-20020a056870e74600b001b3ec6bb264mr335871oak.5.1688523873982; 
 Tue, 04 Jul 2023 19:24:33 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a17090282ca00b001b8062c1db3sm15235365plz.82.2023.07.04.19.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 19:24:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 2/2] pcie: Specify 0 for ARI next function numbers
Date: Wed,  5 Jul 2023 11:24:20 +0900
Message-ID: <20230705022421.13115-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705022421.13115-1-akihiko.odaki@daynix.com>
References: <20230705022421.13115-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x2e.google.com
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

The current implementers of ARI are all SR-IOV devices. The ARI next
function number field is undefined for VF according to PCI Express Base
Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF should
end the linked list formed with the field by specifying 0 according to
section 7.8.7.2.

For migration, the field will keep having 1 as its value on the old
virt models.

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
index e2eb4c3b4a..45a9bc0da8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -82,6 +82,8 @@ static Property pci_props[] = {
     DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
     DEFINE_PROP_BIT("x-pcie-err-unc-mask", PCIDevice, cap_present,
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
+    DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
+                    QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
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


