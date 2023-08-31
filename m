Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD3D78F620
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 01:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbr22-0006oH-6o; Thu, 31 Aug 2023 19:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr1z-0006nT-Qe
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:55 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr1r-0002HY-MT
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:55 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso10603925ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 16:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693524285; x=1694129085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+xlV3SGZMVXNVWkGKftcbyBWtbVebk+6sY7EU3bpYY=;
 b=UNjaB68YDDIRwEWVvxyeK2ZRUu3iLlAu4fYyaJvxIVO9U74IS8Yr69KSJeAno4ATa0
 AjapMPmMQe8ZTyvnb+bTfDaUVEQuJHg6Xs1w2IGaOVhF2foWt/M5oKb0WuE8kTxkizg8
 7e5AXGfMZFzSbDxt75QMDAKBSXFNOupLI7nKargJ61l2e3Of0rqhdi0FpFGj3rhTKvp3
 IFOq/s+I5XbzC6YKX0pfPQNYkmNqm9MdvXjHSLbRLqUlzKX7MqHJopnD3PrpVw9R8Gzy
 jKa+FiZBzgV0UF6UKfCT2zk19xU6pgIJbWxPKNTKKoHNwDf6QqjAHdVPIeAdO2aRi0g1
 DFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693524285; x=1694129085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+xlV3SGZMVXNVWkGKftcbyBWtbVebk+6sY7EU3bpYY=;
 b=YcWVnlB/SdZMap26YAFovPoYswnQwo4Q1/f1r2CQa0S5FMMlUBSF5LktXLE4MuLCxG
 OfWXGhjDr74aI59ONuGzN3DqSz3M0B2rTT0mR5qYxM63hGasgU4WTmn9RTZ8K7iRdhdK
 CLrj6kkU+sTLRY0WjSX09z5dt1Qx4/FFZm9ETaNvjgtkAlBW2KwC+VxpGyNWzmoNGnwq
 C39egMhkQAjI6wz23eIQMQECLOTHoZgncyfhSDhDnZCb2dktn/oCDgR2cTA4JmsePVM2
 XEQk/mFRvpMb7Txsf99l6WSgfakxuHYRkF2wGb0ElekbwfEkRks8h62eQYFvbfU5jLYL
 StUA==
X-Gm-Message-State: AOJu0Yz6JVThIYJW9WluqMAbRrFEXy9EA8jE8ipddfp5eb6slEkR36lc
 3pb0VHHn5q0AMhYrGyg+DQyVK0VPWAxCSrETeZE=
X-Google-Smtp-Source: AGHT+IEG2nEjYH5V/EhS5beDeoyLhNk/ug0D6QeLGXbP3LYt6lMHNG5p/IIrL/hN2uMLWyzmcZNGYw==
X-Received: by 2002:a17:902:ef8c:b0:1b6:af1a:7dd3 with SMTP id
 iz12-20020a170902ef8c00b001b6af1a7dd3mr1108532plb.23.1693524284892; 
 Thu, 31 Aug 2023 16:24:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 jd5-20020a170903260500b001bb8895848bsm1732711plb.71.2023.08.31.16.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 16:24:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 3/5] target/arm: Implement HCR_EL2.TIDCP
Date: Thu, 31 Aug 2023 16:24:39 -0700
Message-Id: <20230831232441.66020-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831232441.66020-1-richard.henderson@linaro.org>
References: <20230831232441.66020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Perform the check for EL2 enabled in the security space and the
TIDCP bit in an out-of-line helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h            |  1 +
 target/arm/tcg/op_helper.c     | 13 +++++++++++++
 target/arm/tcg/translate-a64.c | 16 ++++++++++++++--
 target/arm/tcg/translate.c     | 27 +++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95e32a697a..cf5c55a12b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -81,6 +81,7 @@ DEF_HELPER_FLAGS_2(check_bxj_trap, TCG_CALL_NO_WG, void, env, i32)
 
 DEF_HELPER_4(access_check_cp_reg, cptr, env, i32, i32, i32)
 DEF_HELPER_FLAGS_2(lookup_cp_reg, TCG_CALL_NO_RWG_SE, cptr, env, i32)
