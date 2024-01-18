Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A3831C1C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 16:13:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQU1x-0002ek-BG; Thu, 18 Jan 2024 10:10:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0j-0001BW-Sp; Thu, 18 Jan 2024 10:08:55 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQU0g-0008CJ-Ot; Thu, 18 Jan 2024 10:08:53 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d70b0e521eso4110995ad.1; 
 Thu, 18 Jan 2024 07:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590529; x=1706195329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Vb8ossKuCaYVQFl2NjYtgMPxp4XZN6RFwICf1cUjCg=;
 b=cIgJNY5Axby7ZJKEVo47ZridhON9VIUAJo/Xuu+qpL9lAjK6qPwuSyvvEPWjkPSLAR
 bbO5FRsv4a6x6o4MNPPYVsUATt8NmNFIL3Rz8sHWcdbMjpWqNNBVrrt+To9GmS4Nb7gx
 FbgalGEf6VzdRqepwuf4go7cxGrB5vsXRhC44O9Nwz8YfUQAHSF3DtVac7qc25nDGQrP
 cnAM3oi5BGsEXahZUFlDf6kp+c+rz4pEhVDMPvnm08SBY1y67OCSG5r32pXiff8olKsN
 hasmwHQaCy4ULt6RQ22KtD++GAUEw68c+El4yuo3B0cKXgAik4rzy+RYhTAPR92nED/T
 Fdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590529; x=1706195329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Vb8ossKuCaYVQFl2NjYtgMPxp4XZN6RFwICf1cUjCg=;
 b=Bn5L/bBNlDdkHf0YkKEUb5Hb7kRo15dHRzsFNUbT92P9NC+OJqooiSIsWge7157M+s
 o/V9lFC7AWkjiUWahczjGYGcIk/nDoQPPUygJjfnQH8xhG7Khp9kOOlBXPOIYIZSW7Iu
 Z9jOTdx/FHWCDEOvMvkRIlqLGApmdFRjjRSO4enRuINV3kgsZbAVglI5XEKWJjL8yuar
 4ePKd2JOTpAZgVuT7PJ4WAxnJDHONsVu3hRex+4kNnguIwWE9FZd2/YvHU/3rH3Uk4Sy
 FywUGmyI5RKuIgob0Q+/PLSrL62TflRPS0HXs43gU9LPgZqn13Qz/bIv1a4fE/vnipdn
 cnRA==
X-Gm-Message-State: AOJu0YwyySFql3X7LRzy3sNpAXqiv9XVvRhY1WkOgp2kEOiNu2/wBr2j
 tPXuMBskpp9wsbi+lemaLK0iXv4naMo3Dnd3zhzrRsZbjLt5a9DMyqf8jw3b
X-Google-Smtp-Source: AGHT+IG7i34DVlDFswYsIuRc+NgRnHzFPNOVMoQD+k9QUpUZS8BQsTr3ub9VnVyHrz6Iid1gJQoG0w==
X-Received: by 2002:a17:902:bd94:b0:1d3:5ed5:764a with SMTP id
 q20-20020a170902bd9400b001d35ed5764amr1024356pls.123.1705590528906; 
 Thu, 18 Jan 2024 07:08:48 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a170902cf5100b001d052d1aaf2sm1509401plg.101.2024.01.18.07.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:08:48 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 25/26] target/ppc: Implement SPRC/SPRD SPRs
Date: Fri, 19 Jan 2024 01:06:43 +1000
Message-ID: <20240118150644.177371-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118150644.177371-1-npiggin@gmail.com>
References: <20240118150644.177371-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

This implements SPRC/SPRD SPRs, and SCRATCH0-7 registers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |  7 +++--
 target/ppc/helper.h      |  3 ++
 target/ppc/spr_common.h  |  3 ++
 target/ppc/cpu_init.c    | 10 ++++++
 target/ppc/misc_helper.c | 66 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/translate.c   | 18 +++++++++++
 6 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b6a955b9b7..a50440ea51 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1266,6 +1266,9 @@ struct CPUArchState {
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
     struct CPUWatchpoint *dawr0_watchpoint;
+
+    /* POWER CPU regs/state */
+    target_ulong scratch[8]; /* SCRATCH registers (shared across core) */
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1802,9 +1805,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
 #define SPR_SPRG2             (0x112)
 #define SPR_SPRG3             (0x113)
 #define SPR_SPRG4             (0x114)
-#define SPR_SCOMC             (0x114)
+#define SPR_POWER_SPRC        (0x114)
 #define SPR_SPRG5             (0x115)
-#define SPR_SCOMD             (0x115)
+#define SPR_POWER_SPRD        (0x115)
 #define SPR_SPRG6             (0x116)
 #define SPR_SPRG7             (0x117)
 #define SPR_ASR               (0x118)
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 8cdb322ed6..43333b4d5e 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -730,6 +730,9 @@ DEF_HELPER_2(book3s_msgsndp, void, env, tl)
 DEF_HELPER_2(book3s_msgclrp, void, env, tl)
 DEF_HELPER_1(load_tfmr, tl, env)
 DEF_HELPER_2(store_tfmr, void, env, tl)
+DEF_HELPER_FLAGS_2(store_sprc, TCG_CALL_NO_RWG, void, env, tl)
+DEF_HELPER_FLAGS_1(load_sprd, TCG_CALL_NO_RWG_SE, tl, env)
+DEF_HELPER_FLAGS_2(store_sprd, TCG_CALL_NO_RWG, void, env, tl)
 #endif
 DEF_HELPER_2(store_sdr1, void, env, tl)
 DEF_HELPER_2(store_pidr, void, env, tl)
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 85f73b860b..01aff449bc 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -207,6 +207,9 @@ void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn);
 void spr_read_dexcr_ureg(DisasContext *ctx, int gprn, int sprn);
 void spr_read_ppr32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_ppr32(DisasContext *ctx, int sprn, int gprn);
