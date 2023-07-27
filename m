Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51399765576
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1H6-00061h-Iw; Thu, 27 Jul 2023 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVv-0005fI-R0
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:23 -0400
Received: from [192.55.52.136] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVu-0004Nk-78
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690443262; x=1721979262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PDY6PXgBHsLC8cUf42XTMOY4sPIs93ocKgpDuj7Te6A=;
 b=E8V7UkQauWE6NxD3lEq7hN91mUUiqASGeR/S26ivYwvEFawx9NPxn/Op
 oIBHB5q6o7ScLT4HQWtaF7SaMC820GCPrlx5S7u/dXeOP9xoizNRRFwKu
 g2/VRiGisQfjZymScLh7/crZvjacZs5n+Vrw3a8f/PrSl5WKARZoOlOXJ
 k1Tg1r25OygI8Jc33BMWuiEEuSXR0Flq9d/9eOL10//JxOIod7KUOr8/W
 /nvxIBMXDzR80j+5gC4ew+dRaCO2nRWkDv6tUu6Mnp62Shx74mtfhobgt
 iNctoPtESSmhDt9FG3YKRP6WmVmuVa4j1cixkxvfUv5AHPQnShJyPH1KU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347842880"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="347842880"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2023 00:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756547376"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="756547376"
Received: from vmmteam.bj.intel.com ([10.240.192.110])
 by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 00:24:20 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com
Subject: [PATCH RFC v1 3/3] vfio/pci: dynamic MSI-X allocation in interrupt
 restoring
Date: Thu, 27 Jul 2023 03:24:10 -0400
Message-Id: <20230727072410.135743-4-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230727072410.135743-1-jing2.liu@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.136 (failed)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Jul 2023 09:43:26 -0400
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

During migration restoring, vfio_enable_vectors() is called to restore
enabling MSI-X interrupts for assigned devices. It sets the range from 0
to nr_vectors to kernel to enable MSI-X and the vectors unmasked in
guest. During the MSI-X enabling, all the vectors within the range are
allocated according to the ioctl().

When dynamic MSI-X allocation is supported, we only want the guest
unmasked vectors being allocated and enabled. Therefore, Qemu can first
set vector 0 to enable MSI-X and after that, all the vectors can be
allocated in need.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 hw/vfio/pci.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8c485636445c..43ffacd5b36a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -375,6 +375,38 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
     int ret = 0, i, argsz;
     int32_t *fds;
 
+    /*
+     * If dynamic MSI-X allocation is supported, the vectors to be allocated
+     * and enabled can be scattered. Before kernel enabling MSI-X, setting
+     * nr_vectors causes all these vectors being allocated on host.
+     *
+     * To keep allocation as needed, first setup vector 0 with an invalid
+     * fd to make MSI-X enabled, then enable vectors by setting all so that
+     * kernel allocates and enables interrupts only when enabled in guest.
+     */
+    if (msix && !(vdev->msix->irq_info_flags & VFIO_IRQ_INFO_NORESIZE)) {
+        argsz = sizeof(*irq_set) + sizeof(*fds);
+
+        irq_set = g_malloc0(argsz);
+        irq_set->argsz = argsz;
+        irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
+                         VFIO_IRQ_SET_ACTION_TRIGGER;
+        irq_set->index = msix ? VFIO_PCI_MSIX_IRQ_INDEX :
+                         VFIO_PCI_MSI_IRQ_INDEX;
+        irq_set->start = 0;
+        irq_set->count = 1;
+        fds = (int32_t *)&irq_set->data;
+        fds[0] = -1;
+
+        ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+
+        g_free(irq_set);
+
+        if (ret) {
+            return ret;
+        }
+    }
+
     argsz = sizeof(*irq_set) + (vdev->nr_vectors * sizeof(*fds));
 
     irq_set = g_malloc0(argsz);
-- 
2.27.0


