Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6E7577C8
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgus-000699-Q1; Tue, 18 Jul 2023 05:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguq-000677-Ic; Tue, 18 Jul 2023 05:22:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguo-0000sO-R6; Tue, 18 Jul 2023 05:22:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I96Xx0009313; Tue, 18 Jul 2023 09:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BHkXSX9PtilYoEUAj/9UK3emp2k/dnZlJbEvv1oohqo=;
 b=qLDxOsuUrIP7Rjka8xtrlonyW/SPM6lm6bzHJ+CAetGvEkkEWU3UhF1Ofi9yug/H7YRj
 xDCPeWUxh4FpIHWqHDhAjGaWxyt92kAkyRVN1uu7XoZrBVEQZ1HhHA5t/AHN7goEE60z
 iYvNL4YbSsEb3TF4WJRGM4RW8cD7WCGY0LdBM4F2RrbRql3HwEH2SA379Jn5wu/vOUUq
 B2UlTgrNeYXFZ91xcv51mD4RwTgFWHEI9UXnfWE1BIz7XrcTKaf+PIhz9xPtD4d5uxOU
 jMRHXnIM0bHY8nyLPQMB2U916PiBwWRUknNDhH3G2oCURXDbcovuCgER6yPqXrXkwJqK 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqf4s48x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:39 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I96asO009525;
 Tue, 18 Jul 2023 09:22:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqf4s48j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I4UYWY031116; Tue, 18 Jul 2023 09:22:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jjat9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9MYDn18940604
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 227CD20040;
 Tue, 18 Jul 2023 09:22:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E15C20043;
 Tue, 18 Jul 2023 09:22:32 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 03/15] ppc: spapr: Use SpaprMachineStateNested's ptcr instead
 of nested_ptcr
Date: Tue, 18 Jul 2023 14:52:09 +0530
Message-Id: <20230718092221.1053686-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nc_f-0epYv9q2m3YUzClf3pXNdq49hQx
X-Proofpoint-ORIG-GUID: 5KxN1Ipr-utd-M03tNj6zP-Q6zrZd6jV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=711
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

Use nested guest state specific struct for storing related info.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c         | 4 ++--
 hw/ppc/spapr_nested.c  | 4 ++--
 include/hw/ppc/spapr.h | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c8b8d57a7..1e5325a429 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1340,8 +1340,8 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
 
         assert(lpid != 0);
 
-        patb = spapr->nested_ptcr & PTCR_PATB;
-        pats = spapr->nested_ptcr & PTCR_PATS;
+        patb = spapr->nested.ptcr & PTCR_PATB;
+        pats = spapr->nested.ptcr & PTCR_PATS;
 
         /* Check if partition table is properly aligned */
         if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 121aa96ddc..a669470f1a 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -25,7 +25,7 @@ static target_ulong h_set_ptbl(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    spapr->nested_ptcr = ptcr; /* Save new partition table */
+    spapr->nested.ptcr = ptcr; /* Save new partition table */
 
     return H_SUCCESS;
 }
@@ -157,7 +157,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
-    if (spapr->nested_ptcr == 0) {
+    if (spapr->nested.ptcr == 0) {
         return H_NOT_AVAILABLE;
     }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3990fed1d9..c8b42af430 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -12,6 +12,7 @@
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
 #include "hw/ppc/spapr_tpm_proxy.h"
+#include "hw/ppc/spapr_nested.h" /* for SpaprMachineStateNested */
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -216,7 +217,7 @@ struct SpaprMachineState {
     uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
 
     /* Nested HV support (TCG only) */
-    uint64_t nested_ptcr;
+    struct SpaprMachineStateNested nested;
 
     Notifier epow_notifier;
     QTAILQ_HEAD(, SpaprEventLogEntry) pending_events;
-- 
2.39.3


