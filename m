Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9F57470F5
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGf3J-0001uh-12; Tue, 04 Jul 2023 08:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGf3A-0001tU-PW
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:22:33 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGf36-0007iX-IR
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:22:31 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-557790487feso3866620a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688473346; x=1691065346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=94unPck/HFMYNf7Mv5w9vhyjWp/Os8sneFiELbRad9k=;
 b=ONVCHyOk6QCsxV39WhdxCYlywZEi/ReX+oQgKS2cln6Tk3GUUxUIDKw7U5Gp8ls41w
 K25kFqqqsh63z33dECBeIDIuAL8hlIr3vCNNo0ppL9uPO510qPO+5j4R5IGDyG34xyuF
 T7/1YESviLBWA4jWKwJ+NKh1VtRBRVYFxsQKIH1MU/KKQ8gxv1hAVFEFSipE08EntPiD
 KkIT4sQyXRBLyf+P4zEpEFAci9frII3uOWP8BEDO+D7h5nDeue2/gQ4+OnODPn8Yogdt
 6v6GPW0VBwiSI4GWfJUPdgPAUD9VAh6gGFp9GNJ9FF0xIXhG9VHRpIgNskqp1z80duJi
 JQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688473346; x=1691065346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94unPck/HFMYNf7Mv5w9vhyjWp/Os8sneFiELbRad9k=;
 b=UNQLZHdMAp2X1YDs9wD1kSMhgJRMiN420pu8mE6xPuy1n3O+EBy4UdpUbWJtGAuKeJ
 hCWfbRrDzjgek1+NMgfXYsrdOz9Ldg1f84UO6igeCNQmy4XREr1BFggOhFp6KpZsJDYr
 t4RGXJVP+6m6v55uxjzozqzrYSJ7gBlY7UJfJThP68t9OJTG+CEs5Pr1VROZ1kGEi3sn
 DkoLza42d3x7XFT0Ui6FdABAdh34e5EaK/HVvfS2QS9kb+8lvnqiPZL2xrN06nmiNd+1
 VyFkpLmiDq53jRuRq+CltsxK7zY+TSK/SDU0woMwvCmFy5JfsSoO+6pmdNkoJKgK4Tdl
 LQUA==
X-Gm-Message-State: AC+VfDw9tRZcXaaaqr6Se8+zuQo/w0CHgWpVYiSAV707lueC56RBmQAa
 2rQnvzTrjZEFnzubf7HX+JqdQ+fs2/dRi/8jb4w=
X-Google-Smtp-Source: ACHHUZ6hfi2is+Ab63aOkzG4Sf/ncxB9KJQ1352amOOyEkdj8JrgeYzXiAqiZPAIEyWgQrvaScHJUw==
X-Received: by 2002:a05:6a20:8f07:b0:122:a808:dbbe with SMTP id
 b7-20020a056a208f0700b00122a808dbbemr17897376pzk.29.1688473346076; 
 Tue, 04 Jul 2023 05:22:26 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x48-20020a056a000bf000b0064d32771fa8sm11009743pfu.134.2023.07.04.05.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:22:25 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 2/2] pcie: Specify 0 for ARI next function numbers
Date: Tue,  4 Jul 2023 21:22:14 +0900
Message-ID: <20230704122215.23270-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704122215.23270-1-akihiko.odaki@daynix.com>
References: <20230704122215.23270-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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
function number field is undefined for VF. The PF should end the linked
list formed with the field by specifying 0.

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


