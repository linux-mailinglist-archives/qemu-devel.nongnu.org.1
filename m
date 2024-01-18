Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C5A83125C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:27:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKtz-0006J9-R4; Thu, 18 Jan 2024 00:25:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtn-0006Hu-Hl; Thu, 18 Jan 2024 00:25:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtl-0006Tw-BH; Thu, 18 Jan 2024 00:25:07 -0500
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I476UN031367; Thu, 18 Jan 2024 05:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WT/iFehkVWZA4MvCKi9fT2bCJGVzYXPa0bzPhbsKZE4=;
 b=F8Qp7Zd2kS2K0qiQuWfRoQZBlWTc2Gjy2g27HkKE8jreswMO0kuezCUdKWin8uFY5h0a
 diERE2KWytM5YiNe23DNMt71hhUiH4dL/S+Z+rsO6xWEAdkU3N/vuYVPGHinfGFr0ixB
 T0X+JzD3cfJmt1ZHdlP6TVrlW5LRmQ9dOLPNgmx0dYs6cuK5xlGg7Y6WizJkpAPUwQ4Z
 VOm75Vujf9I0MYRMbdukJaOpa+JtNSQG4RlAE1Kl8pbiOPF2fo3DZHSK6T6QIAwdpNag
 6O51Twly6niUNBRWRyoPw/rGdvMfuLSgf0EhGDu/EsxXQhV7TTW7bDCdR3ocPBrqNyq5 NA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp4sdkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:00 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5KYUF028913;
 Thu, 18 Jan 2024 05:25:00 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpvp4sdk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3UJqZ000561; Thu, 18 Jan 2024 05:24:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm4ut1pxj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:24:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5OuiK41353622
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:24:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EBDC20043;
 Thu, 18 Jan 2024 05:24:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE0CA20040;
 Thu, 18 Jan 2024 05:24:54 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:24:54 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 02/15] spapr: nested: move nested part of spapr_get_pate
 into spapr_nested.c
Date: Thu, 18 Jan 2024 10:54:25 +0530
Message-Id: <20240118052438.1475437-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118052438.1475437-1-harshpb@linux.ibm.com>
References: <20240118052438.1475437-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cLLQ455IQ1fh2k3e59okUsEEKDfTXbPC
X-Proofpoint-ORIG-GUID: Xcxh7kK7nLJgNDKQGOoDU8zAsdUuoy_-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180035
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Most of the nested code has already been moved to spapr_nested.c
This logic inside spapr_get_pate is related to nested guests and
better suited for spapr_nested.c, hence moving there.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr_nested.h |  3 ++-
 hw/ppc/spapr.c                | 28 ++-------------------------
 hw/ppc/spapr_nested.c         | 36 +++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 41894b24e5..cc199a05a7 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -97,5 +97,6 @@ struct nested_ppc_state {
 };
 
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
-
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e8dabc8614..9e2a42dd2d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1362,7 +1362,6 @@ void spapr_init_all_lpcrs(target_ulong value, target_ulong mask)
     }
 }
 
-
 static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
@@ -1375,33 +1374,10 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         /* Copy PATE1:GR into PATE0:HR */
         entry->dw0 = spapr->patb_entry & PATE0_HR;
         entry->dw1 = spapr->patb_entry;
-
+        return true;
     } else {
-        uint64_t patb, pats;
-
-        assert(lpid != 0);
-
-        patb = spapr->nested_ptcr & PTCR_PATB;
-        pats = spapr->nested_ptcr & PTCR_PATS;
-
-        /* Check if partition table is properly aligned */
-        if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
-            return false;
-        }
-
-        /* Calculate number of entries */
-        pats = 1ull << (pats + 12 - 4);
-        if (pats <= lpid) {
-            return false;
-        }
-
-        /* Grab entry */
-        patb += 16 * lpid;
-        entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
-        entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
     }
-
-    return true;
 }
 
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 556d52ddd1..401b52833f 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -6,8 +6,38 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
+#include "mmu-book3s-v3.h"
 
 #ifdef CONFIG_TCG
+
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    uint64_t patb, pats;
+
+    assert(lpid != 0);
+
+    patb = spapr->nested_ptcr & PTCR_PATB;
+    pats = spapr->nested_ptcr & PTCR_PATS;
+
+    /* Check if partition table is properly aligned */
+    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
+        return false;
+    }
+
+    /* Calculate number of entries */
+    pats = 1ull << (pats + 12 - 4);
+    if (pats <= lpid) {
+        return false;
+    }
+
+    /* Grab entry */
+    patb += 16 * lpid;
+    entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
+    entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+    return true;
+}
+
 #define PRTS_MASK      0x1f
 
 static target_ulong h_set_ptbl(PowerPCCPU *cpu,
@@ -392,4 +422,10 @@ void spapr_register_nested_hv(void)
 {
     /* DO NOTHING */
 }
+
+bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                              target_ulong lpid, ppc_v3_pate_t *entry)
+{
+    return false;
+}
 #endif
-- 
2.39.3


