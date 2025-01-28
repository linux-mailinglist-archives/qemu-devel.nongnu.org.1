Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD532A20553
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 08:56:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgSF-0007kG-7N; Tue, 28 Jan 2025 02:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgRX-0007SL-B7; Tue, 28 Jan 2025 02:55:32 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgRV-0008V3-D9; Tue, 28 Jan 2025 02:55:31 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0C95EE1AD4;
 Tue, 28 Jan 2025 10:53:00 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7B8A01A62C3;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 3A8885201D; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sebastian Ott <sebott@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 27/31] pci: ensure valid link status bits for
 downstream ports
Date: Tue, 28 Jan 2025 00:41:19 +0300
Message-Id: <20250127214124.3730126-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PCI hotplug for downstream endpoints on arm fails because Linux'
PCIe hotplug driver doesn't like the QEMU provided LNKSTA:

  pcieport 0000:08:01.0: pciehp: Slot(2): Card present
  pcieport 0000:08:01.0: pciehp: Slot(2): Link Up
  pcieport 0000:08:01.0: pciehp: Slot(2): Cannot train link: status 0x2000

There's 2 cases where LNKSTA isn't setup properly:
* the downstream device has no express capability
* max link width of the bridge is 0

Move the sanity checks added via 88c869198aa63
("pci: Sanity test minimum downstream LNKSTA") outside of the
branch to make sure downstream ports always have a valid LNKSTA.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Message-Id: <20241203121928.14861-1-sebott@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 694632fd44987cc4618612a38ad151047524a590)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 68a62da0b5..9ffc625cc2 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -999,18 +999,22 @@ void pcie_sync_bridge_lnk(PCIDevice *bridge_dev)
         if ((lnksta & PCI_EXP_LNKSTA_NLW) > (lnkcap & PCI_EXP_LNKCAP_MLW)) {
             lnksta &= ~PCI_EXP_LNKSTA_NLW;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_MLW;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
         }
 
         if ((lnksta & PCI_EXP_LNKSTA_CLS) > (lnkcap & PCI_EXP_LNKCAP_SLS)) {
             lnksta &= ~PCI_EXP_LNKSTA_CLS;
             lnksta |= lnkcap & PCI_EXP_LNKCAP_SLS;
-        } else if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
-            lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
         }
     }
 
+    if (!(lnksta & PCI_EXP_LNKSTA_NLW)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_NLW(QEMU_PCI_EXP_LNK_X1);
+    }
+
+    if (!(lnksta & PCI_EXP_LNKSTA_CLS)) {
+        lnksta |= QEMU_PCI_EXP_LNKSTA_CLS(QEMU_PCI_EXP_LNK_2_5GT);
+    }
+
     pci_word_test_and_clear_mask(exp_cap + PCI_EXP_LNKSTA,
                                  PCI_EXP_LNKSTA_CLS | PCI_EXP_LNKSTA_NLW);
     pci_word_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA, lnksta &
-- 
2.39.5


