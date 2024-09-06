Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E396EB39
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 08:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSuT-0002Td-4v; Fri, 06 Sep 2024 02:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSuD-0001nS-HY; Fri, 06 Sep 2024 02:57:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSuB-0003UN-J8; Fri, 06 Sep 2024 02:57:17 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E43E8C253;
 Fri,  6 Sep 2024 09:53:13 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6696213340B;
 Fri,  6 Sep 2024 09:54:31 +0300 (MSK)
Received: (nullmailer pid 43562 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:30 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 30/53] target/i386: Fix VSIB decode
Date: Fri,  6 Sep 2024 09:54:00 +0300
Message-Id: <20240906065429.42415-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

With normal SIB, index == 4 indicates no index.
With VSIB, there is no exception for VR4/VR12.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2474
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240805003130.1421051-3-richard.henderson@linaro.org
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit ac63755b20013ec6a3d2aef4538d37dc90bc3d10)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: modify the change to pre-new-decoder introduced past qemu 9.0)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 73aa2c42b7..ffd3a42688 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1102,7 +1102,8 @@ static int decode_modrm(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     } else {
         op->has_ea = true;
         op->n = -1;
-        decode->mem = gen_lea_modrm_0(env, s, get_modrm(s, env));
+        decode->mem = gen_lea_modrm_0(env, s, modrm,
+                                      decode->e.vex_class == 12);
     }
     return modrm;
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 716a747df7..157348273e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2159,7 +2159,7 @@ typedef struct AddressParts {
 } AddressParts;
 
 static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
-                                    int modrm)
+                                    int modrm, bool is_vsib)
 {
     int def_seg, base, index, scale, mod, rm;
     target_long disp;
@@ -2188,7 +2188,7 @@ static AddressParts gen_lea_modrm_0(CPUX86State *env, DisasContext *s,
             int code = x86_ldub_code(env, s);
             scale = (code >> 6) & 3;
             index = ((code >> 3) & 7) | REX_X(s);
-            if (index == 4) {
+            if (index == 4 && !is_vsib) {
                 index = -1;  /* no index */
             }
             base = (code & 7) | REX_B(s);
@@ -2318,21 +2318,21 @@ static TCGv gen_lea_modrm_1(DisasContext *s, AddressParts a, bool is_vsib)
 
 static void gen_lea_modrm(CPUX86State *env, DisasContext *s, int modrm)
 {
-    AddressParts a = gen_lea_modrm_0(env, s, modrm);
+    AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
     TCGv ea = gen_lea_modrm_1(s, a, false);
     gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
 }
 
 static void gen_nop_modrm(CPUX86State *env, DisasContext *s, int modrm)
 {
-    (void)gen_lea_modrm_0(env, s, modrm);
+    (void)gen_lea_modrm_0(env, s, modrm, false);
 }
 
 /* Used for BNDCL, BNDCU, BNDCN.  */
 static void gen_bndck(CPUX86State *env, DisasContext *s, int modrm,
                       TCGCond cond, TCGv_i64 bndv)
 {
-    AddressParts a = gen_lea_modrm_0(env, s, modrm);
+    AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
     TCGv ea = gen_lea_modrm_1(s, a, false);
 
     tcg_gen_extu_tl_i64(s->tmp1_i64, ea);
@@ -4156,7 +4156,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             goto illegal_op;
         reg = ((modrm >> 3) & 7) | REX_R(s);
         {
-            AddressParts a = gen_lea_modrm_0(env, s, modrm);
+            AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
             TCGv ea = gen_lea_modrm_1(s, a, false);
             gen_lea_v_seg(s, s->aflag, ea, -1, -1);
             gen_op_mov_reg_v(s, dflag, reg, s->A0);
@@ -4378,7 +4378,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             op = ((b & 7) << 3) | ((modrm >> 3) & 7);
             if (mod != 3) {
                 /* memory op */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 TCGv ea = gen_lea_modrm_1(s, a, false);
                 TCGv last_addr = tcg_temp_new();
                 bool update_fdp = true;
@@ -5322,7 +5322,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         rm = (modrm & 7) | REX_B(s);
         gen_op_mov_v_reg(s, MO_32, s->T1, reg);
         if (mod != 3) {
-            AddressParts a = gen_lea_modrm_0(env, s, modrm);
+            AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
             /* specific case: we need to add a displacement */
             gen_exts(ot, s->T1);
             tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
@@ -6318,7 +6318,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                 }
             } else if (mod != 3) {
                 /* bndldx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
@@ -6362,7 +6362,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (a.base >= 0) {
                     tcg_gen_extu_tl_i64(cpu_bndl[reg], cpu_regs[a.base]);
                     if (!CODE64(s)) {
@@ -6423,7 +6423,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                 }
             } else if (mod != 3) {
                 /* bndstx */
-                AddressParts a = gen_lea_modrm_0(env, s, modrm);
+                AddressParts a = gen_lea_modrm_0(env, s, modrm, false);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
-- 
2.39.2


