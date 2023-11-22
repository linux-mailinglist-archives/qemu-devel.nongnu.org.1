Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1217F41A1
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:29:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jXr-0003De-B5; Wed, 22 Nov 2023 04:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jXk-0003CU-Dk; Wed, 22 Nov 2023 04:29:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jXi-0006OM-3K; Wed, 22 Nov 2023 04:29:12 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM8Lm7c031370; Wed, 22 Nov 2023 09:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=En1cxgX7rVxZTjsOqoaez45g+2FmPhwDw9LvApSnbcc=;
 b=AOzYpvcOvUn05xbjVl3oajiLe9ghmvzdLsf6XgCu2KM6onk1nb7cj3eGq/lEdFuY9jxv
 KRz0zpXYSpeDFtlTofEL09MjrAIF/edi9qO046RsFyIln9Wofuc1RWsAuul5so46idFW
 1WQkBZhqvlIyj/3VfQpH4lKP67yylqOcQX1d+c0nOoJPrG2lraL6xpRDcfnQ0qMM0gKl
 LAXkb49MW0fELDguZUbBwq4qpdrnCBWQEfoJ5BvL240RpGmUDcKquw56/7D5wPFO4wdK
 Lr6ed9FBxXh0XuekzFYJT1BHl9oFqu7P01y498RaTs6AZb6Pi0cyKppBzYaS9z5xmAma FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdbrbef6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:29:02 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM9I9iX029449;
 Wed, 22 Nov 2023 09:29:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdbrbeeq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:29:02 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM7Cr8L032683; Wed, 22 Nov 2023 09:29:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knxwmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:29:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AM9SxPK6095580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Nov 2023 09:28:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 698EA20043;
 Wed, 22 Nov 2023 09:28:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5790720040;
 Wed, 22 Nov 2023 09:28:57 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.43.17.116]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Nov 2023 09:28:57 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, harshpb@linux.ibm.com
Subject: [PATCH v2 2/2] ppc/spapr: Initialize max_cpus limit to SPAPR_NR_IPIS.
Date: Wed, 22 Nov 2023 14:58:45 +0530
Message-Id: <20231122092845.973949-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231122092845.973949-1-harshpb@linux.ibm.com>
References: <20231122092845.973949-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xCG_alhmbSiDwZaUVdLl4lN-yv_bjpWX
X-Proofpoint-ORIG-GUID: Kx6b1aSW2Gv4bqaAjfxwDCMKXkrdali2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Initialize the machine specific max_cpus limit as per the maximum range
of CPU IPIs available. Keeping between 4096 to 8192 will throw IRQ not
free error due to XIVE/XICS limitation and keeping beyond 8192 will hit
assert in tcg_region_init or spapr_xive_claim_irq.

Logs:

Without patch fix:

[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
qemu-system-ppc64: IRQ 4096 is not free
[root@host build]#

On LPAR:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
**
ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
(region_size >= 2 * page_size)
Bail out! ERROR:../tcg/region.c:774:tcg_region_init: assertion failed:
(region_size >= 2 * page_size)
Aborted (core dumped)
[root@host build]#

On x86:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=8193
qemu-system-ppc64: ../hw/intc/spapr_xive.c:596: spapr_xive_claim_irq:
Assertion `lisn < xive->nr_irqs' failed.
Aborted (core dumped)
[root@host build]#

With patch fix:
[root@host build]# qemu-system-ppc64 -accel tcg -smp 10,maxcpus=4097
qemu-system-ppc64: Invalid SMP CPUs 4097. The max CPUs supported by
machine 'pseries-8.2' is 4096
[root@host build]#

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index df09aa9d6a..0de11a4458 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4647,13 +4647,10 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
 
     /*
-     * Setting max_cpus to INT32_MAX. Both KVM and TCG max_cpus values
-     * should be limited by the host capability instead of hardcoded.
-     * max_cpus for KVM guests will be checked in kvm_init(), and TCG
-     * guests are welcome to have as many CPUs as the host are capable
-     * of emulate.
+     * While KVM determines max cpus in kvm_init() using kvm_max_vcpus(),
+     * In TCG the limit is restricted by the range of CPU IPIs available.
      */
-    mc->max_cpus = INT32_MAX;
+    mc->max_cpus = SPAPR_NR_IPIS;
 
     mc->no_parallel = 1;
     mc->default_boot_order = "";
-- 
2.39.3


