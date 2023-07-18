Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E16527577E0
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:25:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgv3-0006F6-La; Tue, 18 Jul 2023 05:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgv1-0006Do-Ga; Tue, 18 Jul 2023 05:22:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguz-0000zH-QQ; Tue, 18 Jul 2023 05:22:55 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I9MTsF027678; Tue, 18 Jul 2023 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ql+zLBGz0lFChRPU64uisTerD+D7Wr6/cfD7Qd45G6M=;
 b=hvnxOSETNZjrslEjfOuPYUC0YdaffBIuzr8xNR0IvbJz15FbjJuarpDckJD9cogrVwm5
 FUUh7JULG8j019mnUDPW2Pu29Ki3/OdIROSZnKt1mtAiqlRCN9OdH2byj91RvvfMhNCR
 yBhpuhaM/C82rlVL2mDUHqLZ5Wm58++p7J9vptecG+wIRde002/D5YhhOqFSPfPcUMcI
 fHPR7qNJd6Dtrpr7WrZba8xKiKcbJHHC/C3yOqN5Lp2CJUAXugqD40lhw2Gg6+85KDSP
 9qMAjelR22qhmuHYjozsJdmH9sglkKOwAJhhvzRrEdh5Yvgri5Go0lJQ29EQI8IBkCXq cw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1t005a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:49 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I9MnSt028163;
 Tue, 18 Jul 2023 09:22:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwr1t004w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I4eG8p030687; Tue, 18 Jul 2023 09:22:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jjath-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9MjJc45351312
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E48B220043;
 Tue, 18 Jul 2023 09:22:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C59820040;
 Tue, 18 Jul 2023 09:22:42 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:42 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 07/15] ppc: spapr: Implement nested PAPR hcall -
 H_GUEST_SET_CAPABILITIES
Date: Tue, 18 Jul 2023 14:52:13 +0530
Message-Id: <20230718092221.1053686-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230718092221.1053686-1-harshpb@linux.ibm.com>
References: <20230718092221.1053686-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2Agm4ouNjbMr_G99UBJxPLfxWW3aMOyn
X-Proofpoint-GUID: vWssjoobgYJZrvmwNe8Tb26cRuZ3b9QN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307180082
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

This patch implements nested PAPR hcall H_GUEST_SET_CAPABILITIES.
This is used by L1 to set capabilities of the nested guest being
created. The capabilities being set are subset of the capabilities
returned from the previous call to H_GUEST_GET_CAPABILITIES hcall.
Currently, it only supports P9/P10 capability check through PVR.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c                |  1 +
 hw/ppc/spapr_nested.c         | 46 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr_nested.h |  3 +++
 3 files changed, 50 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d357350468..8643ee31fd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3443,6 +3443,7 @@ static void spapr_instance_init(Object *obj)
         "Host serial number to advertise in guest device tree");
     /* Nested */
     spapr->nested.api = 0;
+    spapr->nested.capabilities_set = false;
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 37f3a49be2..9af65f257f 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -399,6 +399,51 @@ static target_ulong h_guest_get_capabilities(PowerPCCPU *cpu,
     return H_SUCCESS;
 }
 
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
+
+    /* isn't supported */
+    if (capabilities & H_GUEST_CAPABILITIES_COPY_MEM) {
+        env->gpr[4] = 0;
+        return H_P2;
+    }
+
+    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
+        (CPU_POWERPC_POWER9_BASE)) {
+        /* We are a P9 */
+        if (!(capabilities & H_GUEST_CAPABILITIES_P9_MODE)) {
+            env->gpr[4] = 1;
+            return H_P2;
+        }
+    }
+
+    if ((env->spr[SPR_PVR] & CPU_POWERPC_POWER_SERVER_MASK) ==
+        (CPU_POWERPC_POWER10_BASE)) {
+        /* We are a P10 */
+        if (!(capabilities & H_GUEST_CAPABILITIES_P10_MODE)) {
+            env->gpr[4] = 2;
+            return H_P2;
+        }
+    }
+
+    spapr->nested.capabilities_set = true;
+
+    spapr->nested.pvr_base = env->spr[SPR_PVR];
+
+    return H_SUCCESS;
+}
+
 void spapr_register_nested(void)
 {
     spapr_register_hypercall(KVMPPC_H_SET_PARTITION_TABLE, h_set_ptbl);
@@ -410,6 +455,7 @@ void spapr_register_nested(void)
 void spapr_register_nested_phyp(void)
 {
     spapr_register_hypercall(H_GUEST_GET_CAPABILITIES, h_guest_get_capabilities);
+    spapr_register_hypercall(H_GUEST_SET_CAPABILITIES, h_guest_set_capabilities);
 }
 
 #else
diff --git a/include/hw/ppc/spapr_nested.h b/include/hw/ppc/spapr_nested.h
index ce198e9f70..a7996251cb 100644
--- a/include/hw/ppc/spapr_nested.h
+++ b/include/hw/ppc/spapr_nested.h
@@ -193,6 +193,9 @@
 #define H_GUEST_CAPABILITIES_COPY_MEM 0x8000000000000000
 #define H_GUEST_CAPABILITIES_P9_MODE  0x4000000000000000
 #define H_GUEST_CAPABILITIES_P10_MODE 0x2000000000000000
+#define H_GUEST_CAP_COPY_MEM_BMAP   0
+#define H_GUEST_CAP_P9_MODE_BMAP    1
+#define H_GUEST_CAP_P10_MODE_BMAP   2
 
 typedef struct SpaprMachineStateNestedGuest {
     unsigned long vcpus;
-- 
2.39.3


