Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D297C6B86
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHU-0001bL-Fp; Thu, 12 Oct 2023 06:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtH2-00013b-KV; Thu, 12 Oct 2023 06:50:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGw-0004z6-4p; Thu, 12 Oct 2023 06:50:35 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAjIY4013047; Thu, 12 Oct 2023 10:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CAMfbZyxZGGinVBjz6TG78BnGa0OCXOrjJTbn1Fgy9U=;
 b=UKhiiF3AWDwx0IBZrhxjk4DuaJ7JHLfz/A5jcT+6eoP/BByVw0p3Aj6l/1TwLp+bMgGg
 ab3nSIhTGn55RsGxs75apc4e3cEm/zu6stiP+er0nRBUPEndTTkVyJIGi7NvPnvGaDLM
 4aMEcTfLmtToE0b5F4BBWKpw/pvYchh+m621qSLKkGWxomgTkBw3s+PR9RTshR2uTLKY
 s6wfMMe2BFos5Onx9w55k3PCkn5LpAifCvvtxE9GyUlmWEKG0uUEdFGUSsenes2AQPL9
 mBObEBMOFVMWAkg4vsGlPpivHLya9UHCvs/4enpRaKZCqVdgmD7Kq5VuL8sn7pkUsYIy lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaqr4v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:23 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAjV3U013574;
 Thu, 12 Oct 2023 10:50:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaqr4uu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAJMsP000693; Thu, 12 Oct 2023 10:50:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5kxqsu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoJI643647656
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 173E020040;
 Thu, 12 Oct 2023 10:50:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 209F82004D;
 Thu, 12 Oct 2023 10:50:17 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:16 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 06/14] spapr: nested: Introduce
 H_GUEST_[GET|SET]_CAPABILITIES hcalls.
Date: Thu, 12 Oct 2023 16:19:43 +0530
Message-Id: <20231012104951.194876-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xh72oAqQaIDEOH1mU-TxiHGnA7BKssBi
X-Proofpoint-GUID: ESHyfpbkO1YZzajq1jLsUVG8C3xIfqL5
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

Introduce the nested PAPR hcalls:
 - H_GUEST_GET_CAPABILITIES which is used to query the capabilities
   of the API and the L2 guests it provides.
 - H_GUEST_SET_CAPABILITIES which is used to set the Guest API
   capabilities that the Host Partition supports and may use.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c         | 70 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |  5 ++-
 include/hw/ppc/spapr_nested.h | 10 +++++
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 87a0db22a5..c53b310f82 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -7,10 +7,12 @@
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/spapr_nested.h"
 #include "mmu-book3s-v3.h"
+#include "cpu-models.h"
 
 void spapr_nested_init(SpaprMachineState *spapr)
 {
     spapr->nested.api = 0;
+    spapr->nested.capabilities_set = false;
 }
 
 bool spapr_get_pate_nested(SpaprMachineState *spapr, PowerPCCPU *cpu,
@@ -409,6 +411,72 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
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
+static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
+                                             SpaprMachineState *spapr,
+                                             target_ulong opcode,
+                                              target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong capabilities = args[1];
+
+    if (flags) { /* don't handle any flags capabilities for now */
+        return H_PARAMETER;
+    }
+
+    if (capabilities & H_GUEST_CAPABILITIES_COPY_MEM) {
+        env->gpr[4] = 0;
+        return H_P2; /* isn't supported */
+    }
+
+    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
+        (CPU_POWERPC_POWER9_BASE)) {
+        if (!(capabilities & H_GUEST_CAPABILITIES_P9_MODE)) {
+            env->gpr[4] = 1;
+            return H_P2;
+        }
+    }
+
+    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
+        (CPU_POWERPC_POWER10_BASE)) {
+        if (!(capabilities & H_GUEST_CAPABILITIES_P10_MODE)) {
+            env->gpr[4] = 2;
+            return H_P2;
+        }
+    }
+
+    if (!spapr->nested.capabilities_set) {
+        spapr->nested.capabilities_set = true;
+        spapr->nested.pvr_base = env->spr[SPR_PVR];
+        return H_SUCCESS;
+    } else {
+        return H_STATE;
+    }
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -420,6 +488,8 @@ void spapr_register_nested(void)
 void spapr_register_nested_papr(void)
 {
     /* register hcalls here */
+    spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
+    spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
 }
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index e33ee87ba4..c83dd76a84 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -366,6 +366,7 @@ struct SpaprMachineState {
 #define H_NOOP            -63
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
+#define H_STATE           -75
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -585,8 +586,10 @@ struct SpaprMachineState {
 #define H_RPT_INVALIDATE        0x448
 #define H_SCM_FLUSH             0x44C
 #define H_WATCHDOG              0x45C
+#define H_GUEST_GET_CAPABILITIES 0x460
+#define H_GUEST_SET_CAPABILITIES 0x464
 
-#define MAX_HCALL_OPCODE        H_WATCHDOG
+#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index efdfc78200..b7586d06a4 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -9,8 +9,18 @@ typedef struct SpaprMachineStateNested {
     uint8_t api;
 #define NESTED_API_KVM_HV  1
 #define NESTED_API_PAPR    2
+    bool capabilities_set;
+    uint32_t pvr_base;
 } SpaprMachineStateNested;
 
+/* Nested PAPR API related macros */
+#define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
+#define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
+#define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
+#define H_GUEST_CAP_COPY_MEM_BMAP     0
+#define H_GUEST_CAP_P9_MODE_BMAP      1
+#define H_GUEST_CAP_P10_MODE_BMAP     2
+
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
  * New member must be added at the end.
-- 
2.39.3


