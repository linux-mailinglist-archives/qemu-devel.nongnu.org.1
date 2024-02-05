Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E86C849CF6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Feb 2024 15:24:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzsy-0008PB-CE; Mon, 05 Feb 2024 09:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWzsu-0008JB-Jc
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:23:44 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rWzss-00086f-PR
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:23:44 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7nL5t8bz6JB1b;
 Mon,  5 Feb 2024 22:20:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 084581404F5;
 Mon,  5 Feb 2024 22:23:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:23:40 +0000
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
 <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 08/11] hw/pci/aer: Default to error handling on.
Date: Mon, 5 Feb 2024 14:19:37 +0000
Message-ID: <20240205141940.31111-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This should be dependent on the platform supporting FW first.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/pci/pcie.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 9f1ca718b5..4f04a1702a 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -304,6 +304,12 @@ void pcie_cap_deverr_init(PCIDevice *dev)
     uint32_t pos = dev->exp.exp_cap;
     pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_DEVCAP,
                                PCI_EXP_DEVCAP_RBER);
+
+    /* HACK - FW first settings - how to do this cleanly? */
+    pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_DEVCTL,
+                               PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
+                               PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE);
+
     pci_long_test_and_set_mask(dev->wmask + pos + PCI_EXP_DEVCTL,
                                PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
                                PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE);
-- 
2.39.2


