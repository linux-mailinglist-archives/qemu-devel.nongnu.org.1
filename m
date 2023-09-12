Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D41079DA7B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:02:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAUr-0001fc-0q; Tue, 12 Sep 2023 17:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qgAUU-0001WM-Vs; Tue, 12 Sep 2023 17:00:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qgAUR-0005X4-Jq; Tue, 12 Sep 2023 17:00:10 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CKgFdS005127; Tue, 12 Sep 2023 20:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dE6SZcUTvxnbu/Alt5R7481oeWmTREolDdAvvYc8wwc=;
 b=mtfcIyM+juiiXXxdDs/3Ts96Y8Ny2BMTdWpb4eMCYvlX9iXw4+P4CaWwbmB1YQEHLxOj
 mpwvvSpcehAwwI9mWyfHmgLT3Zq5uJC6gHJ/Y2R6CoFT08J4ziV39Cr67VdIF/fwWqeu
 6bGH1DzIZFTLblsiG/lraFyVhCAS2KpNnkTMNtjWsOnVYbFLj2lIJFiZDH+6LQuRO9bl
 hmbirP35Al0I+vgyIEvRZTJbfN+BmK51M1fBfhotZu9rhjoNzReiU0TBSnP0UREPdbQR
 w5h/sSpq+0kJmHnf3xHqfLlAfQdW6PDsrSdMFz8aR4ZopLC99ZmclE9t4KQdeaXsYjhG 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2y8p0dtt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:57:50 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38CKhC8w006502;
 Tue, 12 Sep 2023 20:57:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2y8p0dth-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:57:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38CJcc63012069; Tue, 12 Sep 2023 20:57:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dypagw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Sep 2023 20:57:49 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38CKvmCi59113826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Sep 2023 20:57:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A41C958056;
 Tue, 12 Sep 2023 20:57:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9365258052;
 Tue, 12 Sep 2023 20:57:48 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 12 Sep 2023 20:57:48 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id ED66B16A073D;
 Tue, 12 Sep 2023 15:57:47 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38CKvlWh3408088;
 Tue, 12 Sep 2023 15:57:47 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs)
Subject: [PATCH 3/4] target/ppc: Add clrbhrb and mfbhrbe instructions
Date: Tue, 12 Sep 2023 15:57:41 -0500
Message-Id: <20230912205741.3408040-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
References: <20230912192144.3330174-1-milesg@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UTVByi_coaY7hKZ4di8NJ3sozRdJ09On
X-Proofpoint-GUID: ggBUIZx78dXbRd5y102f9Xxyey0q-2Qz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_19,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=247
 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309120174
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

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
---
 target/ppc/cpu.h         |  1 +
 target/ppc/helper.h      |  4 ++++
 target/ppc/misc_helper.c | 43 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate.c   | 13 ++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index bda1afb700..ee81ede4ee 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -541,6 +541,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 
 /* HFSCR bits */
 #define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities */
+#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 1a3d9a7e57..bbc32ff114 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -816,3 +816,7 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+DEF_HELPER_1(clrbhrb, void, env)
+DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
+
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 692d058665..45abe04f66 100644
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
@@ -351,3 +362,35 @@ void helper_fixup_thrm(CPUPPCState *env)
         env->spr[i] = v;
     }
 }
+
+void helper_clrbhrb(CPUPPCState *env)
+{
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "clrbhrb", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA, 0, FSCR_IC_BHRB);
+
+    memset(env->bhrb, 0, sizeof(env->bhrb));
+}
+
+uint64_t helper_mfbhrbe(CPUPPCState *env, uint32_t bhrbe)
+{
+    unsigned int index;
+
+    helper_hfscr_facility_check(env, HFSCR_BHRB, "mfbhrbe", FSCR_IC_BHRB);
+
+    helper_mmcr0_facility_check(env, MMCR0_BHRBA, 0, FSCR_IC_BHRB);
+
+    if ((bhrbe >= env->bhrb_num_entries) ||
+       (env->spr[SPR_POWER_MMCR0] & MMCR0_PMAE)) {
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
index 7824475f54..b330871793 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6549,12 +6549,25 @@ static void gen_brh(DisasContext *ctx)
 }
 #endif
 
+static void gen_clrbhrb(DisasContext *ctx)
+{
+    gen_helper_clrbhrb(cpu_env);
+}
+
+static void gen_mfbhrbe(DisasContext *ctx)
+{
+    TCGv_i32 bhrbe = tcg_constant_i32(_SPR(ctx->opcode));
+    gen_helper_mfbhrbe(cpu_gpr[rD(ctx->opcode)], cpu_env, bhrbe);
+}
+
 static opcode_t opcodes[] = {
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(brd, 0x1F, 0x1B, 0x05, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
 #endif
+GEN_HANDLER_E(clrbhrb, 0x1F, 0x0E, 0x0D, 0x3FFF801, PPC_NONE, PPC2_ISA207S),
+GEN_HANDLER_E(mfbhrbe, 0x1F, 0x0E, 0x09, 0x0000001, PPC_NONE, PPC2_ISA207S),
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
 #if defined(TARGET_PPC64)
 GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
-- 
2.31.1


