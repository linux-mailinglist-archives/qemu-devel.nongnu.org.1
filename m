Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAD4716BE1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43fA-0003Z0-HB; Tue, 30 May 2023 14:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43el-0002mX-9s
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:01:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q43ej-0002nV-C5
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:01:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UE4udJ016942; Tue, 30 May 2023 18:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=NHP3YX3xN1KFlY3tE2FocA1gNKdffoZzE3n9vQTADMI=;
 b=3xvU3pC6H1/IGfVPY9snPBk2XqbdaP62OrujCOVUx6WPTuZeXAa/+0Hn8YBT+a6Vs6Xr
 pz/K8vb3n6LChez5QgvZKtld2bBTmygzCyDKU27unwmtK9QbeELLILmPXMKItmFD/bej
 15RsqSFHPr+EXAOzabdV+hZLUmDPDPO44PA/m2NB31VaiDsXExLFMZhjreoam4f8zTHf
 Qz1b/wseSRhSzbL4Mni2zsunAPP4LB0cHv+94M7dJrbKU2cJr8KzWLsIQ2zo0NrSpulm
 W0pqAmO97P3A3qj+4gq2qkIgPID3KIf4oNcnllByD+XRVXL4hQcgk8l0aZ6+9n1N5SXK KA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhjkkexd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:01:09 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34UHhRMH014722; Tue, 30 May 2023 18:01:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a48vs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:01:08 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHxspf011459;
 Tue, 30 May 2023 18:01:08 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-191-61.vpn.oracle.com
 [10.175.191.61])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 3qu8a48srr-16; Tue, 30 May 2023 18:01:07 +0000
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
Subject: [PATCH v3 15/15] vfio/common: Block migration with vIOMMUs without
 address width limits
Date: Tue, 30 May 2023 18:59:37 +0100
Message-Id: <20230530175937.24202-16-joao.m.martins@oracle.com>
In-Reply-To: <20230530175937.24202-1-joao.m.martins@oracle.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=717 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300144
X-Proofpoint-ORIG-GUID: kU_iBsfymTH9mQECYztpOBfWqHjmGQWy
X-Proofpoint-GUID: kU_iBsfymTH9mQECYztpOBfWqHjmGQWy
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
address space limits, in addition to DMA translation being off, or no
vIOMMU being present. The limits are needed such that can define the IOVA
limits to arm the device dirty tracker.

Additionally, reword the migration blocker error message to clarify that
we the configured vIOMMU does not support migration, as opposed to
implying that just being there blocks migration.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 hw/vfio/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5b211380306a..b0cf86559032 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -474,15 +474,17 @@ static int vfio_viommu_get_max_iova(hwaddr *max_iova)
 
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
+               "Migration is currently not supported with the configured vIOMMU");
     ret = migrate_add_blocker(giommu_migration_blocker, errp);
     if (ret < 0) {
         error_free(giommu_migration_blocker);
-- 
2.39.3


