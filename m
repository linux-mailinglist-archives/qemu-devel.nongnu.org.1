Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A8831262
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:27:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKuI-0006X8-5G; Thu, 18 Jan 2024 00:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKty-0006Lr-8F; Thu, 18 Jan 2024 00:25:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtw-0006aA-BW; Thu, 18 Jan 2024 00:25:18 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I5Flxh010397; Thu, 18 Jan 2024 05:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tJY1MKOG5/8W4IZnM1pIyHFTsh06yY7hZBg22A0wgD8=;
 b=NLF8eKmCi+8YwgMFEyUKLgl9O3Hg7urOkfhUkoQaOl5Q6gibxr3hleAz1ql7zOGeowF+
 eXryqwKCb9WTkajMKoJ4CwWol3KJe76/JwtB5CoIxCkvXDegbMG0/5RlENYAENzViM6Y
 HQb/iJHHOMJm/EckqkXroNOdHodXyU3nSR4RWzbMvPDa9wh48THTm/V6/mp4D01gz+Wc
 w1H1lQFqgNlxGMdad7dij8cDWfHyd0mk/h1X6sob/awJbnGBOiRLQlDdx9Vcps0OS3BA
 QJctX9ZbhD6UFfDVdcrDDW8ZCNc07QYBf3hQUoFK+KmLv2AqqczfVQkq5NTm6fmIa1bb BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpwpbg8s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:12 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5IOpL020807;
 Thu, 18 Jan 2024 05:25:11 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpwpbg8rw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:11 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3NNDe005785; Thu, 18 Jan 2024 05:25:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bksd0p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:25:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5P8JE25887374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:25:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0E4E20043;
 Thu, 18 Jan 2024 05:25:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DC3C20040;
 Thu, 18 Jan 2024 05:25:06 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:25:06 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 08/15] spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
Date: Thu, 18 Jan 2024 10:54:31 +0530
Message-Id: <20240118052438.1475437-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240118052438.1475437-1-harshpb@linux.ibm.com>
References: <20240118052438.1475437-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TXEM_mYIfzO8zRoz7XVpBMyB43W_xQkW
X-Proofpoint-ORIG-GUID: U7kRLRYBz7als9ZqYnPCbXhpOVNtvaTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=720 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180035
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

Introduce the nested PAPR hcall H_GUEST_CREATE_VCPU which is used to
create and initialize the specified VCPU resource for the previously
created guest. Each guest can have multiple VCPUs upto max 2048.
All VCPUs for a guest gets deallocated on guest delete.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h        |  2 +
 include/hw/ppc/spapr_nested.h | 10 ++++
 hw/ppc/spapr_nested.c         | 96 +++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5a001a7c00..fb5e8c093d 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -365,6 +365,7 @@ struct SpaprMachineState {
 #define H_UNSUPPORTED     -67
 #define H_OVERLAP         -68
 #define H_STATE           -75
+#define H_IN_USE          -77
 #define H_UNSUPPORTED_FLAG -256
 #define H_MULTI_THREADS_ACTIVE -9005
 
@@ -587,6 +588,7 @@ struct SpaprMachineState {
 #define H_GUEST_GET_CAPABILITIES 0x460
 #define H_GUEST_SET_CAPABILITIES 0x464
 #define H_GUEST_CREATE           0x470
+#define H_GUEST_CREATE_VCPU      0x474
 #define H_GUEST_DELETE           0x488
 
 #define MAX_HCALL_OPCODE         H_GUEST_DELETE
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index a01f8e37ab..4a9a13089d 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -15,6 +15,8 @@ typedef struct SpaprMachineStateNested {
 
 typedef struct SpaprMachineStateNestedGuest {
     uint32_t pvr_logical;
+    unsigned long vcpus;
+    struct SpaprMachineStateNestedGuestVcpu *vcpu;
 } SpaprMachineStateNestedGuest;
 
 /* Nested PAPR API related macros */
@@ -28,6 +30,7 @@ typedef struct SpaprMachineStateNestedGuest {
 #define H_GUEST_CAP_P10_MODE_BMAP     2
 #define PAPR_NESTED_GUEST_MAX         4096
 #define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
+#define PAPR_NESTED_GUEST_VCPU_MAX    2048
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
@@ -119,8 +122,15 @@ struct nested_ppc_state {
     uint64_t ppr;
 
     int64_t tb_offset;
+    /* Nested PAPR API */
+    uint64_t pvr;
 };
 
+typedef struct SpaprMachineStateNestedGuestVcpu {
+    bool enabled;
+    struct nested_ppc_state state;
+} SpaprMachineStateNestedGuestVcpu;
+
 void spapr_exit_nested(PowerPCCPU *cpu, int excp);
 typedef struct SpaprMachineState SpaprMachineState;
 bool spapr_get_pate_nested_hv(SpaprMachineState *spapr, PowerPCCPU *cpu,
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 1e620ef2fb..127f3facd2 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -428,6 +428,41 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     }
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
@@ -523,6 +558,7 @@ static void
 destroy_guest_helper(gpointer value)
 {
     struct SpaprMachineStateNestedGuest *guest = value;
+    g_free(guest->vcpu);
     g_free(guest);
 }
 
@@ -618,6 +654,65 @@ static target_ulong h_guest_delete(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
+static target_ulong h_guest_create_vcpu(PowerPCCPU *cpu,
+                                        SpaprMachineState *spapr,
+                                        target_ulong opcode,
+                                        target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    struct nested_ppc_state *l2_state;
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
+    l2_state = &guest->vcpu[guest->vcpus].state;
+    guest->vcpus++;
+    assert(vcpuid < guest->vcpus); /* linear vcpuid allocation only */
+    /* Set L1 PVR as L2 default */
+    l2_state->pvr = env->spr[SPR_PVR];
+    guest->vcpu[vcpuid].enabled = true;
+
+    if (!spapr_nested_vcpu_check(guest, vcpuid)) {
+        return H_PARAMETER;
+    }
+    return H_SUCCESS;
+}
+
 void spapr_register_nested_hv(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -632,6 +727,7 @@ void spapr_register_nested_papr(void)
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
     spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
     spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
+    spapr_register_hypercall(H_GUEST_CREATE_VCPU     , h_guest_create_vcpu);
 }
 
 #else
-- 
2.39.3


