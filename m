Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A275D7C6B84
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHC-00017H-Hx; Thu, 12 Oct 2023 06:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGx-00011d-0y; Thu, 12 Oct 2023 06:50:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGo-0004vt-VZ; Thu, 12 Oct 2023 06:50:30 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAjLuZ013166; Thu, 12 Oct 2023 10:50:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=mNjJpcRHIHGTe2ZJopyLKSWZdPl04I1xb+ySHwxusgs=;
 b=RC5zq9+ocJ8CaYF6JdGycyPixifG1j4x6IVienl/jh041+UytN320n2pKuv14zsBJHIz
 quDMhQFdovGQReGxAp6MfwnZfiNXoyuQ2Bst3G0iL1EETRNWm+QCilTWq9orSrGGDmi9
 wkFZ8bg6Mdc7Ir5OAvTJl4UxnWnLlPpQqKqrbJooDecDi+LE4j3DQcFFREt+acXZbh7l
 PdJHSxm51QSPuCpxcO2hzGo+FP8qdz++3FyymUiu+jfqEk/BOrcYZRiYeMOap61FPaT0
 zzdb+CeN3JQBmlE33A63a7cIuTfIS9zhdb0fAINYgt7NyiiFZW1FR1K1XULpzW6sPEDj aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaqr4t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:18 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAjNjP013252;
 Thu, 12 Oct 2023 10:50:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaqr4sr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C9mj6E025883; Thu, 12 Oct 2023 10:50:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnpx7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoEbo10814156
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EC2420043;
 Thu, 12 Oct 2023 10:50:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8A4C620040;
 Thu, 12 Oct 2023 10:50:12 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:12 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 04/14] spapr: nested: Introduce cap-nested-papr for Nested
 PAPR API
Date: Thu, 12 Oct 2023 16:19:41 +0530
Message-Id: <20231012104951.194876-5-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B3Dd4VHWoA17yKT2p2Ho-lhWAPzof1B8
X-Proofpoint-GUID: -mkAPq3HK8uuYqT4VPdLk2anLpT9axfO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Introduce a SPAPR capability cap-nested-papr which provides a nested
HV facility to the guest. This is similar to cap-nested-hv, but uses
a different (incompatible) API and so they are mutually exclusive.
This new API is to enable support for KVM on PowerVM and recently the
Linux kernel side patches have been accepted upstream as well [1].
Support for related hcalls is being added in next set of patches.

[1]
https://lore.kernel.org/linuxppc-dev/169528846875.874757.8861595746180557787.b4-ty@ellerman.id.au/

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c                |  9 +++++-
 hw/ppc/spapr_caps.c           | 61 +++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_nested.c         | 15 +++++++++
 include/hw/ppc/spapr.h        |  5 ++-
 include/hw/ppc/spapr_nested.h |  5 +++
 5 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a2c69d0f4f..14196fdd11 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1355,7 +1355,11 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         entry->dw1 = spapr->patb_entry;
         return true;
     } else {
-        return spapr_get_pate_nested(spapr, cpu, lpid, entry);
+        assert(spapr->nested.api);
+        if (spapr->nested.api == NESTED_API_KVM_HV) {
+            return spapr_get_pate_nested(spapr, cpu, lpid, entry);
+        }
+        return false;
     }
 }
 
@@ -2093,6 +2097,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_fwnmi,
         &vmstate_spapr_fwnmi,
         &vmstate_spapr_cap_rpt_invalidate,
+        &vmstate_spapr_cap_nested_papr,
         NULL
     }
 };
@@ -3437,6 +3442,7 @@ static void spapr_instance_init(Object *obj)
         spapr_get_host_serial, spapr_set_host_serial);
     object_property_set_description(obj, "host-serial",
         "Host serial number to advertise in guest device tree");
+    spapr_nested_init(spapr);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
@@ -4675,6 +4681,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_WORKAROUND;
     smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] = 16; /* 64kiB */
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_NESTED_PAPR] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 5a0755d34f..9b53f19ec8 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -454,6 +454,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
         return;
     }
 
+    if (!spapr->nested.api) {
+        spapr->nested.api = NESTED_API_KVM_HV;
+    } else {
+        error_setg(errp, "Nested-HV APIs are mutually exclusive/incompatible");
+        error_append_hint(errp, "Please use either cap-nested-hv or "
+                                 "cap-nested-papr to proceed.\n");
+        return;
+    }
     if (kvm_enabled()) {
         if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
                               spapr->max_compat_pvr)) {
@@ -490,6 +498,49 @@ static void cap_nested_kvm_hv_apply(SpaprMachineState *spapr,
     }
 }
 
