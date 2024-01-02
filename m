Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A02821AB9
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:15:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKcjM-0005b3-77; Tue, 02 Jan 2024 06:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=87314d91c5=schalla@marvell.com>)
 id 1rKcjK-0005av-VS
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:14:42 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=87314d91c5=schalla@marvell.com>)
 id 1rKcjJ-0000ma-7b
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:14:42 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4025LPJS008170; Tue, 2 Jan 2024 03:14:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=pfpt0220; bh=vdvFXjYI
 wzzWeDI5t51XYynUaKTLBBGaYjvDZabBfQw=; b=CNwo9hkIQ6LL/f2uGA/PQB+I
 3qvuFjcgnXv2RMRgE5y0Tt1xrkO3Yu1UfbdRGAOzVeD+apo72HwI2jkAsS+OAJRj
 NSQUYSr020lXJCywpQSBceLB4iDKIQ+FexxklGhWZmuOfiK5hPHO1CMwQ5m0gd5F
 NalqQuzWv6K4rv6FImYXnnHBdINobdR7zYgNKw8lR4H5VkHQEXY2onHn8ynpZl+P
 eK1dUV4GmvB/tbJO3I3xhylQkTCwq8b7AC1e9fFoVZQCI81IV4EzkHI/ibIwMx54
 lspCUnmv61FvvBYJdhQTxgYCq4t20/l+S2mMFXtqS+8vhGQTAfVmqDDLeTRspg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vcc908t9a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Tue, 02 Jan 2024 03:14:36 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48;
 Tue, 2 Jan 2024 03:14:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 2 Jan 2024 03:14:35 -0800
Received: from localhost.localdomain (unknown [10.28.36.175])
 by maili.marvell.com (Postfix) with ESMTP id 93C0E3F7078;
 Tue,  2 Jan 2024 03:14:33 -0800 (PST)
From: Srujana Challa <schalla@marvell.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <vattunuru@marvell.com>, <jerinj@marvell.com>
Subject: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER feature bits to
 vdpa_feature_bits
Date: Tue, 2 Jan 2024 16:44:32 +0530
Message-ID: <20240102111432.36817-1-schalla@marvell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bCosLgaO_aLwlzqoPw2bIYIvPOhFb-fr
X-Proofpoint-GUID: bCosLgaO_aLwlzqoPw2bIYIvPOhFb-fr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
Received-SPF: pass client-ip=67.231.148.174;
 envelope-from=prvs=87314d91c5=schalla@marvell.com;
 helo=mx0b-0016f401.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER feature bits
for vhost vdpa backend. Also adds code to consider all feature bits
supported by vhost net client type for feature negotiation, so that
vhost backend device supported features can be negotiated with guest.

Signed-off-by: Srujana Challa <schalla@marvell.com>
---
 hw/net/vhost_net.c | 10 ++++++++++
 net/vhost-vdpa.c   |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e8e1661646..65ae8bcece 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -117,6 +117,16 @@ static const int *vhost_net_get_feature_bits(struct vhost_net *net)
 
 uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t features)
 {
+    const int *bit = vhost_net_get_feature_bits(net);
+
+    /*
+     * Consider all feature bits for feature negotiation with vhost backend,
+     * so that all backend device supported features can be negotiated.
+     */
+    while (*bit != VHOST_INVALID_FEATURE_BIT) {
+        features |= (1ULL << *bit);
+        bit++;
+    }
     return vhost_get_features(&net->dev, vhost_net_get_feature_bits(net),
             features);
 }
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 3726ee5d67..51334fcfe2 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
  */
 const int vdpa_feature_bits[] = {
     VIRTIO_F_ANY_LAYOUT,
+    VIRTIO_F_IN_ORDER,
     VIRTIO_F_IOMMU_PLATFORM,
+    VIRTIO_F_NOTIFICATION_DATA,
     VIRTIO_F_NOTIFY_ON_EMPTY,
     VIRTIO_F_RING_PACKED,
     VIRTIO_F_RING_RESET,
-- 
2.25.1


