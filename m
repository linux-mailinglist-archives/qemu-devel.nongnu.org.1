Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1031713AC6
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3JaT-0000Vl-6v; Sun, 28 May 2023 12:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaR-0000VJ-Ck; Sun, 28 May 2023 12:49:43 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaP-0003a2-HT; Sun, 28 May 2023 12:49:43 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3985f70cf1bso1568151b6e.3; 
 Sun, 28 May 2023 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292580; x=1687884580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bf9x7ZIiLolV6tEMTComlUTmWu2cOguNqnynRmmxcJ4=;
 b=MfN7GWwm5FUezPVD96QkxVBE3JyFNCJdrcSppZz8ts2ryFffW1K3onyTsdXGfttjUS
 Mc7SQkUmpeW+xq8Z1ihGCBObeGUTA9X0Yj3iHuB6NT0UJotIHmZ/M9IYSP5QEfT1RQc5
 2qQ2luKYgc16wuG7tWCOnH6fIgM82pL6HBaIR3lYlWE5ujALsMVt3WQi3EZrMWYRSBl1
 PyovYAWPj1XHUE414NoQtPNrQhMsaaFtbn5qezFhB6MrPEe1g8ArUKulXWq6RuFfl2Bj
 iT/dMTsFQZwUXtEHiB+toSNQb44hn32Xh0iHzeZP/HTaqyFfD3XNOmeDxe++xcShSWIy
 kVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292580; x=1687884580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bf9x7ZIiLolV6tEMTComlUTmWu2cOguNqnynRmmxcJ4=;
 b=g7NG9Fd6KeXOcly8MrZ5UTJJ/CToT8H/Tet8BnBngw35XdoCfQc+Sod64LqmIaDZKW
 lECaTSvSe1o0lXCfq+ae0fblaNrh8Z+OTj3UUWn5yTUI/OQ8bp67VBggJL1OOLjWjiwn
 5cNSU4wUmriMGqw/gL85TQn0tOEph3sjN1RXNS4MgSpxygON9GHKSF3W3v0uHJLkctAs
 V4gHZ7yrDxiGs/xoA+7drC7zSnsABJew6a0MqLGJiN9nzV+SQ2D+T6qHg3/T2qnDhcUw
 ae/Rhmy3JIC+nN9bm+hFb6EUhSDX5Qj7IocAEKyoTtdQQ7uLtTQfzZBsWcrrN5VohpvR
 aoSQ==
X-Gm-Message-State: AC+VfDy70aB7dJZ/d93UuOxucMwbA2mQG0cSpPM4CxsD1zSYmPPFoKF2
 slA4E/row/H4omgCnwbmzWO3sQbWzP8=
X-Google-Smtp-Source: ACHHUZ4SrHytnlH2JKWo0AE4NbI3Xl2qxTZd1KvuW+xiyTVIYtVNJWwcbDFkT5Ha+U0fW17hkgUVfw==
X-Received: by 2002:a05:6808:23c1:b0:395:e452:47c1 with SMTP id
 bq1-20020a05680823c100b00395e45247c1mr4543450oib.30.1685292579722; 
 Sun, 28 May 2023 09:49:39 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:39 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 02/10] target/ppc: Fix width of some 32-bit SPRs
Date: Sun, 28 May 2023 13:49:14 -0300
Message-Id: <20230528164922.20364-3-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Some 32-bit SPRs are incorrectly implemented as 64-bits on 64-bit
targets.

This changes VRSAVE, DSISR, HDSISR, DAWRX0, PIDR, LPIDR, DEXCR,
HDEXCR, CTRL, TSCR, MMCRH, and PMC[1-6] from to be 32-bit registers.

This only goes by the 32/64 classification in the architecture, it
does not try to implement finer details of SPR implementation (e.g.,
not all bits implemented as simple read/write storage).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20230515092655.171206-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu_init.c    | 18 +++++++++---------
 target/ppc/helper_regs.c |  2 +-
 target/ppc/misc_helper.c |  4 ++--
 target/ppc/power8-pmu.c  |  2 +-
 target/ppc/spr_common.h  |  2 +-
 target/ppc/translate.c   | 26 +++++++++++++-------------
 6 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 0ce2e3c91d..5aa0b3f0f1 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -5085,8 +5085,8 @@ static void register_book3s_altivec_sprs(CPUPPCState *env)
     }
 
     spr_register_kvm(env, SPR_VRSAVE, "VRSAVE",
-                     &spr_read_generic, &spr_write_generic,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_generic32,
+                     &spr_read_generic, &spr_write_generic32,
                      KVM_REG_PPC_VRSAVE, 0x00000000);
 
 }
@@ -5120,7 +5120,7 @@ static void register_book3s_207_dbg_sprs(CPUPPCState *env)
     spr_register_kvm_hv(env, SPR_DAWRX0, "DAWRX0",
                         SPR_NOACCESS, SPR_NOACCESS,
                         SPR_NOACCESS, SPR_NOACCESS,
-                        &spr_read_generic, &spr_write_generic,
+                        &spr_read_generic, &spr_write_generic32,
                         KVM_REG_PPC_DAWRX, 0x00000000);
     spr_register_kvm_hv(env, SPR_CIABR, "CIABR",
                         SPR_NOACCESS, SPR_NOACCESS,
@@ -5376,7 +5376,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_TSCR, "TSCR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_HMER, "HMER",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5406,7 +5406,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_MMCRC, "MMCRC",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_MMCRH, "MMCRH",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5441,7 +5441,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HDSISR, "HDSISR",
                  SPR_NOACCESS, SPR_NOACCESS,
                  SPR_NOACCESS, SPR_NOACCESS,
-                 &spr_read_generic, &spr_write_generic,
+                 &spr_read_generic, &spr_write_generic32,
                  0x00000000);
     spr_register_hv(env, SPR_HRMOR, "HRMOR",
                  SPR_NOACCESS, SPR_NOACCESS,
@@ -5665,7 +5665,7 @@ static void register_power7_book4_sprs(CPUPPCState *env)
                      KVM_REG_PPC_ACOP, 0);
     spr_register_kvm(env, SPR_BOOKS_PID, "PID",
                      SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_generic32,
                      KVM_REG_PPC_PID, 0);
 #endif
 }
