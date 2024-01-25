Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2440F83BAD5
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jan 2024 08:40:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSuKh-0004i0-3c; Thu, 25 Jan 2024 02:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSuKd-0004f6-PQ; Thu, 25 Jan 2024 02:39:27 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rSuKc-0002Z1-1w; Thu, 25 Jan 2024 02:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706168365; x=1737704365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5UPbvjnJVUH3Taf72eBNl8r8qzYN+VKXSZvKAc2YBa0=;
 b=J4NILJaaDwAu6raLK+TeLfZU+7PM2BRo/ocr4fEuZv0OwSdq10W8aGZZ
 9szNaRYkeG1qo8JTTRbl3x5LTitOqTtnPBvWQT74WfHewAA6fTnkDP1Mx
 qgOWSLQgsTex4cyfhGOqa0w54RD9aJxQHMms81Aci6X+bT81UgKKEvkcA
 +iMyBDmXPs10cHgrgv+oHiwBhtq/iLJhIHrtYc4DhPsRXBKEYnEgVMi42
 BJ6CZpFCkoFSnQErkKYkgeQXJ4Ji/IOca0ygAAZgFFvhPD0PEPpWNIp11
 GouVSHbeuAq6Wq/86u2tW120oETaG8F3xRgFW3XyQhsXWJC1fRCbNklwI w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="400942958"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; d="scan'208";a="400942958"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 23:39:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2187721"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 23:39:16 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: eric.auger@redhat.com, jean-philippe@linaro.org,
 alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 1/2] virtio_iommu: Clear IOMMUPciBus pointer cache when
 system reset
Date: Thu, 25 Jan 2024 15:37:05 +0800
Message-Id: <20240125073706.339369-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125073706.339369-1-zhenzhong.duan@intel.com>
References: <20240125073706.339369-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
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

s->iommu_pcibus_by_bus_num is a IOMMUPciBus pointer cache indexed
by bus number, bus number may not always be a fixed value,
i.e., guest reboot to different kernel which set bus number with
different algorithm.

This could lead to endpoint binding to wrong iommu MR in
virtio_iommu_get_endpoint(), then vfio device setup wrong
mapping from other device.

Remove the memset in virtio_iommu_device_realize() to avoid
redundancy with memset in system reset.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/virtio/virtio-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 8a4bd933c6..86623d55a5 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1264,6 +1264,8 @@ static void virtio_iommu_system_reset(void *opaque)
 
     trace_virtio_iommu_system_reset();
 
+    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_num));
+
     /*
      * config.bypass is sticky across device reset, but should be restored on
      * system reset
@@ -1302,8 +1304,6 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 
     virtio_init(vdev, VIRTIO_ID_IOMMU, sizeof(struct virtio_iommu_config));
 
-    memset(s->iommu_pcibus_by_bus_num, 0, sizeof(s->iommu_pcibus_by_bus_num));
-
     s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
                              virtio_iommu_handle_command);
     s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
-- 
2.34.1


