Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4DD79808F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:25:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeR9p-0002Xv-Gp; Thu, 07 Sep 2023 22:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>)
 id 1qeR9k-0002Vp-1y; Thu, 07 Sep 2023 22:23:36 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>)
 id 1qeR9h-0006t6-Gz; Thu, 07 Sep 2023 22:23:35 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id CB4A944104;
 Fri,  8 Sep 2023 02:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139811; bh=QxlikTwW6pQoFCZSpsJC77hNhTCZa5umaxY7dERkGWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RXa/sUyMzRSV1LwaOvvieiScrjMOULPFB6UkqQM4E6yUXgMVD2F0fgi60vpzNVX4P
 8xNS2VAUiXX7qvLKDwR+2KzL4JdAesKIK+nsOn85d7hVE5MTLFHFX/i4mKi3XLrbnb
 aKnnACZjPYqNRd8YLB63piYxh+nPm5dRhSDI5dzg=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org (open list:AArch64 TCG target),
 qemu-riscv@nongnu.org (open list:RISC-V TCG target)
Subject: [PATCH v4 03/16] tcg: pass vece to tcg_target_const_match()
Date: Fri,  8 Sep 2023 10:21:10 +0800
Message-ID: <20230908022302.180442-4-c@jia.je>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908022302.180442-1-c@jia.je>
References: <20230908022302.180442-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Pass vece to tcg_target_const_match() to allow correct interpretation of
const args of vector ops.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc     | 2 +-
 tcg/arm/tcg-target.c.inc         | 2 +-
 tcg/i386/tcg-target.c.inc        | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 2 +-
 tcg/mips/tcg-target.c.inc        | 2 +-
 tcg/ppc/tcg-target.c.inc         | 2 +-
 tcg/riscv/tcg-target.c.inc       | 2 +-
 tcg/s390x/tcg-target.c.inc       | 2 +-
 tcg/sparc64/tcg-target.c.inc     | 2 +-
 tcg/tcg.c                        | 4 ++--
 tcg/tci/tcg-target.c.inc         | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

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
2.42.0


