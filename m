Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCED9EB600
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Dec 2024 17:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2wb-0002bq-7C; Tue, 10 Dec 2024 11:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wV-0002aN-ET
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:36 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wT-0006NS-6Y
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:35 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5401d3ea5a1so2522945e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847511; x=1734452311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Aqe7AiIYBOFmb8LLSvrb79BS28+QL4PQSesWGDIC9U=;
 b=wRMjQuf/KlcXxSUFHDqFFY6H6weXrqDxa54YsRNi0k9++R08CyLTk/SAdp6Ha6zK4P
 70NlM2eX/FerqBiGvpxlIAITNs0lzjX78QsNjMOWQ0rb301HsaO2XWWPFontaeMQHrFU
 c0yA3ToD0zPQ5jGgCkcOJ5uyFg1FCuQ+5LWs9qUVBkaqW+j25tZkACb/KGHEKUw1Zas5
 bRjghBol710httHtxde9YdNVjv5wzwNZ6lRYd/sPnaWrBRABwPkfwdRw71Cx5/jRsODE
 xRhZX9I9fLFxC+fk2NAMvDRlmfS7dEdnxLA1ZPBhpox/i5MWUzWgPZMy4jqrEK3KExA7
 GO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847511; x=1734452311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Aqe7AiIYBOFmb8LLSvrb79BS28+QL4PQSesWGDIC9U=;
 b=JpcN13B6gE0WqQVexTxkk26XGZ4d/8NLxqLhliDNzK4gFV6V3yBjfaH7ubzmvNwS9U
 302t0R+eJSQlKPSfWms82lZLCAuaBpIg6hjsrXRA/uLcWx+hlFZFJSzXb0n82zdoOpMx
 EfX7Eq0VunbooqrsMbFGxr8XfZTcCN0Uir68KPdC7hUTHdJSuu2Oa9FxrUKDYb2DAhzo
 GjHaBof7FbhHBpWlGEI7JifzQfPtF5/bL1GilxkJ015QWqIR/C/3c91H/GOuQ2RZcuqw
 TJ/wg0zeZ4E4e3aOlpz4rYdN6nptD09FwDdqd8qyoGrsUepJ12kaoQAuK9V7+H1BTrYT
 4DyQ==
X-Gm-Message-State: AOJu0Yyt6DJ2YM0EsegMjEtjy1kbjFCdaMhxQJjtDTc1rRnTtMN4ZnA5
 IkX51kk5wU/BBoSmvhi2v1S+gc1aFM2Qx6zG6o0JlaJvy2sqrIJfb9SIpeHp19o3o1I1e+07L6c
 hBDTv+uuV
X-Gm-Gg: ASbGncut3zkp1WdJ4VRiiAe+WiPKP2J+9mZfXxcwGQBEaDohlNPFfKbTQjryhCcHxod
 WP6nRpNC9PGE4hLcnC14tL5frb37KrsM6S8U8s+Cn4F+CwTfPpho7uMBxKVQMMD7eaY0QHryjVk
 fTC2mNnFAvwe75JhZhCOOfNCrI17XVZyCI9Px8sI0KMuwnV6tigpE7URBsBJ2iu0bpi7fBcTywT
 XUnV4vRyVgUuqM/y8ch+8pXKDNnAM32P3mJNK4mF8b2XKX+ccomVp3c8vU=
X-Google-Smtp-Source: AGHT+IECQLQMUu0cWEtmETFsLJVAY2g5/ukXhbIgnf07vJf/Jckz9mGmFsUOaJwnBm36D0eeMsv39g==
X-Received: by 2002:a05:6512:b26:b0:540:2311:28c5 with SMTP id
 2adb3069b0e04-54024112f8dmr1769224e87.57.1733847511522; 
 Tue, 10 Dec 2024 08:18:31 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/69] target/arm: Convert disas_add_sub_ext_reg to
 decodetree
Date: Tue, 10 Dec 2024 10:16:36 -0600
Message-ID: <20241210161733.1830573-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This includes ADD, SUB, ADDS, SUBS (extended register).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 65 +++++++++++-----------------------
 target/arm/tcg/a64.decode      |  9 +++++
 2 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ecc8899dd8..8f777875fe 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7864,57 +7864,27 @@ TRANS(AND_r, do_logic_reg, a, tcg_gen_and_i64, tcg_gen_andc_i64, false)
 TRANS(ANDS_r, do_logic_reg, a, tcg_gen_and_i64, tcg_gen_andc_i64, true)
 TRANS(EOR_r, do_logic_reg, a, tcg_gen_xor_i64, tcg_gen_eqv_i64, false)
 
