Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CB74CF0F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:50:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIleH-0006Uq-52; Mon, 10 Jul 2023 03:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIleB-0006Rd-OV
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIle9-0006xT-0s
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx3Q0RGfz4wyK;
 Mon, 10 Jul 2023 17:49:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx3M0YY5z4wyH;
 Mon, 10 Jul 2023 17:49:18 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Robin Voetter <robin@streamhpc.com>
Subject: [PULL 10/11] pcie: Add a PCIe capability version helper
Date: Mon, 10 Jul 2023 09:48:47 +0200
Message-ID: <20230710074848.456453-11-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Alex Williamson <alex.williamson@redhat.com>

Report the PCIe capability version for a device

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Robin Voetter <robin@streamhpc.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/pci/pcie.h | 1 +
 hw/pci/pcie.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 3cc2b159570f..51ab57bc3c50 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -93,6 +93,7 @@ void pcie_cap_exit(PCIDevice *dev);
 int pcie_endpoint_cap_v1_init(PCIDevice *dev, uint8_t offset);
 void pcie_cap_v1_exit(PCIDevice *dev);
 uint8_t pcie_cap_get_type(const PCIDevice *dev);
+uint8_t pcie_cap_get_version(const PCIDevice *dev);
 void pcie_cap_flags_set_vector(PCIDevice *dev, uint8_t vector);
 uint8_t pcie_cap_flags_get_vector(PCIDevice *dev);
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b8c24cf45f7e..b7f107ed8dd4 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -274,6 +274,13 @@ uint8_t pcie_cap_get_type(const PCIDevice *dev)
             PCI_EXP_FLAGS_TYPE) >> PCI_EXP_FLAGS_TYPE_SHIFT;
 }
 
+uint8_t pcie_cap_get_version(const PCIDevice *dev)
+{
+    uint32_t pos = dev->exp.exp_cap;
+    assert(pos > 0);
+    return pci_get_word(dev->config + pos + PCI_EXP_FLAGS) & PCI_EXP_FLAGS_VERS;
+}
+
 /* MSI/MSI-X */
 /* pci express interrupt message number */
 /* 7.8.2 PCI Express Capabilities Register: Interrupt Message Number */
-- 
2.41.0


