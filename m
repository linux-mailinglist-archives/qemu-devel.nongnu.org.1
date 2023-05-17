Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F89B70625D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:10:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6p-0002nV-6R; Wed, 17 May 2023 04:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6d-0002d7-Qa; Wed, 17 May 2023 04:01:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6b-0000kp-OY; Wed, 17 May 2023 04:01:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A03856764;
 Wed, 17 May 2023 11:01:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2853C5E1C;
 Wed, 17 May 2023 11:01:00 +0300 (MSK)
Received: (nullmailer pid 3624160 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v8.0.1 27/36] hw/pci-bridge: pci_expander_bridge fix type in
 pxb_cxl_dev_reset()
Date: Wed, 17 May 2023 11:00:47 +0300
Message-Id: <20230517080056.3623993-27-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reproduce issue with

configure --enable-qom-cast-debug ...

qemu-system-x86_64 -display none -machine q35,cxl=on -device pxb-cxl,bus=pcie.0

  hw/pci-bridge/pci_expander_bridge.c:54:PXB_DEV: Object 0x5570e0b1ada0 is not an instance of type pxb
  Aborted

The type conversion results in the right state structure, but PXB_DEV is
not a parent of PXB_CXL_DEV hence the error. Rather than directly
cleaning up the inheritance, this is the minimal fix which will be
followed by the cleanup.

Fixes: 154070eaf6 ("hw/pxb-cxl: Support passthrough HDM Decoders unless overridden")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230420142750.6950-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9136f661c7277777a2f85a7e98438f4fe6472fdc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/pci-bridge/pci_expander_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index ead33f0c05..a78327b5f2 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -311,7 +311,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
      * The CXL specification allows for host bridges with no HDM decoders
      * if they only have a single root port.
      */
-    if (!PXB_DEV(dev)->hdm_for_passthrough) {
+    if (!PXB_CXL_DEV(dev)->hdm_for_passthrough) {
         dsp_count = pcie_count_ds_ports(hb->bus);
     }
     /* Initial reset will have 0 dsp so wait until > 0 */
-- 
2.39.2