+void spr_write_sprc(DisasContext *ctx, int sprn, int gprn);
+void spr_read_sprd(DisasContext *ctx, int sprn, int gprn);
+void spr_write_sprd(DisasContext *ctx, int sprn, int gprn);
 #endif
 
 void register_low_BATs(CPUPPCState *env);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 31d535d501..d42996bbb0 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5705,6 +5705,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
                  SPR_NOACCESS, SPR_NOACCESS,
                  &spr_read_generic, &spr_core_write_generic,
                  0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRC, "SPRC",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_generic, &spr_write_sprc,
+                 0x00000000);
+    spr_register_hv(env, SPR_POWER_SPRD, "SPRD",
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 SPR_NOACCESS, SPR_NOACCESS,
+                 &spr_read_sprd, &spr_write_sprd,
+                 0x00000000);
 #endif
 }
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index 5317713fc3..68620f19cd 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -310,6 +310,72 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
     }
     bql_unlock();
 }
+
+/* Indirect SCOM (SPRC/SPRD) access to SCRATCH0-7 are implemented. */
+void helper_store_sprc(CPUPPCState *env, target_ulong val)
+{
+    if (val & ~0x3f8ULL) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid SPRC register value "
+                      TARGET_FMT_lx"\n", val);
+        return;
+    }
+    env->spr[SPR_POWER_SPRC] = val;
+}
+
+target_ulong helper_load_sprd(CPUPPCState *env)
+{
+    target_ulong sprc = env->spr[SPR_POWER_SPRC];
+
+    switch (sprc & 0x3c0) {
+    case 0: /* SCRATCH0-7 */
+        return env->scratch[(sprc >> 3) & 0x7];
+    default:
+        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+    return 0;
+}
+
+static void do_store_scratch(CPUPPCState *env, int nr, target_ulong val)
+{
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+
+    /*
+     * Log stores to SCRATCH, because some firmware uses these for debugging
+     * and logging, but they would normally be read by the BMC, which is
+     * not implemented in QEMU yet. This gives a way to get at the information.
+     * Could also dump these upon checkstop.
+     */
+    qemu_log("SPRD write 0x%016lx to SCRATCH%d\n", val, nr);
+
+    if (nr_threads == 1) {
+        env->scratch[nr] = val;
+        return;
+    }
+
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        cenv->scratch[nr] = val;
+    }
+}
+
+void helper_store_sprd(CPUPPCState *env, target_ulong val)
+{
+    target_ulong sprc = env->spr[SPR_POWER_SPRC];
+
+    switch (sprc & 0x3c0) {
+    case 0: /* SCRATCH0-7 */
+        do_store_scratch(env, (sprc >> 3) & 0x7, val);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "mfSPRD: Unimplemented SPRC:0x"
+                                  TARGET_FMT_lx"\n", sprc);
+        break;
+    }
+}
 #endif /* defined(TARGET_PPC64) */
 
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 41aeb2d06e..bdd39c89e0 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1298,6 +1298,24 @@ void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
     gen_helper_store_tfmr(tcg_env, cpu_gpr[gprn]);
 }
 
+void spr_write_sprc(DisasContext *ctx, int sprn, int gprn)
+{
+    gen_helper_store_sprc(tcg_env, cpu_gpr[gprn]);
+}
+
+void spr_read_sprd(DisasContext *ctx, int gprn, int sprn)
+{
+    gen_helper_load_sprd(cpu_gpr[gprn], tcg_env);
+}
+
+void spr_write_sprd(DisasContext *ctx, int sprn, int gprn)
+{
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+    gen_helper_store_sprd(tcg_env, cpu_gpr[gprn]);
+}
+
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
 {
     translator_io_start(&ctx->base);
-- 
2.42.0


