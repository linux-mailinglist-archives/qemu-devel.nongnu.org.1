Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329617C6B8B
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHU-0001bm-HP; Thu, 12 Oct 2023 06:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtHA-0001AD-9O; Thu, 12 Oct 2023 06:50:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtH6-00054p-Nx; Thu, 12 Oct 2023 06:50:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAiPAk016058; Thu, 12 Oct 2023 10:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ARIQyAF8NpS8BAi37fwC24fqGn0rdJD+FP2FkvwFLvY=;
 b=sas4Zz1JB1pjxMFXBSUzn84qgrooe9v8GSvj1oGgv3ew7mgykLB3ZsCoc+80vsgewgwU
 gK7+yBSj3S9IpQC4xyBH8gQzL1EdvM1NX3vyiCVEo+mnG8j8ckt5XFbGu3BA52F+cETz
 AAr3mAcx3POO90ZOFsNbZBO+ehFhTz30YSil7oBmA0RtsNw6FxuviGpSHqdUehZuQwao
 xzzNnAO2GZIsk4qI/y7LJyc8fTgtpGQ7JqDAEPMIV79cEW/dfEslqptxxO6vdFYoj0nN
 4jw33OOazIBbMA6R0YSGTols3aTo4iAPZitK7kKvxuusQnuDDOxH5egmTBNLwjngqm2w Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaf865k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:35 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAircJ018790;
 Thu, 12 Oct 2023 10:50:35 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaf8657-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C7oZ9M001239; Thu, 12 Oct 2023 10:50:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk6h49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoVNj44958354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E8112004B;
 Thu, 12 Oct 2023 10:50:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6057820040;
 Thu, 12 Oct 2023 10:50:29 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:29 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 11/14] spapr: nested: Use correct source for parttbl info
 for nested PAPR API.
Date: Thu, 12 Oct 2023 16:19:48 +0530
Message-Id: <20231012104951.194876-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dPdcspeo-MwUgYODCWRTis94P9tE7af1
X-Proofpoint-ORIG-GUID: k72UAoq1osz0gsRog7W6J0VUAJugF7qE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=956
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
partition table info, use the same in spapr_get_pate_nested() as well.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c                |  5 +---
 hw/ppc/spapr_nested.c         | 49 +++++++++++++++++++++++------------
 include/hw/ppc/spapr_nested.h |  3 +++
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 14196fdd11..e1f7b29842 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1356,10 +1356,7 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         return true;
     } else {
         assert(spapr->nested.api);
-        if (spapr->nested.api == NESTED_API_KVM_HV) {
-            return spapr_get_pate_nested(spapr, cpu, lpid, entry);
-        }
-        return false;
+        return spapr_get_pate_nested(spapr, cpu, lpid, entry);
     }
 }
 
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index f41b0c0944..1917d8bb13 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -19,29 +19,45 @@ void spapr_nested_init(SpaprMachineState *spapr)
 bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
-    uint64_t patb, pats;
+    if (spapr->nested.api == NESTED_API_KVM_HV) {
+        uint64_t patb, pats;
 
-    assert(lpid != 0);
+        assert(lpid != 0);
 
-    patb = spapr->nested.ptcr & PTCR_PATB;
-    pats = spapr->nested.ptcr & PTCR_PATS;
+        patb = spapr->nested.ptcr & PTCR_PATB;
+        pats = spapr->nested.ptcr & PTCR_PATS;
 
-    /* Check if partition table is properly aligned */
-    if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
-        return false;
-    }
+        /* Check if partition table is properly aligned */
+        if (patb & MAKE_64BIT_MASK(0, pats + 12)) {
+            return false;
+        }
 
-    /* Calculate number of entries */
-    pats = 1ull << (pats + 12 - 4);
-    if (pats <= lpid) {
-        return false;
+        /* Calculate number of entries */
+        pats = 1ull << (pats + 12 - 4);
+        if (pats <= lpid) {
+            return false;
+        }
+
+        /* Grab entry */
+        patb += 16 * lpid;
+        entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
+        entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+        return true;
     }
+#ifdef CONFIG_TCG
+    /* Nested PAPR API */
+    SpaprMachineStateNestedGuest *guest;
+    assert(lpid != 0);
+    guest = spapr_get_nested_guest(spapr, lpid);
+    assert(guest != NULL);
+
+    entry->dw0 = guest->parttbl[0];
+    entry->dw1 = guest->parttbl[1];
 
-    /* Grab entry */
-    patb += 16 * lpid;
-    entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
-    entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
     return true;
+#else
+    return false;
+#endif
 }
 
 #ifdef CONFIG_TCG
@@ -412,7 +428,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
-static
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong guestid)
 {
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index d27688b1b8..e04202ecb4 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -457,4 +457,7 @@ bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
 void spapr_register_nested_papr(void);
 void spapr_nested_init(SpaprMachineState *spapr);
 void spapr_nested_gsb_init(void);
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong lpid);
+
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.39.3


