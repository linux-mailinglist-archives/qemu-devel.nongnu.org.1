Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5A74CF83
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:09:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlx3-00077R-KR; Mon, 10 Jul 2023 04:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIlwz-00076g-9x
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:08:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIlwq-0006tw-B5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:08:45 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-666fb8b1bc8so3719108b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688976523; x=1691568523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2CsWidimTPQzosDdC860b+h1kqgtnDYWMVoPP8FDuE=;
 b=JxwHCpUNbwC3tD4uPAxJcNdszadzbYZBYjL12YQGwMBALbcFEzJ3Nh+KxeEEqO5ELx
 /m0MesgpipewP/BlSEFGWg8Y97PYPZctqJMzY2RmZDniI8zfqDo/09eybR7JLmUUx464
 y+ffC/6y0OVOAMJtGAP6i9q/fTu9wec0+A0HHrGbsNako/0vwx0KlzPOywitdQvzl8Zj
 Ga53vIvG4oc230X50kPskxqWRSlzIK6aGcGcXI0bknCLgoXgSeomUR3/6DOhxVR+wEuY
 DdWtyZN/e8Qa3zmMcdEYUxDk6p6ypImx4Ed+ZU4ln4LfXZtRM/JNVASGujFdzQmKJOkc
 lkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688976523; x=1691568523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2CsWidimTPQzosDdC860b+h1kqgtnDYWMVoPP8FDuE=;
 b=T27q/W/X/rH3IeTFIi7DOO2fC/ydW7x2wlXQSfqKjBbcdBVcjwHpAb3pFP5CBWAaUD
 zDx+PH/i6+eXh95b+kFiG0Ox6kGFw58/kt90fsR9ecvhAFduySOL4HfNJYxXTZWmVZi2
 AxLI/LUEj9tSQEwmVJ+4DE4ocRluGHUiahCKIbLo6f3vEFJIIL8P7RUqrxiAjWYtYOMt
 0tqEy97wRgWSOv1bjl7yG5wEAWVvn8eUMqediFXdQFaRIZOSAl59TT67UlHD3YIpydq/
 X2Ye1HVBceUUqP39jw5V1IvpeJjGScINdL1MHknhUqNxbKDX4MLqXU7rxBteQumNXdZs
 oEFQ==
X-Gm-Message-State: ABy/qLaYAFUrg3OkuL2yz8sySIv4ERK6V98zZWxGILOB9CAvUpV69hLT
 NZeBxh2UqCOJSzLChOYob15ggvtmNORuQynByXM=
X-Google-Smtp-Source: APBJJlGSCec8NjSp5euCXDML44YCNs02r6RrT5HB6k8KYw5p3qA+2VHc07eRd89fOX+tdFL+ZEVjVQ==
X-Received: by 2002:a05:6a00:a04:b0:682:713e:e510 with SMTP id
 p4-20020a056a000a0400b00682713ee510mr16320378pfh.27.1688976522832; 
 Mon, 10 Jul 2023 01:08:42 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a62ae15000000b00640dbbd7830sm6814073pff.18.2023.07.10.01.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 01:08:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 2/2] pcie: Specify 0 for ARI next function numbers
Date: Mon, 10 Jul 2023 17:08:29 +0900
Message-ID: <20230710080830.19053-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710080830.19053-1-akihiko.odaki@daynix.com>
References: <20230710080830.19053-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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
function number field is undefined for VF according to PCI Express Base
Specification Revision 5.0 Version 1.0 section 9.3.7.7. The PF still
requires some defined value so end the linked list formed with the field
by specifying 0 as required for any ARI implementation according to
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


