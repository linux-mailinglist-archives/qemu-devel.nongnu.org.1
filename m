Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 210BA8FC68B
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jun 2024 10:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5i-0001Ih-V3; Wed, 05 Jun 2024 04:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5g-0001IK-LJ
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:52 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5f-00062T-3F
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576432; x=1749112432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eYNT8b3bn6ZdiQtKOajy9p/skFvrCmyO5rDGJbWkONE=;
 b=Ry0frEH+BQY2gqjojk6lXV2BBs2WbUB8ZYNR/aKiYO5c+9bjpypAwyBa
 HfU2ndC+Peo0AzUTjkvHnXtXRSj5K4bka/NJ8ocNJhVPdVPf8DOk5+/1c
 oFlQh1D2av00CQt980EAHLUStTb0W8Po0+RyX7w/iCpAWx7sekfXceTUh
 WZep/RhKGafcEjGmu2W+lQM/jwON4rPxLbTjKOZu9H2Au/i6MPLJ9KGhi
 R9r39iYF1vNnpJoCLsx+GHGCaa5x2OPidur2k+gP/LmQphMzS45Sbu11/
 WpGfev/Uu5/Lhc3HbETpUUsLI1eAEEAQaTVqAyoSYX54ItLUtQ1V3tG4u g==;
X-CSE-ConnectionGUID: vTPJhI9FRyuMpa248IgY6w==
X-CSE-MsgGUID: +rq/xdQETp6Brok6+OOhPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575371"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575371"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:51 -0700
X-CSE-ConnectionGUID: 9Z9W8ZRWSaaIHUmn4RdHGg==
X-CSE-MsgGUID: ok8pDI3GQMyh6xzx0cvzaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954814"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 09/17] vfio/container: Implement
 HostIOMMUDeviceClass::get_cap() handler
Date: Wed,  5 Jun 2024 16:30:35 +0800
Message-Id: <20240605083043.317831-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2f62c13214..99beeba422 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1147,11 +1147,26 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     return true;
 }
 
+static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
+                                    Error **errp)
+{
+    HostIOMMUDeviceCaps *caps = &hiod->caps;
+
+    switch (cap) {
+    case HOST_IOMMU_DEVICE_CAP_AW_BITS:
+        return caps->aw_bits;
+    default:
+        error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
+        return -EINVAL;
+    }
+}
+
 static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
 {
     HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
 
     hioc->realize = hiod_legacy_vfio_realize;
+    hioc->get_cap = hiod_legacy_vfio_get_cap;
 };
 
 static const TypeInfo types[] = {
-- 
2.34.1


