Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 304E3AA68B0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 May 2025 04:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAfxN-00040K-Pd; Thu, 01 May 2025 22:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfxE-0003yQ-W3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uAfxC-0007TQ-NJ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 22:16:44 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541KeNtX024976;
 Fri, 2 May 2025 02:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=fMOsx
 hjp26Lh0BIlPWm0XLzoyoE4zg7kHdXKyAmVPgw=; b=O7qsHXOy7Jyk8HcHsZ9zo
 gfvBZyVKaI1KeXc2Dl4sPWpbLdBESGBBhGcCEAVbV7uTvX24iUPdy94wDXs5iDhQ
 6glD+rU0aisZpG2O5VWPOo6Ha9i2bja2mduIUEWSUuNu/jKXs+tWTMLAUN5J2+7/
 PfFtsUji+a3ojXR7mRPZEQ45rKeYcad29H3MWuoBrIi8H2mSyqN0LJ061KK5kGlj
 Koj/3/wUDaFXE/RDkGRjcFQ1TF/S9XKTw1hfQpsw6rtaKIz++BMZRN5LOl5TZMvM
 soRbZA/B2xJZiZ98/qmo6AzhIyKSlNJ4z2y7TZvA/LHmPeQuwViDOn6KWSZKsbpn
 g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usmcp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:33 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5421Ioqa023986; Fri, 2 May 2025 02:16:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 468nxkh03c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 02 May 2025 02:16:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5422FEsM011525;
 Fri, 2 May 2025 02:16:17 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 468nxkgyvr-17; Fri, 02 May 2025 02:16:17 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH v2 16/20] amd_iommu: Set all address spaces to default
 translation mode on reset
Date: Fri,  2 May 2025 02:16:01 +0000
Message-ID: <20250502021605.1795985-17-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020015
X-Proofpoint-ORIG-GUID: fjv1qYqqMVSyFnzXzWBh8xoGhcFo7GgL
X-Proofpoint-GUID: fjv1qYqqMVSyFnzXzWBh8xoGhcFo7GgL
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68142b01 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=TyYeUvuNVc17vi0sGpoA:9 cc=ntf
 awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDAxNiBTYWx0ZWRfXxG0FeF0zL4FU
 fx532BZ+gDBsSHo8DW7yrQFTy2M7N1Wn3xnaJNNB63ODyorGiS4s9aYyJuMxID68D2kISAhzdIN
 7J1flgttqsvZhDMn8une2x914on6fIuuDrMBwJmCv8SUe7VDezd2Dgokka7tTgFroKDJAkZgESX
 n0uNdjt3OAXqGXYWXGfLwcxU/hVzzgAbJwb5P1VoB4HYx5plAClebNSZLX9ddwjpvwBwPoQqVcg
 sncuss55sygbYx3sU47cq9YrUdJMS5XU4UQGfpPihnekJ9RWoK3NNjBqqgJCAF8Zb5DqsNfsCKl
 exOWHBqiaAMCd6Q5L3zn6Wxwf/Oy2I1KSqJ4EqZqHGb1GA43tochahDmLxDoUkOfFYbLhzGSzWe
 jD2KcOe6w465xJrfriSYWqXDsKesopPcX/TxDs3h4jNbES+TBnqvdsJbnY4thlysZ15vUQTK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On reset, restore the default address translation mode for all the
address spaces managed by the vIOMMU.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 71018d70dd10..90491367594b 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -962,6 +962,33 @@ static void amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
     }
 }
 
+/*
+ * For all existing address spaces managed by the IOMMU, enable/disable the
+ * corresponding memory regions depending on the address translation mode
+ * as determined by the global and individual address space settings.
+ */
+static void amdvi_switch_address_space_all(AMDVIState *s)
+{
+    AMDVIAddressSpace **iommu_as;
+
+    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
+
+        /* Nothing to do if there are no devices on the current bus */
+        if (!s->address_spaces[bus_num]) {
+            continue;
+        }
+        iommu_as = s->address_spaces[bus_num];
+
+        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
+
+            if (!iommu_as[devfn]) {
+                continue;
+            }
+            amdvi_switch_address_space(iommu_as[devfn]);
+        }
+    }
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
@@ -2199,6 +2226,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
 
     /* Discard all mappings on device reset */
     amdvi_address_space_unmap_all(s);
+    amdvi_switch_address_space_all(s);
 }
 
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
-- 
2.43.5