+static void cap_nested_papr_apply(SpaprMachineState *spapr,
+                                    uint8_t val, Error **errp)
+{
+    ERRP_GUARD();
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUPPCState *env = &cpu->env;
+
+    if (!val) {
+        /* capability disabled by default */
+        return;
+    }
+
+    if (!spapr->nested.api) {
+        spapr->nested.api = NESTED_API_PAPR;
+        spapr_register_nested_papr();
+    } else {
+        error_setg(errp, "Nested-HV APIs are mutually exclusive/incompatible");
+        error_append_hint(errp, "Please use either cap-nested-hv or "
+                                 "cap-nested-papr to proceed.\n");
+        return;
+    }
+
+    if (tcg_enabled()) {
+        if (!(env->insns_flags2 & PPC2_ISA300)) {
+            error_setg(errp, "Nested-PAPR only supported on POWER9 and later");
+            error_append_hint(errp,
+                              "Try appending -machine cap-nested-papr=off\n");
+            return;
+        }
+    } else if (kvm_enabled()) {
+        /*
+         * this gets executed in L1 qemu when L2 is launched,
+         * needs kvm-hv support in L1 kernel.
+         */
+        if (!kvmppc_has_cap_nested_kvm_hv()) {
+            error_setg(errp,
+                       "KVM implementation does not support Nested-HV");
+        } else if (kvmppc_set_cap_nested_kvm_hv(val) < 0) {
+            error_setg(errp, "Error enabling Nested-HV with KVM");
+        }
+    }
+}
+
 static void cap_large_decr_apply(SpaprMachineState *spapr,
                                  uint8_t val, Error **errp)
 {
@@ -735,6 +786,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_nested_kvm_hv_apply,
     },
+    [SPAPR_CAP_NESTED_PAPR] = {
+        .name = "nested-papr",
+        .description = "Allow Nested HV (PAPR API)",
+        .index = SPAPR_CAP_NESTED_PAPR,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_nested_papr_apply,
+    },
     [SPAPR_CAP_LARGE_DECREMENTER] = {
         .name = "large-decr",
         .description = "Allow Large Decrementer",
@@ -919,6 +979,7 @@ SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
 SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
 SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
+SPAPR_CAP_MIG_STATE(nested_papr, SPAPR_CAP_NESTED_PAPR);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
 SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index db47c1196f..87a0db22a5 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -8,6 +8,11 @@
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
 
+void spapr_nested_init(SpaprMachineState *spapr)
+{
+    spapr->nested.api = 0;
+}
+
 bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry)
 {
@@ -411,6 +416,11 @@ void spapr_register_nested(void)
     spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
     spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
 }
+
+void spapr_register_nested_papr(void)
+{
+    /* register hcalls here */
+}
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
@@ -421,4 +431,9 @@ void spapr_register_nested(void)
 {
     /* DO NOTHING */
 }
+
+void spapr_register_nested_papr(void)
+{
+    /* DO NOTHING */
+}
 #endif
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3e825f2787..e33ee87ba4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -81,8 +81,10 @@ typedef enum {
 #define SPAPR_CAP_RPT_INVALIDATE        0x0B
 /* Support for AIL modes */
 #define SPAPR_CAP_AIL_MODE_3            0x0C
+/* Nested PAPR */
+#define SPAPR_CAP_NESTED_PAPR           0x0D
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_NESTED_PAPR + 1)
 
 /*
  * Capability Values
@@ -982,6 +984,7 @@ extern const VMStateDescription vmstate_spapr_cap_sbbc;
 extern const VMStateDescription vmstate_spapr_cap_ibs;
 extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
 extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
+extern const VMStateDescription vmstate_spapr_cap_nested_papr;
 extern const VMStateDescription vmstate_spapr_cap_large_decr;
 extern const VMStateDescription vmstate_spapr_cap_ccf_assist;
 extern const VMStateDescription vmstate_spapr_cap_fwnmi;
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 0722b999cd..efdfc78200 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -6,6 +6,9 @@
 
 typedef struct SpaprMachineStateNested {
     uint64_t ptcr;
+    uint8_t api;
+#define NESTED_API_KVM_HV  1
+#define NESTED_API_PAPR    2
 } SpaprMachineStateNested;
 
 /*
@@ -105,4 +108,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
                            target_ulong lpid, ppc_v3_pate_t *entry);
+void spapr_register_nested_papr(void);
+void spapr_nested_init(SpaprMachineState *spapr);
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.39.3


