Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A937D1B3F
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eT-00033T-Mw; Sat, 21 Oct 2023 01:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eN-0002jm-Tw
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eL-000181-EN
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b5e6301a19so1431292b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866548; x=1698471348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfkUJwcD3UlJPNgPGqdmmi12msrrgZ0GHrBj/wiCyt0=;
 b=qC1cANgrk19d/TmOfdPqCD+frs/r80OkHoctPMmMijK8LMpIa0877ClQTzCEB/d3UR
 u9vAbJMzeJMNU4fjuL5/qcBoN1TPX3YL/MTQuJrUrnOOqgYnU+332BH4huVQbohkm9/t
 Hbg4Lr1/E1qreivtJp4CM7pQxbt4bQhEDPTh5h8zjj+WsnPesIGbfysSOM06ekDDJVY6
 iCcQNHRqMQBuONbXHekH9beOvGTWN6dxJni8bVNXXOyf8ZLjns/md6KSeSBzjjqgWSE0
 DjvPWKn7Bc6imVa5RtCnSKMIBURULblnlXcUtKwQNgD9dkL2HT632sEjcbNwmAO+FtCi
 MQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866548; x=1698471348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfkUJwcD3UlJPNgPGqdmmi12msrrgZ0GHrBj/wiCyt0=;
 b=fveMgccN6SSnI6+MAFkROGQqrBMgcYrO60tmP3uKJIZG0zEkd90Ct1hF3VTlv2vzFX
 iKGWtnJgjeMQL9iY1FSO/ZY4daW1pJspDnEr+DrCrfehmuzVf0jDiCxsj7Hdt1ShrU6p
 sVedSnESb8+eAguoOmqKVIFBl0UwmHtv/9K1zLQ5Z3IIx2hV/QVu1iWqm49EbHuFaCLL
 ewp18PHOZfrYpTysYCDzCXdgdVSelhhWPPyqwbV82rUH0ZziHWu2T5oZ1QpN+jlut7rL
 dbfeWHT0JOgCBjmlC8Ud1UdvmPlsLRfbfwIO5r5TW+kMEIAK8SZrF6ThV2iwysaq54yu
 w1Xg==
X-Gm-Message-State: AOJu0Yz1Yf53ndH+spdlFIoZgcErW0MIHsR/bp3I6e/rZP7V1SbrH9BP
 ZzkG9I8oY3eWWizwOPiNFNP65Fd1UrYRQxt9PwE=
X-Google-Smtp-Source: AGHT+IEk92/+sbcA2j3CxRTc9mceEC1mdckxjzbmbwVjdd0HfEJNu4u09WADPbpgNbWD0aVKH3dqig==
X-Received: by 2002:a05:6a00:1ad1:b0:6bd:a7ea:5c7e with SMTP id
 f17-20020a056a001ad100b006bda7ea5c7emr4206018pfv.11.1697866548096; 
 Fri, 20 Oct 2023 22:35:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 58/90] target/sparc: Merge LDFSR, LDXFSR implementations
Date: Fri, 20 Oct 2023 22:31:26 -0700
Message-Id: <20231021053158.278135-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
index 8ac9ef2e12..f1f43b4e14 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -58,7 +58,8 @@
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
 #define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
-#define gen_helper_ldxfsr(R, E, X, Y)   qemu_build_not_reached()
+#define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
+#define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
 static void gen_helper_ld_asi(TCGv_i64 r, TCGv_env e, TCGv a,
                               TCGv_i32 asi, TCGv_i32 mop)
@@ -4797,44 +4798,27 @@ static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
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


