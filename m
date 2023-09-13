Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6279EB87
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:48:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgR9W-0007sU-Kk; Wed, 13 Sep 2023 10:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uW8d=E5=gmx.de=deller@kernel.org>)
 id 1qgR9L-0007nS-1G
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:47:27 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=uW8d=E5=gmx.de=deller@kernel.org>)
 id 1qgR9F-0008LH-IM
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:47:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8888D61965;
 Wed, 13 Sep 2023 14:47:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC158C433C7;
 Wed, 13 Sep 2023 14:47:15 +0000 (UTC)
Date: Wed, 13 Sep 2023 16:47:12 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: [PATCH] target/hppa: Optimize ldcw/ldcd instruction translation
Message-ID: <ZQHLcL6E5uNvjkaN@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=SRS0=uW8d=E5=gmx.de=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

ldcw (load word and clear) is the only atomic memory instruction of
the hppa architecture and thus is heavily used by the Linux and
HP/UX kernel to implement locks.

Since ldcw always writes a zero, optimize it to not write zero again
if the memory already contained zero (as the lock was already
locked). This reduces the memory contention.
Furthermore, use a native qatomic_xchg() call to write the zero and
thus give a small performace improvement and avoid additional
atomic locking in the target.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/helper.h b/target/hppa/helper.h
index c7e35ce8c7..26d022c714 100644
--- a/target/hppa/helper.h
+++ b/target/hppa/helper.h
@@ -16,7 +16,7 @@ DEF_HELPER_FLAGS_3(stby_b_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e, TCG_CALL_NO_WG, void, env, tl, tr)
 DEF_HELPER_FLAGS_3(stby_e_parallel, TCG_CALL_NO_WG, void, env, tl, tr)
 
-DEF_HELPER_FLAGS_1(ldc_check, TCG_CALL_NO_RWG, void, tl)
+DEF_HELPER_FLAGS_3(ldc, TCG_CALL_NO_WG, tr, env, tl, i32)
 
 DEF_HELPER_FLAGS_4(probe, TCG_CALL_NO_WG, tr, env, tl, i32, i32)
 
diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index f25a5a72aa..d61f067e71 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -155,13 +155,63 @@ void HELPER(stby_e_parallel)(CPUHPPAState *env, target_ulong addr,
     do_stby_e(env, addr, val, true, GETPC());
 }
 
-void HELPER(ldc_check)(target_ulong addr)
+target_ureg HELPER(ldc)(CPUHPPAState *env, target_ulong addr, uint32_t size)
 {
+    uintptr_t ra = GETPC();
+    int mmu_idx = cpu_mmu_index(env, 0);
+    void *vaddr;
+
+    /*
+     * For hppa1.1, LDCW is undefined unless aligned mod 16.
+     * However actual hardware succeeds with aligned mod 4.
+     * Detect this case and log a GUEST_ERROR.
+     *
+     * TODO: HPPA64 relaxes the over-alignment requirement
+     * with the ,co completer.
+     */
     if (unlikely(addr & 0xf)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Undefined ldc to unaligned address mod 16: "
                       TARGET_FMT_lx "\n", addr);
     }
+
+    vaddr = probe_access(env, addr, size, MMU_DATA_STORE, mmu_idx, ra);
+    if (vaddr == NULL) {
+        cpu_loop_exit_restore(env_cpu(env), ra);
+    }
+
+    if (size == 4) {
+        /* 32-bit ldcw */
+        uint32_t old, *haddr;
+
+        haddr = (uint32_t *)((uintptr_t)vaddr);
+        old = *haddr;
+
+        /* if already zero, do not write 0 again to reduce memory presssure */
+        if (old == 0) {
+            return 0;
+        }
+        old = qatomic_xchg(haddr, (uint32_t) 0);
+        return be32_to_cpu(old);
+    } else {
+        /* 64-bit ldcd */
+#ifdef TARGET_HPPA64
+        uint64_t old, *haddr;
+
+        haddr = (uint64_t *)((uintptr_t)vaddr);
+        old = *haddr;
+
+        /* if already zero, do not write 0 again to reduce memory presssure */
+        if (old == 0) {
+            return 0;
+        }
+        old = qatomic_xchg(haddr, (uint64_t) 0);
+        return be64_to_cpu(old);
+#else
+        hppa_dynamic_excp(env, EXCP_ILL, ra);
+        return 0;
+#endif
+    }
 }
 
 target_ureg HELPER(probe)(CPUHPPAState *env, target_ulong addr,
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c04dc15228..c96691ab62 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2857,9 +2857,9 @@ static bool trans_st(DisasContext *ctx, arg_ldst *a)
 
 static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
 {
-    MemOp mop = MO_TE | MO_ALIGN | a->size;
-    TCGv_reg zero, dest, ofs;
+    TCGv_reg dest, ofs;
     TCGv_tl addr;
+    TCGv_i32 sz;
 
     nullify_over(ctx);
 
@@ -2874,18 +2874,8 @@ static bool trans_ldc(DisasContext *ctx, arg_ldst *a)
     form_gva(ctx, &addr, &ofs, a->b, a->x, a->scale ? a->size : 0,
              a->disp, a->sp, a->m, ctx->mmu_idx == MMU_PHYS_IDX);
 
-    /*
-     * For hppa1.1, LDCW is undefined unless aligned mod 16.
-     * However actual hardware succeeds with aligned mod 4.
-     * Detect this case and log a GUEST_ERROR.
-     *
-     * TODO: HPPA64 relaxes the over-alignment requirement
-     * with the ,co completer.
-     */
-    gen_helper_ldc_check(addr);
-
-    zero = tcg_constant_reg(0);
-    tcg_gen_atomic_xchg_reg(dest, addr, zero, ctx->mmu_idx, mop);
+    sz = tcg_constant_i32((a->size == MO_32) ? 4 : 8);
+    gen_helper_ldc(dest, cpu_env, addr, sz);
 
     if (a->m) {
         save_gpr(ctx, a->b, ofs);

