Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A90768451FF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 08:32:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRX7-0005KK-8h; Thu, 01 Feb 2024 02:30:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWy-0005IZ-KU
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:42 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRWs-0001bF-Pu
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772634; x=1738308634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=N3xsv2GtRVX6aSgVHRkuCisTKekGHMSdCU/SFK0nNzk=;
 b=MsFKUGqbGoQUacOgpGOHqsucBigpWLKA+yhjm/Y5rEpMaQfe/91RN4b6
 tNNeqdE5CtYNlFe3D2HkWPGzEmgTpuzjBs2lzKw0MaEwaaMLq6A+dOC6B
 GsNAV5Duu+jUo0+lcQkAqVK+rLdrB3j88RPI5nWsmuv4zwiPnPS67NMQM
 fVZEGRqkcEaqi6Pijmt5dAilQJbrfcTNSDvbsvWUnYEuWKrqCmLmqpajp
 p9UWaKVyvR6B6VY1raSL3Wkb57sUBcGGelp5A3r3HwSnkGRJ6y2/W0F3m
 QnfDP5tLfJO3gfbh9nZW4fJBKkT1lMiVHu33S6jdo9mCIrtoxWbv9Hcdo w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676650"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676650"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443189"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:30:27 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv2 03/18] vfio: Introduce IOMMULegacyDevice
Date: Thu,  1 Feb 2024 15:28:03 +0800
Message-Id: <20240201072818.327930-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

Similar as IOMMUFDDevice, IOMMULegacyDevice represents a device in
legacy mode and can be used as a communication interface between
devices (i.e., VFIO, VDPA) and vIOMMU.

Currently it includes nothing legacy specific, but could be extended
with any wanted info of legacy mode when necessary.

IOMMULegacyDevice is willingly not a QOM object because we don't want
it to be visible from the user interface.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9b7ef7d02b..8bfb9cbe94 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -31,6 +31,7 @@
 #endif
 #include "sysemu/sysemu.h"
 #include "hw/vfio/vfio-container-base.h"
+#include "sysemu/host_iommu_device.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -97,6 +98,11 @@ typedef struct VFIOIOMMUFDContainer {
     uint32_t ioas_id;
 } VFIOIOMMUFDContainer;
 
+/* Abstraction of host IOMMU legacy device */
+typedef struct IOMMULegacyDevice {
+    HostIOMMUDevice base;
+} IOMMULegacyDevice;
+
 typedef struct VFIODeviceOps VFIODeviceOps;
 
 typedef struct VFIODevice {
-- 
2.34.1


