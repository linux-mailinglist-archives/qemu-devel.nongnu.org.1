Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C17ADDF1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:46:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpeZ-0003ah-Bk; Mon, 25 Sep 2023 13:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qkpeM-0003EB-Kb; Mon, 25 Sep 2023 13:45:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qkpeI-0008KF-DT; Mon, 25 Sep 2023 13:45:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PHKOZ5030075; Mon, 25 Sep 2023 17:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KBGYjGpjRW/Lwypb2j0N24s+hbYvZ/3YxeRxBYJeqeA=;
 b=XIN0nMqODU40AkYejzQN5ij75ypqn2L0Kg9qCfih4JSv/2ZS6jWe/HAgYvWGBM+BvuzP
 GKQnqdZRPBTrJKVxHUAouDZTsqw2psYQ8peZbMvo0xIw3ipzeE9Cl3oW5j6k473xv8IA
 i6itSqVSqkxjHr9usN5vXzFyXInH3JJrGO+EspYsCjuB6ehDUl9erSMHcipNKsgTiGY8
 R2cYr/167IfQWApvgHWt7lRdQPyMK1ftpAGZQm3OY1Fp5VGXyJVumrgKDtwXJncjl7vk
 6SLrlFch9Sbhi6RsGqVhwmCrV1bWjgXC6iW5ccA98aVkxP6ugmwzPTmYKElQQCtWnHbd BA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbe61rvcr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:45:13 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PHbCOc012873;
 Mon, 25 Sep 2023 17:45:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbe61rvcd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:45:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PG7QrP011010; Mon, 25 Sep 2023 17:45:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabuk3xc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:45:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38PHjCp861276584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Sep 2023 17:45:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E74D058058;
 Mon, 25 Sep 2023 17:45:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D728558057;
 Mon, 25 Sep 2023 17:45:11 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 25 Sep 2023 17:45:11 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 471F816A065F;
 Mon, 25 Sep 2023 12:45:11 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38PHjB5W619591;
 Mon, 25 Sep 2023 12:45:11 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 3/4] target/ppc: Add clrbhrb and mfbhrbe instructions
Date: Mon, 25 Sep 2023 12:43:50 -0500
Message-Id: <20230925174351.617891-4-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
References: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ClJsg4p7l5a44NP3WcL2-KqoXWo5ZekO
X-Proofpoint-ORIG-GUID: 8YzgGwredgByGe6-BPhfmWf-nC0un1p_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=558
 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250137
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Add support for the clrbhrb and mfbhrbe instructions.

Since neither instruction is believed to be critical to
performance, both instructions were implemented using helper
functions.

Access to both instructions is controlled by bits in the
HFSCR (for privileged state) and MMCR0 (for problem state).
A new function, helper_mmcr0_facility_check, was added for
checking MMCR0[BHRBA] and raising a facility_unavailable exception
if required.

NOTE: For P8 and P9, due to a performance issue, branch history will
not be kept, but the instructions will be allowed to execute
as normal with the exception that the mfbhrbe instruction will
always return a zero value.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 target/ppc/cpu.h                     |  2 ++
 target/ppc/helper.h                  |  4 +++
 target/ppc/insn32.decode             |  8 +++++
 target/ppc/misc_helper.c             | 46 ++++++++++++++++++++++++++++
 target/ppc/translate.c               |  2 ++
 target/ppc/translate/bhrb-impl.c.inc | 43 ++++++++++++++++++++++++++
 6 files changed, 105 insertions(+)
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 396b1f1a6c..15326c4d40 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -441,6 +441,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
 #define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
 #define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
+#define MMCR0_BHRBA_NR PPC_BIT_NR(42)    /* BHRB Available */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -540,6 +541,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 
 /* HFSCR bits */
 #define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities */
