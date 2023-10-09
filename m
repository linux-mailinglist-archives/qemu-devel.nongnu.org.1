Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA817BD1F5
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 04:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpfuu-00044h-Jn; Sun, 08 Oct 2023 22:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpfug-0003yI-9P; Sun, 08 Oct 2023 22:22:30 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpfud-0003d1-Jw; Sun, 08 Oct 2023 22:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696818147; x=1728354147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W3t+oZ2tvo7vonv10vitojnEdRzJxfPzOZNTQxOItU4=;
 b=I3h/fseDfpqcs0rdbtpFVyEi6T449VkOiqUVqPnEcfayR/LN8AwKDZNu
 4ejckU+qfGrLDBkHmous9u7YYQiE7stlToz3rIRZrgQ8EIEDJSudgJwZa
 qv5V4FfQInlai5Y5T7aFKGUjScO8Nmclf0X9wwbZizt6jsVSUd/PTCisL
 Sq0j3ZZ5LM1ZA2hNqg0vLAkXKsFNJ5l8f71JRhc5Wnk5Tclzhw1ghyNbj
 uyVMq1pWkTDaFCfdOKu0PbwgqApVWpTXJB8UATyZvvBTH1Z0txfT7e0Gx
 FF4EF9s9waIVGihlJV+SRaSUuQG+e8XKuCFGPPpqOoTmGRpsLi3w2Sza9 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="387916666"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="387916666"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="752860840"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="752860840"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 19:22:21 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, thuth@redhat.com,
 akrowiak@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
 farman@linux.ibm.com, mjrosato@linux.ibm.com, borntraeger@linux.ibm.com,
 aik@ozlabs.ru, eric.auger@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, qemu-s390x@nongnu.org
Subject: [PATCH 1/3] vfio/pci: Fix a potential memory leak in
 vfio_listener_region_add
Date: Mon,  9 Oct 2023 10:20:46 +0800
Message-Id: <20231009022048.35475-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009022048.35475-1-zhenzhong.duan@intel.com>
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

When there is an failure in vfio_listener_region_add() and the section
belongs to a ram device, there is an inaccurate error report which should
never be related to vfio_dma_map failure. The memory holding err is also
incrementally leaked in each failure.

Fix it by reporting the real error and free it.

Fixes: 567b5b309ab ("vfio/pci: Relax DMA map errors for MMIO regions")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9e61de03ee..5ff5acf1d8 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -763,7 +763,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
 
 fail:
     if (memory_region_is_ram_device(section->mr)) {
-        error_report("failed to vfio_dma_map. pci p2p may not work");
+        error_reportf_err(err, "PCI p2p may not work: ");
         return;
     }
     /*
-- 
2.34.1


