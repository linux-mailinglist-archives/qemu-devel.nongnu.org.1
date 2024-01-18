Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA4C831260
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:27:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKuC-0006Qr-9T; Thu, 18 Jan 2024 00:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtr-0006IY-5D; Thu, 18 Jan 2024 00:25:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtp-0006Yr-Ck; Thu, 18 Jan 2024 00:25:10 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I41k85023710; Thu, 18 Jan 2024 05:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fAkrmGFcRyCfiA4GUYgppCJ5SKZIKUEc4xLB43Ulqq8=;
 b=MC6JPT0TUemOzSQCOA+HqVYpuxVEe/jZGScorZQ6+rbkPRyXq8CzyNEc9xjBLweJM8BV
 UW/k9zFrX3jNGBgt8vt+Sg03N61Adtr72go5cyBRgI8eP4AXhykd5B5j8E3J7s3xrY6D
 id2U/pTJUB6+ZCKu0Qnxe1ib3fmodyKvEfAybFsp9Zlca/cc5erSipfagL4TammwbwBO
 KBr+CuZr8m/2GgxtPMLb0ZGYmmuJR4599X5gGov1uEZyf1M9S6ovRE2T4OOw6LylQkUs
 qtFjDK/vk8rZQmuucgvqAfKWlwKnRxlXCQ+lvvtubOoqzxsT8ecZFfZdXDeE3DdMsosv PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vptjckqyu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:04 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5Jl6Z004106;
 Thu, 18 Jan 2024 05:25:04 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vptjckqyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3G4Na006513; Thu, 18 Jan 2024 05:25:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j210jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5P0FY63766890
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:25:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 388F82004D;
 Thu, 18 Jan 2024 05:25:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 988ED20040;
 Thu, 18 Jan 2024 05:24:58 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:24:58 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 04/15] spapr: nested: keep nested-hv related code
 restricted to its API.
Date: Thu, 18 Jan 2024 10:54:27 +0530
Message-Id: <20240118052438.1475437-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118052438.1475437-1-harshpb@linux.ibm.com>
References: <20240118052438.1475437-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f2YtoCy4NW_Cf6KiFlqoiNmYxn3m7CVn
X-Proofpoint-GUID: aDzNVP9R-5EKo13u8eqcgTgYNbN4NPMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=780 mlxscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401180035
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

spapr_exit_nested and spapr_get_pate_nested_hv contains code which
is specific to nested-hv API. Isolating code flows based on API
helps extending it to be used with different API as well.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Suggested-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/spapr_nested.h |  4 ++++
 hw/ppc/spapr.c                |  7 ++++++-
 hw/ppc/spapr_caps.c           |  1 +
 hw/ppc/spapr_nested.c         | 27 ++++++++++++++++++++++++---
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index e9c11111dd..28a102c273 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -6,6 +6,8 @@
 
 typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
+    uint8_t api;
+#define NESTED_API_KVM_HV  1
 } SpaprMachineStateNested;
 
 /*
@@ -104,4 +106,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
                               target_ulong lpid, ppc_v3_pate_t *entry);
+void spapr_nested_init(SpaprMachineState *spapr);
+uint8_t spapr_nested_api(SpaprMachineState *spapr);
 #endif /* HW_SPAPR_NESTED_H */
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9e2a42dd2d..367beb5255 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1376,7 +1376,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         entry->dw1 = spapr->patb_entry;
         return true;
     } else {
-        return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        assert(spapr_nested_api(spapr));
+        if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+            return spapr_get_pate_nested_hv(spapr, cpu, lpid, entry);
+        }
+        return false;
     }
 }
 
@@ -3451,6 +3455,7 @@ static void spapr_instance_init(Object *obj)
         spapr_get_host_serial, spapr_set_host_serial);
     object_property_set_description(obj, "host-serial",
         "Host serial number to advertise in guest device tree");
+    spapr_nested_init(spapr);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index d615be1117..c3c83f6e68 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -487,6 +487,7 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
             error_append_hint(errp, "Try appending -machine cap-nested-hv=off "
                                     "or use threads=1 with -smp\n");
         }
+    spapr->nested.api = NESTED_API_KVM_HV;
     spapr_register_nested_hv();
     }
 }
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index a41f1af839..afadd5b22d 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -8,6 +8,16 @@
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
 
+void spapr_nested_init(SpaprMachineState *spapr)
+{
+    spapr->nested.api = 0;
+}
+
+uint8_t spapr_nested_api(SpaprMachineState *spapr)
+{
+    return spapr->nested.api;
+}
+
 #ifdef CONFIG_TCG
 
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
@@ -302,7 +312,7 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
     return env->gpr[3];
 }
 
-void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+static void spapr_exit_nested_hv(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
@@ -314,8 +324,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     struct kvmppc_pt_regs *regs;
     hwaddr len;
 
-    assert(spapr_cpu->in_nested);
-
     nested_save_state(&l2_state, cpu);
     hsrr0 = env->spr[SPR_HSRR0];
     hsrr1 = env->spr[SPR_HSRR1];
@@ -405,6 +413,19 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
+void spapr_exit_nested(PowerPCCPU *cpu, int excp)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
+
+    assert(spapr_cpu->in_nested);
+    if (spapr_nested_api(spapr) == NESTED_API_KVM_HV) {
+        spapr_exit_nested_hv(cpu, excp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
-- 
2.39.3


