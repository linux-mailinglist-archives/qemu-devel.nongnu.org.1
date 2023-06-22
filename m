Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DADA73ABDF
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 23:51:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCSCN-0004Sb-8o; Thu, 22 Jun 2023 17:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSCD-0004I3-Pn
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:50:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qCSCC-00082c-27
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 17:50:29 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MJYYdd019949; Thu, 22 Jun 2023 21:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=mMoMFeioJjSbDxrvMabIUSoJaWlEO/hD5COIK4zVbUw=;
 b=mDD9g1ZJirlQAq3J1DmzuWgp8rFmzu3vrszB81ClUm29nBoZo7SQAoTHdKpsG0rtPwB1
 KQQKDdAcB+sceQxQ+XSFYPz5zBsXR9UKqrT1oZJCa7wagpLrdiQPt0tgLy42/+f1cOQ4
 mcKmkRYCNd5g2Zpoq+tJkthtCW0N3Sef5ye3vsPCO/FuGvnQSfhVPiyu/Dp1KqMOmuX6
 2ZC1v/Hamlzfaeg5rzYYgt24gG8kH+qgly8xj2EX//VpJn+DQl6liYqewoV/SLVBrS6N
 GhiJecfUHAi4Bf+rcA8jSu7/FgOjnYEMpPNQeCWlEuy8kOIsotRE8166KwFW1WHaNWdS qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1jugv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:50:23 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35MKIV3H008333; Thu, 22 Jun 2023 21:50:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r9398eqb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 21:50:22 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MLn77I035791;
 Thu, 22 Jun 2023 21:50:22 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-180-251.vpn.oracle.com
 [10.175.180.251])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3r9398ep1g-16; Thu, 22 Jun 2023 21:50:22 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v4 15/15] vfio/common: Block migration with vIOMMUs without
 address width limits
Date: Thu, 22 Jun 2023 22:48:45 +0100
Message-Id: <20230622214845.3980-16-joao.m.martins@oracle.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_16,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=723
 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220186
X-Proofpoint-GUID: xhYTTd1lRk3AP-TeeRjKa7MSHJZSFceh
X-Proofpoint-ORIG-GUID: xhYTTd1lRk3AP-TeeRjKa7MSHJZSFceh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Only block the case when the underlying vIOMMU model does not report any
address space limits, in addition to DMA translation being off or no
vIOMMU present. The limits are needed such that can define the IOVA limits
that arm the device dirty tracker.

Additionally, reword the migration blocker error message to clarify that
we the configured vIOMMU does not support migration, as opposed to
implying that just being there blocks migration.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 62f91e8e102d..c3cc0dd47044 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -449,15 +449,18 @@ static int vfio_viommu_get_max_iova(hwaddr *max_iova)
 
 int vfio_block_giommu_migration(Error **errp)
 {
+    hwaddr max;
     int ret;
 
     if (giommu_migration_blocker ||
-        !vfio_viommu_preset()) {
+        !vfio_viommu_preset() ||
+        (vfio_viommu_preset() && !vfio_viommu_get_max_iova(&max))) {
         return 0;
     }
 
     error_setg(&giommu_migration_blocker,
-               "Migration is currently not supported with vIOMMU enabled");
+               "Migration with vIOMMU is currently not supported "
+               "without vIOMMU address space boundaries");
     ret = migrate_add_blocker(giommu_migration_blocker, errp);
     if (ret < 0) {
         error_free(giommu_migration_blocker);
-- 
2.17.2


