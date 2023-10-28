Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFAF7DA910
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:48:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFy-0004s4-Jz; Sat, 28 Oct 2023 15:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFe-0004kh-Ko
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:49 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFb-000485-GH
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:41 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c87a85332bso28249045ad.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522338; x=1699127138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YeM+4oP+r9qlt49XreLO4t20hEw82/Jgmzg6CBtnr4=;
 b=OHGIeGztKeJw28a61FUaeh20KD4/tXOCcZYOSmhcYiF/TM+vMcYiVFLjE3uptOBEZy
 4rZBG8u8GcMr6kenkqtrvGR8VXS6s4lvJsPLPzz9r2s24ZHmPSeLc4fb31CIKBNJGQxC
 +aTiqErGN7bz7NjPr8IVKZTvwH2ye1BWCEmReZr4biuOTl7L1XJ/VjM8TbHJOzPL4oxq
 l0pX9YUp1aPKi2ZJhsuaBqfBWmRdtN2zHANwLMdQj+yde4piQa8+ZioHgTFLZbkn5UiC
 9asIAAGiRSpUNIk/BksY6mQkPubDgX3nZIN7LN/lRJ/fOaRrB5tuwfhnUP1I6x3RqNvD
 aZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522338; x=1699127138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2YeM+4oP+r9qlt49XreLO4t20hEw82/Jgmzg6CBtnr4=;
 b=IBZ0cEC2TXLSD8KaUdk8nYNTyBIHxL9HWQ7Nz1zJaLmUJNxn1iGhlqMnA7G/n6oMiv
 ByIhNvSY7+mw6N1zY99H8KgiTV4n0LnteSQYIyb1E31K+7ddwigroUY9L7mflDFc6VkO
 0HG8+UcSIZofdTk5BftHh3dpaSC6vrvNY/LOafiyPe2Ulf7Mm02YQbIeI11r3qMPMM7f
 PSUWVhTHlG+mTrCaYUBh/i/qtHPKtGxLGmG++wLR5e635VWDqmGeFLVZc+kld/xAfW18
 +qYf0oAglXP7eGQexhyhTroFoxOskljNW3mE7AuhB/LwrGCTJmGeEaSaFFMMzGj++aKb
 wjdA==
X-Gm-Message-State: AOJu0YyXuv8ZXPVDu/HeUA7yu+fgQcWLQPqE+HlemxirfZfjdmbgLLLt
 mZhcCDNUGfNXeeQtVjWhv/RA75ROd2MVnjoZpbI=
X-Google-Smtp-Source: AGHT+IGHidV3ys+YyZXd0syhJZQJa5RZSdMVpZfQFPuxVVyc1HPoKA2lQAgs7XFi5Rg/qRNQpLl6sw==
X-Received: by 2002:a17:902:ea10:b0:1cc:247a:f9f3 with SMTP id
 s16-20020a170902ea1000b001cc247af9f3mr5389725plg.48.1698522337886; 
 Sat, 28 Oct 2023 12:45:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 15/35] tcg/i386: Improve TSTNE/TESTEQ vs powers of two
Date: Sat, 28 Oct 2023 12:45:02 -0700
Message-Id: <20231028194522.245170-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Use "test x,x" when the bit is one of the 4 sign bits.
Use "bt imm,x" otherwise.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  6 ++--
 tcg/i386/tcg-target-con-str.h |  1 +
 tcg/i386/tcg-target.c.inc     | 56 ++++++++++++++++++++++++++++++++---
 3 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 7d00a7dde8..e24241cfa2 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -20,7 +20,7 @@ C_O0_I2(L, L)
 C_O0_I2(qi, r)
 C_O0_I2(re, r)
 C_O0_I2(ri, r)
-C_O0_I2(r, re)
+C_O0_I2(r, reT)
 C_O0_I2(s, L)
 C_O0_I2(x, r)
 C_O0_I3(L, L, L)
@@ -34,7 +34,7 @@ C_O1_I1(r, r)
 C_O1_I1(x, r)
 C_O1_I1(x, x)
 C_O1_I2(q, 0, qi)
-C_O1_I2(q, r, re)
+C_O1_I2(q, r, reT)
 C_O1_I2(r, 0, ci)
 C_O1_I2(r, 0, r)
 C_O1_I2(r, 0, re)
@@ -50,7 +50,7 @@ C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
 C_O1_I3(x, 0, x, x)
 C_O1_I3(x, x, x, x)
