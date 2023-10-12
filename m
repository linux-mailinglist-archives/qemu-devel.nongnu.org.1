Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294167C6B7E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHF-0001EN-67; Thu, 12 Oct 2023 06:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtH6-00016J-7c; Thu, 12 Oct 2023 06:50:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGy-00050h-1b; Thu, 12 Oct 2023 06:50:37 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAiQwE016096; Thu, 12 Oct 2023 10:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6QiLBJ6BX67KF5q7jFcVow5MyNAOg6ei7fCS2BV1vvc=;
 b=BTsP7O+cTgZeP2nPSynDDH1s4SsHMHh28Tl6Cw2KuzKRf2h45eHys84xIFQDmbIFrGbO
 wHpCZ9VObz2vHnCh06Ojd4SZdjV0uG3j4Iiy4g5If7L8e+3rjJfY8kKV4yolO4UEqKT4
 m8QPZ6ECtr38gG6M0948TRpqkyCJRZj66feWkHAAYLVMsDry1UW6sof+Dftuc+W5ndVS
 ayaT7pbqP3EV13et4SuOPw8dP4uYQ/aOFdCVDx+cfv5UM3mBpsFar1zApIH5shx+0zd8
 F3ixxa/HySnbVMqpNOJzWrq7Zym0reC87TUEW3gdNQtYq3Q53A2niMHcTUm2yeqTl6Lx /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaf8628-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAjjLb023204;
 Thu, 12 Oct 2023 10:50:27 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfaf8620-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C8ljHp024458; Thu, 12 Oct 2023 10:50:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnsy90s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoN4n22676188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:23 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C2E7B20043;
 Thu, 12 Oct 2023 10:50:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6E3820040;
 Thu, 12 Oct 2023 10:50:21 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:21 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 08/14] spapr: nested: Introduce H_GUEST_CREATE_VPCU hcall.
Date: Thu, 12 Oct 2023 16:19:45 +0530
Message-Id: <20231012104951.194876-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qoj1lGfkbIVeKVm-1XirQZ6wo-HB2IVd
X-Proofpoint-ORIG-GUID: vHZ5TiraZfoSOvZB4OYejU7gzhPtv1V_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=776
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

Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
create and initialize the specified VCPU resource for the previously
created guest. Each guest can have multiple VCPUs upto max 2048.
All VCPUs for a guest gets deallocated on guest delete.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c         | 100 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   2 +
 include/hw/ppc/spapr_nested.h |   8 +++
 3 files changed, 110 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index e95e70e20c..b38116b7c3 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -411,6 +411,41 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
+static
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong guestid)
+{
+    SpaprMachineStateNestedGuest *guest;
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
+    return guest;
+}
+
+static bool spapr_nested_vcpu_check(SpaprMachineStateNestedGuest *guest,
+                                    target_ulong vcpuid)
+{
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
+    /*
+     * Perform sanity checks for the provided vcpuid of a guest.
+     * For now, ensure its valid, allocated and enabled for use.
+     */
+
+    if (vcpuid >= PAPR_NESTED_GUEST_VCPU_MAX) {
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
+    return true;
+}
+
 static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
                                              SpaprMachineState *spapr,
                                              target_ulong opcode,
@@ -481,6 +516,11 @@ static void
 destroy_guest_helper(gpointer value)
 {
     struct SpaprMachineStateNestedGuest *guest = value;
+
+    for (int i = 0; i < guest->vcpus; i++) {
+        cpu_ppc_tb_free(&guest->vcpu[i].env);
+    }
+    g_free(guest->vcpu);
     g_free(guest);
 }
 
@@ -576,6 +616,65 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env, *l2env;
+    target_ulong flags = args[0];
+    target_ulong guestid = args[1];
+    target_ulong vcpuid = args[2];
+    SpaprMachineStateNestedGuest *guest;
+
+    if (flags) { /* don't handle any flags for now */
+        return H_UNSUPPORTED_FLAG;
+    }
+
+    guest = spapr_get_nested_guest(spapr, guestid);
+    if (!guest) {
+        return H_P2;
+    }
+
+    if (vcpuid < guest->vcpus) {
+        return H_IN_USE;
+    }
+
+    if (guest->vcpus >= PAPR_NESTED_GUEST_VCPU_MAX) {
+        return H_P3;
+    }
+
+    if (guest->vcpus) {
+        SpaprMachineStateNestedGuestVcpu *vcpus;
+        vcpus = g_try_renew(struct SpaprMachineStateNestedGuestVcpu,
+                            guest->vcpu,
+                            guest->vcpus + 1);
+        if (!vcpus) {
+            return H_NO_MEM;
+        }
+        memset(&vcpus[guest->vcpus], 0,
+               sizeof(SpaprMachineStateNestedGuestVcpu));
+        guest->vcpu = vcpus;
+    } else {
+        guest->vcpu = g_try_new0(SpaprMachineStateNestedGuestVcpu, 1);
+        if (guest->vcpu == NULL) {
+            return H_NO_MEM;
+        }
+    }
+    l2env = &guest->vcpu[guest->vcpus].env;
+    guest->vcpus++;
+    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */
+    /* Copy L1 PVR to L2 */
+    l2env->spr[SPR_PVR] = env->spr[SPR_PVR];
+    cpu_ppc_tb_init(l2env, SPAPR_TIMEBASE_FREQ);
+    guest->vcpu[vcpuid].enabled = true;
+
+    if (!spapr_nested_vcpu_check(guest, vcpuid)) {
+        return H_PARAMETER;
+    }
+    return H_SUCCESS;
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -591,6 +690,7 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
+    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
 }
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fcc6f0a3d9..25aa8c5ffe 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -367,6 +367,7 @@ struct SpaprMachineState {
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
 #define H_STATE           -75
+#define H_IN_USE          -77
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -589,6 +590,7 @@ struct SpaprMachineState {
 #define H_GUEST_GET_CAPABILITIES 0x460
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
+#define H_GUEST_CREATE_VCPU      0x474
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index f186005f00..91cb744a5b 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -16,8 +16,15 @@ typedef struct SpaprMachineStateNested {
 
 typedef struct SpaprMachineStateNestedGuest {
     uint32_t pvr_logical;
+    unsigned long vcpus;
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
 } SpaprMachineStateNestedGuest;
 
+typedef struct SpaprMachineStateNestedGuestVcpu {
+    bool enabled;
+    CPUPPCState env;
+} SpaprMachineStateNestedGuestVcpu;
+
 /* Nested PAPR API related macros */
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
@@ -27,6 +34,7 @@ typedef struct SpaprMachineStateNestedGuest {
 #define H_GUEST_CAP_P10_MODE_BMAP     2
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
+#define PAPR_NESTED_GUEST_VCPU_MAX    2048
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
-- 
2.39.3


