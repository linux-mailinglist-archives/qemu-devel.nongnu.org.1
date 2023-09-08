Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA680798B39
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:08:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeewK-0005pP-DW; Fri, 08 Sep 2023 13:06:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeewI-0005pG-QW
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevs-00019u-Cd
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso26192285e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192770; x=1694797570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PGMMLtx/QSPdPXb4eYHkhBkguoEA0R+NGsfo5ryyFTQ=;
 b=z1ShES17f4x6DHCDAk2nPrPLZJnx02HDdIY0YJVYsTlDp0qh31lZ/ke6lsXCsnRX72
 WCFJUp8s0jYWP4WmEiYWJQhykCekmpvsdwdNTmoWkJoGEnwnJ1l6DN91ldPdisjA8O5h
 ikzPR28Lmk5yv3FE73KxA3dvD4TykEbhRLn0OSpneOmSyzm664XIHCN4Wu5qZ+KK4iKp
 Z/HVxvUN5LG9o2F288jGOJiYaItMEcWH7ghdJkblXpkZyqlAklOZCo3GG7ThTWXIaYrv
 Zxj7WA27tOVzJuUEiQ0+3/pntprtXa9Q1NxwuIS5QYKrYYyu7u+V3/ETdR7x4MkrlCL7
 umGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192770; x=1694797570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGMMLtx/QSPdPXb4eYHkhBkguoEA0R+NGsfo5ryyFTQ=;
 b=PoE+ZzE1EhvUzi+01Xl76VTFtYH9T+SrrDbIyeKiuWbdkNKRpdUTATkobHx/M4IBMU
 k4y67eeia0Qhc1RStDyMD6g2DKdUdM5S7PRY5q0J5NPB9H00Qvv7/hWcv03emGES4qo2
 3qCHbcVtrJBHaVrk8RAv7sAiv3l8w3LHTkoko1M3HVJZj2/LmKv5MhRCr3Ob1HZgq1VG
 c9AN9LRlMd7LN+H0cJ+Tz15GM4NKmmUlyFvw4Bewds2ymEo7hZe1CUowSzHzDYVksUqP
 bu+sOGzIV4oPvRbXoUV17DJgqk6MAz0qi57Zqd/pOZVWGLjBst2Mo7rSRdEwx5nPqjTJ
 EFLA==
X-Gm-Message-State: AOJu0YzWnuiV7UNarMH324msclNsRMkw6ObcMIev2SEsFHlJrxgVzyr+
 rBY+DnYRNqucEa9fv4xTMaixFliTgWnRnZ9Ych0=
X-Google-Smtp-Source: AGHT+IH7P64ok8VfcroMeqOnWCKv6uAPoZjbNdV+J7JP41k2JodBZcl0KmJ+RssF+nHtmmsI5UCkcg==
X-Received: by 2002:a7b:cbd1:0:b0:3fc:a49:4c05 with SMTP id
 n17-20020a7bcbd1000000b003fc0a494c05mr2572121wmi.40.1694192770714; 
 Fri, 08 Sep 2023 10:06:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] target/arm: Implement HCR_EL2.TIDCP
Date: Fri,  8 Sep 2023 18:05:54 +0100
Message-Id: <20230908170557.773048-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Perform the check for EL2 enabled in the security space and the
TIDCP bit in an out-of-line helper.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230831232441.66020-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |  1 +
 target/arm/tcg/op_helper.c     | 13 +++++++++++++
 target/arm/tcg/translate-a64.c | 16 ++++++++++++++--
 target/arm/tcg/translate.c     | 27 +++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95e32a697aa..cf5c55a12b3 100644
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
index 3baf8004f64..9014c3ca460 100644
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
index 7d2f8026e65..cb5c42638cc 100644
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
index 38ad8dd4bdb..47d3bc5fd51 100644
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


