Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 705CB7D2717
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx6-0006ga-OY; Sun, 22 Oct 2023 19:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwz-0006YK-VX
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:42 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwl-0007cU-Vn
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so2609506b3a.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017606; x=1698622406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZIda51sk/68ROGv151fvNG1yn0StWv8blLPAPdrX3w=;
 b=h3EruLQ3D4PdjylJc7PyRdCYkUjEQZeWnDOYg8HgMQEBs35LbH6tibGvHQvUyzCnwI
 BncqQLyG4hi2h3BnznbPrF+OnbDKOzRvx63ntHUNhkWmYpDwSBjBQkhRW2i3/miBLllb
 dbYWuT+PX6eemDXcfAG2gVGB2AtDmQz+Z/pQrNfJ6AaBjkCG5H68urdwTdbjBB/+Tv85
 OxBDtfk+udjrMuiL9XRvqAhqMGOg8oNs/wCEf5RuVtiVFtXlpxz6sb4zSyHt1sNvf9ob
 k0t3YKdCFeaYHrW6mm6gZzqRr7cWutJzfhVqPzc3ANKRfc3Ked7B6NunUl1f7kih5N3p
 3efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017606; x=1698622406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZIda51sk/68ROGv151fvNG1yn0StWv8blLPAPdrX3w=;
 b=mz9YzCP4+2A5/Bo2rowZr5xlNXVL98NMs3JC1Tlu5fxJM962/voIIsDMhj+vujm6Ln
 K/1hezN2cgfdS0vuGBm40cmAYt6RXoj/oo2ccYuu8mHLOOFUM0jARPAwQdqQyRX+Ru4u
 jwlu9PDmYmt2cXdWcnlPtsMUZBFksJ+A28toUH66Aj2fStrCS3n2GXFc/s8QcYzI+vuY
 VYCmzRydgTBFsDHjTdrwagqdwhEGA4oWUrbojWFwUy68PcrL8z3kPt3ZxXAXjRcwP5ul
 o8SFeD8GjO3ivp/AkIg4pSnq7I7XMXch6wcqf4pOPT2A0GMDNLsf9qxGKgcc40LcfHjo
 g/gg==
X-Gm-Message-State: AOJu0Yx/DAScBgiA5DxF/u59nN17v01flp/kzawRV3uHb/7uRqeDMo5J
 mYH3QQiFKW2CUBZ8otT4AW0yVT33BFf/aIzgJHE=
X-Google-Smtp-Source: AGHT+IGpTlMLUx9ZIRhjQBE/F4KKTKjoSnXKql2QgmLIuS8LEvFuLdNHYB76IeBodpyFa85bXqRrWg==
X-Received: by 2002:a05:6a00:2ea3:b0:6be:23dd:d62c with SMTP id
 fd35-20020a056a002ea300b006be23ddd62cmr8484763pfb.2.1698017606420; 
 Sun, 22 Oct 2023 16:33:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 62/94] target/sparc: Merge LDFSR, LDXFSR implementations
Date: Sun, 22 Oct 2023 16:29:00 -0700
Message-Id: <20231022232932.80507-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Combine the helper to a single set_fsr().
Perform the mask and merge inline.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  3 +--
 target/sparc/fop_helper.c | 17 ++--------------
 target/sparc/translate.c  | 42 ++++++++++++---------------------------
 3 files changed, 16 insertions(+), 46 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b116ddcb29..790752467f 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -42,7 +42,7 @@ DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
 DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
 #endif
 DEF_HELPER_FLAGS_1(check_ieee_exceptions, TCG_CALL_NO_WG, tl, env)
-DEF_HELPER_FLAGS_3(ldfsr, TCG_CALL_NO_RWG, tl, env, tl, i32)
+DEF_HELPER_FLAGS_2(set_fsr, TCG_CALL_NO_RWG, void, env, tl)
 DEF_HELPER_FLAGS_1(fabss, TCG_CALL_NO_RWG_SE, f32, f32)
 DEF_HELPER_FLAGS_2(fsqrts, TCG_CALL_NO_RWG, f32, env, f32)
 DEF_HELPER_FLAGS_2(fsqrtd, TCG_CALL_NO_RWG, f64, env, f64)
