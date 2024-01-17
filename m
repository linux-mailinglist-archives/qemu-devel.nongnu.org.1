Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4B831209
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 05:12:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJkW-00064F-F0; Wed, 17 Jan 2024 23:11:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1rQEV2-0000Ol-EK; Wed, 17 Jan 2024 17:35:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dantan@linux.vnet.ibm.com>)
 id 1rQEUz-0005uu-DL; Wed, 17 Jan 2024 17:35:08 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HMLH5m018194; Wed, 17 Jan 2024 22:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=iY/pYYAs8IHc+J3CFGtBieLq4EI462k2OJ/M2Ws5P0s=;
 b=INatLyguhdJTgBjSN3/dxDsBSZpEEubsnrnPCI3LycRrYsCVlf+/O7/g5k7NEyVzi2bx
 Hc52TbJ/jwZq2qTKfv+Cf5qqQR6ggFsENG50qCx5gleEXeEJDcFJVst5C/1df7xc8JAr
 x0XPj9XOJdKBwC6oT5U9XLvuzn/7H/iaVqZv5LDUo4saLwetGVNfK5i0jly4X4FtjPfh
 z0C0rVpp9dog+N3jf7OV8+U5HWnL9xECTozdZ2IVUPv1F8LBi5j43Mr9FJ84mWlAHk30
 oz2bLot0Evk/FYS/A7rz5LWFX3LnlvuQ1+8PfsAl33yRqXgVKFgNrJ3C/7jyQxclY1U7 nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpqfq0ffu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 22:34:52 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HMPxT8031126;
 Wed, 17 Jan 2024 22:34:52 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpqfq0ffd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 22:34:51 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HJeINg006878; Wed, 17 Jan 2024 22:34:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm7j1yfm6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 22:34:51 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HMYoU423462602
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 22:34:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 994B958060;
 Wed, 17 Jan 2024 22:34:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E44258056;
 Wed, 17 Jan 2024 22:34:50 +0000 (GMT)
Received: from gfwa819.aus.stglabs.ibm.com (unknown [9.3.62.57])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 22:34:50 +0000 (GMT)
From: dan tan <dantan@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org, qemu-ppc@nongnu.org
Subject: [PATCH]       ppc/pnv: Add PowerPC Special Purpose Registers
Date: Wed, 17 Jan 2024 16:34:28 -0600
Message-Id: <20240117223429.2295-1-dantan@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -cHYQ0MWyMATMtziQ550YH_sivkYZxC_
X-Proofpoint-GUID: 5y6MPgbb5BtqGgSS5KjeM4iemQA4qKMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=670 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401170161
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dantan@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Jan 2024 23:11:26 -0500
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

        The handling of the following two registers are added -
            DAWR1  (0x0bd, 189) - Data Address Watchpoint 1
            DAWRX1 (0x0b5, 181) - Data Address Watchpoint Extension 1

      Signed-off-by: dan tan <dantan@linux.vnet.ibm.com>
---
 target/ppc/cpu.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 target/ppc/cpu.h         |  6 ++++++
 target/ppc/cpu_init.c    | 10 ++++++++++
 target/ppc/excp_helper.c | 11 ++++++++++-
 target/ppc/helper.h      |  2 ++
 target/ppc/machine.c     |  1 +
 target/ppc/misc_helper.c | 10 ++++++++++
 target/ppc/spr_common.h  |  2 ++
 target/ppc/translate.c   | 12 ++++++++++++
 9 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
index e3ad8e0..8a77328 100644
--- a/target/ppc/cpu.c
+++ b/target/ppc/cpu.c
@@ -188,6 +188,57 @@ void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
     env->spr[SPR_DAWRX0] = val;
     ppc_update_daw0(env);
 }
+
+void ppc_update_daw1(CPUPPCState *env)
+{
+    CPUState *cs = env_cpu(env);
+    target_ulong deaw = env->spr[SPR_DAWR1] & PPC_BITMASK(0, 60);
+    uint32_t dawrx = env->spr[SPR_DAWRX1];
+    int mrd = extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
+    bool dw = extract32(dawrx, PPC_BIT_NR(57), 1);
+    bool dr = extract32(dawrx, PPC_BIT_NR(58), 1);
+    bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
+    bool sv = extract32(dawrx, PPC_BIT_NR(62), 1);
+    bool pr = extract32(dawrx, PPC_BIT_NR(62), 1);
+    vaddr len;
+    int flags;
+
+    if (env->dawr1_watchpoint) {
+        cpu_watchpoint_remove_by_ref(cs, env->dawr1_watchpoint);
+        env->dawr1_watchpoint = NULL;
+    }
+
+    if (!dr && !dw) {
+        return;
+    }
+
+    if (!hv && !sv && !pr) {
+        return;
+    }
+
+    len = (mrd + 1) * 8;
+    flags = BP_CPU | BP_STOP_BEFORE_ACCESS;
+    if (dr) {
+        flags |= BP_MEM_READ;
+    }
+    if (dw) {
+        flags |= BP_MEM_WRITE;
+    }
+
+    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr1_watchpoint);
+}
+
+void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
+{
+    env->spr[SPR_DAWR1] = val;
+    ppc_update_daw1(env);
+}
+
+void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
+{
+    env->spr[SPR_DAWRX1] = val;
+    ppc_update_daw1(env);
+}
 #endif
 #endif
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index f8101ff..ab34fc7 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1237,6 +1237,7 @@ struct CPUArchState {
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
     struct CPUWatchpoint *dawr0_watchpoint;
+    struct CPUWatchpoint *dawr1_watchpoint;
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1552,6 +1553,9 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong value);
 void ppc_update_daw0(CPUPPCState *env);
 void ppc_store_dawr0(CPUPPCState *env, target_ulong value);
 void ppc_store_dawrx0(CPUPPCState *env, uint32_t value);
