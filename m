Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60837A2DAF
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM0p-0005wD-Ul; Fri, 15 Sep 2023 23:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0n-0005uz-Do
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:25 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0k-000807-KR
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:25 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso2040258b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835021; x=1695439821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsKnXZVZhcam0jM8C69b4FxqC6SCRjR+f0eXXVwvxZk=;
 b=rZ9VMAEdLvYzemWQUVxWsN1bosU3PZuG2kIrj3Y2fmkIda84Ibi3VhpeLCp0n6N5f+
 PmKFiWTPmLz4QntdtDT2B3fnHS+WUWu8AyrB19+8H7T7v3M0Q64O8Ht8S42AmeGIbxzc
 d+hGN1JjauIxFmHXQXIIk9yN0ekq4lX7JQEz45k9uzN8EKBtX/mVXOlm/t/eodCgyS9Q
 fLA9vUw3EsNKfRkCuksmzb/iqx1dTZaVbcbZSeRqIlXU1s7Pb+ycrv33L4cuiRKrX69r
 o1X3XclFLLwC69Tx3KlsFg1pxUs6gAh8ugYqCYYjLffFhT8Ab7LeHHrw4JjKvQd5uq0w
 wv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835021; x=1695439821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lsKnXZVZhcam0jM8C69b4FxqC6SCRjR+f0eXXVwvxZk=;
 b=W1qcy5gMbuc54eFOAqxlos1kCuph6SJ9Y1RUT3yg2b8wj3xL8rXpKnNxUOPwnPmKxM
 bCU89Bah9zOvqLkwgg42Ng8d+syt3ibjUuY74Ici3s4BTZwJMKSHmbpcP/jK7/k/rBlP
 i+SaQz5Y4iR/44Zkd4e7wyYUva8+vQyVSrkixhhRKwfxkker/6UwG6ewJ5WHVL4DdwQs
 Qb1LL0DVL2YsPwTHcaAyHPrTHWs+CsTcvfb2MSls4LEQfFL2cJSvDHkomjp/H8/QLxwg
 y6mbxpevaI5R4JdqrAzEtZpWNazEr3SIyWLsnK/R5z2iGSlPkjzBj1WYTfl8F5riQ7/Z
 vPmQ==
X-Gm-Message-State: AOJu0YyGm1EPEjqBT3sWoOyMHOR9eWVBD6X/l0YK8FWbLj0Gy7Uy9fKL
 EzWPfiCvbCsEW2VI5yc0928eHeSDybXnIsiohtk=
X-Google-Smtp-Source: AGHT+IH/0WI/8XJCtmeJqgAjRmmksTja7UMH6mrs1RCfXPFMH8dIc+/70Q9gy5zS2RZaI4hXDwbFzQ==
X-Received: by 2002:a05:6a00:3014:b0:68f:cdb8:ae33 with SMTP id
 ay20-20020a056a00301400b0068fcdb8ae33mr9779553pfb.10.1694835021160; 
 Fri, 15 Sep 2023 20:30:21 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/39] tcg: pass vece to tcg_target_const_match()
Date: Fri, 15 Sep 2023 20:29:40 -0700
Message-Id: <20230916033011.479144-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

From: Jiajie Chen <c@jia.je>

Pass vece to tcg_target_const_match() to allow correct interpretation of
const args of vector ops.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908022302.180442-4-c@jia.je>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 4 ++--
 tcg/aarch64/tcg-target.c.inc     | 2 +-
 tcg/arm/tcg-target.c.inc         | 2 +-
 tcg/i386/tcg-target.c.inc        | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 2 +-
 tcg/mips/tcg-target.c.inc        | 2 +-
 tcg/ppc/tcg-target.c.inc         | 2 +-
 tcg/riscv/tcg-target.c.inc       | 2 +-
 tcg/s390x/tcg-target.c.inc       | 2 +-
 tcg/sparc64/tcg-target.c.inc     | 2 +-
 tcg/tci/tcg-target.c.inc         | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 620dbe08da..e81e8936d6 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -171,7 +171,7 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 static void tcg_out_call(TCGContext *s, const tcg_insn_unit *target,
                          const TCGHelperInfo *info);
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot);
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct);
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece);
 #ifdef TCG_TARGET_NEED_LDST_LABELS
 static int tcg_out_ldst_finalize(TCGContext *s);
 #endif
@@ -4689,7 +4689,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         ts = arg_temp(arg);
 
         if (ts->val_type == TEMP_VAL_CONST
-            && tcg_target_const_match(ts->val, ts->type, arg_ct->ct)) {
+            && tcg_target_const_match(ts->val, ts->type, arg_ct->ct, TCGOP_VECE(op))) {
             /* constant is OK for instruction */
             const_args[i] = 1;
             new_args[i] = ts->val;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 0931a69448..a1e2b6be16 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -272,7 +272,7 @@ static bool is_shimm1632(uint32_t v32, int *cmode, int *imm8)
     }
 }
 
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index acb5f23b54..76f1345002 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -509,7 +509,7 @@ static bool is_shimm1632(uint32_t v32, int *cmode, int *imm8)
  * mov operand2:     values represented with x << (2 * y), x < 0x100
  * add, sub, eor...: ditto
  */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 0c3d1e4cef..aed91e515e 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -198,7 +198,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 150278e112..07a0326e5d 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -186,7 +186,7 @@ static inline tcg_target_long sextreg(tcg_target_long val, int pos, int len)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return true;
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9faa8bdf0b..c6662889f0 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -190,7 +190,7 @@ static bool is_p2m1(tcg_target_long val)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 090f11e71c..ccf245191d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -261,7 +261,7 @@ static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 9be81c1b7b..3bd7959e7e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -145,7 +145,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define sextreg  sextract64
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ecd8aaf2a1..f4d3abcb71 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -540,7 +540,7 @@ static bool risbg_mask(uint64_t c)
 }
 
 /* Test if a constant matches the constraint. */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 81a08bb6c5..6b9be4c520 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -322,7 +322,7 @@ static bool patch_reloc(tcg_insn_unit *src_rw, int type,
 }
 
 /* test if a constant matches the constraint */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     if (ct & TCG_CT_CONST) {
         return 1;
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 253f27f174..1dbb4b087e 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -913,7 +913,7 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
 }
 
 /* Test if a constant matches the constraint. */
-static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
+static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 {
     return ct & TCG_CT_CONST;
 }
-- 
2.34.1