+DEF_HELPER_FLAGS_2(tidcp_el1, TCG_CALL_NO_WG, void, env, i32)
 DEF_HELPER_3(set_cp_reg, void, env, cptr, i32)
 DEF_HELPER_2(get_cp_reg, i32, env, cptr)
 DEF_HELPER_3(set_cp_reg64, void, env, cptr, i64)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 3baf8004f6..9014c3ca46 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -764,6 +764,19 @@ const void *HELPER(lookup_cp_reg)(CPUARMState *env, uint32_t key)
     return ri;
 }
 
+/*
+ * Test for HCR_EL2.TIDCP at EL1.
+ * Since implementation defined registers are rare, and within QEMU
+ * most of them are no-op, do not waste HFLAGS space for this and
+ * always use a helper.
+ */
+void HELPER(tidcp_el1)(CPUARMState *env, uint32_t syndrome)
+{
+    if (arm_hcr_el2_eff(env) & HCR_TIDCP) {
+        raise_exception_ra(env, EXCP_UDEF, syndrome, 2, GETPC());
+    }
+}
+
 void HELPER(set_cp_reg)(CPUARMState *env, const void *rip, uint32_t value)
 {
     const ARMCPRegInfo *ri = rip;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0b77c92437..786a568d31 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2154,6 +2154,20 @@ static void handle_sys(DisasContext *s, bool isread,
     bool need_exit_tb = false;
     TCGv_ptr tcg_ri = NULL;
     TCGv_i64 tcg_rt;
+    uint32_t syndrome;
+
+    if (crn == 11 || crn == 15) {
+        /*
+         * Check for TIDCP trap, which must take precedence over
+         * the UNDEF for "no such register" etc.
+         */
+        syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
+        switch (s->current_el) {
+        case 1:
+            gen_helper_tidcp_el1(cpu_env, tcg_constant_i32(syndrome));
+            break;
+        }
+    }
 
     if (!ri) {
         /* Unknown register; this might be a guest error or a QEMU
@@ -2176,8 +2190,6 @@ static void handle_sys(DisasContext *s, bool isread,
         /* Emit code to perform further access permissions checks at
          * runtime; this may result in an exception.
          */
-        uint32_t syndrome;
-
         syndrome = syn_aa64_sysregtrap(op0, op1, op2, crn, crm, rt, isread);
         gen_a64_update_pc(s, 0);
         tcg_ri = tcg_temp_new_ptr();
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 38ad8dd4bd..47d3bc5fd5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4538,6 +4538,20 @@ void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
 
+static bool aa32_cpreg_encoding_in_impdef_space(uint8_t crn, uint8_t crm)
+{
+    static const uint16_t mask[3] = {
+        0b0000000111100111,  /* crn ==  9, crm == {c0-c2, c5-c8}   */
+        0b0000000100010011,  /* crn == 10, crm == {c0, c1, c4, c8} */
+        0b1000000111111111,  /* crn == 11, crm == {c0-c8, c15}     */
+    };
+
+    if (crn >= 9 && crn <= 11) {
+        return (mask[crn - 9] >> crm) & 1;
+    }
+    return false;
+}
+
 static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
                            int opc1, int crn, int crm, int opc2,
                            bool isread, int rt, int rt2)
@@ -4619,6 +4633,19 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
         }
     }
 
+    if (cpnum == 15 && aa32_cpreg_encoding_in_impdef_space(crn, crm)) {
+        /*
+         * Check for TIDCP trap, which must take precedence over the UNDEF
+         * for "no such register" etc.  It shares precedence with HSTR,
+         * but raises the same exception, so order doesn't matter.
+         */
+        switch (s->current_el) {
+        case 1:
+            gen_helper_tidcp_el1(cpu_env, tcg_constant_i32(syndrome));
+            break;
+        }
+    }
+
     if (!ri) {
         /*
          * Unknown register; this might be a guest error or a QEMU
-- 
2.34.1


