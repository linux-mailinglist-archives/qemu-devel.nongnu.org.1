Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B967577D7
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:24:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgv2-0006EG-Aw; Tue, 18 Jul 2023 05:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguz-0006DW-To; Tue, 18 Jul 2023 05:22:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgux-0000yF-4w; Tue, 18 Jul 2023 05:22:53 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9CPK2020040; Tue, 18 Jul 2023 09:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k/n1MsfTZPUO5NkmW9ULXk0OQuuWZB8POEVYl/6hUy0=;
 b=TLx49ciXoirkVJC7LEEHdQGrYhpVCovtr2MuJrn4Gjd0Qs/pwqVklMzcP6JNY2n1qYEy
 VMKOZobMSNAxzaYcNCfXlemS1ujnBk+vuFVag2KRBVm21ge1VzC9kRawu0myZfyImHfF
 zRqe+Jv2pMR8ciNT9cAP9gnfF5Ju8YTARDJ+UkqivShAh7idyWFvJFQtTaUno5gXq2cX
 uTDrTvmnZ/3IH6dPhK+v59PsJyLw4bNoxA3Mw3NO3h3anigPddbVpAcZif8kicD1u/bC
 iAE5kCeihYBxDMj0G2EaT+SJkqGajbbK53i6thwiGcxliVFtupSmje2pnJ+lmL4WU0Te iw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqw488rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:47 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9CvMh021544;
 Tue, 18 Jul 2023 09:22:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqw488qs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:46 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I7RWD0029625; Tue, 18 Jul 2023 09:22:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6smcm88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:45 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9Mgbi10683128
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29CA32004D;
 Tue, 18 Jul 2023 09:22:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDF0E20040;
 Tue, 18 Jul 2023 09:22:39 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:39 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 06/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_GET_CAPABILITIES
Date: Tue, 18 Jul 2023 14:52:12 +0530
Message-Id: <20230718092221.1053686-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -LX11MBqpMJ6CWN03nL0ABRZEcc13NUa
X-Proofpoint-ORIG-GUID: FRQHGj0XeHWk7cydMHi1F21gieQodJuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 mlxlogscore=857 malwarescore=0 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This patch implements nested PAPR hcall H_GUEST_GET_CAPABILITIES and
also enables registration of nested PAPR hcalls whenever an L0 is
launched with cap-nested-papr=true. The common registration routine
shall be used by future patches for registration of related hcall
support
being added. This hcall is used by L1 kernel to get the set of guest
capabilities that are supported by L0 (Qemu TCG).

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_caps.c           |  1 +
 hw/ppc/spapr_nested.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_nested.h |  6 ++++++
 3 files changed, 42 insertions(+)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index d3b9f107aa..cbe53a79ec 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -511,6 +511,7 @@ static void cap_nested_papr_apply(SpaprMachineState *spapr,
             return;
         }
         spapr->nested.api = NESTED_API_PAPR;
+        spapr_register_nested_phyp();
     } else if (kvm_enabled()) {
         /*
          * this gets executed in L1 qemu when L2 is launched,
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index a669470f1a..37f3a49be2 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -6,6 +6,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
+#include "cpu-models.h"
 
 #ifdef CONFIG_TCG
 #define PRTS_MASK      0x1f
@@ -375,6 +376,29 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
+static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
+                                             SpaprMachineState *spapr,
+                                             target_ulong opcode,
+                                             target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+
+    if (flags) { /* don't handle any flags capabilities for now */
+        return H_PARAMETER;
+    }
+
+    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
+        (CPU_POWERPC_POWER9_BASE))
+        env->gpr[4] = H_GUEST_CAPABILITIES_P9_MODE;
+
+    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
+        (CPU_POWERPC_POWER10_BASE))
+        env->gpr[4] = H_GUEST_CAPABILITIES_P10_MODE;
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -382,6 +406,12 @@ void spapr_register_nested(void)
     spapr_register_hypercall(KVMPPC_H_TLB_INVALIDATE, h_tlb_invalidate);
     spapr_register_hypercall(KVMPPC_H_COPY_TOFROM_GUEST, h_copy_tofrom_guest);
 }
+
+void spapr_register_nested_phyp(void)
+{
+    spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
+}
+
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
 {
@@ -392,4 +422,9 @@ void spapr_register_nested(void)
 {
     /* DO NOTHING */
 }
+
+void spapr_register_nested_phyp(void)
+{
+    /* DO NOTHING */
+}
 #endif
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index f8db31075b..ce198e9f70 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -189,6 +189,11 @@
 /* End of list of Guest State Buffer Element IDs */
 #define GSB_LAST                GSB_VCPU_SPR_ASDR
 
+/* Bit masks to be used in nested PAPR API */
+#define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
+#define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
+#define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
+
 typedef struct SpaprMachineStateNestedGuest {
     unsigned long vcpus;
     struct SpaprMachineStateNestedGuestVcpu *vcpu;
@@ -331,6 +336,7 @@ struct nested_ppc_state {
 };
 
 void spapr_register_nested(void);
+void spapr_register_nested_phyp(void);
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 
 #endif /* HW_SPAPR_NESTED_H */
-- 
2.39.3