-/*
- * Add/subtract (extended register)
- *
- *  31|30|29|28       24|23 22|21|20   16|15  13|12  10|9  5|4  0|
- * +--+--+--+-----------+-----+--+-------+------+------+----+----+
- * |sf|op| S| 0 1 0 1 1 | opt | 1|  Rm   |option| imm3 | Rn | Rd |
- * +--+--+--+-----------+-----+--+-------+------+------+----+----+
- *
- *  sf: 0 -> 32bit, 1 -> 64bit
- *  op: 0 -> add  , 1 -> sub
- *   S: 1 -> set flags
- * opt: 00
- * option: extension type (see DecodeRegExtend)
- * imm3: optional shift to Rm
- *
- * Rd = Rn + LSL(extend(Rm), amount)
- */
-static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
+static bool do_addsub_ext(DisasContext *s, arg_addsub_ext *a,
+                          bool sub_op, bool setflags)
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int imm3 = extract32(insn, 10, 3);
-    int option = extract32(insn, 13, 3);
-    int rm = extract32(insn, 16, 5);
-    int opt = extract32(insn, 22, 2);
-    bool setflags = extract32(insn, 29, 1);
-    bool sub_op = extract32(insn, 30, 1);
-    bool sf = extract32(insn, 31, 1);
+    TCGv_i64 tcg_rm, tcg_rn, tcg_rd, tcg_result;
 
-    TCGv_i64 tcg_rm, tcg_rn; /* temps */
-    TCGv_i64 tcg_rd;
-    TCGv_i64 tcg_result;
-
-    if (imm3 > 4 || opt != 0) {
-        unallocated_encoding(s);
-        return;
+    if (a->sa > 4) {
+        return false;
     }
 
     /* non-flag setting ops may use SP */
     if (!setflags) {
-        tcg_rd = cpu_reg_sp(s, rd);
+        tcg_rd = cpu_reg_sp(s, a->rd);
     } else {
-        tcg_rd = cpu_reg(s, rd);
+        tcg_rd = cpu_reg(s, a->rd);
     }
-    tcg_rn = read_cpu_reg_sp(s, rn, sf);
+    tcg_rn = read_cpu_reg_sp(s, a->rn, a->sf);
 
-    tcg_rm = read_cpu_reg(s, rm, sf);
-    ext_and_shift_reg(tcg_rm, tcg_rm, option, imm3);
+    tcg_rm = read_cpu_reg(s, a->rm, a->sf);
+    ext_and_shift_reg(tcg_rm, tcg_rm, a->st, a->sa);
 
     tcg_result = tcg_temp_new_i64();
-
     if (!setflags) {
         if (sub_op) {
             tcg_gen_sub_i64(tcg_result, tcg_rn, tcg_rm);
@@ -7923,19 +7893,25 @@ static void disas_add_sub_ext_reg(DisasContext *s, uint32_t insn)
         }
     } else {
         if (sub_op) {
-            gen_sub_CC(sf, tcg_result, tcg_rn, tcg_rm);
+            gen_sub_CC(a->sf, tcg_result, tcg_rn, tcg_rm);
         } else {
-            gen_add_CC(sf, tcg_result, tcg_rn, tcg_rm);
+            gen_add_CC(a->sf, tcg_result, tcg_rn, tcg_rm);
         }
     }
 
-    if (sf) {
+    if (a->sf) {
         tcg_gen_mov_i64(tcg_rd, tcg_result);
     } else {
         tcg_gen_ext32u_i64(tcg_rd, tcg_result);
     }
+    return true;
 }
 
+TRANS(ADD_ext, do_addsub_ext, a, false, false)
+TRANS(SUB_ext, do_addsub_ext, a, true, false)
+TRANS(ADDS_ext, do_addsub_ext, a, false, true)
+TRANS(SUBS_ext, do_addsub_ext, a, true, true)
+
 /*
  * Add/subtract (shifted register)
  *
@@ -8374,8 +8350,7 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     if (!op1) {
         if (op2 & 8) {
             if (op2 & 1) {
-                /* Add/sub (extended register) */
-                disas_add_sub_ext_reg(s, insn);
+                goto do_unallocated;
             } else {
                 /* Add/sub (shifted register) */
                 disas_add_sub_reg(s, insn);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 8e2949d236..0539694506 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -727,6 +727,15 @@ ANDS_r          . 11 01010 .. . ..... ...... ..... .....    @logic_shift
 
 # Add/subtract (shifted reg)
 # Add/subtract (extended reg)
+
+&addsub_ext     rd rn rm sf sa st
+@addsub_ext     sf:1 .. ........ rm:5 st:3 sa:3 rn:5 rd:5   &addsub_ext
+
+ADD_ext         . 00 01011001 ..... ... ... ..... .....     @addsub_ext
+SUB_ext         . 10 01011001 ..... ... ... ..... .....     @addsub_ext
+ADDS_ext        . 01 01011001 ..... ... ... ..... .....     @addsub_ext
+SUBS_ext        . 11 01011001 ..... ... ... ..... .....     @addsub_ext
+
 # Add/subtract (carry)
 # Rotate right into flags
 # Evaluate into flags
-- 
2.43.0