+#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3df360efe9..a62d32d786 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -820,3 +820,7 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+DEF_HELPER_1(clrbhrb, void, env)
+DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
+
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index 4fcf3af8d0..00d3ddda02 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -972,3 +972,11 @@ MSGSND          011111 ----- ----- ..... 0011001110 -   @X_rb
 MSGCLRP         011111 ----- ----- ..... 0010101110 -   @X_rb
 MSGSNDP         011111 ----- ----- ..... 0010001110 -   @X_rb
 MSGSYNC         011111 ----- ----- ----- 1101110110 -
+
+# Branch History Rolling Buffer (BHRB) Instructions
+
+&XFX_bhrbe      rt bhrbe
+@XFX_bhrbe      ...... rt:5 bhrbe:10 .......... -       &XFX_bhrbe
+
+MFBHRBE         011111 ..... ..... ..... 0100101110 -   @XFX_bhrbe
+CLRBHRB         011111 ----- ----- ----- 0110101110 -
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a05bdf78c9..866b064b3d 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -139,6 +139,17 @@ void helper_fscr_facility_check(CPUPPCState *env, uint32_t bit,
 #endif
 }
 
+static void helper_mmcr0_facility_check(CPUPPCState *env, uint32_t bit,
+                                 uint32_t sprn, uint32_t cause)
+{
+#ifdef TARGET_PPC64
+    if (FIELD_EX64(env->msr, MSR, PR) &&
+        !(env->spr[SPR_POWER_MMCR0] & (1ULL << bit))) {
+        raise_fu_exception(env, bit, sprn, cause, GETPC());
+    }
+#endif
+}
+
 void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
                                uint32_t sprn, uint32_t cause)
 {
@@ -366,3 +377,38 @@ void helper_fixup_thrm(CPUPPCState *env)
         env->spr[i] = v;
     }
 }
+
+void helper_clrbhrb(CPUPPCState *env)
+{
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "clrbhrb", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA_NR, 0, FSCR_IC_BHRB);
+
+    if (env->flags & POWERPC_FLAG_BHRB) {
+        memset(env->bhrb, 0, sizeof(env->bhrb));
+    }
+}
+
+uint64_t helper_mfbhrbe(CPUPPCState *env, uint32_t bhrbe)
+{
+    unsigned int index;
+
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "mfbhrbe", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA_NR, 0, FSCR_IC_BHRB);
+
+    if (!(env->flags & POWERPC_FLAG_BHRB) ||
+         (bhrbe >= env->bhrb_num_entries) ||
+         (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
+        return 0;
+    }
+
+    /*
+     * Note: bhrb_offset is the byte offset for writing the
+     * next entry (over the oldest entry), which is why we
+     * must offset bhrbe by 1 to get to the 0th entry.
+     */
+    index = ((env->bhrb_offset / sizeof(uint64_t)) - (bhrbe + 1)) %
+            env->bhrb_num_entries;
+    return env->bhrb[index];
+}
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5f0c79923f..68a8395a23 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6505,6 +6505,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
 
 #include "translate/storage-ctrl-impl.c.inc"
 
+#include "translate/bhrb-impl.c.inc"
+
 /* Handles lfdp */
 static void gen_dform39(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/bhrb-impl.c.inc b/target/ppc/translate/bhrb-impl.c.inc
new file mode 100644
index 0000000000..fd09f444f5
--- /dev/null
+++ b/target/ppc/translate/bhrb-impl.c.inc
@@ -0,0 +1,43 @@
+/*
+ * Power ISA Decode For BHRB Instructions
+ *
+ *  Copyright IBM Corp. 2023
+ *
+ * Authors:
+ *  Glenn Miles      <milesg@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
+
+static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    TCGv_i32 bhrbe = tcg_constant_i32(arg->bhrbe);
+    gen_helper_mfbhrbe(cpu_gpr[arg->rt], cpu_env, bhrbe);
+    return true;
+}
+
+static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    gen_helper_clrbhrb(cpu_env);
+    return true;
+}
+
+#else
+
+static bool trans_MFBHRBE(DisasContext *ctx, arg_XFX_bhrbe *arg)
+{
+    gen_invalid(ctx);
+    return true;
+}
+
+static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
+{
+    gen_invalid(ctx);
+    return true;
+}
+#endif
-- 
2.31.1


