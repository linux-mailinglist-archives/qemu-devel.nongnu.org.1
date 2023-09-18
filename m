Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EED8B7A464F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAou-0005p0-Gx; Mon, 18 Sep 2023 05:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAos-0005oU-2P
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:30 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAop-0000zF-US
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695030327; x=1726566327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KqrlI41bT36v2JNI8frGPTvfWv6nYWbfQq51fwpgcGI=;
 b=fIsb/RJplL8cSG9ePCTqpWGbjE4v/xvM15wwvA5U4uPjnJn0FS+YgmaH
 RYHrG6DwlNKgUtWo5VeHOQigONWK81vmG+exD03BPq44rMBbwTPASDi3L
 rZUXxdtzMan2WVJksYH+h1gvpAxx9IoO0kiwBKAFtiHod/ehEPoWTAt0P
 L3f6mNGCo4yD0mhr72ByhMJMd6nOrw4IpzFGTaqd+0vbgEvLhmU576kEv
 IKx+kli3RV8f8iirVsHz3+9S10iiomkOyjDIZqjcd9ckp0NgcpDDU/cPf
 H5XJItYHdATbr/Id1QJRZgFEblvRaINyiBSYa/2UZymj8OG3HOR5oKBF0 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="446072281"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="446072281"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 02:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835955962"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="835955962"
Received: from vmmteam.bj.intel.com ([10.240.193.84])
 by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2023 02:45:18 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v2 4/4] vfio/pci: enable MSI-X in interrupt restoring on
 dynamic allocation
Date: Mon, 18 Sep 2023 05:45:07 -0400
Message-Id: <20230918094507.409050-5-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918094507.409050-1-jing2.liu@intel.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During migration restoring, vfio_enable_vectors() is called to restore
enabling MSI-X interrupts for assigned devices. It sets the range from
0 to nr_vectors to kernel to enable MSI-X and the vectors unmasked in
guest. During the MSI-X enabling, all the vectors within the range are
allocated according to the VFIO_DEVICE_SET_IRQS ioctl.

When dynamic MSI-X allocation is supported, we only want the guest
unmasked vectors being allocated and enabled. Use vector 0 with an
invalid fd to get MSI-X enabled, after that, all the vectors can be
allocated in need.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
Changes since v1:
- No change.

Changes since RFC v1:
- Revise the comments. (Alex)
- Call the new helper function in previous patch to enable MSI-X. (Alex)
---
 hw/vfio/pci.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0117f230e934..f5f891dc0792 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -402,6 +402,23 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
     int ret = 0, i, argsz;
     int32_t *fds;
 
+    /*
+     * If dynamic MSI-X allocation is supported, the vectors to be allocated
+     * and enabled can be scattered. Before kernel enabling MSI-X, setting
+     * nr_vectors causes all these vectors to be allocated on host.
+     *
+     * To keep allocation as needed, use vector 0 with an invalid fd to get
+     * MSI-X enabled first, then set vectors with a potentially sparse set of
+     * eventfds to enable interrupts only when enabled in guest.
+     */
+    if (msix && !vdev->msix->noresize) {
+        ret = vfio_enable_msix_no_vec(vdev);
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


