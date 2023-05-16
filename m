Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D811704427
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 05:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pylnU-0004qC-Op; Mon, 15 May 2023 23:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1pylnQ-0004po-Ar
 for qemu-devel@nongnu.org; Mon, 15 May 2023 23:56:20 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1pylnN-0000Tw-G8
 for qemu-devel@nongnu.org; Mon, 15 May 2023 23:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684209377; x=1715745377;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Vu+6Laj1P0PLA5q1OKXMnHH/+ZiRlfeXk7GbV9RYpus=;
 b=PFR/aHQMXOevoJqgZoZjWXU9xyZEWLkrbzJIVM6mtiWvynVKm7al/dQF
 4mc+R4+mT+k5BYlm7ibYhayJKPlOZAqANDQNBurDMqX7T7Sr5q5CmFXVR
 nd/HdoW90Ai62g1VUTg4tYNKnw/QuYy5KlOie2S5jWD8iw27acTq4XhIC
 giuewtSxPsi7f+DdLDrp/tLQACs3ug45LRwEwnCXfwVwCVCWEIB4AKwND
 xL3oG35ZAXlR3CN+FAPU6yfOAJO2rQpMB3/yfERr3w39zziGf4nAzi8EW
 Zsq6RyPp69FpT31RvLvNvhMA7n9qSU5JDI46vZ6/ocPye9wAoh1OsDtxD w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="335918900"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; d="scan'208";a="335918900"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 20:56:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="701203910"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; d="scan'208";a="701203910"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 20:56:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: minwoo.im@samsung.com, alex.williamson@redhat.com, clg@redhat.com,
 chao.p.peng@intel.com
Subject: [PATCH] vfio/pci: Fix a use-after-free issue
Date: Tue, 16 May 2023 11:43:57 +0800
Message-Id: <20230516034357.61276-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We should free the duplicated variant of vbasedev->name plus uuid
rather than vbasedev->name itself.

Fixes: 2dca1b37a7 ("vfio/pci: add support for VF toke")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bf27a3990564..d2593681e000 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2998,7 +2998,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     }
 
     ret = vfio_get_device(group, name, vbasedev, errp);
-    g_free(name);
+    if (name != vbasedev->name) {
+        g_free(name);
+    }
     if (ret) {
         vfio_put_group(group);
         goto error;
-- 
2.34.1


