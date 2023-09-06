Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3477934A9
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:02:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdkf1-0005Gc-82; Wed, 06 Sep 2023 01:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdkeu-0005Fm-Bc; Wed, 06 Sep 2023 01:00:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdkeq-00085y-7W; Wed, 06 Sep 2023 01:00:55 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3864uQAi019325; Wed, 6 Sep 2023 05:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0NQyHHUPyTdiqifX/7NyUBpEwXfXgP6ce6exbfo8Kbs=;
 b=njYjj2X+GXg+WjxX/3FFEML4ToHtqZKGAGgbe7udxdfkyUH/KibYFoIE5wPK+JdPhQCt
 1J2ZAuTpVQL03olB1mTaqpyIHk0C7fLnGLdeBlGLUZs/C6PEWr4Zm36iKGww8sgBKotg
 OyspD9BkfF6uc1Tz3RFRDcr8p/9wf33LSUzWqFh+YZhvlfPSIsedhaMUZsHSPAKd41kC
 eKFSL2SAKdbqT9pL13ucyQMX9JhZeg76JWxCKZxtki0Bin4l2u/qushWrN+esudEvD5H
 VOxqq9Qio4mzah+tWhGKaKZIn3H8kLrteYYGCCLjgwy/qkuHDwr9tznSD1aH1XeSgESn Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxjud0230-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:00:43 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3864uver019768;
 Wed, 6 Sep 2023 05:00:43 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxjud01vu-14
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:00:43 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3861V4SU001610; Wed, 6 Sep 2023 04:34:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsrja6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 04:34:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3864Y3IA38797672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 04:34:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CBA5120043;
 Wed,  6 Sep 2023 04:34:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE1BC20040;
 Wed,  6 Sep 2023 04:34:01 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 04:34:01 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH RESEND 08/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_CREATE
Date: Wed,  6 Sep 2023 10:03:26 +0530
Message-Id: <20230906043333.448244-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230906043333.448244-1-harshpb@linux.ibm.com>
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oQ-UXYvl4KWrvnxy3uOeO28gX11O5AF3
X-Proofpoint-ORIG-GUID: ST7bpMPuhn-lkEwxWRnK1qVCbP7Csmyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=367 clxscore=1011 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060040
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

This hcall is used by L1 to indicate to L0 that a new nested guest needs
to be created and therefore necessary resource allocation shall be made.
The L0 uses a hash table for nested guest specific resource management.
This data structure is further utilized by other hcalls to operate on
related members during entire life cycle of the nested guest.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c         | 75 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_nested.h |  3 ++
 2 files changed, 78 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 9af65f257f..09bbbfb341 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -444,6 +444,80 @@ static target_ulong h_guest_set_capabilities(PowerPCCPU *cpu,
     return H_SUCCESS;
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
+    uint64_t lpid;
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
+    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
+        return H_FUNCTION;
+    }
+
+    if (!spapr->nested.capabilities_set) {
+        return H_STATE;
+    }
+
+    if (!spapr->nested.guests) {
+        spapr->nested.lpid_max = NESTED_GUEST_MAX;
+        spapr->nested.guests = g_hash_table_new_full(NULL,
+                                                     NULL,
+                                                     NULL,
+                                                     destroy_guest_helper);
+    }
+
+    nguests = g_hash_table_size(spapr->nested.guests);
+
+    if (nguests == spapr->nested.lpid_max) {
+        return H_NO_MEM;
+    }
+
+    /* Lookup for available lpid */
+    for (lpid = 1; lpid < spapr->nested.lpid_max; lpid++) {
+        if (!(g_hash_table_lookup(spapr->nested.guests,
+                                  GINT_TO_POINTER(lpid)))) {
+            break;
+        }
+    }
+    if (lpid == spapr->nested.lpid_max) {
+        return H_NO_MEM;
+    }
+
+    guest = g_try_new0(struct SpaprMachineStateNestedGuest, 1);
+    if (!guest) {
+        return H_NO_MEM;
+    }
+
+    guest->pvr_logical = spapr->nested.pvr_base;
+
+    g_hash_table_insert(spapr->nested.guests, GINT_TO_POINTER(lpid), guest);
+    printf("%s: lpid: %lu (MAX: %i)\n", __func__, lpid, spapr->nested.lpid_max);
+
+    env->gpr[4] = lpid;
+    return H_SUCCESS;
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -456,6 +530,7 @@ void spapr_register_nested_phyp(void)
 {
     spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
     spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
+    spapr_register_hypercall(H_GUEST_CREATE          , h_guest_create);
 }
 
 #else
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index a7996251cb..7841027df8 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -197,6 +197,9 @@
 #define H_GUEST_CAP_P9_MODE_BMAP    1
 #define H_GUEST_CAP_P10_MODE_BMAP   2
 
+/* Nested PAPR API macros */
+#define NESTED_GUEST_MAX 4096
+
 typedef struct SpaprMachineStateNestedGuest {
     unsigned long vcpus;
     struct SpaprMachineStateNestedGuestVcpu *vcpu;
-- 
2.39.3