+void ppc_update_daw1(CPUPPCState *env);
+void ppc_store_dawr1(CPUPPCState *env, target_ulong value);
+void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
 #endif /* !defined(CONFIG_USER_ONLY) */
 void ppc_store_msr(CPUPPCState *env, target_ulong value);
 
@@ -1737,9 +1741,11 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_PSPB              (0x09F)
 #define SPR_DPDES             (0x0B0)
 #define SPR_DAWR0             (0x0B4)
+#define SPR_DAWR1             (0x0B5)
 #define SPR_RPR               (0x0BA)
 #define SPR_CIABR             (0x0BB)
 #define SPR_DAWRX0            (0x0BC)
+#define SPR_DAWRX1            (0x0BD)
 #define SPR_HFSCR             (0x0BE)
 #define SPR_VRSAVE            (0x100)
 #define SPR_USPRG0            (0x100)
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 40fe14a..d75c359 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5119,11 +5119,21 @@ static void register_book3s_207_dbg_sprs(CPUPPCState *env)
                         SPR_NOACCESS, SPR_NOACCESS,
                         &spr_read_generic, &spr_write_dawr0,
                         KVM_REG_PPC_DAWR, 0x00000000);
+    spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_dawr1,
+                        KVM_REG_PPC_DAWR, 0x00000000);
     spr_register_kvm_hv(env, SPR_DAWRX0, "DAWRX0",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
                         &spr_read_generic, &spr_write_dawrx0,
                         KVM_REG_PPC_DAWRX, 0x00000000);
+    spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        SPR_NOACCESS, SPR_NOACCESS,
+                        &spr_read_generic, &spr_write_dawrx1,
+                        KVM_REG_PPC_DAWRX, 0x00000000);
     spr_register_kvm_hv(env, SPR_CIABR, "CIABR",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a42743a..0b87b85 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3314,10 +3314,19 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
 #if defined(TARGET_PPC64)
     CPUPPCState *env = cpu_env(cs);
+    bool match = false;
+    uint32_t dawrx;
 
     if (env->insns_flags2 & PPC2_ISA207S) {
         if (wp == env->dawr0_watchpoint) {
-            uint32_t dawrx = env->spr[SPR_DAWRX0];
+            dawrx = env->spr[SPR_DAWRX0];
+            match = true;
+        } else if (wp == env->dawr1_watchpoint) {
+            dawrx = env->spr[SPR_DAWRX1];
+            match = true;
+        }
+
+        if (match == true) {
             bool wt = extract32(dawrx, PPC_BIT_NR(59), 1);
             bool wti = extract32(dawrx, PPC_BIT_NR(60), 1);
             bool hv = extract32(dawrx, PPC_BIT_NR(61), 1);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee..da6ada4 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -27,7 +27,9 @@ DEF_HELPER_2(store_lpcr, void, env, tl)
 DEF_HELPER_2(store_pcr, void, env, tl)
 DEF_HELPER_2(store_ciabr, void, env, tl)
 DEF_HELPER_2(store_dawr0, void, env, tl)
+DEF_HELPER_2(store_dawr1, void, env, tl)
 DEF_HELPER_2(store_dawrx0, void, env, tl)
+DEF_HELPER_2(store_dawrx1, void, env, tl)
 DEF_HELPER_2(store_mmcr0, void, env, tl)
 DEF_HELPER_2(store_mmcr1, void, env, tl)
 DEF_HELPER_3(store_pmc, void, env, i32, i64)
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 68cbdff..eef596d 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -326,6 +326,7 @@ static int cpu_post_load(void *opaque, int version_id)
 #if defined(TARGET_PPC64)
         ppc_update_ciabr(env);
         ppc_update_daw0(env);
+        ppc_update_daw1(env);
 #endif
         /*
          * TCG needs to re-start the decrementer timer and/or raise the
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a05bdf7..1fc0705 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -209,11 +209,21 @@ void helper_store_dawr0(CPUPPCState *env, target_ulong value)
     ppc_store_dawr0(env, value);
 }
 
+void helper_store_dawr1(CPUPPCState *env, target_ulong value)
+{
+    ppc_store_dawr1(env, value);
+}
+
 void helper_store_dawrx0(CPUPPCState *env, target_ulong value)
 {
     ppc_store_dawrx0(env, value);
 }
 
+void helper_store_dawrx1(CPUPPCState *env, target_ulong value)
+{
+    ppc_store_dawrx1(env, value);
+}
+
 /*
  * DPDES register is shared. Each bit reflects the state of the
  * doorbell interrupt of a thread of the same core.
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 8a9d6cd..2f9b31f 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -161,7 +161,9 @@ void spr_read_cfar(DisasContext *ctx, int gprn, int sprn);
 void spr_write_cfar(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn);
+void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_read_purr(DisasContext *ctx, int gprn, int sprn);
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d..171e080 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -588,11 +588,23 @@ void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_dawr0(tcg_env, cpu_gpr[gprn]);
 }
 
+void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawr1(tcg_env, cpu_gpr[gprn]);
+}
+
 void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
     gen_helper_store_dawrx0(tcg_env, cpu_gpr[gprn]);
 }
+
+void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn)
+{
+    translator_io_start(&ctx->base);
+    gen_helper_store_dawrx1(tcg_env, cpu_gpr[gprn]);
+}
 #endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
 
 /* CTR */
-- 
1.8.3.1


