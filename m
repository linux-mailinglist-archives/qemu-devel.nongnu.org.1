Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D997577D4
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:24:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgvN-0006jD-AC; Tue, 18 Jul 2023 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgvL-0006dk-3c; Tue, 18 Jul 2023 05:23:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgvI-00014Q-3l; Tue, 18 Jul 2023 05:23:14 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9Ll1c000741; Tue, 18 Jul 2023 09:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ozjIqm8Mp5T4QPHbB3deNz0IbaVBGo3HYz4gLtK6Tyc=;
 b=nnQ8o6hU7Udp0eC2wbXiC8jy+fYybzLKw1NDON1aWXrbCODgcM6hA4I4jNbOgjXRtCrw
 fKe2ocG/b/JQMmxM4SGSSbeDAo0ac7sbBE+LUSdMzCSKtdtvusUE5lfgkfXKQ3t7DJnP
 cK55z2x/C7+5IjNk4Nz/xL/7kem3oOpTKCcI8JtGO+lQxhNiBxZ4FwMMNUIxExhUvOM8
 y76cA+uUs81cQA7wHF9E7nxmxTsMkclgUtaczDU3oNOTNTr/z2LoQjgckgmaS7QTmvTW
 peyEtpCmGcXi+yAiHnbXJV7bejIm5hlRKzKhYV0s+zV62FncBUEltbyH/yM3QNbGD+pw Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1t0097-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:23:08 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9N762003257;
 Tue, 18 Jul 2023 09:23:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1t008j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:23:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I4eKXC031299; Tue, 18 Jul 2023 09:23:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jjau4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:23:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9N32Z16253586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:23:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59AA42004B;
 Tue, 18 Jul 2023 09:23:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD43420043;
 Tue, 18 Jul 2023 09:23:00 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:23:00 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 14/15] ppc: spapr: Implement nested PAPR hcall - H_GUEST_DELETE
Date: Tue, 18 Jul 2023 14:52:20 +0530
Message-Id: <20230718092221.1053686-15-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jLA0GcmF5LAd0aYctW1AG4YG3FTr9tR0
X-Proofpoint-GUID: aDvrBWj4JqIdU65h5-0OVpCYm7GCbfoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=871 adultscore=0
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


