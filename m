Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEE579146B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Z0-00048J-BT; Mon, 04 Sep 2023 05:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Ys-0003se-Pc; Mon, 04 Sep 2023 05:07:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yo-0003ui-LH; Mon, 04 Sep 2023 05:07:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN880Q4rz4wxW;
 Mon,  4 Sep 2023 19:07:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN843YYYz4wy9;
 Mon,  4 Sep 2023 19:07:48 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-stable@nongnu.org,
 Ivan Warren <ivan@vmfacility.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 28/35] target/ppc: Fix LQ,
 STQ register-pair order for big-endian
Date: Mon,  4 Sep 2023 11:06:23 +0200
Message-ID: <20230904090630.725952-29-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

LQ, STQ have the same register-pair ordering as LQARX/STQARX., which is
the even (lower) register contains the most significant bits. This is
not implemented correctly for big-endian.

do_ldst_quad() has variables low_addr_gpr and high_addr_gpr which is
confusing because they are low and high addresses, whereas LQARX/STQARX.
and most such things use the low and high values for lo/hi variables.
The conversion to native 128-bit memory access functions missed this
strangeness.

Fix this by changing the if condition, and change the variable names to
hi/lo to match convention.

Cc: qemu-stable@nongnu.org
Reported-by: Ivan Warren <ivan@vmfacility.fr>
Fixes: 57b38ffd0c6f ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1836
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/translate/fixedpoint-impl.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 4ce02fd3a479..7ff7e1ec46a9 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -71,7 +71,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
 {
 #if defined(TARGET_PPC64)
     TCGv ea;
-    TCGv_i64 low_addr_gpr, high_addr_gpr;
+    TCGv_i64 lo, hi;
     TCGv_i128 t16;
 
     REQUIRE_INSNS_FLAGS(ctx, 64BX);
@@ -94,21 +94,21 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
     gen_set_access_type(ctx, ACCESS_INT);
     ea = do_ea_calc(ctx, a->ra, tcg_constant_tl(a->si));
 
-    if (prefixed || !ctx->le_mode) {
-        low_addr_gpr = cpu_gpr[a->rt];
-        high_addr_gpr = cpu_gpr[a->rt + 1];
+    if (ctx->le_mode && prefixed) {
+        lo = cpu_gpr[a->rt];
+        hi = cpu_gpr[a->rt + 1];
     } else {
-        low_addr_gpr = cpu_gpr[a->rt + 1];
-        high_addr_gpr = cpu_gpr[a->rt];
+        lo = cpu_gpr[a->rt + 1];
+        hi = cpu_gpr[a->rt];
     }
     t16 = tcg_temp_new_i128();
 
     if (store) {
-        tcg_gen_concat_i64_i128(t16, low_addr_gpr, high_addr_gpr);
+        tcg_gen_concat_i64_i128(t16, lo, hi);
         tcg_gen_qemu_st_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
     } else {
         tcg_gen_qemu_ld_i128(t16, ea, ctx->mem_idx, DEF_MEMOP(MO_128));
-        tcg_gen_extr_i128_i64(low_addr_gpr, high_addr_gpr, t16);
+        tcg_gen_extr_i128_i64(lo, hi, t16);
     }
 #else
     qemu_build_not_reached();
-- 
2.41.0


