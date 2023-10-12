Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DB17C6B91
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHW-0001dI-IO; Thu, 12 Oct 2023 06:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtHG-0001Jd-0l; Thu, 12 Oct 2023 06:50:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGx-0004zk-3R; Thu, 12 Oct 2023 06:50:49 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAgadT024044; Thu, 12 Oct 2023 10:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A/BCCSNNQndzwE+l1zpST7QV8n+rGngEtJ1Z15pqKps=;
 b=jC9c2OEGX6WdNwT5mayNa3OB4RCw2O7HvG2t7xcwl0DtnjgPpOvLd2kacHvr7Kp4sv+/
 uq9KYG//+Vz+b1yUyjNOqL+cbLVJErWByuOmuTa+jXvO5AXMt6RzJmZ1nu++gnqm9aCC
 ErPQ2dyG+Yg3QF7MDp4y+FrmaPyGoKertUvnCe5lwWbiAiGOaKEUxQUkKSl+lmBf5YJE
 zDT2P2Ak5X6FwI2HlWWTb10NrgxeyLspgbTHhn6wDrbsnKuPqzv1cVCYPmEbecA3rT2w
 TPkClGyQ/u1gNUv/O0lhZ3Dz0/tQj7SPl19scjRG1Pq7Zx075o3syitEaYsZvbsMVnUi zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpf9jrb6v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:27 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAgjtX024901;
 Thu, 12 Oct 2023 10:50:26 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpf9jrb68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C8RUUw023021; Thu, 12 Oct 2023 10:50:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1xe90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:24 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoL2h21299716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CCA320043;
 Thu, 12 Oct 2023 10:50:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F16820040;
 Thu, 12 Oct 2023 10:50:19 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:19 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 07/14] spapr: nested: Introduce H_GUEST_[CREATE|DELETE]
 hcalls.
Date: Thu, 12 Oct 2023 16:19:44 +0530
Message-Id: <20231012104951.194876-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nPR_mPCotDtN3sknHRHfyNlmSLHtH5el
X-Proofpoint-GUID: a7q4Z7mMLRD4G0jx5ynXpAOE1Zhetl4_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=580 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
    - H_GUEST_CREATE which is used to create and allocate resources for
nested guest being created.
    - H_GUEST_DELETE which is used to delete and deallocate resources
for the nested guest being deleted. It also supports deleting all nested
guests at once using a deleteAll flag.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c         | 101 ++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h        |   4 +-
 include/hw/ppc/spapr_nested.h |   7 +++
 3 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index c53b310f82..e95e70e20c 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -477,6 +477,105 @@ static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
     }
 }
 
+static void
+destroy_guest_helper(gpointer value)
+{
+    struct SpaprMachineStateNestedGuest *guest = value;
+    g_free(guest);
+}
+
+static target_ulong h_guest_create(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    CPUPPCState *env = &cpu->env;
+    target_ulong flags = args[0];
+    target_ulong continue_token = args[1];
+    uint64_t guestid;
+    int nguests = 0;
+    struct SpaprMachineStateNestedGuest *guest;
+
+    if (flags) { /* don't handle any flags for now */
+        return H_UNSUPPORTED_FLAG;
+    }
+
+    if (continue_token != -1) {
+        return H_P2;
+    }
+
+    if (!spapr->nested.capabilities_set) {
+        return H_STATE;
+    }
+
+    if (!spapr->nested.guests) {
+        spapr->nested.guests = g_hash_table_new_full(NULL,
+                                                     NULL,
+                                                     NULL,
+                                                     destroy_guest_helper);
+    }
+
+    nguests = g_hash_table_size(spapr->nested.guests);
+
+    if (nguests == PAPR_NESTED_GUEST_MAX) {
+        return H_NO_MEM;
+    }
+
+    /* Lookup for available guestid */
+    for (guestid = 1; guestid < PAPR_NESTED_GUEST_MAX; guestid++) {
+        if (!(g_hash_table_lookup(spapr->nested.guests,
+                                  GINT_TO_POINTER(guestid)))) {
+            break;
+        }
+    }
+
+    if (guestid == PAPR_NESTED_GUEST_MAX) {
+        return H_NO_MEM;
+    }
+
+    guest = g_try_new0(struct SpaprMachineStateNestedGuest, 1);
+    if (!guest) {
+        return H_NO_MEM;
+    }
+
+    guest->pvr_logical = spapr->nested.pvr_base;
+    g_hash_table_insert(spapr->nested.guests, GINT_TO_POINTER(guestid), guest);
+    env->gpr[4] = guestid;
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_guest_delete(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong guestid = args[1];
+    struct SpaprMachineStateNestedGuest *guest;
+
+    /*
+     * handle flag deleteAllGuests, if set:
+     * guestid is ignored and all guests are deleted
+     *
+     */
+    if (flags & ~H_GUEST_DELETE_ALL_FLAG) {
+        return H_UNSUPPORTED_FLAG; /* other flag bits reserved */
+    } else if (flags & H_GUEST_DELETE_ALL_FLAG) {
+        g_hash_table_destroy(spapr->nested.guests);
+        return H_SUCCESS;
+    }
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(guestid));
+    if (!guest) {
+        return H_P2;
+    }
+
+    g_hash_table_remove(spapr->nested.guests, GINT_TO_POINTER(guestid));
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -490,6 +589,8 @@ void spapr_register_nested_papr(void)
     /* register hcalls here */
     spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
+    spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
+    spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
 }
 #else
 void spapr_exit_nested(PowerPCCPU *cpu, int excp)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c83dd76a84..fcc6f0a3d9 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -588,8 +588,10 @@ struct SpaprMachineState {
 #define H_WATCHDOG              0x45C
 #define H_GUEST_GET_CAPABILITIES 0x460
 #define H_GUEST_SET_CAPABILITIES 0x464
+#define H_GUEST_CREATE           0x470
+#define H_GUEST_DELETE           0x488
 
-#define MAX_HCALL_OPCODE         H_GUEST_SET_CAPABILITIES
+#define MAX_HCALL_OPCODE         H_GUEST_DELETE
 
 /* The hcalls above are standardized in PAPR and implemented by pHyp
  * as well.
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index b7586d06a4..f186005f00 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -11,8 +11,13 @@ typedef struct SpaprMachineStateNested {
 #define NESTED_API_PAPR    2
     bool capabilities_set;
     uint32_t pvr_base;
+    GHashTable *guests;
 } SpaprMachineStateNested;
 
+typedef struct SpaprMachineStateNestedGuest {
+    uint32_t pvr_logical;
+} SpaprMachineStateNestedGuest;
+
 /* Nested PAPR API related macros */
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
@@ -20,6 +25,8 @@ typedef struct SpaprMachineStateNested {
 #define H_GUEST_CAP_COPY_MEM_BMAP     0
 #define H_GUEST_CAP_P9_MODE_BMAP      1
 #define H_GUEST_CAP_P10_MODE_BMAP     2
+#define PAPR_NESTED_GUEST_MAX         4096
+#define H_GUEST_DELETE_ALL_FLAG       0x8000000000000000ULL
 
 /*
  * Register state for entering a nested guest with H_ENTER_NESTED.
-- 
2.39.3


