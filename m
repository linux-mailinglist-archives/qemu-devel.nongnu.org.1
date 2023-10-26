Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA557D79B6
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9t-0002tv-HW; Wed, 25 Oct 2023 20:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9T-0001QP-0Z
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:07 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9O-0008CP-5W
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:06 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-27d292d38c0so243709a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279779; x=1698884579; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwblM3qYHhgk/BSbqYTN8K2nRmzxfzwTe7jRYcOw49o=;
 b=siYacVCUOgF3CAT2tuXgx68dIpTpF5VA2069tcX3Dlf83rN4sXazeu2JgO14PceC/Z
 aF8blQZr+M2OwOWoejORTOBiUku2A76WNcOa7B7T3Wb72cXm4cvvWO/JTZB+EC1LvrGM
 r4aq0NeiJo69qTxrY9awGoX1wCnQ5EdZlyZiDoh123Hio+KijxCpW34uOAyPCfjZfQ0u
 9pjGTqZY6moVTI7+gIY4kFsowxC9A2r+Ci4Zg5dEZR47y6hWdaH/h0IsQoIDMf7oOnoa
 aO0D8mqduL2r1TjGZIZP+LZhkOOKZDyjkMiXhzSqGokB/OweFtYGJ1mYevHi/tJrvCmm
 RR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279779; x=1698884579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwblM3qYHhgk/BSbqYTN8K2nRmzxfzwTe7jRYcOw49o=;
 b=YZU6dhl5uWiHQTKCtz4FAkhqRledptgzfMfPH2SlR/8kIJmnj7EAv3FHWo+bOWGbRF
 yiBIP+T4lIEjrkvhdsYX9ANTyiFvEEn5Vble1SQBECT7ngKeLWK75LPl5MyrDgWcfef5
 OjeB6+jGlbmZcrXe7Vi6ReXkg+eh2bCuwFKDsaEFP1PJdn7VV9SsG8/0LdNUX6Hu8Kyu
 VikFJgMHI7eGcAuEeLyptuZRQ+wS/lCZggJwvcxxEQO674iI/95WTkjiu+dlLhg/1oSq
 AOUkKizNQxctMBJnQiW+CqnrJXncQkuZw54ltYsOKo/mIC1WgpgRYRotsUtzVQf5qLWO
 PJ/w==
X-Gm-Message-State: AOJu0YyhbLBwZwVjxQVV8twVPDIDLEd9uM7pnyd5o6uods35OxDsWWnQ
 YY9VYRHNr32araonRhDfwvDj6pkZGEFUce/1ePk=
X-Google-Smtp-Source: AGHT+IG9zHcRR+OT8n35bz+h6/YfnAyHdrnQrIWNEfDeqw/i3AUf66Dmd6PBsibzqiKbpUrVh2/PbA==
X-Received: by 2002:a17:90a:56:b0:27d:1ec3:4367 with SMTP id
 22-20020a17090a005600b0027d1ec34367mr14292477pjb.0.1698279779037; 
 Wed, 25 Oct 2023 17:22:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 62/94] target/sparc: Merge LDFSR, LDXFSR implementations
Date: Wed, 25 Oct 2023 17:15:10 -0700
Message-Id: <20231026001542.1141412-92-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
index 4c0e7cde4a..bf8c5a16b6 100644
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
 
@@ -4675,44 +4676,27 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
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


