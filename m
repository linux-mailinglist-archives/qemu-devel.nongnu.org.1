Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F648CDD3A
	for <lists+qemu-devel@lfdr.de>; Fri, 24 May 2024 01:12:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHZu-0003ln-AZ; Thu, 23 May 2024 19:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZM-0001my-PY; Thu, 23 May 2024 19:09:57 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZK-0005r5-If; Thu, 23 May 2024 19:09:56 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f8e98784b3so291536b3a.1; 
 Thu, 23 May 2024 16:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505792; x=1717110592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ZqJmFX2phFPC3IYzJbSwWIl3Jmbu25XCOtZEiDmVQY=;
 b=PrcXWdtg35L1CYdY3ieMbGQ3+kWeQwJ0wELdm1hY2mnzo3SKxxWUAUGXgBi+Mhqj2j
 wuzp9bUgE63iZWzcyrKT4MY8oo2gzVh1syPUGzg6zgjT4ZhyiTVKJWqVfcQDWkrlFLmj
 TzJ0lpGb/DB6JE2rwXdaofWcNuo2hPoKqyUy95N1ixqj/Rofd0ISzNS4a4WJdiVYM8uy
 vvx2KpLcNY/Ssza+u9aMQF2iJKQul7LJVBHhSnBPaG6Kk/oJeOiEAJLvnNqRZ/9u2b1q
 WYnKHna3p2CcoP1IRHQLEnUSlxeDA7PaIpmUFj7VzmSBPaxcpS0S8E4d5SxqeiY2VJLk
 cXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505792; x=1717110592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZqJmFX2phFPC3IYzJbSwWIl3Jmbu25XCOtZEiDmVQY=;
 b=p4OdoMxES3WrybmJ8BnjD2Qe5wvOuyDlTQC11gC5e4i0S8EiJcTYNORxWGXlF7TSIf
 6+xyMxI6HolBXVgE28WJZEhwJ6neXPJM8ssNnbgvPPPkF0GQr6O5VUKauBq3N1lKSgOe
 oPFmieGA+RYs01MU2EOq3hEdhaissEHUy13S9ChsrZ+lFadEMjZoMTXFgV20IvhgUyW7
 /S1P7eEJVOkmPyaN27Wnk54yh77/vcoBZuFk0YhJJs5rJWJwhCa19q0VgqwmkLiHHc21
 b7BAdJwBIj9i7d21MKANtQu8TifNi2NBetft/HaDv8+O7GtmnoJlyXlQ5WY3jCgi1SZz
 TuOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiXTv36Mg9yQQX5+6WrTiIGg8nZoNMPjYyFK+9Ub4R7oZOkZbH6Ds0ZnSgDClstpoJXJa102sEfpzhSZP3gTOnUHil
X-Gm-Message-State: AOJu0Yz5F9474vHUo9u8fDpnjl3IqZugN3iL92I4D/sJ8Zgo8O/lrXLX
 aCgMDvbZUfAj0v4NZgAk6gEsFUGgyJ3srWeGiadZ9V3hcBWlu2CTHSZsSg==
X-Google-Smtp-Source: AGHT+IFa+EQ0f9cfXhjAMxWosQ+rgDDGfzMKW+xLSVk/Q7NkBdZuyZzEN8PCZzkldNmG7mUPRvMjmA==
X-Received: by 2002:a05:6a20:de95:b0:1ad:878:5006 with SMTP id
 adf61e73a8af0-1b212daceb6mr717819637.14.1716505792502; 
 Thu, 23 May 2024 16:09:52 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:09:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 37/72] target/ppc: Implement SPRC/SPRD SPRs
Date: Fri, 24 May 2024 09:07:10 +1000
Message-ID: <20240523230747.45703-38-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This implements the POWER SPRC/SPRD SPRs, and SCRATCH0-7 registers that
can be accessed via these indirect SPRs.

SCRATCH registers only provide storage, but they are used by firmware
for low level crash and progress data, so this implementation logs
writes to the registers to help with analysis.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h         |  7 +++--
 target/ppc/cpu_init.c    | 10 ++++++
 target/ppc/helper.h      |  3 ++
 target/ppc/misc_helper.c | 66 ++++++++++++++++++++++++++++++++++++++++
 target/ppc/spr_common.h  |  3 ++
 target/ppc/translate.c   | 18 +++++++++++
 6 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 823be85d03..e4c342b17d 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1264,6 +1264,9 @@ struct CPUArchState {
     ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
     struct CPUBreakpoint *ciabr_breakpoint;
     struct CPUWatchpoint *dawr0_watchpoint;
+
+    /* POWER CPU regs/state */
+    target_ulong scratch[8]; /* SCRATCH registers (shared across core) */
 #endif
     target_ulong sr[32];   /* segment registers */
     uint32_t nb_BATs;      /* number of BATs */
@@ -1806,9 +1809,9 @@ void ppc_compat_add_property(Object *obj, const char *name,
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
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index d181adc5f1..8cfaee61d9 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5777,6 +5777,16 @@ static void register_power_common_book4_sprs(CPUPPCState *env)
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
 
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 09d50f9b76..57bf8354e7 100644
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
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a67930d031..fa47be2298 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -307,6 +307,72 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
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
+    qemu_log("SPRD write 0x" TARGET_FMT_lx " to SCRATCH%d\n", val, nr);
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
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 64131bf15c..0bc16d7251 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1301,6 +1301,24 @@ void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
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
2.43.0


