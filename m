Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 455237934B2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:03:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdkfm-0005gQ-Jk; Wed, 06 Sep 2023 01:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdkf0-0005Jj-9U; Wed, 06 Sep 2023 01:01:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdkeu-00086r-TK; Wed, 06 Sep 2023 01:01:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3864pKVk026001; Wed, 6 Sep 2023 05:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ozjIqm8Mp5T4QPHbB3deNz0IbaVBGo3HYz4gLtK6Tyc=;
 b=Y9TucUPz/MfD9CWiiSdGH/sPgzFQM6cJrMt0/8a7UPr8XWFBX44LbQYKuyxGD8AZQpYr
 b8iZ8ZB7PM94rKoJB6NpO2wyTO+jp24U0A6BsV1X3sl994VQK2JbKIPS6enX3x9Oe7SV
 GCEL8xgUQyFHSmAhdBGEFA0TfLqGQEBRWkulMkKWqd/T1oAzZP+YIRbTxy4QAuJrZVl4
 kNfinnd5tcef/QKKnQEkna2VCmncc+ZvKR/dqOZcKGTOi9PumIw3P+n94Jzh6XFJemO6
 y1EWZDdoYzHWexU0PNjP3FyuXaoIhQ5/ywltRKBONuv0EdeFwKs7sievaN+OEMzEAlV2 Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxjrer6wg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:00:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3864pOUB026323;
 Wed, 6 Sep 2023 05:00:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxjrer6rm-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:00:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3862u6nQ026759; Wed, 6 Sep 2023 04:34:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcng6e1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 04:34:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3864YHRd42205920
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 04:34:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2BFE20043;
 Wed,  6 Sep 2023 04:34:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C520620040;
 Wed,  6 Sep 2023 04:34:15 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 04:34:15 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH RESEND 14/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_DELETE
Date: Wed,  6 Sep 2023 10:03:32 +0530
Message-Id: <20230906043333.448244-15-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230906043333.448244-1-harshpb@linux.ibm.com>
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5oKypm2iIC1tcMTaJnoiK0mRa2KO1M1G
X-Proofpoint-ORIG-GUID: 5AkJ-wH4NtFAY4KkyYKkV_BhadVhytyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=803
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
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

This hcall is used by L1 to delete a guest entry in L0 or can also be
used to delete all guests if needed (usually in shutdown scenarios).

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c         | 32 ++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_nested.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 3605f27115..5afdad4990 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1692,6 +1692,37 @@ static void exit_process_output_buffer(PowerPCCPU *cpu,
     return;
 }
 
+static target_ulong h_guest_delete(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   target_ulong opcode,
+                                   target_ulong *args)
+{
+    target_ulong flags = args[0];
+    target_ulong lpid = args[1];
+    struct SpaprMachineStateNestedGuest *guest;
+
+    if (!spapr_get_cap(spapr, SPAPR_CAP_NESTED_PAPR)) {
+        return H_FUNCTION;
+    }
+
+    /* handle flag deleteAllGuests, remaining bits reserved */
+    if (flags & ~H_GUEST_DELETE_ALL_MASK) {
+        return H_UNSUPPORTED_FLAG;
+    } else if (flags & H_GUEST_DELETE_ALL_MASK) {
+        g_hash_table_destroy(spapr->nested.guests);
+        return H_SUCCESS;
+    }
+
+    guest = g_hash_table_lookup(spapr->nested.guests, GINT_TO_POINTER(lpid));
+    if (!guest) {
+        return H_P2;
+    }
+
+    g_hash_table_remove(spapr->nested.guests, GINT_TO_POINTER(lpid));
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -1709,6 +1740,7 @@ void spapr_register_nested_phyp(void)
     spapr_register_hypercall(H_GUEST_SET_STATE       , h_guest_set_state);
     spapr_register_hypercall(H_GUEST_GET_STATE       , h_guest_get_state);
     spapr_register_hypercall(H_GUEST_RUN_VCPU        , h_guest_run_vcpu);
+    spapr_register_hypercall(H_GUEST_DELETE          , h_guest_delete);
 }
 
 #else
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index ca5d28c06e..9eb43778ad 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -209,6 +209,7 @@
 #define H_GUEST_GETSET_STATE_FLAG_GUEST_WIDE 0x8000000000000000 /* BE in GSB */
 #define GUEST_STATE_REQUEST_GUEST_WIDE       0x1
 #define GUEST_STATE_REQUEST_SET              0x2
+#define H_GUEST_DELETE_ALL_MASK              0x8000000000000000ULL
 
 #define GUEST_STATE_ELEMENT(i, sz, s, f, ptr, c) { \
     .id = (i),                                     \
-- 
2.39.3


