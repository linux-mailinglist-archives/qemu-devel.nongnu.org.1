Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E69A7577C3
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgvA-0006Ib-CA; Tue, 18 Jul 2023 05:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgv6-0006I0-Gd; Tue, 18 Jul 2023 05:23:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgv4-000111-Lq; Tue, 18 Jul 2023 05:23:00 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9LtgU000809; Tue, 18 Jul 2023 09:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PK2QUMdc4kXcoHFoik5RTRoydEJQaKFTLfZVHzEdxbU=;
 b=N+LmA2VNWCNwlmjfgaiSlFB3Cns319e71GDNl4G4+t0mXYDyCnprGZ0xb3vmidEbVytY
 gLOHm5iSsmMlKPOZjKePNSO/pokxkAE//Of/kyHqeKUXnFwV5tTa7rW8ueyGzekyGcD2
 pUJurxdmmoqgnRKQsYtHAKnf8jUx0+sFUuAFliFMCIi6QK9wRYJfEi4o7PSDM8zOoHCa
 Y1snTxhvCPjAJ1/bXwl5DOBtlf8m1620W5O3T/OmNdnMVHnBJeRgfwP/4HLKXEt2Dg/2
 8biYJn90pHJ9k5mFjrS/jUS6bespSz8qNXKkfTVeVVSojvCq4LHbf6B75p2GvXzuSMyU nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1t0062-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:54 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9Ms4p002251;
 Tue, 18 Jul 2023 09:22:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1t005v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I7CG9o003171; Tue, 18 Jul 2023 09:22:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xcnga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:53 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9Mnb316253566
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CEDF320043;
 Tue, 18 Jul 2023 09:22:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC26420040;
 Tue, 18 Jul 2023 09:22:47 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:47 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 09/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_CREATE_VCPU
Date: Tue, 18 Jul 2023 14:52:15 +0530
Message-Id: <20230718092221.1053686-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N1-u_ccFaFLNbfMv_jWrgqICwieta85e
X-Proofpoint-GUID: 265v0Oea8xjatVkqBBYjOqOi43SoocDy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=753 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307180082
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


