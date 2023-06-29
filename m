Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 677E87422BD
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:54:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnPO-0002JL-V8; Thu, 29 Jun 2023 04:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPM-0002Il-P1
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:44 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPL-0003fe-3M
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688028823; x=1719564823;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M9sOthnyrGqoEEYhYVxWzaWHTpau5NyEbkjO3zdN17c=;
 b=co7LqUfuzEyo5NO/tIUIhtWYN+YVnXyvbkSCBrV3DM3WodXSUyKgLMg+
 twzYALzQGmiR1w6/3+fGfPO0cH0xehLhNt7b5bv1HrIgVugaFpTVBPxci
 Mf/OG4Fo1M0OVkggkTAgJG43sxkX09GGQJrTZkNQT6QC/7rCXBcOuwCf0
 V5A+ReitBNEMdED5Kyy64J/A7D8TLJ2g5tRgSxc3a4FNJpX7qe+E/GQfc
 2AnfRaQ9SAyq0HyENzd3EnsRoz/sJdasOobxIVMt5eTUuyS5LEKhpevOM
 Ug6z8iyYIAEa0QZr/0yUEdo4mYUqc3n0P5jkei7P/6Sh//4SCpNYT8ZI5 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360908856"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="360908856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720494337"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="720494337"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:39 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v4 2/5] vfio/pci: Free leaked timer in vfio_realize error path
Date: Thu, 29 Jun 2023 16:40:39 +0800
Message-Id: <20230629084042.86502-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629084042.86502-1-zhenzhong.duan@intel.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When vfio_realize fails, the mmap_timer used for INTx optimization
isn't freed. As this timer isn't activated yet, the potential impact
is just a piece of leaked memory.

Fixes: ea486926b07d ("vfio-pci: Update slow path INTx algorithm timer related")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 48df517f79ee..ab6645ba60af 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3224,6 +3224,9 @@ out_deregister:
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     }
+    if (vdev->intx.mmap_timer) {
+        timer_free(vdev->intx.mmap_timer);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
-- 
2.34.1


