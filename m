Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D347A6E9F2
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Mar 2025 07:58:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twyBA-00015I-NZ; Tue, 25 Mar 2025 02:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy90-0005ZB-1O; Tue, 25 Mar 2025 02:52:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1twy8t-0001vd-H4; Tue, 25 Mar 2025 02:52:13 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CF1DA107D77;
 Tue, 25 Mar 2025 09:49:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 71C661D5E82;
 Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6F0E15704C; Tue, 25 Mar 2025 09:50:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.3 52/69] target/arm: Make DisasContext.{fp,
 sve}_access_checked tristate
Date: Tue, 25 Mar 2025 09:50:26 +0300
Message-Id: <20250325065043.3263864-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
References: <qemu-stable-9.2.3-20250325094901@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The check for fp_excp_el in assert_fp_access_checked is
incorrect.  For SME, with StreamingMode enabled, the access
is really against the streaming mode vectors, and access
to the normal fp registers is allowed to be disabled.
C.f. sme_enabled_check.

Convert sve_access_checked to match, even though we don't
currently check the exception state.

Cc: qemu-stable@nongnu.org
Fixes: 3d74825f4d6 ("target/arm: Add SME enablement checks")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250307190415.982049-2-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 298a04998fa4a6dc977abe9234d98dfcdab98423)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b2851ea503..dc6af6ea25 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1215,14 +1215,14 @@ static bool fp_access_check_only(DisasContext *s)
 {
     if (s->fp_excp_el) {
         assert(!s->fp_access_checked);
-        s->fp_access_checked = true;
+        s->fp_access_checked = -1;
 
         gen_exception_insn_el(s, 0, EXCP_UDEF,
                               syn_fp_access_trap(1, 0xe, false, 0),
                               s->fp_excp_el);
         return false;
     }
-    s->fp_access_checked = true;
+    s->fp_access_checked = 1;
     return true;
 }
 
@@ -1256,13 +1256,13 @@ bool sve_access_check(DisasContext *s)
                               syn_sve_access_trap(), s->sve_excp_el);
         goto fail_exit;
     }
-    s->sve_access_checked = true;
+    s->sve_access_checked = 1;
     return fp_access_check(s);
 
  fail_exit:
     /* Assert that we only raise one exception per instruction. */
     assert(!s->sve_access_checked);
-    s->sve_access_checked = true;
+    s->sve_access_checked = -1;
     return false;
 }
 
@@ -1291,8 +1291,9 @@ bool sme_enabled_check(DisasContext *s)
      * sme_excp_el by itself for cpregs access checks.
      */
     if (!s->fp_excp_el || s->sme_excp_el < s->fp_excp_el) {
-        s->fp_access_checked = true;
-        return sme_access_check(s);
+        bool ret = sme_access_check(s);
+        s->fp_access_checked = (ret ? 1 : -1);
+        return ret;
     }
     return fp_access_check_only(s);
 }
@@ -11825,8 +11826,8 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     s->insn = insn;
     s->base.pc_next = pc + 4;
 
-    s->fp_access_checked = false;
-    s->sve_access_checked = false;
+    s->fp_access_checked = 0;
+    s->sve_access_checked = 0;
 
     if (s->pstate_il) {
         /*
diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 0fcf7cb63a..bb35ebe3ef 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -65,7 +65,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
 static inline void assert_fp_access_checked(DisasContext *s)
 {
 #ifdef CONFIG_DEBUG_TCG
-    if (unlikely(!s->fp_access_checked || s->fp_excp_el)) {
+    if (unlikely(s->fp_access_checked <= 0)) {
         fprintf(stderr, "target-arm: FP access check missing for "
                 "instruction 0x%08x\n", s->insn);
         abort();
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 20cd0e851c..06893a61c0 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -91,15 +91,19 @@ typedef struct DisasContext {
     bool aarch64;
     bool thumb;
     bool lse2;
-    /* Because unallocated encodings generate different exception syndrome
+    /*
+     * Because unallocated encodings generate different exception syndrome
      * information from traps due to FP being disabled, we can't do a single
      * "is fp access disabled" check at a high level in the decode tree.
      * To help in catching bugs where the access check was forgotten in some
      * code path, we set this flag when the access check is done, and assert
      * that it is set at the point where we actually touch the FP regs.
+     *   0: not checked,
+     *   1: checked, access ok
+     *  -1: checked, access denied
      */
-    bool fp_access_checked;
-    bool sve_access_checked;
+    int8_t fp_access_checked;
+    int8_t sve_access_checked;
     /* ARMv8 single-step state (this is distinct from the QEMU gdbstub
      * single-step support).
      */
-- 
2.39.5