@@ -54,7 +54,6 @@ DEF_HELPER_FLAGS_1(fsqrtq, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(fcmpq, TCG_CALL_NO_WG, tl, env)
 DEF_HELPER_FLAGS_1(fcmpeq, TCG_CALL_NO_WG, tl, env)
 #ifdef TARGET_SPARC64
-DEF_HELPER_FLAGS_3(ldxfsr, TCG_CALL_NO_RWG, tl, env, tl, i64)
 DEF_HELPER_FLAGS_1(fabsd, TCG_CALL_NO_RWG_SE, f64, f64)
 DEF_HELPER_FLAGS_3(fcmps_fcc1, TCG_CALL_NO_WG, tl, env, f32, f32)
 DEF_HELPER_FLAGS_3(fcmps_fcc2, TCG_CALL_NO_WG, tl, env, f32, f32)
diff --git a/target/sparc/fop_helper.c b/target/sparc/fop_helper.c
index f54fa9b959..0f8aa3abcd 100644
--- a/target/sparc/fop_helper.c
+++ b/target/sparc/fop_helper.c
@@ -382,20 +382,7 @@ static void set_fsr(CPUSPARCState *env, target_ulong fsr)
     set_float_rounding_mode(rnd_mode, &env->fp_status);
 }
 
-target_ulong helper_ldfsr(CPUSPARCState *env, target_ulong old_fsr,
-                          uint32_t new_fsr)
+void helper_set_fsr(CPUSPARCState *env, target_ulong fsr)
 {
-    old_fsr = (new_fsr & FSR_LDFSR_MASK) | (old_fsr & FSR_LDFSR_OLDMASK);
-    set_fsr(env, old_fsr);
-    return old_fsr;
+    set_fsr(env, fsr);
 }
-
-#ifdef TARGET_SPARC64
-target_ulong helper_ldxfsr(CPUSPARCState *env, target_ulong old_fsr,
-                           uint64_t new_fsr)
-{
-    old_fsr = (new_fsr & FSR_LDXFSR_MASK) | (old_fsr & FSR_LDXFSR_OLDMASK);
-    set_fsr(env, old_fsr);
-    return old_fsr;
-}
-#endif
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 37fd209671..8075593237 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -45,7 +45,6 @@
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_done(E)                     qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
-# define gen_helper_ldxfsr(D, E, A, B)          qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
@@ -63,6 +62,8 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
+# define FSR_LDXFSR_MASK                        0
+# define FSR_LDXFSR_OLDMASK                     0
 # define MAXTL_MASK                             0
 #endif
 
@@ -4672,44 +4673,27 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
     return true;
 }
 
-static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
+static bool do_ldfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop,
+                     target_ulong new_mask, target_ulong old_mask)
 {
-    TCGv addr;
-    TCGv_i32 tmp;
-
-    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    TCGv tmp, addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
     if (addr == NULL) {
         return false;
     }
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    tmp = tcg_temp_new_i32();
-    tcg_gen_qemu_ld_i32(tmp, addr, dc->mem_idx, MO_TEUL | MO_ALIGN);
-    gen_helper_ldfsr(cpu_fsr, tcg_env, cpu_fsr, tmp);
+    tmp = tcg_temp_new();
+    tcg_gen_qemu_ld_tl(tmp, addr, dc->mem_idx, mop | MO_ALIGN);
+    tcg_gen_andi_tl(tmp, tmp, new_mask);
+    tcg_gen_andi_tl(cpu_fsr, cpu_fsr, old_mask);
+    tcg_gen_or_tl(cpu_fsr, cpu_fsr, tmp);
+    gen_helper_set_fsr(tcg_env, cpu_fsr);
     return advance_pc(dc);
 }
 
-static bool trans_LDXFSR(DisasContext *dc, arg_r_r_ri *a)
-{
-    TCGv addr;
-    TCGv_i64 tmp;
-
-    if (!avail_64(dc)) {
-        return false;
-    }
-    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
-    if (addr == NULL) {
-        return false;
-    }
-    if (gen_trap_ifnofpu(dc)) {
-        return true;
-    }
-    tmp = tcg_temp_new_i64();
-    tcg_gen_qemu_ld_i64(tmp, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN);
-    gen_helper_ldxfsr(cpu_fsr, tcg_env, cpu_fsr, tmp);
-    return advance_pc(dc);
-}
+TRANS(LDFSR, ALL, do_ldfsr, a, MO_TEUL, FSR_LDFSR_MASK, FSR_LDFSR_OLDMASK)
+TRANS(LDXFSR, 64, do_ldfsr, a, MO_TEUQ, FSR_LDXFSR_MASK, FSR_LDXFSR_OLDMASK)
 
 static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 {
-- 
2.34.1


