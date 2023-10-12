Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4F7C6B82
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:51:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtGn-0000vw-Jj; Thu, 12 Oct 2023 06:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGl-0000qi-7m; Thu, 12 Oct 2023 06:50:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGi-0004u5-LP; Thu, 12 Oct 2023 06:50:18 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAijME009613; Thu, 12 Oct 2023 10:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cTHT2FNWIvI1hQjbGLPHQpsJnA3L3DKumiboXVbtsHA=;
 b=lPMwvAB8sATPRHCW3LaAZTEK5lIkmhcEujgynMkhyP0xHpK/WvRW9kWs6/rbIki2Nh4O
 HAnQJzW7wA8rCGVjbnHcdVot4J4zQKPRbVJEW5ujl26T49PRz5OSUKhJVMxORyb8s8K4
 z+wYOeJyvIkm8T7Lx7NpnQuIDtwW2eRLurk3ct1SgceDSCrgMnFyjjjNfERqVkhlsWLX
 vnTbQ43gXaSFvw4gSbTjJrc+oPQP3LuaOU12d5hkWj1eMeKcC5wNqSubkmWEx2A6ES6Q
 0f9Nzj7fnMfaN1wYpyvuIh6XNfzQznRLcvkDeQIyhFT+LO6ofwAwCt4X/MBaPen9mEwo mg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfamg5je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:11 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAimmf010108;
 Thu, 12 Oct 2023 10:50:11 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfamg5j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C8RUUh023021; Thu, 12 Oct 2023 10:50:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1xe6t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAo7TR28508916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D5B22004D;
 Thu, 12 Oct 2023 10:50:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E078A20043;
 Thu, 12 Oct 2023 10:50:04 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:04 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 01/14] spapr: nested: move nested part of spapr_get_pate
 into spapr_nested.c
Date: Thu, 12 Oct 2023 16:19:38 +0530
Message-Id: <20231012104951.194876-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4tl5haDpXMtu79KU9K3_MXnhvcaJk-hX
X-Proofpoint-ORIG-GUID: gMKZYd__Lvqd5UJ56h0HZ4ueCYiE2e8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 hw/ppc/spapr.c                | 28 ++--------------------------
 hw/ppc/spapr_nested.c         | 29 +++++++++++++++++++++++++++++
 include/hw/ppc/spapr_nested.h |  3 ++-
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cb840676d3..a2c69d0f4f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1341,7 +1341,6 @@ void spapr_init_all_lpcrs(target_ulong value, target_ulong mask)
     }
 }
 
-
 static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
@@ -1354,33 +1353,10 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
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
+        return spapr_get_pate_nested(spapr, cpu, lpid, entry);
     }
-
-    return true;
 }
 
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 121aa96ddc..123e127b08 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -6,6 +6,35 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
+#include "mmu-book3s-v3.h"
+
+bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                           target_ulong lpid, ppc_v3_pate_t *entry)
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
 
 #ifdef CONFIG_TCG
 #define PRTS_MASK      0x1f
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index d383486476..e3d15d6d0b 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -98,5 +98,6 @@ struct nested_ppc_state {
 
 void spapr_register_nested(void);
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
-
+bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
+                           target_ulong lpid, ppc_v3_pate_t *entry);
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.39.3


