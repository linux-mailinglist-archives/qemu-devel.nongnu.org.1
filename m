Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C064AC82C3
	for <lists+qemu-devel@lfdr.de>; Thu, 29 May 2025 21:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKiyb-0002RY-A2; Thu, 29 May 2025 15:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixZ-0001O6-U8
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uKixX-0001Fe-O0
 for qemu-devel@nongnu.org; Thu, 29 May 2025 15:30:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfu4m028838;
 Thu, 29 May 2025 19:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=5xLy6
 sphNSR3sEGiWhHFRd/mLRl+6eUEjK379NlJVlg=; b=AJLgcz2w7JVpyzETXNbpm
 0GlI1F3J2Jc4t8MDPY61fQrS38Q9OkfyFT/g+ZmQ15T4/asVCTw8GDI/8YPLMOkD
 eqW/XoC/5h68G8lPfoiYaMi6HSfQoAEVmaxHTIp5TqJfcp/I8BdP4MTmRScTEBAm
 0B3U3d3wABAwXDN5zuNII/3O69WwVIT7M4DBehkGEmPb1vLDLvRm1fzjFpFvMvHc
 o7G7YtCYSCpTqldTRDP1BGnMqBPKPEp+b+vUil1VUmn4a+GDKGwW13UIjfoVfUz5
 k0H21TOS/kah6oQLNhk0E4WquOhV7I0m+m4RSzS6atztIR2uKsv6MzJ0VkN8YqPS
 w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd8r7r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54TJJgDc019337; Thu, 29 May 2025 19:30:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jccs2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 May 2025 19:30:28 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54TJUOVH005039;
 Thu, 29 May 2025 19:30:28 GMT
Received: from alaljimee5bm-ol9-20250405.osdevelopmeniad.oraclevcn.com
 (alaljimee5bm-ol9-20250405.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.254.235])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jccrx6-7; Thu, 29 May 2025 19:30:28 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, brijesh.singh@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH v3 6/7] amd_iommu: Fix the calculation for Device Table size
Date: Thu, 29 May 2025 19:30:22 +0000
Message-ID: <20250529193023.3590780-7-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
References: <20250529193023.3590780-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_09,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290190
X-Proofpoint-ORIG-GUID: LD870zN0inw0ZUvunVaxtghFihNT_arI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE5MCBTYWx0ZWRfX3/gyrY3ewfBD
 TvQ++4HBUr4TX9t4keEXWNLSirJF99bVjQ7cbfFfdrG/f5j/e+q98fVA+Ulc2VRzT7GCnMBaySr
 rrCoDEeLhF5OkKyE1XX8OheBCaR6mwteQEHV/Hzf0ztQdc2gnL7dlMfhh4kRfbFYX6BJ+gwmZtu
 BYtgNqMTCab0QfhLB1iNZEuxQQn2TZ8dOpBFZhgOkBtQzphAqt+SgtFVS8pmgNDvRoak3Y4Z2ew
 v8g1xlFqE2UeKOUf6g+PdVdfU48FXIrly+fQHvMBSPNR0c/FyfCHxz4DT2qWc00CJov3vdck2Ob
 yICacIswhzjwI6PqoqemfET1W7Q3X6Zh0insh498+bNM0Y8yLGk7WVTP1ol9aGz6/Zp17B7mywz
 2UNTvqJyu7niB2venTvNu3xyW9MmmJylAWca8JMndUimsGmNP/e9ASPnid2+6Lz3/ONuGNBl
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=6838b5d6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=dt9VzEwgFbYA:10 a=69wJf7TsAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
 a=r9zmrm_j51NoiylAmAIA:9
 a=Fg1AiH1G6rFz08G2ETeA:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: LD870zN0inw0ZUvunVaxtghFihNT_arI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.499,
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

Correctly calculate the Device Table size using the format encoded in the
Device Table Base Address Register (MMIO Offset 0000h).

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index cc47ba9249990..6a68f0f6068a0 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -665,8 +665,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
     uint64_t val = amdvi_readq(s, AMDVI_MMIO_DEVICE_TABLE);
     s->devtab = (val & AMDVI_MMIO_DEVTAB_BASE_MASK);
 
-    /* set device table length */
-    s->devtab_len = ((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1 *
+    /* set device table length (i.e. number of entries table can hold) */
+    s->devtab_len = (((val & AMDVI_MMIO_DEVTAB_SIZE_MASK) + 1) *
                     (AMDVI_MMIO_DEVTAB_SIZE_UNIT /
                      AMDVI_MMIO_DEVTAB_ENTRY_SIZE));
 }
-- 
2.43.5


