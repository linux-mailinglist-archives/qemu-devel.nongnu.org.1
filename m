Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1595382A42B
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLS-0007ns-7q; Wed, 10 Jan 2024 17:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLF-0006z6-0a
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:34 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLC-0003Tc-Pr
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:32 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78315243c11so329011685a.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926789; x=1705531589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTZQ8U70bvvwDjHMDYUT6Xyjxfqygw11gwaeaagFYFE=;
 b=g15M/3H/vDmAZQVaIMz1eFhJ064GVoRA2JATYebIPDdqiTLksGB49UwDzPYAlE2c7R
 mxYzSApTpRKssQbpQo3R6ScX48x+SxGd9KgaWW28gS/iCJvFhrzSmI7vDSoNnUDVOEfM
 ASUAlniP29IWzhAjnPcNeyc417VmVmKQGIomHPbPesJ9OEgDuEYlRuteo8u8o35vnNy+
 l0klal7gYG1CFoUZMxy7i4HGVCzFWbqytExhyp82fTD/xYcRqA4D7E3cuZ4pVzLO3ttd
 OQokVmhoETVMSNLFiUtaDpIsk7Jy7lRbICxotdkvycTd25+J0RccSMUqxFdTLv5kZQfS
 YqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926789; x=1705531589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTZQ8U70bvvwDjHMDYUT6Xyjxfqygw11gwaeaagFYFE=;
 b=LnJIRLBtfZMJOUmukWrTQvI8LjQN9421FzPyQs2zEKfQhrhvmYSNGJN87uYfxonoCb
 X4rtUSsWXZejflvRHI5kt+eP9gzVwn0imui37Z/PqhacSy91aPknmsLANTASrVpnH+Rk
 jghCLTCt6L2v5DePv5loOO/hcNubEgeId0K2bQ3p+IK2fFmD1HWHkMvwxUAURlcxIzMu
 QUwEdZeOSTbGogTdyms3yEyeSdh5cB98z+OOXmp4+YPuyyXVfmzQNotB5l9b5Kdoj5T8
 bnd9boBY6fczppfTX3y4ZD0AwMqmdmiay1Tz9kREaVy4cS+E/xhtIEtfCuRG9DOEbA6Q
 NaHA==
X-Gm-Message-State: AOJu0YwjzM5ol0nD3UoPEqYLSFuNN8sgHVl6aMMF0S+Xhh6hrs924DXa
 ME9CV0xz0lynepgY+BD9WZuNgt70B53w9LfxycBVV+3JR27SUGsN
X-Google-Smtp-Source: AGHT+IGmQ+P5X49j1+y1jv3dIdPLLfQytAZdRXvVrNl1in52vYYuGZ1s1atVrCpk3n7fxrbO4BfKHg==
X-Received: by 2002:ac8:7d13:0:b0:429:899c:7387 with SMTP id
 g19-20020ac87d13000000b00429899c7387mr246384qtb.128.1704926789658; 
 Wed, 10 Jan 2024 14:46:29 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 28/38] tcg/sparc64: Pass TCGCond to tcg_out_cmp
Date: Thu, 11 Jan 2024 09:43:58 +1100
Message-Id: <20240110224408.10444-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