-C_O1_I4(r, r, re, r, 0)
+C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
 C_O2_I2(a, d, a, r)
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index 95a30e58cd..cc22db227b 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -28,5 +28,6 @@ REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
  */
 CONST('e', TCG_CT_CONST_S32)
 CONST('I', TCG_CT_CONST_I32)
+CONST('T', TCG_CT_CONST_TST)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('Z', TCG_CT_CONST_U32)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 17b250f16f..3d7306b341 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -132,6 +132,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_U32 0x200
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
+#define TCG_CT_CONST_TST 0x1000
 
 /* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
@@ -202,7 +203,8 @@ static bool tcg_target_const_match(int64_t val, int ct,
         return 1;
     }
     if (type == TCG_TYPE_I32) {
-        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 | TCG_CT_CONST_I32)) {
+        if (ct & (TCG_CT_CONST_S32 | TCG_CT_CONST_U32 |
+                  TCG_CT_CONST_I32 | TCG_CT_CONST_TST)) {
             return 1;
         }
     } else {
@@ -215,6 +217,17 @@ static bool tcg_target_const_match(int64_t val, int ct,
         if ((ct & TCG_CT_CONST_I32) && ~val == (int32_t)~val) {
             return 1;
         }
+        /*
+         * This will be used in combination with TCG_CT_CONST_S32,
+         * so "normal" TESTQ is already matched.  Also accept:
+         *    TESTQ -> TESTL   (uint32_t)
+         *    TESTQ -> BT      (is_power_of_2)
+         */
+        if ((ct & TCG_CT_CONST_TST)
+            && is_tst_cond(cond)
+            && (val == (uint32_t)val || is_power_of_2(val))) {
+            return 1;
+        }
     }
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
@@ -395,6 +408,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_SHLX        (0xf7 | P_EXT38 | P_DATA16)
 #define OPC_SHRX        (0xf7 | P_EXT38 | P_SIMDF2)
 #define OPC_SHRD_Ib     (0xac | P_EXT)
+#define OPC_TESTB	(0x84)
 #define OPC_TESTL	(0x85)
 #define OPC_TZCNT       (0xbc | P_EXT | P_SIMDF3)
 #define OPC_UD2         (0x0b | P_EXT)
@@ -441,6 +455,12 @@ static bool tcg_target_const_match(int64_t val, int ct,
 #define OPC_GRP3_Ev     (0xf7)
 #define OPC_GRP5        (0xff)
 #define OPC_GRP14       (0x73 | P_EXT | P_DATA16)
+#define OPC_GRPBT       (0xba | P_EXT)
+
+#define OPC_GRPBT_BT    4
+#define OPC_GRPBT_BTS   5
+#define OPC_GRPBT_BTR   6
+#define OPC_GRPBT_BTC   7
 
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
@@ -1433,6 +1453,34 @@ static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
         } else if ((arg2 & ~0xff00) == 0 && arg1 < 4) {
             tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
             tcg_out8(s, arg2 >> 8);
+        } else if (is_power_of_2(rexw ? arg2 : (uint32_t)arg2)) {
+            int js = (cond == TCG_COND_TSTNE ? JCC_JS : JCC_JNS);
+            int sh = ctz64(arg2);
+
+            switch (sh) {
+            case 7:
+                if (TCG_TARGET_REG_BITS == 64 || arg1 < 4) {
+                    tcg_out_modrm(s, OPC_TESTB | P_REXB_R, arg1, arg1);
+                    return js;
+                }
+                break;
+            case 15:
+                if (arg1 < 4) {
+                    tcg_out_modrm(s, OPC_TESTB, arg1 + 4, arg1 + 4);
+                } else {
+                    tcg_out_modrm(s, OPC_TESTL | P_DATA16, arg1, arg1);
+                }
+                return js;
+            case 31:
+                tcg_out_modrm(s, OPC_TESTL | P_DATA16, arg1, arg1);
+                return js;
+            case 63:
+                tcg_out_modrm(s, OPC_TESTL | P_REXW, arg1, arg1);
+                return js;
+            }
+            rexw = sh >= 32;
+            tcg_out_modrm(s, OPC_GRPBT + rexw, OPC_GRPBT_BT, arg1);
+            tcg_out8(s, sh);
         } else {
             if (rexw) {
                 if (arg2 == (uint32_t)arg2) {
@@ -3357,7 +3405,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, re);
+        return C_O0_I2(r, reT);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3405,11 +3453,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(q, r, re);
+        return C_O1_I2(q, r, reT);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, re, r, 0);
+        return C_O1_I4(r, r, reT, r, 0);
 
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.34.1


