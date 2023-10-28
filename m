Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B197DA911
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFu-0004ph-OW; Sat, 28 Oct 2023 15:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFi-0004kv-EW
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFg-00048z-F6
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:46 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so2449856a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522343; x=1699127143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwVxkbAXYLmkseWHOh9WFstoLQErXGaZYO3LsVFGKmE=;
 b=HxTe7WkXDWC9+sNfddiNLVPWOLB/tS5zeEyD+i6hXp5mjXeMOrSAXgWA28fuYzBDwB
 E6M+uIMWgW0t+xx6PWt/iWfbx2RNEhgRMKyr5mCCojeRA6dPjQp+wSC9pm5/defYKGpc
 46vAMSxv7KE3cK33sHJIqBb+x22NKK/v2OJiKb93yJ3rVqtXNmEV5OT+aqRFedv/pgtw
 JT1AFllmOWOjdmu391LaiE2LcwncFY7KzKfUV0Qs5cnkf0ILl2Q9Ocd1oBZkjHgsEHPm
 /+STm+d/FNljyZvQHfX1aSnqvAuwMb3prlSMydhBDBDVuO5bJMIrG2Vu1e3AXIRWVFBg
 4+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522343; x=1699127143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwVxkbAXYLmkseWHOh9WFstoLQErXGaZYO3LsVFGKmE=;
 b=miafb3SGdfhKP1ReioHZTvxSQCpNmEyWVrHbs73RdUpirh7z2LUrHGpBe95thSXgtb
 OBkV1MDvvLQJ0pjnRuQNE2w0wJi9btldVkgXIDwx3guBHBOSaXS1dUM8l8MUx7WDssD4
 DNqxv3RtpZMlsrFzvWrXLmDaNFIdNauoy3tbDOphtOrRayM4dbUJBNgozYbpb6hMdp3P
 94N4O+JQwOOB8o1n0e+k0ELugvB6mSJAOfUleRgKxXnOr82UYMIK+m4b4x4pRwvpt9F5
 VwJdAxH1exzPqBZdMcBQkIav0gjhrC+hN+urQqA/MFzpIZ05HOvybgFZ5hGkrur0fwsW
 M+BQ==
X-Gm-Message-State: AOJu0YyJiuUXJn4BuDtniGnuPQIgZBEUD/bXsger09895/Un0REKEa/N
 qBfPO7Pb7sILoj08vIFa8f8eyjKGsZdEr2wyIfE=
X-Google-Smtp-Source: AGHT+IEYgwYbix/Af8Q0Tdw2dPYOAIDhsiX6nohhN2iLqBeVVqBrvFJG+r4JSnfa9dCbm36exOXY5Q==
X-Received: by 2002:a17:902:d48a:b0:1ca:85ae:3b4f with SMTP id
 c10-20020a170902d48a00b001ca85ae3b4fmr6283295plg.55.1698522343192; 
 Sat, 28 Oct 2023 12:45:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 21/35] tcg/sparc64: Pass TCGCond to tcg_out_cmp
Date: Sat, 28 Oct 2023 12:45:08 -0700
Message-Id: <20231028194522.245170-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e16b25e309..10fb8a1a0d 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -646,7 +646,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
     tcg_out_bpcc0(s, scond, flags, off19);
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
+static void tcg_out_cmp(TCGContext *s, TCGCond cond,
+                        TCGReg c1, int32_t c2, int c2const)
 {
     tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
 }
@@ -654,7 +655,7 @@ static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
                                int32_t arg2, int const_arg2, TCGLabel *l)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2);
+    tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
     tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_ICC | BPCC_PT, l);
     tcg_out_nop(s);
 }
@@ -671,7 +672,7 @@ static void tcg_out_movcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg c1, int32_t c2, int c2const,
                                 int32_t v1, int v1const)
 {
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     tcg_out_movcc(s, cond, MOVCC_ICC, ret, v1, v1const);
 }
 
@@ -691,7 +692,7 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
                   | INSN_COND(rcond) | off16);
     } else {
-        tcg_out_cmp(s, arg1, arg2, const_arg2);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
         tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_XCC | BPCC_PT, l);
     }
     tcg_out_nop(s);
@@ -715,7 +716,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     if (c2 == 0 && rcond && (!v1const || check_fit_i32(v1, 10))) {
         tcg_out_movr(s, rcond, ret, c1, v1, v1const);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
     }
 }
@@ -759,13 +760,13 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         /* FALLTHRU */
 
     default:
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
         return;
     }
 
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     if (cond == TCG_COND_LTU) {
         if (neg) {
             /* 0 - 0 - C = -C = (C ? -1 : 0) */
@@ -799,7 +800,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
             c2 = c1, c2const = 0, c1 = TCG_REG_G0;
             /* FALLTHRU */
         case TCG_COND_LTU:
-            tcg_out_cmp(s, c1, c2, c2const);
+            tcg_out_cmp(s, cond, c1, c2, c2const);
             tcg_out_arith(s, ret, TCG_REG_G0, TCG_REG_G0, ARITH_ADDXC);
             return;
         default:
@@ -814,7 +815,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movr(s, rcond, ret, c1, neg ? -1 : 1, 1);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
     }
@@ -1102,7 +1103,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_movi_s32(s, TCG_REG_T3, compare_mask);
         tcg_out_arith(s, TCG_REG_T3, addr_reg, TCG_REG_T3, ARITH_AND);
     }
-    tcg_out_cmp(s, TCG_REG_T2, TCG_REG_T3, 0);
+    tcg_out_cmp(s, TCG_COND_NE, TCG_REG_T2, TCG_REG_T3, 0);
 
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
-- 
2.34.1


