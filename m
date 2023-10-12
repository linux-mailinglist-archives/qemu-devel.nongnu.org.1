Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E27C6B8E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtHO-0001KP-Af; Thu, 12 Oct 2023 06:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtHE-0001F9-GM; Thu, 12 Oct 2023 06:50:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtHA-000560-B8; Thu, 12 Oct 2023 06:50:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAgnwY007066; Thu, 12 Oct 2023 10:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yK1La9Ml3D//IhgGtV5iJy65bdk8FmJCF8fEMs2/hO8=;
 b=oR7KFiNd5x30S/jXEhMzEuNUkEX+4ncmelPNs40TZg9sU8VLNcsdpaDB7648gbUQRltx
 rWKuSOV3hihC1Qgtbf9GRj32s6AZchU1mUSmSiPm0hs+lN/AECpnHUE0wxUqQZv3aVMb
 2bYz4DLTkEMjbBPyhKw321f8JmiTmtd1tUTFstlsLf7PYWCCSv/zyxCDtTyf5oo+yD8N
 kdZ+5YN2GEmQ5i10iTHfem4bMvJqbXiwpnNbuu7MS9KpU1KPiD5tMUWNaQJuQ7dwpTgl
 BxXphkYX9p3cFREK+ZUUtOE0IuG6t4YJWJac20znmtYEnS7g+8loOexiI6J52u3oRjrL xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpf9k0dq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:39 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAnJst017347;
 Thu, 12 Oct 2023 10:50:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpf9k0dpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:39 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAeOTR000643; Thu, 12 Oct 2023 10:50:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5kxqtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAoYvp14287538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F63020043;
 Thu, 12 Oct 2023 10:50:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DCD420040;
 Thu, 12 Oct 2023 10:50:32 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:50:31 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 12/14] spapr: nested: rename nested_host_state to
 nested_hv_host
Date: Thu, 12 Oct 2023 16:19:49 +0530
Message-Id: <20231012104951.194876-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231012104951.194876-1-harshpb@linux.ibm.com>
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nrl0NweKndSORK_oDtuJluZgLdZqIBWu
X-Proofpoint-GUID: yHujYzSru6fyeF3w0A02BS4ucICovHVU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=797
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Renaming nested host state variable name to reflect the nested-hv API
being used. For nested PAPR API, similar convention shall be used in
upcoming patch which helps distinguishing them from each other.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr_nested.c           | 18 +++++++++---------
 include/hw/ppc/spapr_cpu_core.h |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 1917d8bb13..607fb7ead2 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -238,21 +238,21 @@ static target_ulong h_enter_nested(PowerPCCPU *cpu,
         return H_PARAMETER;
     }
 
-    spapr_cpu->nested_host_state = g_try_new(struct nested_ppc_state, 1);
-    if (!spapr_cpu->nested_host_state) {
+    spapr_cpu->nested_hv_host = g_try_new(struct nested_ppc_state, 1);
+    if (!spapr_cpu->nested_hv_host) {
         return H_NO_MEM;
     }
 
     assert(env->spr[SPR_LPIDR] == 0);
     assert(env->spr[SPR_DPDES] == 0);
-    nested_save_state(spapr_cpu->nested_host_state, cpu);
+    nested_save_state(spapr_cpu->nested_hv_host, cpu);
 
     len = sizeof(*regs);
     regs = address_space_map(CPU(cpu)->as, regs_ptr, &len, false,
                                 MEMTXATTRS_UNSPECIFIED);
     if (!regs || len != sizeof(*regs)) {
         address_space_unmap(CPU(cpu)->as, regs, len, 0, false);
-        g_free(spapr_cpu->nested_host_state);
+        g_free(spapr_cpu->nested_hv_host);
         return H_P2;
     }
 
@@ -330,8 +330,8 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     CPUPPCState *env = &cpu->env;
     SpaprCpuState *spapr_cpu = spapr_cpu_state(cpu);
     struct nested_ppc_state l2_state;
-    target_ulong hv_ptr = spapr_cpu->nested_host_state->gpr[4];
-    target_ulong regs_ptr = spapr_cpu->nested_host_state->gpr[5];
+    target_ulong hv_ptr = spapr_cpu->nested_hv_host->gpr[4];
+    target_ulong regs_ptr = spapr_cpu->nested_hv_host->gpr[5];
     target_ulong hsrr0, hsrr1, hdar, asdr, hdsisr;
     struct kvmppc_hv_guest_state *hvstate;
     struct kvmppc_pt_regs *regs;
@@ -350,15 +350,15 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
      * Switch back to the host environment (including for any error).
      */
     assert(env->spr[SPR_LPIDR] != 0);
-    nested_load_state(cpu, spapr_cpu->nested_host_state);
+    nested_load_state(cpu, spapr_cpu->nested_hv_host);
     env->gpr[3] = env->excp_vectors[excp]; /* hcall return value */
 
     cpu_ppc_hdecr_exit(env);
 
     spapr_cpu->in_nested = false;
 
-    g_free(spapr_cpu->nested_host_state);
-    spapr_cpu->nested_host_state = NULL;
+    g_free(spapr_cpu->nested_hv_host);
+    spapr_cpu->nested_hv_host = NULL;
 
     len = sizeof(*hvstate);
     hvstate = address_space_map(CPU(cpu)->as, hv_ptr, &len, true,
diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_core.h
index 69a52e39b8..9c8c59f173 100644
--- a/include/hw/ppc/spapr_cpu_core.h
+++ b/include/hw/ppc/spapr_cpu_core.h
@@ -53,7 +53,7 @@ typedef struct SpaprCpuState {
 
     /* Fields for nested-HV support */
     bool in_nested; /* true while the L2 is executing */
-    struct nested_ppc_state *nested_host_state; /* holds the L1 state while L2 executes */
+    struct nested_ppc_state *nested_hv_host; /* holds the L1 state while L2 executes */
 } SpaprCpuState;
 
 static inline SpaprCpuState *spapr_cpu_state(PowerPCCPU *cpu)
-- 
2.39.3


