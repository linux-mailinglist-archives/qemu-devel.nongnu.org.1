Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFFADD276
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Jun 2025 17:42:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYJ8-0002hQ-Qr; Tue, 17 Jun 2025 11:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRYI8-0001BQ-SQ
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:32:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uRXrZ-0006sL-Na
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:04:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55HEWwa9003868;
 Tue, 17 Jun 2025 15:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Qd9ck
 DpIfzkSXuwON6JL4VOurKp58Q4gTqJb6IkYUVk=; b=kQN/OEKN3y/cibA07WucM
 thDgENgc1sQwyDorgoXMtr6TKIbso362CVZsiF9e9HH6yCHiYAdTzu5dXFk7X0/7
 nhr9mq0vDNbW8QMePL5OAGu6rMUm7A7YCRDOHFJOgNrNB1wMF2irmsNsK6Tmmpa4
 +ctoksftRKHrJuthlNvwN9te1lcrlYDGQzH4bObtuJJo4rr4NonZLfBwHM43BAWh
 PK3k/M8qVUyuaRCAgNv6BiFHPCayYLIK8QjtGe2VzD53N9gGsCmWgcpOrHCoZVEi
 8niMMf5p9s0XLC8A723JRrfAor3Db8wUNKB8S3c0WF53bn50AV5N4XLfBq9d6YJ/
 Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yv55eya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55HEFnN2000824; Tue, 17 Jun 2025 15:04:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yh9bxrk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Jun 2025 15:04:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55HF4Svb014869;
 Tue, 17 Jun 2025 15:04:29 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 478yh9bxny-3; Tue, 17 Jun 2025 15:04:29 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: ethan.milon@eviden.com, mst@redhat.com, pbonzini@redhat.com,
 mjt@tls.msk.ru, marcel.apfelbaum@gmail.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, sarunkod@amd.com, brijesh.singh@amd.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
 alejandro.j.jimenez@oracle.com, philmd@linaro.org
Subject: [PATCH v4 2/8] amd_iommu: Fix Device ID decoding for
 INVALIDATE_IOTLB_PAGES command
Date: Tue, 17 Jun 2025 15:04:21 +0000
Message-ID: <20250617150427.20585-3-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
References: <20250617150427.20585-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_06,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDExOCBTYWx0ZWRfX0UJjT1+9fASP
 KXWmrJEtB+qSqvWSblfFNSO93cH0lj7KzI2DNEItGfS7a6TEu52UrO1qSY89JcItG2Fs2Xh+Krh
 Vm0+Wpu0E0b8Pv7PazrBre7EbDk23HKLUJ2voxEcledoQ1XYemvEfcd14r+g6hOiPuJAmQa0bSV
 cH0iT0CkRsPk4/rnXA/gRlk94gWvyCR8uIulQnnDVzegdVF1TFQ0ILFEK068DwmAPP9FSZ0ldRi
 OTqaArtMzxpV+6C2tcuTpB5qF+ZJ/WiNY2G5+ga+MYQPjEVqHwHiN+hMwCHpJMF3xPFSmIJxNEB
 XwHY82UrJqScCHk3LwrzJyjjky1GcYzDsaVNWYqEjJ2NIk8C6Fc8ZfJGNXHQhO442tXYJAZ8vOa
 B/2BdW/8UpnBlxbSS2ehDvAey8C+kuFqcwSKOH9aH+EfQwQYxq8VdYaGFBs0LN98GHhB7O8b
X-Proofpoint-GUID: dxIiQUF7QYvFYKdmEryGF2p4zBU6QoO4
X-Proofpoint-ORIG-GUID: dxIiQUF7QYvFYKdmEryGF2p4zBU6QoO4
X-Authority-Analysis: v=2.4 cv=W9c4VQWk c=1 sm=1 tr=0 ts=685183fe b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6IFa9wvqVegA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=r9zmrm_j51NoiylAmAIA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The DeviceID bits are extracted using an incorrect offset in the call to
amdvi_iotlb_remove_page(). This field is read (correctly) earlier, so use
the value already retrieved for devid.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 963aa2450c997..c27efa504d19a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -508,7 +508,7 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
-    uint16_t devid = extract64(cmd[0], 0, 16);
+    uint16_t devid = cpu_to_le16(extract64(cmd[0], 0, 16));
     if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -521,7 +521,7 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
                                     &devid);
     } else {
         amdvi_iotlb_remove_page(s, cpu_to_le64(extract64(cmd[1], 12, 52)) << 12,
-                                cpu_to_le16(extract64(cmd[1], 0, 16)));
+                                devid);
     }
     trace_amdvi_iotlb_inval();
 }
-- 
2.43.5


