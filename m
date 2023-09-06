Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DA77934F8
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdlHe-0005cS-Cv; Wed, 06 Sep 2023 01:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdlHb-0005c0-Ft; Wed, 06 Sep 2023 01:40:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdlHY-0007it-SE; Wed, 06 Sep 2023 01:40:55 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3865bjtf021603; Wed, 6 Sep 2023 05:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PK2QUMdc4kXcoHFoik5RTRoydEJQaKFTLfZVHzEdxbU=;
 b=qlE2OCWDLkp5YCIyM5kBIhWAUvLiDfgNuhp7uoHTihvzSRFVjdlsZMJmpaWsuqFlCvHo
 Um2Nc/zzk4EnPII152bfhmy1nqJu/G7uMsURXj0VA/P9ucgfVVzVCQ4akVTs6sG/ajoi
 j01hIBaLsi5vjluASGTwJyWQKEhN1mn4EbSr6Flu3ACtVJdV4QU34iDGU504rw8M3icZ
 IBnVhap27x4zkil5DiO2fCaAPToZCbcGi8WMOjVDaoXRUjhK+y7H6SxFanWbg46KxQiL
 BRQSVJCyeEpoMkmVzcJoYFkA9BSFWBpDfxKIciDB22r5Zrk4YmPPKf0oWnNiHvyx9MC+ NQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxka88b96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:40:46 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3865c7lq024128;
 Wed, 6 Sep 2023 05:40:46 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxka88b6s-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:40:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3861T4aE001598; Wed, 6 Sep 2023 04:34:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsrja7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 04:34:09 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3864Y6mB20775546
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 04:34:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F48A20043;
 Wed,  6 Sep 2023 04:34:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39C8420040;
 Wed,  6 Sep 2023 04:34:04 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 04:34:03 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH RESEND 09/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_CREATE_VCPU
Date: Wed,  6 Sep 2023 10:03:27 +0530
Message-Id: <20230906043333.448244-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230906043333.448244-1-harshpb@linux.ibm.com>
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pbj-8RTOlAZHKN1j20bA7dLPPoe-IgN3
X-Proofpoint-GUID: fJaxV-_0S1KQpB15tdcKSPNUNCocN3GL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=711 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060050
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

This patch implements support for hcall H_GUEST_CREATE_VCPU which is
used to instantiate a new VCPU for a previously created nested guest.
The L1 provide the guest-id (returned by L0 during call to
H_GUEST_CREATE) and an associated unique vcpu-id to refer to this
instance in future calls. It is assumed that vcpu-ids are being
allocated in a sequential manner and max vcpu limit is 2048.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c         | 110 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   1 +
 include/hw/ppc/spapr_nested.h |   1 +
 3 files changed, 112 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 09bbbfb341..e7956685af 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -376,6 +376,47 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
+static
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong lpid)
+{
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(lpid));
+    return guest;
+}
+
+static bool vcpu_check(SpaprMachineStateNestedGuest *guest,
+                       target_ulong vcpuid,
+                       bool inoutbuf)
+{
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
+
+    if (vcpuid >= NESTED_GUEST_VCPU_MAX) {
+        return false;
+    }
+
+    if (!(vcpuid < guest->vcpus)) {
+        return false;
+    }
+
+    vcpu = &guest->vcpu[vcpuid];
+    if (!vcpu->enabled) {
+        return false;
+    }
+
+    if (!inoutbuf) {
+        return true;
+    }
+
+    /* Check to see if the in/out buffers are registered */
+    if (vcpu->runbufin.addr && vcpu->runbufout.addr) {
+        return true;
+    }
+
+    return false;
+}
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -448,6 +489,11 @@ static void
 destroy_guest_helper(gpointer value)
 {
     struct SpaprMachineStateNestedGuest *guest = value;
+    int i = 0;
+    for (i = 0; i < guest->vcpus; i++) {
+        cpu_ppc_tb_free(&guest->vcpu[i].env);
+    }
+    g_free(guest->vcpu);
     g_free(guest);
 }
 
@@ -518,6 +564,69 @@ static target_ulong h_guest_create(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env, *l2env;
+    target_ulong flags = args[0];
+    target_ulong lpid = args[1];
+    target_ulong vcpuid = args[2];
+    SpaprMachineStateNestedGuest *guest;
+
+    if (flags) { /* don't handle any flags for now */
+        return H_UNSUPPORTED_FLAG;
+    }
+
+    guest = spapr_get_nested_guest(spapr, lpid);
+    if (!guest) {
+        return H_P2;
+    }
+
+    if (vcpuid < guest->vcpus) {
+        return H_IN_USE;
+    }
+
+    if (guest->vcpus >= NESTED_GUEST_VCPU_MAX) {
+        return H_P3;
+    }
+
+    if (guest->vcpus) {
+        struct SpaprMachineStateNestedGuestVcpu *vcpus;
+        vcpus = g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
+                            guest->vcpu,
+                            guest->vcpus + 1);
+        if (!vcpus) {
+            return H_NO_MEM;
+        }
+        memset(&vcpus[guest->vcpus], 0,
+               sizeof(struct SpaprMachineStateNestedGuestVcpu));
+        guest->vcpu = vcpus;
+        l2env = &vcpus[guest->vcpus].env;
+    } else {
+        guest->vcpu = g_try_new0(struct SpaprMachineStateNestedGuestVcpu, 1);
+        if (guest->vcpu == NULL) {
+            return H_NO_MEM;
+        }
+        l2env = &guest->vcpu->env;
+    }
+    /* need to memset to zero otherwise we leak L1 state to L2 */
+    memset(l2env, 0, sizeof(CPUPPCState));
+    /* Copy L1 PVR to L2 */
+    l2env->spr[SPR_PVR] = env->spr[SPR_PVR];
+    cpu_ppc_tb_init(l2env, SPAPR_TIMEBASE_FREQ);
+
+    guest->vcpus++;
+    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */
+    guest->vcpu[vcpuid].enabled = true;
+
+    if (!vcpu_check(guest, vcpuid, false)) {
+        return H_PARAMETER;
+    }
+    return H_SUCCESS;
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -531,6 +640,7 @@ void spapr_register_nested_phyp(void)
     spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
+    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
 }
 
 #else
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 8a6e9ce929..c9f9682a46 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -371,6 +371,7 @@ struct SpaprMachineState {
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
 #define H_STATE           -75
+#define H_IN_USE          -77
 #define H_INVALID_ELEMENT_ID               -79
 #define H_INVALID_ELEMENT_SIZE             -80
 #define H_INVALID_ELEMENT_VALUE            -81
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index 7841027df8..2e8c6ba1ca 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -199,6 +199,7 @@
 
 /* Nested PAPR API macros */
 #define NESTED_GUEST_MAX 4096
+#define NESTED_GUEST_VCPU_MAX 2048
 
 typedef struct SpaprMachineStateNestedGuest {
     unsigned long vcpus;
-- 
2.39.3