@@ -5730,7 +5730,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
 {
     spr_register(env, SPR_DEXCR, "DEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic,
+            &spr_read_generic, &spr_write_generic32,
             0);
 
     spr_register(env, SPR_UDEXCR, "DEXCR",
@@ -5741,7 +5741,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
     spr_register_hv(env, SPR_HDEXCR, "HDEXCR",
             SPR_NOACCESS, SPR_NOACCESS,
             SPR_NOACCESS, SPR_NOACCESS,
-            &spr_read_generic, &spr_write_generic,
+            &spr_read_generic, &spr_write_generic32,
             0);
 
     spr_register(env, SPR_UHDEXCR, "HDEXCR",
diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
index 779e7db513..fb351c303f 100644
--- a/target/ppc/helper_regs.c
+++ b/target/ppc/helper_regs.c
@@ -448,7 +448,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
     /* Exception processing */
     spr_register_kvm(env, SPR_DSISR, "DSISR",
                      SPR_NOACCESS, SPR_NOACCESS,
-                     &spr_read_generic, &spr_write_generic,
+                     &spr_read_generic, &spr_write_generic32,
                      KVM_REG_PPC_DSISR, 0x00000000);
     spr_register_kvm(env, SPR_DAR, "DAR",
                      SPR_NOACCESS, SPR_NOACCESS,
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a9bc1522e2..40ddc5c08c 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -190,13 +190,13 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
 
 void helper_store_pidr(CPUPPCState *env, target_ulong val)
 {
-    env->spr[SPR_BOOKS_PID] = val;
+    env->spr[SPR_BOOKS_PID] = (uint32_t)val;
     tlb_flush(env_cpu(env));
 }
 
 void helper_store_lpidr(CPUPPCState *env, target_ulong val)
 {
-    env->spr[SPR_LPIDR] = val;
+    env->spr[SPR_LPIDR] = (uint32_t)val;
 
     /*
      * We need to flush the TLB on LPID changes as we only tag HV vs
diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
index 1381072b9e..64a64865d7 100644
--- a/target/ppc/power8-pmu.c
+++ b/target/ppc/power8-pmu.c
@@ -272,7 +272,7 @@ void helper_store_pmc(CPUPPCState *env, uint32_t sprn, uint64_t value)
 {
     pmu_update_cycles(env);
 
-    env->spr[sprn] = value;
+    env->spr[sprn] = (uint32_t)value;
 
     pmc_update_overflow_timer(env, sprn);
 }
diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
index 8437eb0340..4c0f2bed77 100644
--- a/target/ppc/spr_common.h
+++ b/target/ppc/spr_common.h
@@ -81,6 +81,7 @@ void _spr_register(CPUPPCState *env, int num, const char *name,
 void spr_noaccess(DisasContext *ctx, int gprn, int sprn);
 void spr_read_generic(DisasContext *ctx, int gprn, int sprn);
 void spr_write_generic(DisasContext *ctx, int sprn, int gprn);
+void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn);
 void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn);
 void spr_write_PMC(DisasContext *ctx, int sprn, int gprn);
@@ -109,7 +110,6 @@ void spr_write_PMC14_ureg(DisasContext *ctx, int sprn, int gprn);
 void spr_write_PMC56_ureg(DisasContext *ctx, int sprn, int gprn);
 
 #ifndef CONFIG_USER_ONLY
-void spr_write_generic32(DisasContext *ctx, int sprn, int gprn);
 void spr_write_clear(DisasContext *ctx, int sprn, int gprn);
 void spr_access_nop(DisasContext *ctx, int sprn, int gprn);
 void spr_read_decr(DisasContext *ctx, int gprn, int sprn);
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1720570b9b..9b7884586c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -411,19 +411,6 @@ void spr_write_generic(DisasContext *ctx, int sprn, int gprn)
     spr_store_dump_spr(sprn);
 }
 
-void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
-{
-    spr_write_generic(ctx, sprn, gprn);
-
-    /*
-     * SPR_CTRL writes must force a new translation block,
-     * allowing the PMU to calculate the run latch events with
-     * more accuracy.
-     */
-    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
-}
-
-#if !defined(CONFIG_USER_ONLY)
 void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 {
 #ifdef TARGET_PPC64
@@ -436,6 +423,19 @@ void spr_write_generic32(DisasContext *ctx, int sprn, int gprn)
 #endif
 }
 
+void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
+{
+    spr_write_generic32(ctx, sprn, gprn);
+
+    /*
+     * SPR_CTRL writes must force a new translation block,
+     * allowing the PMU to calculate the run latch events with
+     * more accuracy.
+     */
+    ctx->base.is_jmp = DISAS_EXIT_UPDATE;
+}
+
+#if !defined(CONFIG_USER_ONLY)
 void spr_write_clear(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv t0 = tcg_temp_new();
-- 
2.40.1


