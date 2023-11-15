Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CE7EBECC
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 09:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BZ5-0003Ha-Tn; Wed, 15 Nov 2023 03:48:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZ3-0003HA-CV
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:48:01 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3BZ1-0007nA-Pk
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 03:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700038080; x=1731574080;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WpnyEgYVlQhz4JkZ88KelgquTk6OuNRMC6HfJb5IWK4=;
 b=L5aVP8UD9jn8o5LkxVpXVtA7ohwUvhTuqpVkibOvJATNrKZYh15+hnEb
 4u1nozjC1s0IOIrJ94SSYLFSg0UkTo5xxFeINX/w50SN8Xq3ufBxHgfJl
 Meuttsz8bS86LfObSTrq+UdkFmGsRtRcFjBbEwik4Lx4PGbhmUPGOOxKM
 BT2avit9obNTuSwoSe8Y3j/vp8rth9/fW8i9u4QMwB3iqVP+qP0wSkXE8
 XqCJUK2NXSl9EdX1JnSf22Gx9R+0OsW35dI5wKf3r4La8g1DtL+JlyY0C
 9srmQf0Kb++IpQeE7IcyYg6U++ucchZaHlS0+w9XCpdMBWWvQIkaqIRlS w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12385041"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="12385041"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:47:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1012199413"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="1012199413"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 00:47:54 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/4] vfio/pci: Move VFIODevice initializations in
 vfio_instance_init
Date: Wed, 15 Nov 2023 16:32:15 +0800
Message-Id: <20231115083218.1973627-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
References: <20231115083218.1973627-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

Some of the VFIODevice initializations is in vfio_realize,
move all of them in vfio_instance_init.

No functional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


