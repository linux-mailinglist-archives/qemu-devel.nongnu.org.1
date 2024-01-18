Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EFE831C22
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:14:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU0s-0000x7-Bu; Thu, 18 Jan 2024 10:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU06-0008Vf-1d; Thu, 18 Jan 2024 10:08:16 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU04-00088A-2S; Thu, 18 Jan 2024 10:08:13 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3f29fea66so74043985ad.3; 
 Thu, 18 Jan 2024 07:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590490; x=1706195290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AV2Xf065usrVHjnUiij+0BlsSTwAVg19oo0Mq2IcepI=;
 b=fFzua+y92/sYkDT+rJMUpwifNH3iIifQVaH4UBsIbbEfGj41wyjr5UcpXDntceVoLt
 zPiY3QLhGmuO5+RhapaN1IwGwbUf1x98Bo6kPfStn70f0OCQAnzEmdwQAf+D7MC4RTme
 tkWv+CMoSjZXtAQttC+QwjC0Kg8hnTTBu1YaKJ8AZ5Ta8hkZMgcehqG2eZbuYF4rYYT2
 qhNU0gC9QDge3Yp9GnUFCPsj0Py2SIso03gVpY+kKAm2f3zzNjpzgEwFOuxYxOkDMBFI
 rDlDZ1sirwb93XOoNNWy12uJSPpoajhJ5XlO++HF412k+uFl0ZqPD+ofntTvFbNyxdf0
 aITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590490; x=1706195290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AV2Xf065usrVHjnUiij+0BlsSTwAVg19oo0Mq2IcepI=;
 b=Ik6ZWroo1Fyhm7BKj9kyT/RDwAsOuzz+llS4qpy8u1iAxWy3VJE+YUypXmJ4QaUZa8
 mqgJedfvNGenmMJ4DBzBDi7X3qpMMlKE888uYvnZGyHPHIKWryMUwAad103gm30Kq0iz
 rNOptDbbWTrlxgIp3wKDCUExHFly9uYeFFN8XjOtAc8+Jsl7dkYS9x5x04i8lFaj+WXI
 wrUEYSXcaCoACnUY+r84QUspcAs2ZierYkHRRJPE2sgvoJWemJo36wUdbJY+RQRYFpdE
 wNbySn1U1aV7ZnUWflG5yCKtTuBIWBsAFi9u6nkHpNAe+9NhDHXecFwsQQrAEUaJdTsw
 QNBQ==
X-Gm-Message-State: AOJu0YzPtwtwCt2RU1EwCUs0gh692PnZUjvNcTDGv1tDWCOIJrIa3lUi
 1ISkD+/27fH1kkahZsehB9bGaxdoQUpc6f//0OvAKlky/6aI8uePBcvqfScG
X-Google-Smtp-Source: AGHT+IGfCgisbiAzXj7nXrmgEpG7Ix3IbQ85Jlf/E8lgY6ydvkZHfeC9RvE70VrzGS7o/bwOa9L8qQ==
X-Received: by 2002:a17:902:d4c2:b0:1d0:b095:9acc with SMTP id
 o2-20020a170902d4c200b001d0b0959accmr1095392plg.22.1705590490294; 
 Thu, 18 Jan 2024 07:08:10 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PATCH 16/26] target/ppc: Add clrbhrb and mfbhrbe instructions
Date: Fri, 19 Jan 2024 01:06:34 +1000
Message-ID: <20240118150644.177371-17-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

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
[npiggin: rebase and minor compile fixes]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h                     |  2 ++
 target/ppc/helper.h                  |  7 ++++
 target/ppc/insn32.decode             |  8 +++++
 target/ppc/misc_helper.c             | 50 ++++++++++++++++++++++++++++
 target/ppc/translate.c               |  2 ++
 target/ppc/translate/bhrb-impl.c.inc | 43 ++++++++++++++++++++++++
 6 files changed, 112 insertions(+)
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 9bda69f779..acaf39f365 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -537,6 +537,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 #define MMCR0_PMCjCE PPC_BIT(49)         /* MMCR0 PMCj Condition Enabled */
 #define MMCR0_FCP    PPC_BIT(34)         /* Freeze Counters/BHRB if PR=1 */
 #define MMCR0_FCPC   PPC_BIT(51)         /* Condition for FCP bit */
+#define MMCR0_BHRBA_NR PPC_BIT_NR(42)    /* BHRB Available */
 /* MMCR0 userspace r/w mask */
 #define MMCR0_UREG_MASK (MMCR0_FC | MMCR0_PMAO | MMCR0_PMAE)
 /* MMCR2 userspace r/w mask */
@@ -636,6 +637,7 @@ FIELD(MSR, LE, MSR_LE, 1)
 
 /* HFSCR bits */
 #define HFSCR_MSGP     PPC_BIT(53) /* Privileged Message Send Facilities */
+#define HFSCR_BHRB     PPC_BIT(59) /* BHRB Instructions */
 #define HFSCR_IC_MSGP  0xA
 
 #define DBCR0_ICMP (1 << 27)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3df360efe9..8cdb322ed6 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -820,3 +820,10 @@ DEF_HELPER_4(DSCLIQ, void, env, fprp, fprp, i32)
 
 DEF_HELPER_1(tbegin, void, env)
 DEF_HELPER_FLAGS_1(fixup_thrm, TCG_CALL_NO_RWG, void, env)
+
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
+DEF_HELPER_1(clrbhrb, void, env)
+DEF_HELPER_FLAGS_2(mfbhrbe, TCG_CALL_NO_WG, i64, env, i32)
+#endif
+#endif
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
index a9d41d2802..e3b20a8935 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -153,6 +153,17 @@ void helper_msr_facility_check(CPUPPCState *env, uint32_t bit,
 
 #if !defined(CONFIG_USER_ONLY)
 
+#ifdef TARGET_PPC64
+static void helper_mmcr0_facility_check(CPUPPCState *env, uint32_t bit,
+                                 uint32_t sprn, uint32_t cause)
+{
+    if (FIELD_EX64(env->msr, MSR, PR) &&
+        !(env->spr[SPR_POWER_MMCR0] & (1ULL << bit))) {
+        raise_fu_exception(env, bit, sprn, cause, GETPC());
+    }
+}
+#endif
+
 void helper_store_sdr1(CPUPPCState *env, target_ulong val)
 {
     if (env->spr[SPR_SDR1] != val) {
@@ -366,3 +377,42 @@ void helper_fixup_thrm(CPUPPCState *env)
         env->spr[i] = v;
     }
 }
+
+#if !defined(CONFIG_USER_ONLY)
+#if defined(TARGET_PPC64)
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
+#endif
+#endif
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3ff023fafc..0d36a553d3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6543,6 +6543,8 @@ static bool resolve_PLS_D(DisasContext *ctx, arg_D *d, arg_PLS_D *a)
 
 #include "translate/storage-ctrl-impl.c.inc"
 
+#include "translate/bhrb-impl.c.inc"
+
 /* Handles lfdp */
 static void gen_dform39(DisasContext *ctx)
 {
diff --git a/target/ppc/translate/bhrb-impl.c.inc b/target/ppc/translate/bhrb-impl.c.inc
new file mode 100644
index 0000000000..3a19bc4555
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
+    gen_helper_mfbhrbe(cpu_gpr[arg->rt], tcg_env, bhrbe);
+    return true;
+}
+
+static bool trans_CLRBHRB(DisasContext *ctx, arg_CLRBHRB *arg)
+{
+    REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
+    gen_helper_clrbhrb(tcg_env);
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
2.42.0


