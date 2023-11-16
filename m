Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0FF7EDCBF
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:16:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XWR-0004i4-Uw; Thu, 16 Nov 2023 03:14:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWP-0004gO-OQ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:14:45 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3XWO-0008VS-6t
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:14:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700122484; x=1731658484;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i0WRFPY0nft2rrBA8QHFvgJt46uOSg6b8AHmKK37QzI=;
 b=RqmFP65I0p41CBvnKpaIHr2tcMu44fnxbhiEQeXGxTwdVWC6GV51wZmz
 6bPbU9npYwdeK1BSQlMBKze9axrUs4dlIc6Hjo6O0DiVi6pKCrRWTmjUf
 5KKJGp2eGbFg33F0bDSLIaAIF+80o+m1fGhZuznIvjgXJyty1p6ExgF4P
 CVzXSAF2+6ZDIuc85oniTfuKZ9OwoMlB45us3K67/W/QRY5haZmP9V34N
 NQAbK7/Ha62zpB8CkvX1V4T8c995wVwAJadv3sb2Kym3kOqCgBxAskXvm
 fhxRb2W/gOjgq1qfmJx/VQMuMkO7YqevuWdOE4qqOFQUMEVPU1cx4oQ/+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389898200"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="389898200"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="768846134"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="768846134"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 00:14:38 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/5] vfio/pci: Move VFIODevice initializations in
 vfio_instance_init
Date: Thu, 16 Nov 2023 15:59:05 +0800
Message-Id: <20231116075909.1987656-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231116075909.1987656-1-zhenzhong.duan@intel.com>
References: <20231116075909.1987656-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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

Some of the VFIODevice initializations is in vfio_realize,
move all of them in vfio_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b23b492cce..5a2b7a2d6b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2969,9 +2969,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vfio_device_get_name(vbasedev, errp)) {
         return;
     }
-    vbasedev->ops = &vfio_pci_ops;
-    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
-    vbasedev->dev = DEVICE(vdev);
 
     /*
      * Mediated devices *might* operate compatibly with discarding of RAM, but
@@ -3320,6 +3317,7 @@ static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI(obj);
+    VFIODevice *vbasedev = &vdev->vbasedev;
 
     device_add_bootindex_property(obj, &vdev->bootindex,
                                   "bootindex", NULL,
@@ -3328,7 +3326,11 @@ static void vfio_instance_init(Object *obj)
     vdev->host.bus = ~0U;
     vdev->host.slot = ~0U;
     vdev->host.function = ~0U;
-    vdev->vbasedev.fd = -1;
+
+    vbasedev->type = VFIO_DEVICE_TYPE_PCI;
+    vbasedev->ops = &vfio_pci_ops;
+    vbasedev->dev = DEVICE(vdev);
+    vbasedev->fd = -1;
 
     vdev->nv_gpudirect_clique = 0xFF;
 
-- 
2.34.1


