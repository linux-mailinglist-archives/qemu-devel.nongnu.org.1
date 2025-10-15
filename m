Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B8FBDC781
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 06:30:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8t6W-0000sM-0g; Wed, 15 Oct 2025 00:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t6R-0000hz-R9; Wed, 15 Oct 2025 00:27:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v8t6N-0002xo-To; Wed, 15 Oct 2025 00:27:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4889D15D9DA;
 Wed, 15 Oct 2025 07:25:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE29729FE81;
 Wed, 15 Oct 2025 07:25:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>, Qing Wang <qinwang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.6 07/13] pcie_sriov: make pcie_sriov_pf_exit() safe on
 non-SR-IOV devices
Date: Wed, 15 Oct 2025 07:25:31 +0300
Message-ID: <20251015042540.68611-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
References: <qemu-stable-10.0.6-20251014174303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Commit 3f9cfaa92c96 ("virtio-pci: Implement SR-IOV PF") added an
unconditional call from virtio_pci_exit() to pcie_sriov_pf_exit().

pcie_sriov_pf_exit() reads from the SR-IOV Capability in Configuration
Space:

  uint8_t *cfg = dev->config + dev->exp.sriov_cap;
  ...
  unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This results in undefined behavior when dev->exp.sriov_cap is 0 because
this is not an SR-IOV device. For example, unparent_vfs() segfaults when
total_vfs happens to be non-zero.

Fix this by returning early from pcie_sriov_pf_exit() when
dev->exp.sriov_cap is 0 because this is not an SR-IOV device.

Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reported-by: Qing Wang <qinwang@redhat.com>
Buglink: https://issues.redhat.com/browse/RHEL-116443
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Fixes: cab1398a60eb ("pcie_sriov: Reuse SR-IOV VF device instances")
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250924155153.579495-1-stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit bab681f752048c3bc22d561b1d314c7ec16419c9)
(Mjt: backport to before v10.0.0-819-g19e55471d4e8
 "pcie_sriov: Allow user to create SR-IOV device")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index dd4fbaea46..6281bd61d9 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -112,6 +112,9 @@ bool pcie_sriov_pf_init(PCIDevice *dev, uint16_t offset,
 void pcie_sriov_pf_exit(PCIDevice *dev)
 {
     uint8_t *cfg = dev->config + dev->exp.sriov_cap;
+    if (dev->exp.sriov_cap == 0) {
+        return;
+    }
 
     unparent_vfs(dev, pci_get_word(cfg + PCI_SRIOV_TOTAL_VF));
 }
-- 
2.47.3


